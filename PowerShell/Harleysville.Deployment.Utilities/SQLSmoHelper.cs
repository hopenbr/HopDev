using System;
using System.Collections.Generic;
using System.Text;
using System.Data.SqlClient;
using Microsoft.SqlServer.Management.Common;
using Microsoft.SqlServer.Management.Smo;


namespace Harleysville.Deployment.Utilities
{
    public class SQLSmoHelper
    {
        private SqlConnection _conn;
        private ServerConnection _sconn;
        private Server _svr;

        public SqlConnection SqlConnObj
        {
            get { return _conn; }
        }

        public ServerConnection ServerConnObj
        {
            get { return _sconn; }
        }

        public Server ServerObj
        {
            get { return _svr; }
        }

        public void Connect2Server (string ConnectionStr)
        {
            _conn = new SqlConnection(ConnectionStr);

           // _conn.Open();

            _sconn = new ServerConnection(_conn);

            _svr = new Server(_sconn);
        }
    }
}
