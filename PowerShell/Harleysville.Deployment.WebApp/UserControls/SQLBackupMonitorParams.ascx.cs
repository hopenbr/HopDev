using System;
using System.Data;
using System.Configuration;
using System.Collections;
using System.Collections.Generic;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;

using Harleysville.Deployment.Utilities;

namespace Harleysville.Deployment.WebApp.UserControls
{
    public partial class SQLBackupMonitorParams : System.Web.UI.UserControl
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            Dictionary<string, string> _params = new Dictionary<string, string>();
            
            bool gotParams = true;

            if (Request.QueryString.HasKeys() &&
                Request.QueryString["Server"] != null &&
                Request.QueryString["Database"] != null)
            {
                string _sn = Request.QueryString["Server"];
                string _db = Request.QueryString["Database"];

                 _params.Add("server", _sn);
                 _params.Add("database", _db);
              
            }
            else if (SBM_SName.Value.Length > 10 &&
                     SBM_DBName.Value.Length > 3)
            {
                //_params.Add("server", SBM_SName.Value);
                //_params.Add("database", SBM_DBName.Value);

                string _url = Request.Url.ToString();

                _url += "?Server=" + SBM_SName.Value;
                _url += "&Database=" + SBM_DBName.Value;

                Response.Redirect(_url);
               
            }
            else
            {
                SBM_GetParamsPanel.Visible = true;
                gotParams = false;
            }

            if (gotParams)
            {
                SBM_Title.Text = "Backup Status on " + _params["server"];
                SBM_ViewsPanel.Visible = true;
                SBM_GetParamsPanel.Visible = false;

                //SQLBackupMonitor _sbm = new SQLBackupMonitor("Data Source=" + _params["server"] + ";Initial Catalog=" + _params["database"] + ";User ID=TFSDeployer;pwd=simple");

                SQLBackupMonitor _sbm = new SQLBackupMonitor(_params["server"],_params["database"], ConfigurationManager.AppSettings.Get("HPP_Location"), ConfigurationManager.AppSettings.Get("HPP_Reg"));

                DataSet _ds = _sbm.GetBackupProgress();

                SBM_InProgGV.DataSource = _ds;
                SBM_InProgGV.DataBind();

                DataSet _ds1 = _sbm.GetCompletedBackups();

                SBM_CompletedGV.DataSource = _ds1;
                SBM_CompletedGV.DataBind();
            }
        }
    }
}