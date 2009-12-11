#region Directives
using System;
using System.CodeDom.Compiler;
using System.ComponentModel;
using System.Diagnostics;
using System.Xml.Serialization;
#endregion

/// <summary>
/// Event raised when an Access Control List changes
/// </summary>
[GeneratedCodeAttribute("xsd", "2.0.50727.42")]
[SerializableAttribute()]
[DebuggerStepThroughAttribute()]
[DesignerCategoryAttribute("code")]
[XmlRootAttribute(Namespace = "", IsNullable = true)]
[Obsolete("This Event is no longer raised, or raised inconsistently - see http://blogs.msdn.com/psheill/archive/2006/05/09/593946.aspx for more information")]
public partial class AclChangedEvent
{
    #region Fields
    private string objectId;
    private string actionId;
    private string sid;
    private string entryType;
    private string changeType;
    #endregion

    #region Public Properties
    /// <remarks/>
    public string ObjectId
    {
        get { return this.objectId; }
        set { this.objectId = value; }
    }

    /// <remarks/>
    public string ActionId
    {
        get { return this.actionId; }
        set { this.actionId = value; }
    }

    /// <remarks/>
    public string Sid
    {
        get { return this.sid; }
        set { this.sid = value; }
    }

    /// <remarks/>
    public string EntryType
    {
        get { return this.entryType; }
        set { this.entryType = value; }
    }

    /// <remarks/>
    public string ChangeType
    {
        get { return this.changeType; }
        set { this.changeType = value; }
    }
    #endregion
}
