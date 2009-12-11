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
    public partial class NewWMBuildPackage : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (IsPostBack)
            {
                wmPackageHelper _wph = new wmPackageHelper(wMpackName.Text, 
                                                           wMprojType.Text, 
                                                           ConfigurationManager.AppSettings.Get("HPP_Location"),
                                                           wMConfigFileName.Value,
                                                           Context.User.Identity.Name);



                Label4.Visible = true;
                Label4.Text = "Process Complete Please review below results";
                wMResults.Visible = true;
                wMResults.Text = "Build package complete\nResults: " + _wph.Results;

            }

        }

    }
}
