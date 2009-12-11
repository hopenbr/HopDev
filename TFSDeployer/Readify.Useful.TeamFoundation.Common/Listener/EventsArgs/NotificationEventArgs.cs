using System;
using System.Collections.Generic;
using System.Text;
using Readify.Useful.TeamFoundation.Common.Notification;

namespace Readify.Useful.TeamFoundation.Common.Listener
{
    public class NotificationEventArgs<T>:EventArgs
    {

        private T _eventRaised;

        public T EventRaised
        {   
            get { return _eventRaised; }
            set { _eventRaised = value; }
        }
	

        private TFSIdentity _identity;
        public TFSIdentity TFSIdentity
        {
            get { return _identity; }
            set { _identity = value; }
        }

        public NotificationEventArgs(T eventRaised, TFSIdentity identity)
        {
            EventRaised = eventRaised;
            TFSIdentity = identity;
        }
	
    }
}
