#region Directives
using System;
using System.CodeDom.Compiler;
using System.ComponentModel;
using System.Diagnostics;
using System.Xml.Serialization;
#endregion

/// <summary>
/// Event raised when a node is renamed in the CommonStructure (Iteration / Path values) 
/// </summary>
[GeneratedCode("xsd", "2.0.50727.42")]
[Serializable()]
[DebuggerStepThrough()]
[DesignerCategory("code")]
[XmlRoot(Namespace="", IsNullable=true)]
public partial class NodeRenamedEvent
{
    #region Fields
    private string projectUri;
    private string nodeUri;
    private string newName;
    private string oldName; 
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
    public string NewName
    {
        get { return this.newName; }
        set { this.newName = value; }
    }

    /// <remarks/>
    public string OldName
    {
        get { return this.oldName; }
        set { this.oldName = value; }
    } 
    #endregion
}