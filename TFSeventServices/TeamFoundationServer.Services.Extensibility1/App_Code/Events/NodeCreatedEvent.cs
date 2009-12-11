#region Directives
using System;
using System.CodeDom.Compiler;
using System.ComponentModel;
using System.Diagnostics;
using System.Xml.Serialization;
#endregion

/// <summary>
/// Event raised when a node is created in the CommonStructure (Iteration / Path values) 
/// </summary>
[GeneratedCode("xsd", "2.0.50727.42")]
[Serializable()]
[DebuggerStepThrough()]
[DesignerCategory("code")]
[XmlRoot(Namespace="", IsNullable=true)]
public partial class NodeCreatedEvent
{
    #region Fields
    private string projectUri;
    private string nodeUri;
    private string name; 
    #endregion

    #region Public Properties
    /// <remarks/>
    public string ProjectUri
    {
        get { return this.projectUri; }
        set { this.projectUri = value; }
    }

    /// <remarks/>
    public string NodeUri
    {
        get { return this.nodeUri; }
        set { this.nodeUri = value; }
    }

    /// <remarks/>
    public string Name
    {
        get { return this.name; }
        set { this.name = value; }
    } 
    #endregion
}