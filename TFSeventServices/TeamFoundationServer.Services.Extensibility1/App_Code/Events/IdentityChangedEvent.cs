#region Directives
using System;
using System.CodeDom.Compiler;
using System.ComponentModel;
using System.Diagnostics;
using System.Xml.Serialization;
#endregion

/// <summary>
/// Event raised when a user or group is changed for a project
/// </summary>
[GeneratedCodeAttribute("xsd", "2.0.50727.42")]
[SerializableAttribute()]
[DebuggerStepThroughAttribute()]
[DesignerCategoryAttribute("code")]
[XmlRootAttribute(Namespace = "", IsNullable = true)]
public partial class IdentityChangedEvent
{
    #region Fields
    private string sid; 
    #endregion

    #region Public Properties
    /// <remarks/>
    public string Sid
    {
        get { return this.sid; }
        set { this.sid = value; }
    } 
    #endregion
}
