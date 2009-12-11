#region Directives
using System;
using System.CodeDom.Compiler;
using System.ComponentModel;
using System.Diagnostics;
using System.Xml.Serialization;
#endregion

/// <summary>
/// Event raised when the Common Structure has changed. The Common Structure is either the Iteration or Area Path
/// </summary>
[GeneratedCodeAttribute("xsd", "2.0.50727.42")]
[SerializableAttribute()]
[DebuggerStepThroughAttribute()]
[DesignerCategoryAttribute("code")]
[XmlRootAttribute("CommonStructureChangedEvent", Namespace = "", IsNullable = false)]
public partial class CommonStructureChangedEvent
{
    #region Fields
    private string id;
    private string status;
    private string changeType;
    private string nodeId;
    private string projectContext;
    private string structureType;
    private string complex;
    #endregion

    #region Public Properties
    /// <remarks/>
    [System.Xml.Serialization.XmlElementAttribute(Form = System.Xml.Schema.XmlSchemaForm.Unqualified)]
    public string Id
    {
        get { return this.id; }
        set { this.id = value; }
    }

    /// <remarks/>
    [System.Xml.Serialization.XmlElementAttribute(Form = System.Xml.Schema.XmlSchemaForm.Unqualified)]
    public string Status
    {
        get { return this.status; }
        set { this.status = value; }
    }

    /// <remarks/>
    [System.Xml.Serialization.XmlElementAttribute(Form = System.Xml.Schema.XmlSchemaForm.Unqualified)]
    public string ChangeType
    {
        get { return this.changeType; }
        set { this.changeType = value; }
    }

    /// <remarks/>
    [System.Xml.Serialization.XmlElementAttribute(Form = System.Xml.Schema.XmlSchemaForm.Unqualified)]
    public string NodeId
    {
        get { return this.nodeId; }
        set { this.nodeId = value; }
    }

    /// <remarks/>
    [System.Xml.Serialization.XmlElementAttribute(Form = System.Xml.Schema.XmlSchemaForm.Unqualified)]
    public string ProjectContext
    {
        get { return this.projectContext; }
        set { this.projectContext = value; }
    }

    /// <remarks/>
    [System.Xml.Serialization.XmlElementAttribute(Form = System.Xml.Schema.XmlSchemaForm.Unqualified)]
    public string StructureType
    {
        get { return this.structureType; }
        set { this.structureType = value; }
    }

    /// <remarks/>
    [System.Xml.Serialization.XmlElementAttribute(Form = System.Xml.Schema.XmlSchemaForm.Unqualified)]
    public string Complex
    {
        get { return this.complex; }
        set { this.complex = value; }
    }
    #endregion
}