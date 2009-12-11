#region Directives
using System;
using System.CodeDom.Compiler;
using System.ComponentModel;
using System.Diagnostics;
using System.Xml.Serialization;
#endregion

/// <summary>
/// Event raised when a Project is Deleted
/// </summary>
[GeneratedCode("xsd", "2.0.50727.42")]
[Serializable()]
[DebuggerStepThrough()]
[DesignerCategory("code")]
[XmlRoot(Namespace="", IsNullable=true)]
public partial class ProjectDeletedEvent
{
    #region Fields
    private string uri;
    private string deletedUser;
    private string deletedTime; 
    #endregion

    #region Public Properties
    /// <remarks/>
    public string Uri
    {
        get { return this.uri; }
        set { this.uri = value; }
    }

    /// <remarks/>
    public string DeletedUser
    {
        get { return this.deletedUser; }
        set { this.deletedUser = value; }
    }

    /// <remarks/>
    public string DeletedTime
    {
        get { return this.deletedTime; }
        set { this.deletedTime = value; }
    } 
    #endregion
}