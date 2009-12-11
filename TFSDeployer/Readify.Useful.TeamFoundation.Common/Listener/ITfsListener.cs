using System;
using System.Collections.Generic;
using System.Text;
using Microsoft.TeamFoundation.VersionControl.Common;

namespace Readify.Useful.TeamFoundation.Common.Listener
{
    interface ITfsListener
    {
        event EventHandler<CheckinEventArgs> CheckinEventReceived;
        event EventHandler<BuildCompletionEventArgs> BuildCompletionEventReceived;
        event EventHandler<BuildStatusChangeEventArgs> BuildStatusChangeEventReceived;
    }
}
