using System;
using System.Collections.Generic;
using System.Text;

using Microsoft.Build.Framework;
using Microsoft.Build.Utilities;

using Harleysville.Build.Utilities;

namespace Harleysville.Build.Tasks
{
    public class Check4Changesets : Task
    {
        private string _lastGoodBuild;
        [Required]
        public string LastGoodBuildNumber
        {
            get { return _lastGoodBuild; }
            set { _lastGoodBuild = value; }
        }

        private string _ws;
        [Required]
        public string Workspace
        {
            get { return _ws; }
            set {_ws = value; }
        }

        private string _owner;
        [Required]
        public string Owner
        {
            get { return _owner; }
            set { _owner = value; }
        }

        public override bool Execute()
        {
            try
            {
                
                TFVC _tfs = new TFVC();
                bool _changesetsFound = false;
                foreach (string _vcPath in _tfs.GetWorkspaceWorkingFolderServerMappings(_ws, _owner))
                {
                    BuildMessageEventArgs _bmsg = new BuildMessageEventArgs("Checking: " + _vcPath, "help", null, MessageImportance.Low);
                    BuildEngine.LogMessageEvent(_bmsg);
                    if (_tfs.Check4ChangeSetsSinceLabel(_lastGoodBuild, _vcPath))
                    {
                        BuildEngine.LogMessageEvent(new BuildMessageEventArgs("Changesets founds[" + _tfs.ChangesetsFoundCount + "]: " + _tfs.ChangesetsFound, "help", null, MessageImportance.Low));
                        _changesetsFound = true;
                        break;
                    }
                }

                if (_changesetsFound)
                {
                    return true;
                }
                else
                {
                    BuildErrorEventArgs _berror = new BuildErrorEventArgs("No Changes since last good build", "HIC:4201", null, 0, 0, 0, 0, "No changessets were found since the " + _lastGoodBuild, null, null);
                    BuildEngine.LogErrorEvent(_berror);
                    return false;
                }
                
            }
            catch (Exception _ex)
            {
                BuildErrorEventArgs _berr = new BuildErrorEventArgs(_ex.Message, _ex.StackTrace, _ex.Source, 0, 0, 0, 0, _ex.Message, _ex.HelpLink, null);
                BuildEngine.LogErrorEvent(_berr);
                return false;
            }


        }
        
    }
}
