using System;
using System.Collections.Generic;
using System.Text;
using System.IO;
using System.Configuration;

using Microsoft.Build.Framework;
using Microsoft.Build.Utilities;

using Harleysville.Build.Utilities;

namespace Harleysville.Build.Tasks
{
    /// <summary>
    /// This task will setup the Env.Config Directory Structure (DS) in the Build package 
    /// It will seed the DS from the config section in TFVC under wmsourcecontrol 
    /// DS: 
    /// -Env.Config
    ///     -EnvName 
    ///         -Packagename 
    ///            -*.cnf
    /// </summary>
    public class Set_wMEnvConfig : Task
    {
        private DirectoryInfo _path2EnvConfig;
        [Required]
        public string Path2EnvConfig
        {
            set { _path2EnvConfig = new DirectoryInfo(value); }
        }

        private DirectoryInfo _wsPath;
        [Required]
        public string Path2Source
        {
            set { _wsPath = new DirectoryInfo(value); }
        }

        public override bool Execute()
        {
            try
            {
                return this.SetupEnvConfig();
            }
            catch (Exception _ex)
            {
                string _msg = "wM Config setup failure:\n" + _ex.Message + "\n" + _ex.StackTrace;
                BuildEngine.LogErrorEvent(new BuildErrorEventArgs("wM cnf setup Failure", "cnf Failure",
                                                                  _ex.Source, 0, 0, 0, 0,
                                                                  _msg,
                                                                  "Setup of Env.Config was unseccessful",
                                                                  "TFSBuild"));

                return false;
            }
        }

        /// <summary>
        /// The work horse where all the directory structure work it done
        /// </summary>
        /// <returns>true</returns>
        private bool SetupEnvConfig()
        {
            List<string> _environments = new List<string>();

            DirectoryInfo _configPath = new DirectoryInfo(_wsPath.FullName + @"\Config");

            foreach (DirectoryInfo _envDI in _configPath.GetDirectories("*", SearchOption.TopDirectoryOnly))
            {
                _environments.Add(_envDI.Name);
            }

            foreach (FileInfo _zip in _wsPath.GetFiles("*.zip", SearchOption.AllDirectories))
            {
                string _package = Path.GetFileNameWithoutExtension(_zip.FullName);

                foreach (string _env in _environments)
                {
                    string _pathEnvConfig4Package = Path.Combine(Path.Combine(_path2EnvConfig.FullName, _env), _package);

                    //check to ensure directory structure is in place
                    //if not create it
                    if (!Directory.Exists(_pathEnvConfig4Package))
                    {
                        if (!Directory.Exists(Directory.GetParent(_pathEnvConfig4Package).FullName))
                        {
                            Directory.CreateDirectory(Directory.GetParent(_pathEnvConfig4Package).FullName);
                        }

                        Directory.CreateDirectory(_pathEnvConfig4Package);
                    }

                    DirectoryInfo _packageEnvDI = new DirectoryInfo(Path.Combine(Path.Combine(Path.Combine(_configPath.FullName, _env), "Packages"), _package));

                    if (_packageEnvDI.Exists)
                    {
                        foreach (FileInfo _cnf in _packageEnvDI.GetFiles("*.cnf", SearchOption.AllDirectories))
                        {
                            _cnf.CopyTo(Path.Combine(_pathEnvConfig4Package, _cnf.Name));
                        }
                    }

                }
            }



            return true;


        }
    }
}
