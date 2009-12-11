using System;
using System.Collections.Generic;
using System.Text;
using System.Management.Automation;
using System.Collections;
using System.DirectoryServices;

namespace Harleysville.Deployment.SnapIn
{
    [Cmdlet(VerbsCommon.Clear, "AppPool", SupportsShouldProcess = true)]
    public class Recyle_AppPool : PSCmdlet
    {

        #region Parameters
        private string _serverName;
        [Parameter(Position = 0,
            Mandatory = true,
            ValueFromPipelineByPropertyName = true,
            HelpMessage = "The Server name that host the IIS where the AppPool is")]
        [ValidateNotNullOrEmpty]
        public string ServerName
        {
            get { return _serverName; }
            set { _serverName = value; }
        }

        private string _appPoolName;
        [Parameter(Position = 1,
            Mandatory = true,
            ValueFromPipelineByPropertyName = true,
            HelpMessage = "The name of the AppPool that needs to be recycled/cleared")]
        [ValidateNotNullOrEmpty]
        public string AppPoolName
        {
            get { return _appPoolName; }
            set { _appPoolName = value; }
        }

 
        #endregion


        private int _attempts = 0;

        protected override void ProcessRecord()
        {
            string _path = "IIS://" + _serverName + "/W3SVC/AppPools/" + _appPoolName;

            try
            {
                DirectoryEntry _w3svc = new DirectoryEntry(_path);
                _w3svc.Invoke("Recycle", null);
                WriteObject(_path + " was recycled");

            }
            catch (System.Runtime.InteropServices.COMException _ex)
            {
                _attempts++;

                if (_attempts < 4)
                {
                    this.ProcessRecord();
                }
                else
                {
                    WriteError(new ErrorRecord(_ex, "3AppPoolRecycleFailure", ErrorCategory.ResourceUnavailable, (object)_path));
                    throw (_ex);
                }
            }
            catch (Exception ex)
            {
                throw (ex);

            }
        }
    }
}
