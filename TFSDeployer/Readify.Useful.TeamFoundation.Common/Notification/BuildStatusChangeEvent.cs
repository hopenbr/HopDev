using System;
using System.CodeDom.Compiler;
using System.ComponentModel;
using System.Diagnostics;
using System.Xml.Serialization;
namespace Readify.Useful.TeamFoundation.Common.Notification
{
    
    [Serializable, DebuggerStepThrough, GeneratedCode("xsd", "2.0.50701.0"), DesignerCategory("code")]
    public class BuildStatusChangeEvent
    {
        public string ChangedBy
        {
            get
            {
                return this.changedByField;
            }
            set
            {
                this.changedByField = value;
            }
        }

        public string ChangedTime
        {
            get
            {
                return this.changedTimeField;
            }
            set
            {
                this.changedTimeField = value;
            }
        }

        public string Id
        {
            get
            {
                return this.idField;
            }
            set
            {
                this.idField = value;
            }
        }

        public Change StatusChange
        {
            get
            {
                return this.statusChangeField;
            }
            set
            {
                this.statusChangeField = value;
            }
        }

        public string Subscriber
        {
            get
            {
                return this.subscriberField;
            }
            set
            {
                this.subscriberField = value;
            }
        }

        [XmlElement(DataType = "anyURI")]
        public string TeamFoundationServerUrl
        {
            get
            {
                return this.teamFoundationServerUrlField;
            }
            set
            {
                this.teamFoundationServerUrlField = value;
            }
        }

        public string TeamProject
        {
            get
            {
                return this.teamProjectField;
            }
            set
            {
                this.teamProjectField = value;
            }
        }

        public string TimeZone
        {
            get
            {
                return this.timeZoneField;
            }
            set
            {
                this.timeZoneField = value;
            }
        }

        public string TimeZoneOffset
        {
            get
            {
                return this.timeZoneOffsetField;
            }
            set
            {
                this.timeZoneOffsetField = value;
            }
        }

        public string Title
        {
            get
            {
                return this.titleField;
            }
            set
            {
                this.titleField = value;
            }
        }

        [XmlElement(DataType = "anyURI")]
        public string Url
        {
            get
            {
                return this.urlField;
            }
            set
            {
                this.urlField = value;
            }
        }

        private string changedByField;
        private string changedTimeField;
        private string idField;
        private Change statusChangeField;
        private string subscriberField;
        private string teamFoundationServerUrlField;
        private string teamProjectField;
        private string timeZoneField;
        private string timeZoneOffsetField;
        private string titleField;
        private string urlField;
    }


}
