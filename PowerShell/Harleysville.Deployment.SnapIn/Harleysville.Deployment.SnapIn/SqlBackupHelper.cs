using System;
using System.Collections.Generic;
using System.Text;
using System.Configuration;
using System.IO;
using System.Data.SqlClient;
using Microsoft.SqlServer.Management.Smo;
using Microsoft.SqlServer.Management.Common;

namespace Harleysville.Deployment.SnapIn
{
    class SqlBackupHelper
    {
        private string _connStr = "";
        public string ConnectionStr
        { 
            get { return _connStr; }

        }

        private int _percentComplete = 0;
        public int PercentComplete
        {
            get { return _percentComplete; }
        }

        private string _backupLocation = "";
        public string BackupLocation
        {
            get { return _backupLocation; }
        }

        private Backup _bkp;
        private Server _svr;

        public SqlBackupHelper(string connStr, string bkloc, string mediaName)
        {
            _connStr = connStr;
            _backupLocation = bkloc;

            try
            {
                SqlConnection _conn = new SqlConnection(_connStr);

                ServerConnection _sconn = new ServerConnection(_conn);

                _svr = new Server(_sconn);

                _bkp = new Backup();

                _bkp.Action = BackupActionType.Database;

                _bkp.Devices.AddDevice(_backupLocation, DeviceType.File);

                _bkp.Database = _conn.Database;

                _bkp.NoRewind = false;

                _bkp.Initialize = true;

                _bkp.UnloadTapeAfter = false;

                _bkp.MediaName = mediaName;

                _bkp.PercentCompleteNotification = 1;

                _bkp.PercentComplete += new PercentCompleteEventHandler(_bkp_PercentComplete);

               
            }
            catch (Exception _ex)
            {
                throw (_ex);
            }
        }

        //public int GetProgressOfBackUp(string _connStr)
        //{
        //    SqlConnection _conn = new SqlConnection(_connStr);

        //    ServerConnection _sconn = new ServerConnection(_conn);

        //    _svr = new Server(_sconn);

        //    //_conn.InfoMessage += new SqlInfoMessageEventHandler(ProgressStatus);
        //}

        //private void ProgressStatus(object _sender, SqlInfoMessageEventHandler e)
        //{

        //}

        public void StartBackup()
        {
            //_bkp.SqlBackup(_svr);
            _bkp.SqlBackupAsync(_svr);
        }

        void _bkp_PercentComplete(object sender, PercentCompleteEventArgs e)
        {
            _percentComplete = e.Percent;
        }
    }
}
