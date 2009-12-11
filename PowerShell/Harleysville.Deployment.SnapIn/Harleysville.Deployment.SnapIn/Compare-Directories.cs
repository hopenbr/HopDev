using System;
using System.Collections.Generic;
using System.Text;
using System.Management.Automation;
using System.Collections;
using System.IO;
using System.Security.Cryptography;
using System.Diagnostics;

namespace Harleysville.Deployment.SnapIn
{
    [Cmdlet(VerbsData.Compare, "Directories", SupportsShouldProcess = true)]
    public class Compare_Directories : PSCmdlet
    {

        #region Parameters
        private string _sourceDirectory;
        [Parameter(Position = 0,
            Mandatory = true,
            ValueFromPipelineByPropertyName = true,
            HelpMessage = "Help Text")]
        [ValidateNotNullOrEmpty]
        public string SourceDirectory
        {
            get { return _sourceDirectory; }
            set { _sourceDirectory = value; }
        }

        private string _DeploymentDirectory;
        [Parameter(Position = 1,
            Mandatory = true,
            ValueFromPipelineByPropertyName = true,
            HelpMessage = "Help Text")]
        [ValidateNotNullOrEmpty]
        public string DeploymentDirectory
        {
            get { return _DeploymentDirectory; }
            set { _DeploymentDirectory = value; }
        }

        private bool _debug = false;
        [Parameter(Mandatory = false,
            ValueFromPipelineByPropertyName = true,
            HelpMessage = "Help Text")]
       // [ValidateNotNullOrEmpty]
        public bool Debugger
        {
            get { return _debug; }
            set { _debug = value; }
        }

        private bool _isDeployment = false;
        [Parameter(Mandatory = false,
            ValueFromPipelineByPropertyName = true,
            HelpMessage = "Help Text")]
     //   [ValidateNotNullOrEmpty]
        public bool Deployment
        {
            get { return _isDeployment; }
            set { _isDeployment = value; }
        }

        private string _env;
        [Parameter(Mandatory = false,
            ValueFromPipelineByPropertyName = true,
            HelpMessage = "Help Text")]
       [ValidateNotNullOrEmpty]
        public string EnvConfigPath
        {
            get { return _env; }
            set { _env = value; }
        }

        private string _hintPath;
        [Parameter(Mandatory = false,
            ValueFromPipelineByPropertyName = true,
            HelpMessage = "Help Text")]
        [ValidateNotNullOrEmpty]
        public string ConfigHintPath
        {
            get { return _hintPath; }
            set { _hintPath = value; }
        }


        #endregion
        Dictionary<string, string> _extraFileInfo = new Dictionary<string, string>();

        protected override void ProcessRecord()
        {
            EventLog _el = new EventLog("Application", Environment.MachineName, "Harleysville.Deployment.Confirmation");

            try
            {
                _el.WriteEntry("Starting Directory compare", EventLogEntryType.Information, 4200);
                WriteObject(CompareDirectories(_sourceDirectory, _DeploymentDirectory));
                if (_debug)
                {
                    WriteObject("\n" + _sourceDirectory + "\n=>\n" + _DeploymentDirectory);
                }
                
            }
            catch (Exception ex)
            {
                StringBuilder _sb = new StringBuilder();
                _sb.AppendLine(ex.Message)
                   .AppendLine(ex.StackTrace);
                
                _el.WriteEntry(_sb.ToString(), EventLogEntryType.Error, 4202);
                WriteObject(false);
                if (_debug)
                {
                    ErrorRecord _er = new ErrorRecord(ex, "1678", ErrorCategory.InvalidData, ex);
                    WriteError(_er);
                }
            }
        }

        private bool CompareDirectories(string _sourcePath, string _deployPath)
        {
            bool _isExtraFile = false;
         
            //Optimize - if there is not the same number of files 
            //in the each direct they of course that are not equal
            if (Directory.GetFileSystemEntries(_sourcePath).Length !=
                Directory.GetFileSystemEntries(_deployPath).Length)
            {
                //check for extra config files
                if (LookForExtraConfigFiles(_sourcePath) ==
                    Directory.GetFileSystemEntries(_deployPath).Length)
                {
                    _isExtraFile = true;
                }
                else
                {
                    if (!Check4Aspnet_ClientFolder(_deployPath))
                    {
                        return false;
                    }
                }

            }

            //Now compare the files in Top directory of each

            foreach (string _file in Directory.GetFiles(_deployPath))
            {
                //optimize - ensure there is a _file with same name in second folder
                if (Directory.GetFiles(_sourcePath, Path.GetFileName(_file)).Length == 0)
                {
                    if (_isExtraFile)
                    {
                        if (!VerifyExtraConfigNames(_file))
                        {
                            return false;
                        }
                    }
                    else
                    {
                        return false;
                    }
                }
                
                //_file exists now compare content
                FileInfo _deployInfo = new FileInfo(_file);
                FileInfo _sourceInfo;

                if (_isExtraFile && _file.Equals(_extraFileInfo["File"]))
                {
                    _sourceInfo = new FileInfo(Path.Combine(_extraFileInfo["ConfigPath"], Path.GetFileName(_file)));
                }
                else
                {
                    _sourceInfo = new FileInfo(Path.Combine(_sourcePath, Path.GetFileName(_file)));
                }
                
                if (_debug)
                {
                    WriteObject("\n\nFile Compare of:\n1)" + _sourceInfo.FullName + "\n2)" + _deployInfo.FullName + "\n");
                }

                if (!GetCheckSum(_sourceInfo.OpenRead()).Equals(GetCheckSum(_deployInfo.OpenRead())))
                {
                    if (!CheckEnvConfigs(_deployInfo))
                    {
                        return false;
                    }
                }
                
                
            };

            //All files exist in both directories so now recurse on subdirectories

            foreach (string _dir in Directory.GetDirectories(_sourcePath))
            {
                if (_debug)
                {
                    WriteObject("Jumping to subdirectory:\n" + _dir);
                }

                DirectoryInfo _sourceDirInfo = new DirectoryInfo(_dir);
                DirectoryInfo _deployDirInfo = new DirectoryInfo(Path.Combine(_deployPath, _sourceDirInfo.Name));


                if (!_deployDirInfo.Exists)
                {
                    return false;
                }

                if (_debug)
                {
                    WriteObject("Comparing Subdirectories:\n" + _sourceDirInfo.FullName + "\n" + _deployDirInfo.FullName);
                }

                if (!CompareDirectories(_sourceDirInfo.FullName, _deployDirInfo.FullName))
                {
                    return false;
                }
            };

            return true;
        }

        private string GetCheckSum(FileStream _fs)
        {
            //compare contents of files via checksum 
            SHA512Managed _sha512 = new SHA512Managed();
            StringBuilder sb = new StringBuilder();
           
            foreach (byte b in _sha512.ComputeHash(_fs))
            {
                sb.Append(b.ToString("x2").ToLower());
            }

            _fs.Close();
            _sha512.Clear();
            if (_debug)
            {
                WriteObject(sb.ToString());
            }

            return (sb.ToString());
        }

        private bool CheckEnvConfigs(FileInfo _fileInfo)
        {
            if (_isDeployment)
            {
                if (String.IsNullOrEmpty(_env) || !Directory.Exists(_env))
                {
                    Exception _ex = new Exception("The Deployment Environment path must be set when the Deployment parameter is set to true");
                    throw (_ex); 
                }

                //optimize - ensure there is a _file with same name in env.Config folder

                if (Directory.GetFiles(_env, _fileInfo.Name).Length == 0)
                {
                    if (!String.IsNullOrEmpty(_hintPath))
                    {
                        return CheckHintPath(_fileInfo);
                    }
                    else
                    {
                        return false;
                    }
                }
                else
                {
                    FileInfo _configInfo = new FileInfo(Path.Combine(_env, _fileInfo.Name));
                    if (!GetCheckSum(_fileInfo.OpenRead()).Equals(GetCheckSum(_configInfo.OpenRead())))
                    {
                        if (!String.IsNullOrEmpty(_hintPath))
                        {
                            return CheckHintPath(_fileInfo);
                        }
                        else
                        {
                            return false;
                        }
                    }
                }

                return true;

            }
            else
            {
                return false;
            }
        }

        private bool CheckHintPath(FileInfo _fileInfo)
        {
            if (Directory.Exists(_hintPath))
            {
                if (Directory.GetFiles(_hintPath, _fileInfo.Name).Length == 0)
                {
                    return false;
                }
                else
                {
                    FileInfo _lookInfo = new FileInfo(Path.Combine(_hintPath, _fileInfo.Name));

                    if (!GetCheckSum(_fileInfo.OpenRead()).Equals(GetCheckSum(_lookInfo.OpenRead())))
                    {
                        return false;
                    }

                    return true;

                }
            }
            else
            {
                Exception _ex = new Exception("Error:  Could not find ConfigLookPath (" + _hintPath + ")");
                throw (_ex);
            }

        }

        private int LookForExtraConfigFiles(string _sourcePath)
        {
            if (_isDeployment)
            {
                if (_debug)
                {
                    WriteObject("\nExtra file found in deployment area checking for extra configs\n");
                }

                if (String.IsNullOrEmpty(_env) || !Directory.Exists(_env))
                {
                    Exception _ex = new Exception("The Deployment Environment path must be set when the Deployment parameter is set to true");
                    throw (_ex);
                }

                int _trueFileCount = Directory.GetFileSystemEntries(_sourcePath).Length;

                //checking to see if there are extra configs being pushed
                _trueFileCount += Check4ExtraFiles(_sourcePath, _env);

                if (Directory.Exists(_hintPath))
                {
                    _trueFileCount += Check4ExtraFiles(_sourcePath, _hintPath);
                }

                return _trueFileCount;
            }
            else
            {
                return Directory.GetFileSystemEntries(_sourcePath).Length;
            }
        }

        private int Check4ExtraFiles(string _sourcePath, string _extraPath)
        {
            int _extraFileCount = 0;

            foreach (string _file in Directory.GetFiles(_extraPath))
            {
                if (Directory.GetFiles(_sourcePath, Path.GetFileName(_file)).Length == 0)
                {
                    //extra config file found
                    _extraFileCount++;
                }

            }

            return _extraFileCount;

        }

        private bool VerifyExtraConfigNames(string _extraFile)
        {
            bool _isFound = false;

            if (_isDeployment)
            {
                if (_debug)
                {
                    WriteObject("\nChecking extra file name\n");
                }

                if (String.IsNullOrEmpty(_env) || !Directory.Exists(_env))
                {
                    Exception _ex = new Exception("The Deployment Environment path must be set when the Deployment parameter is set to true");
                    throw (_ex);
                }
                _isFound = Check4ExtraFileName(_extraFile, _env);

                if (Directory.Exists(_hintPath))
                {
                    _isFound = Check4ExtraFileName(_extraFile, _hintPath);
                }
                
            }
            
            return _isFound;
            
        }

        private bool Check4ExtraFileName(string _exFile, string _exPath)
        {
            if (Directory.GetFiles(_exPath, Path.GetFileName(_exFile)).Length == 0)
            {
                return false;
            }
            else
            {
                //setting info later use
                _extraFileInfo["File"] = _exFile;
                _extraFileInfo["ConfigPath"] = _exPath;

                return true;
            }

        }

        private bool Check4Aspnet_ClientFolder(string _dPath)
        {
            if (Directory.GetDirectories(_dPath, "aspnet_client").Length != 0)
            {
                return true;
            }
            else
            {
                return false;
            }
        }

    }
}
