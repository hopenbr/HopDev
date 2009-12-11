using System;
using System.Collections.Generic;
using System.Text;
using System.Management.Automation;
using System.Collections;

using Harleysville.Deployment.Utilities;

namespace Harleysville.Deployment.SnapIn
{
    [Cmdlet(VerbsCommon.Get, "TFVC", SupportsShouldProcess = true)]
    public class Get_TFVC : PSCmdlet
    {

        #region Parameters

        private string _project;
        [Parameter(Position = 0,
            Mandatory = true,
            ValueFromPipelineByPropertyName = true,
            HelpMessage = "Help Text")]
        [ValidateNotNullOrEmpty]
        public string TeamProject
        {
            get { return _project; }
            set { _project = value; }
        }

        private string _buildNumber;
        [Parameter(Position = 1,
            Mandatory = true,
            ValueFromPipelineByPropertyName = true,
            HelpMessage = "Help Text")]
        [ValidateNotNullOrEmpty]
        public string BuildNumber
        {
            get { return _buildNumber; }
            set { _buildNumber = value; }
        }


        #endregion

        protected override void ProcessRecord()
        {
            try
            {
                TFS _tfs = new TFS();
                WriteObject(_tfs.GetBuildPackageFromTFS(_project, _buildNumber), true);
            }
            catch (Exception)
            {

            }
        }
    }
}
