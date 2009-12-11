using System;
using System.Collections.Generic;
using System.Text;

using Microsoft.Build.Framework;
using Microsoft.Build.Utilities;

using Harleysville.Build.Utilities;

namespace Harleysville.Build.Tasks
{
    public class DropChangeSets : Task
    {
        private string _lastGoodBuild;
        [Required]
        public string LastGoodBuildNumber
        {
            get { return _lastGoodBuild; }
            set { _lastGoodBuild = value; }
        }

        private string _sourceControlPath;
        [Required]
        public string SourceControlPath
        {
            get { return _sourceControlPath; }
            set { _sourceControlPath = value; }
        }

        private string _dropPath;
        [Required]
        public string BuildPackageDropPath
        {
            get { return _dropPath; }
            set { _dropPath = value; }
        }

        private string _ext = String.Empty;

        public string Extentions
        {
            get { return _ext; }
            set { _ext = value; }
        }


        public override bool Execute()
        {
            try
            {
                
                TFVC _tfs = new TFVC();
                if (_ext.Length != 0)
                {
                    _tfs.DownloadLatestChangeSets(_lastGoodBuild, _sourceControlPath, _dropPath, _ext.Split(';'));
                }
                else
                {
                    _tfs.DownloadLatestChangeSets(_lastGoodBuild, _sourceControlPath, _dropPath, new string[1] {"*"});
                }
            }
            catch (Exception _ex)
            {
                throw (_ex);
            }

            return true;

        }
    }
}
