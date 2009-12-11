using System;
using System.Collections.Generic;
using System.Text;
using Readify.Useful.TeamFoundation.Common.Notification;

namespace Readify.Useful.TeamFoundation.Common.Listener
{
    public class BuildCompletionEventArgs:NotificationEventArgs<BuildCompletionEvent>
    {
        public BuildCompletionEventArgs(BuildCompletionEvent eventRecieved, TFSIdentity identity)
            : base(eventRecieved, identity)
        {
        }
    }
}
