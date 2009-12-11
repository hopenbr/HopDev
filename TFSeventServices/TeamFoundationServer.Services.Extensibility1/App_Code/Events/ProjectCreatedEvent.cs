#region Directives
using System;
using System.CodeDom.Compiler;
using System.ComponentModel;
using System.Diagnostics;
using System.Xml.Serialization;
#endregion

/// <summary>
/// Event raised when a Project is Created
/// </summary>
[GeneratedCode("xsd", "2.0.50727.42")]
[Serializable()]
[DebuggerStepThrough()]
[DesignerCategory("code")]
[XmlRoot(Namespace="", IsNullable=true)]
public partial class ProjectCreatedEvent
{
    #region Fields
    private string uri;
    private string name; 
    #endregion

    #region Public Properties
    /// <remarks/>
    public string Uri
    {
        get { return this.uri; }
        set { this.uri = value; }
    }

    /// <remarks/>
    public string Name
    {
        get { return this.name; }
        set { this.name = value; }
    } 
    #endregion
}