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
    /// Summary description for Harleysville.DBI.Helper
    /// </summary>
    [Serializable]
    public class BBIHelper : WorkItemHelper
    {
        public BBIHelper(WorkItemChangedEvent _wice, string tfsUrl, int _bbiNum)
        {
            SetWorkItemHelper(_wice, tfsUrl, _bbiNum);
        }

    }
}
