#region Directives
using System;
using System.CodeDom.Compiler;
using System.ComponentModel;
using System.Diagnostics;
using System.Xml.Serialization;
#endregion

namespace Readify.Useful.TeamFoundation.Common.Notification
{
    /// <summary>
    /// Type which holds information about the Team Foundation Server which raised the event
    /// </summary>
    [GeneratedCodeAttribute("xsd", "2.0.50727.42")]
    [SerializableAttribute()]
    [DebuggerStepThroughAttribute()]
    [DesignerCategoryAttribute("code")]
    [XmlTypeAttribute(AnonymousType = true)]
    [XmlRootAttribute(Namespace = "", IsNullable = false, ElementName = "TeamFoundationServer")]
    public partial class TFSIdentity
    {
        #region Fields
        private string url;
        #endregion

        #region Public Properties
        /// <remarks/>
        [XmlAttributeAttribute("url")]
        public string Url
        {
            get { return this.url; }
            set { this.url = value; }
        }
        #endregion
    }
}