#region Directives
using System;
using System.CodeDom.Compiler;
using System.ComponentModel;
using System.Diagnostics;
using System.Xml.Serialization;
#endregion

/// <summary>
/// Event raised when a new user / group is changed on a project
/// </summary>
[GeneratedCodeAttribute("xsd", "2.0.50727.42")]
[SerializableAttribute()]
[DebuggerStepThroughAttribute()]
[DesignerCategoryAttribute("code")]
[XmlRootAttribute(Namespace = "", IsNullable = true)]
[Obsolete("This Event is no longer raised, or raised inconsistently - see http://blogs.msdn.com/psheill/archive/2006/05/09/593946.aspx for more information")]
public partial class MembershipChangedEvent
{
    #region Fields
    private string groupSid;
    private string memberSid;
    private string changeType; 
    #endregion

    #region Public Properties
    /// <remarks/>
    public string GroupSid
    {
        get { return this.groupSid; }
        set { this.groupSid = value; }
    }

    /// <remarks/>
    public string MemberSid
    {
        get { return this.memberSid; }
        set { this.memberSid = value; }
    }

    /// <remarks/>
    public string ChangeType
    {
        get { return this.changeType; }
        set { this.changeType = value; }
    } 
    #endregion
}
