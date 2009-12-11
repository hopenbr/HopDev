using System;
using System.Collections.Generic;
using System.Text;
using System.IO;
using System.Configuration;

using Microsoft.Build.Framework;
using Microsoft.Build.Utilities;

using Microsoft.TeamFoundation;
using Microsoft.TeamFoundation.Client;
using Microsoft.TeamFoundation.Build.Proxy;
using Microsoft.TeamFoundation.VersionControl.Client;

using Harleysville.Build.Utilities;

namespace Harleysville.Build.Tasks
{
    public class GetwM_Exports : Task
    {
        private string _wsName;
        [Required]
        public string Workspace
        {
            get { return _wsName; }
            set { _wsName = value; }
        }

        private string _owner;
        [Required]
        public string Owner
        {
            get { return _owner; }
            set { _owner = value; }
        }

        private string _outbound;
        [Required]
        public string OutBoundFolderPath
        {
            get { return _outbound; }
            set { _outbound = value; }
        }

        private string _buildNumber;
        [Required]
        public string BuildNumber
        {
            get { return _buildNumber; }
            set { _buildNumber = value; }
        }

        private string _newPackageSearchString;
        [Required]
        public string NewPackageSearchString
        {
            get { return _newPackageSearchString; }
            set { _newPackageSearchString = value; }
        }

        private bool _isHotFix = false;
        public bool IsHotFixBuild
        {
            get { return _isHotFix;  }
            set { _isHotFix = value; }
        }


        public override bool Execute()
        {
            try
            {
                return (GetExports());
            }
            catch (Exception _ex)
            {
                string _msg = "Get Exports failure:\n" + _ex.Message + "\n" + _ex.StackTrace;
                BuildEngine.LogErrorEvent(new BuildErrorEventArgs("wM exports Failure", "export Failure",
                                                                  _ex.Source, 0, 0, 0, 0,
                                                                  _msg,
                                                                  "Getting wM Packages from Outbound folder was unsuccessful",
                                                                  "TFSBuild"));

                return false;
            }

            
        }

        private bool GetExports()
        {
            TFVC _tfs = new TFVC();
            Workspace _ws = _tfs.GetWorkSpace(_wsName, _owner);
            List<string> _files2BeCheckedOut = new List<string>();
            List<string> _files2Add = new List<string>();
            Dictionary<string, string> _outboundFileMapping = new Dictionary<string,string>();
            string _importPath = String.Empty;
            bool _areThereAnyPackages = false;

            foreach (WorkingFolder _wf in _ws.Folders)
            {
                if (_wf.IsCloaked)
                {
                    continue;
                }

                BuildEngine.LogMessageEvent(new BuildMessageEventArgs("Working Folder search: " + _wf.LocalItem, "Help", "Me", MessageImportance.High));

                foreach (string _vcfile in Directory.GetFiles(_wf.LocalItem, "*.zip", SearchOption.AllDirectories))
                {
                    BuildEngine.LogMessageEvent(new BuildMessageEventArgs("Working Folder search file: " + _vcfile, "Help", "Me", MessageImportance.High));

                    if (Directory.GetFiles(_outbound, Path.GetFileName(_vcfile)).Length != 0)
                    {
                        BuildEngine.LogMessageEvent(new BuildMessageEventArgs("Adding " + _vcfile, "Help", "Me", MessageImportance.High));
                        _files2BeCheckedOut.Add(_vcfile);
                        _outboundFileMapping.Add(_outbound + @"\" + Path.GetFileName(_vcfile), _vcfile);
                    }
                }

                _importPath = _wf.LocalItem;

            }

            //now check to see if there are any new packages that need to be add
            string _folderName;
            if (_newPackageSearchString.Contains("_CL"))
            {
                _folderName = "CommercialLines";
            }
            else if (_newPackageSearchString.Contains("_PL"))
            {
                _folderName = "PersonalLines";
            }
            else if (_newPackageSearchString.Contains("_Agency"))
            {
                _folderName = "Agency";
            }
            else
            {
                _folderName = "Common";
            }
             
            foreach (string _newFile in Directory.GetFiles(_outbound))
            {
                BuildEngine.LogMessageEvent(new BuildMessageEventArgs("Outbound Folder search for new packages: " + _newFile, "Help", "Me", MessageImportance.High));
                if (Path.GetFileName(_newFile).Contains(_newPackageSearchString))
                {
                    FileInfo _fi = new FileInfo(_newFile);
                   
                    if (Directory.GetParent(_importPath).Name.Equals(_folderName))
                    {
                        _importPath = Directory.CreateDirectory(Directory.GetParent(_importPath).ToString() + @"\" + Path.GetFileNameWithoutExtension(_newFile).Replace(_newPackageSearchString, String.Empty)).FullName;
                    }
                    else
                    {
                        _importPath = Directory.CreateDirectory(_importPath + @"\" + _folderName + @"\" +Path.GetFileNameWithoutExtension(_newFile).Replace(_newPackageSearchString, String.Empty)).FullName;
                    }
                    
                    string _vcPathFileName = Path.GetFileName(_newFile).Replace(_newPackageSearchString, String.Empty);
                    string _vcPath = _importPath + @"\" + _vcPathFileName;
                    BuildEngine.LogMessageEvent(new BuildMessageEventArgs("TFVC import path: " + _vcPath, "Help", "Me", MessageImportance.High));
                    if (Directory.GetFiles(_importPath, _vcPathFileName).Length != 0)
                    {
                        BuildEngine.LogMessageEvent(new BuildMessageEventArgs("Package already exists in TFVC, checking out", "Help", "Me", MessageImportance.High));
                        //element already exists in TFVC
                        _files2BeCheckedOut.Add(_vcPath);
                        _outboundFileMapping.Add(_outbound + @"\" + Path.GetFileName(_vcPath), _vcPath);

                    }
                    else
                    {
                         BuildEngine.LogMessageEvent(new BuildMessageEventArgs("New package found: " + _newFile, "Help", "Me", MessageImportance.High));
                        _fi.CopyTo(_vcPath);
                        _files2Add.Add(_vcPath);
                        _fi.Delete();
                    }
                }

            }

            if (_files2BeCheckedOut.Count > 0)
            {
                if (_isHotFix)
                {
                    int _count = 0; 
                    string _localDir2Map = "";

                    foreach (string _outFile in _outboundFileMapping.Keys)
                    {
                        FileInfo _newFile = new FileInfo(_outboundFileMapping[_outFile].Replace(_folderName, @"Hotfixes\" + _buildNumber));
                        if (!_newFile.Directory.Exists)
                        {
                            Directory.CreateDirectory(_newFile.Directory.FullName);
                        }
                        File.Copy(_outFile, _newFile.FullName, true);
                        _files2Add.Add(_newFile.FullName);
                        File.Delete(_outFile);
                        if (_count.Equals(0))
                        {
                            _localDir2Map = _newFile.Directory.Parent.Parent.FullName;
                            //local folder should be SolutionRoot/Hotfixes/Build#/PackageName/Package.zip
                        }
                        _count++;
                    }

                    _ws.Map("$/WmProjects/Hotfixes/", _localDir2Map);
                    //this is not the best way to do this but I need a quick fix

                }
                else
                {
                    _ws.PendEdit(_files2BeCheckedOut.ToArray());


                    foreach (string _outFile in _outboundFileMapping.Keys)
                    {
                        FileInfo _fi = new FileInfo(_outFile);
                        _fi.CopyTo(_outboundFileMapping[_outFile], true);

                        if ((_fi.Attributes & FileAttributes.ReadOnly) == FileAttributes.ReadOnly)
                        {
                            _fi.Attributes &= ~FileAttributes.ReadOnly;

                        }

                        _fi.Delete();

                    }

                }

                _areThereAnyPackages = true;
            }

            if (_files2Add.Count > 0)
            {
                _ws.PendAdd(_files2Add.ToArray());
                _areThereAnyPackages = true;
            }

            if (_areThereAnyPackages)
            {
                _ws.CheckIn(_ws.GetPendingChanges(), "Checkins exported from " + _outbound + " for build " + _buildNumber);
                return true;
            }
            else
            {
                BuildEngine.LogMessageEvent(new BuildMessageEventArgs("No Packages to check in", "Help", "Me", MessageImportance.High));
                return false;
            }


        }


    }
}
