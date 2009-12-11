using System;
using System.Data;
using System.Web;
using System.Collections;
using System.Web.Services;
using System.Web.Services.Protocols;
using System.ComponentModel;
using System.Data.SqlClient;

using Harleysville.Deployment.Utilities;


namespace Harleysville.Deployment.WebServices
{
    /// <summary>
    /// Deployment Services will house helper methods for SRM deployments 
    /// Most calls will be via the TFS Deployers scripts 
    /// These services were deisgned and built by:
    /// Brian J. Hopnewasser Dec, 2008
    /// </summary>
    [WebService(Namespace = "http://Harleysvillegroup.com/")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    [ToolboxItem(false)]
    public class DeploymentServices : System.Web.Services.WebService
    {

        [WebMethod]
        public void MonitorBackupStatus(string ConnectionStr, string NotificationAddress)
        {
            string _outFile = @"C:\temp\backupProgress.xml";
 
            SQLBackupMonitor _sbm = new SQLBackupMonitor(ConnectionStr);

            DataSet _ds = _sbm.GetBackupProgress();

            _ds.WriteXml(_outFile);
        }
    }
}
