using System;
using System.Data;
using System.Configuration;
using System.Globalization;
using System.Text;
using System.IO;
using System.Collections.Generic;
using System.Web.UI.HtmlControls;
using System.Drawing;
using TFSeventClasses;
using System.Xml;
using System.Text.RegularExpressions;


namespace Harleysville.TFSEventServices
{
    /// <summary>
    /// This is a very simple interface that will work with the workitem facotry to 
    /// return the correct workitem alert type 
    /// </summary>
    public interface IHarleysvilleWorkItemAlerts
    {
        /// <summary>
        /// This method will kick off any and all alert and asignments that need to happen 
        /// due to the change to the workitem that just happened
        /// </summary>
        void WorkItemActions();

        /// <summary>
        /// This method will email the exception to the proper mailbox
        /// </summary>
        /// <param name="_sub">subject of message</param>
        /// <param name="_body">Body of message with exception</param>
        void DebugMailer(string _sub, string _body);
    }
}
