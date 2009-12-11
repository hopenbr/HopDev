using System;
using System.Data;
using System.Configuration;
using System.Collections;
using System.Web;
using System.Web.Security;
using System.Web.SessionState;

namespace Harleysville.Deployment.WebApp
{
    public class Global : System.Web.HttpApplication
    {

        protected void Application_Start(object sender, EventArgs e)
        {

        }

        protected void Application_End(object sender, EventArgs e)
        {

        }

        protected void Application_EndRequest(Object sender, EventArgs e)
        { 
         HttpContext context = HttpContext.Current;
         if (context.Response.Status.Substring(0,3).Equals("401"))
         {
            context.Response.ClearContent();
            context.Response.Write("<script language=\"javascript\">" + 
                         "self.location='./NoAccess.htm';</script>");
         } 
        }
    }
}