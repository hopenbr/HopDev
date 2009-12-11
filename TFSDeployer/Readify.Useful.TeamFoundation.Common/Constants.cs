using System;
using System.Collections.Generic;
using System.Text;
using System.Diagnostics;

namespace Readify.Useful.TeamFoundation.Common
{
    internal static class Constants
    {
        public static TraceSwitch CommonSwitch = new TraceSwitch("Readify.Useful.TeamFoundation.Common", "Trace switch for the common components of team foundation", "0");
        public const string NotificationServiceHost = "NotificationServiceHost";
        public const string ServiceHelper = "ServiceHelper";
    }
}
