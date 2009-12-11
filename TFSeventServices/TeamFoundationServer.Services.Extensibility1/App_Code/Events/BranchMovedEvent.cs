#region Directives
using System;
using System.CodeDom.Compiler;
using System.ComponentModel;
using System.Diagnostics;
using System.Xml.Serialization;
#endregion

/// <summary>
/// Event raised when a code Branch is moved.
/// </summary>
[GeneratedCodeAttribute("xsd", "2.0.50727.42")]
[SerializableAttribute()]
[DebuggerStepThroughAttribute()]
[DesignerCategoryAttribute("code")]
[XmlRootAttribute(Namespace = "", IsNullable = true)]
public partial class BranchMovedEvent
{
    #region Fields
    private string projectUri;
    private string nodeUri;
    private string oldParentUri;
    private string newParentUri;
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
    public string OldParentUri
    {
        get { return this.oldParentUri; }
        set { this.oldParentUri = value; }
    }

    /// <remarks/>
    public string NewParentUri
    {
        get { return this.newParentUri; }
        set { this.newParentUri = value; }
    }
    #endregion
}