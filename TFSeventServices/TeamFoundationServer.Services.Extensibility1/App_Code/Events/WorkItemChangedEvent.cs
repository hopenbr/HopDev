#region Directives
using System;
using System.CodeDom.Compiler;
using System.Collections.Generic;
using System.ComponentModel;
using System.Diagnostics;
using System.Xml.Serialization;
#endregion

/// <summary>
/// Event raised when a change occurs to a Work Item
/// </summary>
[GeneratedCodeAttribute("xsd", "2.0.50727.42")]
[SerializableAttribute()]
[DebuggerStepThroughAttribute()]
[DesignerCategoryAttribute("code")]
[XmlTypeAttribute(AnonymousType = true)]
[XmlRootAttribute(Namespace = "", IsNullable = false)]
public partial class WorkItemChangedEvent
{
    #region Fields
    private string portfolioProject;
    private string projectNodeId;
    private string areaPath;
    private string title;
    private string workItemTitle;
    private string subscriber;
    private string changerSid;
    private string displayUrl;
    private string timeZone;
    private string timeZoneOffset;
    private ChangeTypes changeType;
    private CoreFieldsType coreFields;
    private TextField[] textFields;
    private ChangedFieldsType changedFields;
    private string[] addedFiles;
    private string[] deletedFiles;
    private string[] addedResourceLinks;
    private string[] deletedResourceLinks;
    private string[] changedResourceLinks;
    private string[] addedRelations;
    private string[] deletedRelations;
    private string[] changedRelations; 
    #endregion

    #region Public Properties
    /// <remarks/>
    public string PortfolioProject
    {
        get { return this.portfolioProject; }
        set { this.portfolioProject = value; }
    }

    /// <remarks/>
    public string ProjectNodeId
    {
        get { return this.projectNodeId; }
        set { this.projectNodeId = value; }
    }

    /// <remarks/>
    public string AreaPath
    {
        get { return this.areaPath; }
        set { this.areaPath = value; }
    }

    /// <remarks/>
    public string Title
    {
        get { return this.title; }
        set { this.title = value; }
    }

    /// <remarks/>
    public string WorkItemTitle
    {
        get { return this.workItemTitle; }
        set { this.workItemTitle = value; }
    }

    /// <remarks/>
    public string Subscriber
    {
        get { return this.subscriber; }
        set { this.subscriber = value; }
    }

    /// <remarks/>
    public string ChangerSid
    {
        get { return this.changerSid; }
        set { this.changerSid = value; }
    }

    /// <remarks/>
    public string DisplayUrl
    {
        get { return this.displayUrl; }
        set { this.displayUrl = value; }
    }

    /// <remarks/>
    public string TimeZone
    {
        get { return this.timeZone; }
        set { this.timeZone = value; }
    }

    /// <remarks/>
    public string TimeZoneOffset
    {
        get { return this.timeZoneOffset; }
        set { this.timeZoneOffset = value; }
    }

    /// <remarks/>
    public ChangeTypes ChangeType
    {
        get { return this.changeType; }
        set { this.changeType = value; }
    }

    /// <remarks/>
    public CoreFieldsType CoreFields
    {
        get { return this.coreFields; }
        set { this.coreFields = value; }
    }

    /// <remarks/>
    [XmlArrayItemAttribute("Field", IsNullable = false)]
    public TextField[] TextFields
    {
        get { return this.textFields; }
        set { this.textFields = value; }
    }

    /// <remarks/>
    public ChangedFieldsType ChangedFields
    {
        get { return this.changedFields; }
        set { this.changedFields = value; }
    }

    /// <remarks/>
    [XmlArrayItemAttribute("Name", IsNullable = false)]
    public string[] AddedFiles
    {
        get { return this.addedFiles; }
        set { this.addedFiles = value; }
    }

    /// <remarks/>
    [XmlArrayItemAttribute("FileId", IsNullable = false)]
    public string[] DeletedFiles
    {
        get { return this.deletedFiles; }
        set { this.deletedFiles = value; }
    }

    /// <remarks/>
    [XmlArrayItemAttribute("Resource", IsNullable = false)]
    public string[] AddedResourceLinks
    {
        get { return this.addedResourceLinks; }
        set { this.addedResourceLinks = value; }
    }

    /// <remarks/>
    [XmlArrayItemAttribute("LinkId", IsNullable = false)]
    public string[] DeletedResourceLinks
    {
        get { return this.deletedResourceLinks; }
        set { this.deletedResourceLinks = value; }
    }

    /// <remarks/>
    [XmlArrayItemAttribute("LinkId", IsNullable = false)]
    public string[] ChangedResourceLinks
    {
        get { return this.changedResourceLinks; }
        set { this.changedResourceLinks = value; }
    }

    /// <remarks/>
    [XmlArrayItemAttribute("WorkItemId", IsNullable = false)]
    public string[] AddedRelations
    {
        get { return this.addedRelations; }
        set { this.addedRelations = value; }
    }

    /// <remarks/>
    [XmlArrayItemAttribute("WorkItemId", IsNullable = false)]
    public string[] DeletedRelations
    {
        get { return this.deletedRelations; }
        set { this.deletedRelations = value; }
    }

    /// <remarks/>
    [XmlArrayItemAttribute("WorkItemId", IsNullable = false)]
    public string[] ChangedRelations
    {
        get { return this.changedRelations; }
        set { this.changedRelations = value; }
    } 
    #endregion
}

/// <summary>
/// Enumeration which lists the type of change that has occured
/// </summary>
[GeneratedCodeAttribute("xsd", "2.0.50727.42")]
[SerializableAttribute()]
[XmlTypeAttribute(Namespace = "")]
public enum ChangeTypes
{
    /// <summary>
    /// The Work Item has been created
    /// </summary>
    New,

    /// <summary>
    /// The Work Item has been changed
    /// </summary>
    Change
}

/// <summary>
/// Type which contains the CoreFields of the Work Item
/// </summary>
[GeneratedCodeAttribute("xsd", "2.0.50727.42")]
[SerializableAttribute()]
[DebuggerStepThroughAttribute()]
[DesignerCategoryAttribute("code")]
[XmlTypeAttribute(Namespace = "")]
public partial class CoreFieldsType
{
    #region Fields
    private List<IntegerField> integerFields;
    private List<StringField> stringFields; 
    #endregion

    #region Public Properties
    /// <remarks/>
    [XmlArrayItemAttribute("Field", IsNullable = false)]
    public List<IntegerField> IntegerFields
    {
        get { return this.integerFields; }
        set { this.integerFields = value; }
    }

    /// <remarks/>
    [XmlArrayItemAttribute("Field", IsNullable = false)]
    public List<StringField> StringFields
    {
        get { return this.stringFields; }
        set { this.stringFields = value; }
    } 
    #endregion
}

/// <summary>
/// Type which contains the old and new values of the interger field that has changed
/// </summary>
[GeneratedCodeAttribute("xsd", "2.0.50727.42")]
[SerializableAttribute()]
[DebuggerStepThroughAttribute()]
[DesignerCategoryAttribute("code")]
[XmlTypeAttribute(Namespace = "")]
public partial class IntegerField
{
    #region Fields
    private string name;
    private string referenceName;
    private int oldValue;
    private int newValue; 
    #endregion

    #region Public Properties
    /// <remarks/>
    public string Name
    {
        get { return this.name; }
        set { this.name = value; }
    }

    /// <remarks/>
    public string ReferenceName
    {
        get { return this.referenceName; }
        set { this.referenceName = value; }
    }

    /// <remarks/>
    public int OldValue
    {
        get { return this.oldValue; }
        set { this.oldValue = value; }
    }

    /// <remarks/>
    public int NewValue
    {
        get { return this.newValue; }
        set { this.newValue = value; }
    } 
    #endregion
}

/// <summary>
/// Type which contains a list of the fields that have changed
/// </summary>
[GeneratedCodeAttribute("xsd", "2.0.50727.42")]
[SerializableAttribute()]
[DebuggerStepThroughAttribute()]
[DesignerCategoryAttribute("code")]
[XmlTypeAttribute(Namespace = "")]
public partial class ChangedFieldsType
{
    #region Fields
    private List<IntegerField> integerFields;
    private List<StringField> stringFields; 
    #endregion

    #region Public Properties
    /// <remarks/>
    [XmlArrayItemAttribute("Field", IsNullable = false)]
    public List<IntegerField> IntegerFields
    {
        get { return this.integerFields; }
        set { this.integerFields = value; }
    }

    /// <remarks/>
    [XmlArrayItemAttribute("Field", IsNullable = false)]
    public List<StringField> StringFields
    {
        get { return this.stringFields; }
        set { this.stringFields = value; }
    } 
    #endregion
}

/// <summary>
/// Type which contains the old and new values of the string field that has changed
/// </summary>
[GeneratedCodeAttribute("xsd", "2.0.50727.42")]
[SerializableAttribute()]
[DebuggerStepThroughAttribute()]
[DesignerCategoryAttribute("code")]
[XmlTypeAttribute(Namespace = "")]
public partial class StringField
{
    #region Fields
    private string name;
    private string referenceName;
    private string oldValue;
    private string newValue; 
    #endregion

    #region Public Properties
    /// <remarks/>
    public string Name
    {
        get { return this.name; }
        set { this.name = value; }
    }

    /// <remarks/>
    public string ReferenceName
    {
        get { return this.referenceName; }
        set { this.referenceName = value; }
    }

    /// <remarks/>
    public string OldValue
    {
        get { return this.oldValue; }
        set { this.oldValue = value; }
    }

    /// <remarks/>
    public string NewValue
    {
        get { return this.newValue; }
        set { this.newValue = value; }
    } 
    #endregion
}

/// <summary>
/// Type which contains information about the Work Item's text field
/// </summary>
[GeneratedCodeAttribute("xsd", "2.0.50727.42")]
[SerializableAttribute()]
[DebuggerStepThroughAttribute()]
[DesignerCategoryAttribute("code")]
[XmlTypeAttribute(Namespace = "")]
public partial class TextField
{
    #region Fields
    private string name;
    private string referenceName;
    private string value; 
    #endregion

    #region Public Properties
    /// <remarks/>
    public string Name
    {
        get { return this.name; }
        set { this.name = value; }
    }

    /// <remarks/>
    public string ReferenceName
    {
        get { return this.referenceName; }
        set { this.referenceName = value; }
    }

    /// <remarks/>
    public string Value
    {
        get { return this.value; }
        set { this.value = value; }
    } 
    #endregion
}