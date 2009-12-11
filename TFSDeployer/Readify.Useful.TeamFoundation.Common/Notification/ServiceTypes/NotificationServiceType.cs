using System;
using System.Collections.Generic;
using System.Text;
using System.Xml.Serialization;
using System.IO;
using System.ServiceModel;
using System.Xml;
using System.Diagnostics;

namespace Readify.Useful.TeamFoundation.Common.Notification
{
    /// <summary>
    /// Base class for creation of end points.  All that needs to occur
    /// is that you create a 
    /// </summary>
    /// <typeparam name="EventTypeT"></typeparam>
    public abstract class NotificationServiceType<EventTypeT>:INotificationService
    {
      
        private EventTypeT _eventReceived;
        public EventTypeT EventReceived
        {
            get { return _eventReceived; }
        }

        private TFSIdentity _identity;
        public TFSIdentity Identity
        {
            get { return _identity; }
        }
	

        #region INotificationService Members

        public void Notify(string eventXml, string tfsIdentityXml)
        {
            TraceHelper.TraceVerbose(Constants.CommonSwitch, "Notifcation Event Receieved Details as follows:");
            TraceHelper.TraceVerbose(Constants.CommonSwitch, "Eventxml");
            TraceHelper.TraceVerbose(Constants.CommonSwitch, eventXml);
            TraceHelper.TraceVerbose(Constants.CommonSwitch, "TfsIdentityXml");
            TraceHelper.TraceVerbose(Constants.CommonSwitch, tfsIdentityXml);

            _eventReceived= ServiceHelper.DeserializeEvent<EventTypeT>(eventXml);
            _identity = ServiceHelper.DeserializeEvent<TFSIdentity>(tfsIdentityXml);
            OnNotificationEvent(_eventReceived,_identity);
        }

        /// <summary>
        /// Do the work in processing the notification event
        /// </summary>
        /// <param name="eventRaised"></param>
        protected abstract void OnNotificationEvent(EventTypeT eventRaised,TFSIdentity identify);



        /// <summary>
        ///// Deserializes a Type
        ///// </summary>
        ///// <typeparam name="T">Type to deserialize</typeparam>
        ///// <param name="serializedType">serialized version of the type</param>
        ///// <returns>DeSerialized version of the type</returns>
        //protected T CreateInstance<T>(string serializedType)
        //{
        //    T customType;
        //    XmlSerializer serializer = new XmlSerializer(typeof(T));

        //    XmlDocument xmlDocument = new XmlDocument();
        //    xmlDocument.LoadXml(serializedType);
        //    XmlNodeReader xmlNodeReader = new XmlNodeReader(xmlDocument);

        //    try
        //    {
        //        customType = (T)serializer.Deserialize(xmlNodeReader);
        //    }
        //    catch
        //    {
        //        //TODO: Add Logging etc here...
        //        throw;
        //    }
        //    return customType;
        //}


        #endregion



        
    }
}
