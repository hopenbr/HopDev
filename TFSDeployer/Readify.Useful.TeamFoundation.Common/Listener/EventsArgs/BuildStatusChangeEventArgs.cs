using System;
using System.Collections.Generic;
using System.Text;
using Readify.Useful.TeamFoundation.Common.Notification;

namespace Readify.Useful.TeamFoundation.Common.Listener
{
    public class BuildStatusChangeEventArgs : NotificationEventArgs<BuildStatusChangeEvent>
    {
        public BuildStatusChangeEventArgs(BuildStatusChangeEvent eventRecieved, TFSIdentity identity)
            : base(eventRecieved, identity)
        {
        }
    }
}
