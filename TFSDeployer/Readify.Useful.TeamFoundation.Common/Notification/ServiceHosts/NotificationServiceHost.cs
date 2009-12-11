using System;
using System.Collections.Generic;
using System.Text;
using System.ServiceModel;
using Microsoft.TeamFoundation.Server;
using Readify.Useful.TeamFoundation.Common.Properties;
using System.ServiceModel.Activation;
using System.Net;
using System.Reflection;
using Readify.Useful.TeamFoundation.Common.Notification;
using Microsoft.TeamFoundation.VersionControl.Common;
using System.Diagnostics;

namespace Readify.Useful.TeamFoundation.Common.Notification
{

    /// <summary>
    /// Base class for the service hosts.
    /// </summary>
    public class NotificationServiceHost<EventTypeT>:ServiceHost,IDisposable where EventTypeT : new()
    {

        public NotificationServiceHost(object singletonInstance, Uri baseAddress)
            : this(singletonInstance,baseAddress, CredentialCache.DefaultNetworkCredentials.UserName)
        {
        }

        public NotificationServiceHost(object singletonInstance, Uri baseAddress,string userName):base(singletonInstance,baseAddress)
        {
            _userName = userName;
        }

        public NotificationServiceHost(Type serviceType, Uri baseAddress)
            : this(serviceType, baseAddress,CredentialCache.DefaultNetworkCredentials.UserName)
        {
            
        }

        public NotificationServiceHost(Type serviceType, Uri baseAddress, string userName ):base(serviceType, baseAddress)
        {
            _userName = userName;
            
        }

        private string _userName;
        public string UserName
        {
            get
            {
                return _userName;
            }
        }

        
        private DeliveryPreference CreateDeliveryPrefrence(string endPointAddress)
        {
            DeliveryPreference preference = new DeliveryPreference();
            preference.Address = endPointAddress;
            preference.Type = DeliveryType.Soap;
            preference.Schedule = DeliverySchedule.Immediate;
            return preference;
        }


        private int _subscriptionId;
       
        /// <summary>
        /// On opening the service host, subscribe to the event
        /// </summary>
        protected override void OnOpened()
        {
            Subscribe();
            base.OnOpened();
        }

        /// <summary>
        /// On closed, remove the event from the subscription
        /// </summary>
        protected override void OnClosing()
        {
            Unsubscribe();
            base.OnClosing();
        }

        /// <summary>
        /// Details how the event is subscribed 
        /// </summary>
        protected virtual void Unsubscribe()
        {
            Trace.WriteLineIf(Constants.CommonSwitch.Level == TraceLevel.Verbose, string.Format("Unsubscribing from Notification event id {0}", _subscriptionId),Constants.NotificationServiceHost);
            ServiceHelper.Unsubscribe(_subscriptionId);
        }

        

        /// <summary>
        /// Subn
        /// </summary>
        protected virtual void Subscribe()
        {
            string address = this.Description.Endpoints[0].Address.Uri.AbsoluteUri;
            Trace.WriteLineIf(Constants.CommonSwitch.Level == TraceLevel.Verbose, string.Format("Subscrbing to Notification event at address {0}", address), Constants.NotificationServiceHost);
            DeliveryPreference preference = CreateDeliveryPrefrence(address);
            _subscriptionId = ServiceHelper.Subscribe(UserName,typeof(EventTypeT).Name.ToString(), null, preference);
            
        }




      
    }
}
