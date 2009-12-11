using System;
using System.Collections.Generic;
using System.Text;
using System.Management.Automation;
using System.Collections;

using Harleysville.Deployment.Utilities;

namespace Harleysville.Deployment.SnapIn
{
    [Cmdlet(VerbsCommon.Add, "TFVC", SupportsShouldProcess = true)]
    public class Add_TFVC : PSCmdlet
    {

        #region Parameters

        private string _localPath;
        [Parameter(Position = 0,
            Mandatory = true,
            ValueFromPipelineByPropertyName = true,
            HelpMessage = "the local directoy where code to be added to TFVC")]
        [ValidateNotNullOrEmpty]
        public string LocalPath
        {
            get { return _localPath; }
            set { _localPath = value; }
        }

        private string _serverPath;
        [Parameter(Position = 1,
            Mandatory = true,
            ValueFromPipelineByPropertyName = true,
            HelpMessage = "The path in the TFVC repository")]
        [ValidateNotNullOrEmpty]
        public string ServerPath
        {
            get { return _serverPath; }
            set { _serverPath = value; }
        }

        #endregion

        protected override void ProcessRecord()
        {
            try
            {
                TFS _tfs = new TFS();
                WriteObject(_tfs.Add2SourceControl(_serverPath, _localPath));
            }
            catch(Exception ex)
            {
                throw ex;
            }
        }
    }
}
