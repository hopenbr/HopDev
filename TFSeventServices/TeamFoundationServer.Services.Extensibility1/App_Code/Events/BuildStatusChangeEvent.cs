#region Directives
using System;
using System.CodeDom.Compiler;
using System.ComponentModel;
using System.Diagnostics;
using System.Xml.Serialization;
#endregion

/// <summary>
/// Event raised when a Build Status Changes
/// </summary>
[GeneratedCodeAttribute("xsd", "2.0.50727.42")]
[SerializableAttribute()]
[DebuggerStepThroughAttribute()]
[DesignerCategoryAttribute("code")]
[XmlRootAttribute(Namespace = "", IsNullable = false)]
public partial class BuildStatusChangeEvent
{
    #region Fields
    private string teamFoundationServerUrl;
    private string teamProject;
    private string title;
    private string subscriber;
    private string id;
    private string url;
    private string timeZone;
    private string timeZoneOffset;
    private string changedTime;
    private Change statusChange;
    private string changedBy;
    #endregion

    #region Public Propeties
    /// <remarks/>
    [XmlElementAttribute(DataType = "anyURI")]
    public string TeamFoundationServerUrl
    {
        get { return this.teamFoundationServerUrl; }
        set { this.teamFoundationServerUrl = value; }
    }

    /// <remarks/>
    public string TeamProject
    {
        get { return this.teamProject; }
        set { this.teamProject = value; }
    }

    /// <remarks/>
    public string Title
    {
        get { return this.title; }
        set { this.title = value; }
    }

    /// <remarks/>
    public string Subscriber
    {
        get { return this.subscriber; }
        set { this.subscriber = value; }
    }

    /// <remarks/>
    public string Id
    {
        get { return this.id; }
        set { this.id = value; }
    }

    /// <remarks/>
    [XmlElementAttribute(DataType = "anyURI")]
    public string Url
    {
        get { return this.url; }
        set { this.url = value; }
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
    public string ChangedTime
    {
        get { return this.changedTime; }
        set { this.changedTime = value; }
    }

    /// <remarks/>
    public Change StatusChange
    {
        get { return this.statusChange; }
        set { this.statusChange = value; }
    }

    /// <remarks/>
    public string ChangedBy
    {
        get { return this.changedBy; }
        set { this.changedBy = value; }
    } 
    #endregion
}

/// <summary>
/// Type which shows which field have changed - and also contains their old and new value.
/// </summary>
[GeneratedCodeAttribute("xsd", "2.0.50727.42")]
[SerializableAttribute()]
[DebuggerStepThroughAttribute()]
[DesignerCategoryAttribute("code")]
[XmlTypeAttribute(Namespace = "")]
public partial class Change
{
    #region Fields
    private string fieldName;
    private string oldValue;
    private string newValue; 
    #endregion

    #region Public Properties
    /// <remarks/>
    public string FieldName
    {
        get { return this.fieldName; }
        set { this.fieldName = value; }
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