#region Directives
using System;
using System.CodeDom.Compiler;
using System.ComponentModel;
using System.Diagnostics;
using System.Xml.Serialization;
#endregion

/// <summary>
/// Event raised when data changes.
/// </summary>
[GeneratedCodeAttribute("xsd", "2.0.50727.42")]
[SerializableAttribute()]
[DebuggerStepThroughAttribute()]
[DesignerCategoryAttribute("code")]
[XmlRootAttribute(Namespace = "", IsNullable = true)]
public partial class DataChangedEvent
{
    #region Fields
    private string dataType;
    private int seqId; 
    #endregion

    #region Public Properties
    /// <remarks/>
    public string DataType
    {
        get { return this.dataType; }
        set { this.dataType = value; }
    }

    /// <remarks/>
    public int SeqId
    {
        get { return this.seqId; }
        set { this.seqId = value; }
    } 
    #endregion
}
