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

namespace Harleysville.Deployment.WebApp.UserControls
{
    public partial class HppSubTile : System.Web.UI.UserControl
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            HppWebUser.Text = "User: " + Context.User.Identity.Name;

            HppVersion.Text = "Hpp 2.0";
        }
    }
}