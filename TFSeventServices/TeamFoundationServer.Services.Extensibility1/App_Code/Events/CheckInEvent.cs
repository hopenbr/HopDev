#region Directives
using System;
using System.CodeDom.Compiler;
using System.ComponentModel;
using System.Diagnostics;
using System.Xml.Serialization;
#endregion

/// <summary>
/// Event Raised when a item is Checked-In to the Source Control Repository
/// </summary>
[GeneratedCode("xsd", "2.0.50727.42")]
[Serializable()]
[DebuggerStepThrough()]
[DesignerCategory("code")]
[XmlRoot(Namespace="", IsNullable=true)]
public partial class CheckinEvent
{
    #region Fields
    private bool allChangesIncluded;
    private string notice;
    private string subscriber;
    private object[] checkinNotes;
    private object[] policyFailures;
    private object[] checkinInformation;
    private object[] artifacts;
    private string title;
    private string contentTitle;
    private string owner;
    private string committer;
    private int number;
    private string creationDate;
    private string comment;
    private string timeZone;
    private string timeZoneOffset;
    private string teamProject;
    private string policyOverrideComment; 
    #endregion

    #region Public Properties
    /// <remarks/>
    public bool AllChangesIncluded
    {
        get { return this.allChangesIncluded; }
        set { this.allChangesIncluded = value; }
    }

    /// <remarks/>
    public string Notice
    {
        get { return this.notice; }
        set { this.notice = value; }
    }

    /// <remarks/>
    public string Subscriber
    {
        get { return this.subscriber; }
        set { this.subscriber = value; }
    }

    /// <remarks/>
    [XmlArrayItem("CheckinNote")]
    public object[] CheckinNotes
    {
        get { return this.checkinNotes; }
        set { this.checkinNotes = value; }
    }

    /// <remarks/>
    [XmlArrayItem("PolicyFailure")]
    public object[] PolicyFailures
    {
        get { return this.policyFailures; }
        set { this.policyFailures = value; }
    }

    /// <remarks/>
    [XmlArrayItem("CheckinInformation")]
    public object[] CheckinInformation
    {
        get { return this.checkinInformation; }
        set { this.checkinInformation = value; }
    }

    /// <remarks/>
    [XmlArrayItem("Artifact")]
    public object[] Artifacts
    {
        get { return this.artifacts; }
        set { this.artifacts = value; }
    }

    /// <remarks/>
    public string Title
    {
        get { return this.title; }
        set { this.title = value; }
    }

    /// <remarks/>
    public string ContentTitle
    {
        get { return this.contentTitle; }
        set { this.contentTitle = value; }
    }

    /// <remarks/>
    public string Owner
    {
        get { return this.owner; }
        set { this.owner = value; }
    }

    /// <remarks/>
    public string Committer
    {
        get { return this.committer; }
        set { this.committer = value; }
    }

    /// <remarks/>
    public int Number
    {
        get { return this.number; }
        set { this.number = value; }
    }

    /// <remarks/>
    public string CreationDate
    {
        get { return this.creationDate; }
        set { this.creationDate = value; }
    }

    /// <remarks/>
    public string Comment
    {
        get { return this.comment; }
        set { this.comment = value; }
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
    public string TeamProject
    {
        get { return this.teamProject; }
        set { this.teamProject = value; }
    }

    /// <remarks/>
    public string PolicyOverrideComment
    {
        get { return this.policyOverrideComment; }
        set { this.policyOverrideComment = value; }
    } 
    #endregion
}

/// <remarks/>
[GeneratedCode("xsd", "2.0.50727.42")]
[Serializable()]
[DebuggerStepThrough()]
[DesignerCategory("code")]
public partial class ClientArtifact
{
    #region Fields
    private string url;
    private string artifactType;
    private string item;
    private string folder;
    private string teamProject;
    private string itemRevision;
    private string changeType;
    private string serverItem; 
    #endregion

    #region Public Properties
    /// <remarks/>
    public string Url
    {
        get { return this.url; }
        set { this.url = value; }
    }

    /// <remarks/>
    [XmlAttribute()]
    public string ArtifactType
    {
        get { return this.artifactType; }
        set { this.artifactType = value; }
    }

    /// <remarks/>
    [XmlAttribute()]
    public string Item
    {
        get { return this.item; }
        set { this.item = value; }
    }

    /// <remarks/>
    [XmlAttribute()]
    public string Folder
    {
        get { return this.folder; }
        set { this.folder = value; }
    }

    /// <remarks/>
    [XmlAttribute()]
    public string TeamProject
    {
        get { return this.teamProject; }
        set { this.teamProject = value; }
    }

    /// <remarks/>
    [XmlAttribute()]
    public string ItemRevision
    {
        get { return this.itemRevision; }
        set { this.itemRevision = value; }
    }

    /// <remarks/>
    [XmlAttribute()]
    public string ChangeType
    {
        get { return this.changeType; }
        set { this.changeType = value; }
    }

    /// <remarks/>
    [XmlAttribute()]
    public string ServerItem
    {
        get { return this.serverItem; }
        set { this.serverItem = value; }
    } 
    #endregion
}

/// <remarks/>
[GeneratedCode("xsd", "2.0.50727.42")]
[Serializable()]
[DebuggerStepThrough()]
[DesignerCategory("code")]
public partial class NameValuePair
{
    #region Fields
    private string name;
    private string value; 
    #endregion

    #region Public Properties
    /// <remarks/>
    [XmlAttribute("name")]
    public string Name
    {
        get { return this.name; }
        set { this.name = value; }
    }

    /// <remarks/>
    [XmlAttribute("val")]
    public string Value
    {
        get { return this.value; }
        set { this.value = value; }
    } 
    #endregion
}

/// <remarks/>
[GeneratedCode("xsd", "2.0.50727.42")]
[Serializable()]
[DebuggerStepThrough()]
[DesignerCategory("code")]
public partial class CheckinWorkItemInfo
{
    #region Fields
    private string url;
    private int id;
    private CheckinWorkItemCheckinAction checkinAction;
    private string title;
    private string type;
    private string state;
    private string assignedTo; 
    #endregion

    #region Public Properties
    /// <remarks/>
    [XmlAttribute()]
    public string Url
    {
        get { return this.url; }
        set { this.url = value; }
    }

    /// <remarks/>
    [XmlAttribute()]
    public int Id
    {
        get { return this.id; }
        set { this.id = value; }
    }

    /// <remarks/>
    [XmlAttribute()]
    public CheckinWorkItemCheckinAction CheckinAction
    {
        get { return this.checkinAction; }
        set { this.checkinAction = value; }
    }

    /// <remarks/>
    [XmlAttribute()]
    public string Title
    {
        get { return this.title; }
        set { this.title = value; }
    }

    /// <remarks/>
    [XmlAttribute()]
    public string Type
    {
        get { return this.type; }
        set { this.type = value; }
    }

    /// <remarks/>
    [XmlAttribute()]
    public string State
    {
        get { return this.state; }
        set { this.state = value; }
    }

    /// <remarks/>
    [XmlAttribute()]
    public string AssignedTo
    {
        get { return this.assignedTo; }
        set { this.assignedTo = value; }
    } 
    #endregion
}

/// <remarks/>
[GeneratedCode("xsd", "2.0.50727.42")]
[Serializable()]
public enum CheckinWorkItemCheckinAction
{
    /// <remarks/>
    None,

    /// <remarks/>
    Resolve,

    /// <remarks/>
    Associate,
}