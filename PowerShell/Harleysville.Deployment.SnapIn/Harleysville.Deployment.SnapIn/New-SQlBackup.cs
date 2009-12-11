using System;
using System.Collections.Generic;
using System.Text;
using System.Management.Automation;
using System.Collections;


namespace Harleysville.Deployment.SnapIn
{
    [Cmdlet(VerbsCommon.New, "SQlBackup", SupportsShouldProcess = true)]
    public class SQl_Backup : PSCmdlet
    {

        #region Parameters

        private string _connStr = "";

        [Parameter(Position = 0,
            Mandatory = true,
            ValueFromPipelineByPropertyName = true,
            HelpMessage = "Connection string to Database to be backed up")]
        [ValidateNotNullOrEmpty]
        public string ConnectionStr
        {
            set { _connStr = value; }
            get { return _connStr; }
        }

        private string _backupLocation = "";

        [Parameter(Position = 1,
            Mandatory = true,
            ValueFromPipelineByPropertyName = true,
            HelpMessage = "Full Unc path to backup file location")]
        [ValidateNotNullOrEmpty]
        public string BackupLocation
        {
            set { _backupLocation = value; }
            get { return _backupLocation; }
        }

        private string _mName = "";

        [Parameter(Position = 2,
            Mandatory = true,
            ValueFromPipelineByPropertyName = false,
            HelpMessage = "The media name of the backup")]

        [ValidateNotNullOrEmpty]
        public string MediaName
        {
            set 
            {
                if (String.IsNullOrEmpty(value))
                {
                    _mName = "TfsBackup_" + DateTime.Now.ToString("yyyyMMddhhmmss");
                }
                else
                {
                    _mName = value;
                }
            }
            get { return _mName; }
        }

        #endregion

        protected override void ProcessRecord()
        {
            try
            {
                SqlBackupHelper _sbh = new SqlBackupHelper(_connStr, _backupLocation, _mName);

                WriteObject(_sbh as object);
            }
            catch (Exception _ex)
            {
                WriteError(new ErrorRecord(_ex, "420", ErrorCategory.NotSpecified, null));
            }
        }

    }
}
