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
    [Cmdlet(VerbsData.Compare, "Files", SupportsShouldProcess = true)]
    public class Compare_Files : PSCmdlet
    {

        #region Parameters

        private FileInfo _file1;
        [Parameter(Position = 0,
            Mandatory = true,
            ValueFromPipelineByPropertyName = true,
            HelpMessage = "The first file you want to compare")]
        [ValidateNotNullOrEmpty]
        public string File1
        {
            set { _file1 = new FileInfo(value); }
            get { return _file1.FullName; }
            
        }

        private FileInfo _file2;
        [Parameter(Position = 1,
            Mandatory = true,
            ValueFromPipelineByPropertyName = true,
            HelpMessage = "The first file you want to compare")]
        [ValidateNotNullOrEmpty]
        public string File2
        {
            set { _file2 = new FileInfo(value); }
            get { return _file2.FullName; }

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
 
        #endregion

        protected override void ProcessRecord()
        {
            EventLog _el = new EventLog("Application", Environment.MachineName, "Harleysville.File.Compare");

            try
            {
                if (GetCheckSum(_file1.OpenRead()).Equals(GetCheckSum(_file2.OpenRead())))
                {
                    WriteObject(true);
                }
                else
                {
                    WriteObject(false);
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

        private string GetCheckSum(FileStream _fs)
        {
            //compare contents of files via checksum 
            //SHA512 _sha = SHA512.Create();
            SHA512Managed _sha = new SHA512Managed();
            
            StringBuilder sb = new StringBuilder();

            foreach (byte b in _sha.ComputeHash(_fs))
            {
                sb.Append(b.ToString("x2").ToLower());
            }

            _fs.Close();
            _sha.Clear();
            if (_debug)
            {
                WriteObject(sb.ToString());
            }

            return (sb.ToString());
        }
    }
}
