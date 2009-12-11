using System;
using System.Data;
using System.Configuration;
using System.Collections;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;

using Harleysville.Deployment.Utilities;

namespace Harleysville.Deployment.WebApp
{
    public partial class RCSImagration : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (IsPostBack)
            {
                RCSHelper _rcsh = new RCSHelper(dbiNumber.Text, ConfigurationManager.AppSettings.Get("HPP_Location"), Context.User.Identity.Name);

               // ResultsHr.Visible = true;

                Label2.Visible = true;
                Label2.Text = "DBI " +  dbiNumber.Text + " has been completed; please review below results.";
                dbiNumber.Text = "";

                ResultsBox.Visible = true;
                ResultsBox.Text = _rcsh.Results;
                
            }
            
            
        }
  
    }
}
