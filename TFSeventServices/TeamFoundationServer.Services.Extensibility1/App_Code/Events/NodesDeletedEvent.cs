#region Directives
using System;
using System.CodeDom.Compiler;
using System.ComponentModel;
using System.Diagnostics;
using System.Xml.Serialization;
#endregion

/// <summary>
/// Event raised when a node is deleted in the CommonStructure (Iteration / Path values) 
/// </summary>
[GeneratedCode("xsd", "2.0.50727.42")]
[Serializable()]
[DebuggerStepThrough()]
[DesignerCategory("code")]
[XmlRoot(Namespace="", IsNullable=true)]
public partial class NodesDeletedEvent
{
    #region Fields
    private string projectUri;
    private string deletedUser;
    private string deletedTime;
    private DeletedNode[] nodesDeleted; 
    #endregion

    #region Public Properties
    /// <remarks/>
    public string ProjectUri
    {
        get { return this.projectUri; }
        set { this.projectUri = value; }
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

    /// <remarks/>
    public DeletedNode[] NodesDeleted
    {
        get { return this.nodesDeleted; }
        set { this.nodesDeleted = value; }
    } 
    #endregion
}

/// <remarks/>
[GeneratedCode("xsd", "2.0.50727.42")]
[Serializable()]
[DebuggerStepThrough()]
[DesignerCategory("code")]
public partial class DeletedNode
{
    #region Fields
    private string uri;
    private DeletedNode[] children; 
    #endregion

    #region Public Properties
    /// <remarks/>
    public string Uri
    {
        get { return this.uri; }
        set { this.uri = value; }
    }

    /// <remarks/>
    public DeletedNode[] Children
    {
        get { return this.children; }
        set { this.children = value; }
    } 
    #endregion
}