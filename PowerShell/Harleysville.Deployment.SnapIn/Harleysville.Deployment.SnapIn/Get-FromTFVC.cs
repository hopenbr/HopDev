using System;
using System.Collections.Generic;
using System.Text;
using System.Management.Automation;
using System.Collections;

using Harleysville.Deployment.Utilities;

namespace Harleysville.Deployment.SnapIn
{
    /// <summary>
    /// This Cmdlet will download the selected element(s) from TFVC to a local directory.
    /// </summary>
    [Cmdlet(VerbsCommon.Get, "FromTFVC", SupportsShouldProcess = true)]
    public class Get_FromTFVC : PSCmdlet
    {

        #region Parameters

        private string _local;
        [Parameter(Position = 0,
            Mandatory = true,
            ValueFromPipelineByPropertyName = true,
            HelpMessage = "Local path where server element will be mapped")]
        [ValidateNotNullOrEmpty]
        public string LocalPath
        {
            set { _local = value; }
        }

        private string _server;
        [Parameter(Position = 1,
            Mandatory = true,
            ValueFromPipelineByPropertyName = true,
            HelpMessage = "Server path in TFVC ")]
        [ValidateNotNullOrEmpty]
        public string ServerPath
        {
            set { _server = value; }
        }

        private string _label = string.Empty;
        [Parameter(Position = 2,
            Mandatory = false,
            ValueFromPipelineByPropertyName = true,
            HelpMessage = "The label to use during get")]
        [ValidateNotNullOrEmpty]
        public string Label
        {
            set { _label = value; }
        }


        #endregion

        /// <summary>
        /// return full path to local parent direct of Source control elements
        /// </summary>
        protected override void ProcessRecord()
        {
            try
            {
                TFS _tfs = new TFS();

                if (String.IsNullOrEmpty(_label))
                {
                    _tfs.GetFromTFVC(_server, _local);
                }
                else
                {
                    _tfs.GetFromTFVC(_server, _local, _label);
                }

                WriteObject(_local);
            }
            catch (Exception _ex)
            {
                WriteError(new ErrorRecord(_ex, "1", ErrorCategory.InvalidOperation, (object)_server));
            }
        }
    }
}
