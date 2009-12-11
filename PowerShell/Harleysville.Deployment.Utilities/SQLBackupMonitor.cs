using System;
using System.Collections.Generic;
using System.Text;
using System.Data;
using System.Data.Common;
using System.Data.SqlClient;
using System.Data.Sql;
using System.IO;

using Microsoft.SqlServer.Management.Common;
using Microsoft.SqlServer.Management.Smo;
using Harleysville.Powershell.Utilities;

namespace Harleysville.Deployment.Utilities
{
    public class SQLBackupMonitor : SQLSmoHelper
    {
        public string ConnectionError = string.Empty;

        private string Tsql_monitor = @"SELECT command,
            s.text,
            start_time,
            percent_complete, 
            CAST(((DATEDIFF(s,start_time,GetDate()))/3600) as varchar) + ' hour(s), '
                  + CAST((DATEDIFF(s,start_time,GetDate())%3600)/60 as varchar) + 'min, '
                  + CAST((DATEDIFF(s,start_time,GetDate())%60) as varchar) + ' sec' as running_time,
            CAST((estimated_completion_time/3600000) as varchar) + ' hour(s), '
                  + CAST((estimated_completion_time %3600000)/60000 as varchar) + 'min, '
                  + CAST((estimated_completion_time %60000)/1000 as varchar) + ' sec' as est_time_to_go,
            dateadd(second,estimated_completion_time/1000, getdate()) as est_completion_time 
FROM sys.dm_exec_requests r
CROSS APPLY sys.dm_exec_sql_text(r.sql_handle) s
WHERE r.command in ('BACKUP DATABASE', 'BACKUP LOG')";

        /// <summary>
        /// Override to get HPP connection String 
        /// The user name and pswd are decrypted
        /// </summary>
        /// <param name="_serverName"></param>
        /// <param name="_databaseName"></param>
        /// <param name="_hpp">path to Hpp</param>
        /// <param name="_path2Reg">PSH registry path ie HKLM:\SOftware\HGIC\SRM</param>
        public SQLBackupMonitor(string _serverName, string _databaseName, string _hpp, string _path2Reg)
        {
            string connStr = string.Empty;

            try
            {
                PSHScriptHelper _psh = new PSHScriptHelper();
                _psh.ScriptGlobalVariables.Add("serName", _serverName.Trim());
                _psh.ScriptGlobalVariables.Add("dbName", _databaseName.Trim());
                _psh.ScriptGlobalVariables.Add("hppRegPath", _path2Reg.Trim());
                _psh.ScriptGlobalVariables.Add("hpp", _hpp.Trim());
                _psh.ScriptText = _hpp + @"\InvokeScripts\Invoke-GetHppConnStr.ps1";
                connStr = _psh.RunScript();
            }
            catch (Exception _e)
            {
                ConnectionError = _e.ToString();

                connStr = "data source=" + _serverName +";";
                connStr += "Initial Catalog=" + _databaseName + ";";
                connStr += "Trusted_Connection=yes;";
               
            }

            base.Connect2Server(connStr);
        }


        public SQLBackupMonitor (string _connectionStr)
        {
            base.Connect2Server(_connectionStr);

        }

        public DataSet GetBackupProgress()
        {
            try
            {
                DataSet _ds = ServerObj.ConnectionContext.ExecuteWithResults(Tsql_monitor);
                return _ds;
            }
            catch
            {
                return new DataSet("Empty");
            }
        }

        public DataSet GetCompletedBackups()
        {
             string Tsql_backupList = @"SELECT server_name, 
                    database_name, 
                    name, 
                    description, 
                    backup_start_date, 
                    backup_finish_date
                FROM msdb.dbo.backupset 
                WHERE database_name = '" + this.SqlConnObj.Database + 
                "' AND " +
                "backup_finish_date >= '" + DateTime.Now.ToString("MM/dd/yyyy") + @"'
            ORDER BY backup_start_date desc";
            try
            {
                DataSet _ds = ServerObj.ConnectionContext.ExecuteWithResults(Tsql_backupList);
                return _ds;
            }
            catch
            {
                return new DataSet("Empty");
            }
        }

    }
}
