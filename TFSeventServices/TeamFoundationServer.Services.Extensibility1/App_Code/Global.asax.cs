using System;
using System.Data;
using System.Configuration;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;

namespace Harleysville.TFSEventServices
{
    /// <summary>
    /// Summary description for Global
    /// </summary>
    /// 
    public class Global : System.Web.HttpApplication
    {
        /// <summary>
        /// Use this obj to lock when calling PSH script that call Infomatica
        /// </summary>
        public static object infoLockObj; 

        public Global()
        {
            //g_infoLockObj = new object();
        }

        public void Application_Start(object sender, EventArgs e)
        {
            // Code that runs on application startup
           infoLockObj = new object();

        }

        void Application_End(object sender, EventArgs e)
        {
            //  Code that runs on application shutdown

        }

        void Application_Error(object sender, EventArgs e)
        {
            // Code that runs when an unhandled error occurs

        }

        void Session_Start(object sender, EventArgs e)
        {
            // Code that runs when a new session is started

        }

        void Session_End(object sender, EventArgs e)
        {
            // Code that runs when a session ends. 
            // Note: The Session_End event is raised only when the sessionstate mode
            // is set to InProc in the Web.config file. If session mode is set to StateServer 
            // or SQLServer, the event is not raised.

        }
    }
}
