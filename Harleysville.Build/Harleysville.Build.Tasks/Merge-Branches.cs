using System;
using System.Collections.Generic;
using System.Text;
using System.IO;

using Microsoft.Build.Framework;
using Microsoft.Build.Utilities;

using Harleysville.Build.Utilities;


namespace Harleysville.Build.Tasks
{
    public class Merge_Branches : Task
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

        private string _source;
        [Required]
        public string SourceBranch
        {
            get { return _source; }
            set { _source = value; }
        }

        private string  _target;
        [Required]
        public string TargetBranch
        {
            get { return _target; }
            set { _target = value; }
        }

        private int _wiNum;
        [Required]
        public int WorkItemNumber
        {
            get { return _wiNum; }
            set { _wiNum = value; }
        }

        private string _BuildNumer;
        [Required]
        public string BuildNumber
        {
            get { return _BuildNumer; }
            set { _BuildNumer = value; }
        }

        public override bool Execute()
        {
            try
            {
                return Merge();
            }
            catch (Exception _ex)
            {
                string _msg = "Merge failure from " + _source + " to " + _target + "\n" + _ex.Message + "\n" + _ex.StackTrace;
                BuildEngine.LogErrorEvent(new BuildErrorEventArgs("Merge Failure", "Merge Failure",
                                                                  _ex.Source, 420, 69, 45, 25, 
                                                                  _msg, 
                                                                  "Check undo any pending changes in target branch (" + _target + ")", 
                                                                  "TFSBuild"));

              
                return false;

            }
        }

        private bool Merge()
        {
            TFVC _tfs = new TFVC();
            BuildEngine.LogMessageEvent(new BuildMessageEventArgs("Starting Merge from " + _source + "To " + _target, "Help", "Me", MessageImportance.High));
            bool _wasMergeSuccessful = _tfs.Merge(_source, _target, _wsName, _owner);
            if (!_wasMergeSuccessful)
            {

                BuildEngine.LogErrorEvent(new BuildErrorEventArgs("Merge Failure", "Merge",
                                                                  "TFVC", 6969, 69, 45, 25,
                                                                  "TFVC Merge conflict needs action\n" +
                                                                  "There was a failure during merge, maunal merge needed\nError Msg:\n" + _tfs.ErrorMsg,
                                                                  null, "TFSBuild"));

                return false;
            }
            BuildEngine.LogMessageEvent(new BuildMessageEventArgs("Merge Complete, checking in", "Help", "Me", MessageImportance.High));
            bool _wasCheckinSuccessful = _tfs.CheckinAll(_wsName, _owner, "Merge for build " + _BuildNumer, _wiNum);

            if (!_wasCheckinSuccessful)
            {
                
                BuildEngine.LogErrorEvent(new BuildErrorEventArgs("Checkin Failure", "Merge",
                                                                  "TFVC", 6969, 69, 45, 25,
                                                                  "TFVC Checkin error\n" +
                                                                  "There was a failure during checkin, possible issues are no elements to check in after merge, TFSbuild does not have pend change rights to target, etc",
                                                                  null, "TFSBuild"));

                return false;
            }

            BuildEngine.LogMessageEvent(new BuildMessageEventArgs("Checking in complete", "Help", "Me", MessageImportance.High));
            return true;
            
        }


    }
}
