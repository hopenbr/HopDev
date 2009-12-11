#region Directives
using System;
using System.CodeDom.Compiler;
using System.ComponentModel;
using System.Diagnostics;
using System.Xml.Serialization;
#endregion

/// <summary>
/// Event raised when a new user / group is deleted from a project
/// </summary>
[GeneratedCodeAttribute("xsd", "2.0.50727.42")]
[SerializableAttribute()]
[DebuggerStepThroughAttribute()]
[DesignerCategoryAttribute("code")]
[XmlRootAttribute(Namespace = "", IsNullable = true)]
[Obsolete("This Event is no longer raised, or raised inconsistently - see http://blogs.msdn.com/psheill/archive/2006/05/09/593946.aspx for more information")]
public partial class IdentityDeletedEvent 
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
