using System;
using System.Collections.Generic;
using System.Text;
using Microsoft.TeamFoundation.VersionControl.Common;
using Readify.Useful.TeamFoundation.Common.Notification;

namespace Readify.Useful.TeamFoundation.Common.Listener
{
    public class CheckinEventArgs:NotificationEventArgs<CheckinEvent>
    {
        public CheckinEventArgs(CheckinEvent eventRecieved, TFSIdentity identity)
            : base(eventRecieved, identity)
        {
        }
    }
}
