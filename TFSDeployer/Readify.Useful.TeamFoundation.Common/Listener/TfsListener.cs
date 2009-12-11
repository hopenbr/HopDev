using System;
using System.Collections.Generic;
using System.Text;
using Readify.Useful.TeamFoundation.Common.Notification;
using Readify.Useful.TeamFoundation.Common;
using System.ServiceModel;
using Microsoft.TeamFoundation.VersionControl.Common;
using Readify.Useful.TeamFoundation.Common.Properties;
using System.Diagnostics;

namespace Readify.Useful.TeamFoundation.Common.Listener
{
    public class TfsListener:ITfsListener
    {
        
        #region ITfsListener Members
        private List<ITfsEventListener> _eventListeners = new List<ITfsEventListener>();
        public event EventHandler<CheckinEventArgs> CheckinEventReceived;
        public event EventHandler<BuildCompletionEventArgs> BuildCompletionEventReceived;
        public event EventHandler<BuildStatusChangeEventArgs> BuildStatusChangeEventReceived;

        #endregion
        
        public void Start()
        {
            RegisterEventListeners();

          
            foreach(ITfsEventListener listener in _eventListeners)
            {
                listener.Start();
            }
            
        }

        private void RegisterEventListeners()
        {
            if (CheckinEventReceived != null)
            {
                TfsEventListener<CheckinEvent> checkinListener = new TfsEventListener<CheckinEvent>();
                TfsEventListener<CheckinEvent>.NotificationDelegate = delegate(CheckinEvent eventRaised, TFSIdentity identity) { CheckinEventReceived(this, new CheckinEventArgs(eventRaised, identity)); };
                _eventListeners.Add(checkinListener);
            }

            if (BuildCompletionEventReceived != null)
            {
                TfsEventListener<BuildCompletionEvent> buildCompletionEvent = new TfsEventListener<BuildCompletionEvent>();
                TfsEventListener<BuildCompletionEvent>.NotificationDelegate = delegate(BuildCompletionEvent eventRaised, TFSIdentity identity) { BuildCompletionEventReceived(this, new BuildCompletionEventArgs(eventRaised, identity)); };
                _eventListeners.Add(buildCompletionEvent);
            }

            if (BuildStatusChangeEventReceived != null)
            {
                TfsEventListener<BuildStatusChangeEvent> buildStatusChangeEvent = new TfsEventListener<BuildStatusChangeEvent>();
                TfsEventListener<BuildStatusChangeEvent>.NotificationDelegate = delegate(BuildStatusChangeEvent eventRaised, TFSIdentity identity) { BuildStatusChangeEventReceived(this, new BuildStatusChangeEventArgs(eventRaised, identity)); };
                _eventListeners.Add(buildStatusChangeEvent);
            }
        }

        

        public void Stop()
        {
            foreach(ITfsEventListener listener in _eventListeners)
            {
                listener.Stop();
            }

        }




        
    }
}

