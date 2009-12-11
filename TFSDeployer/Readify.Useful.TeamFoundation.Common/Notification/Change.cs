using System;
using System.CodeDom.Compiler;
using System.ComponentModel;
using System.Diagnostics;

namespace Readify.Useful.TeamFoundation.Common.Notification
{
   
    [Serializable, DesignerCategory("code"), GeneratedCode("xsd", "2.0.50701.0"), DebuggerStepThrough]
    public class Change
    {
        public string FieldName
        {
            get
            {
                return this.fieldNameField;
            }
            set
            {
                this.fieldNameField = value;
            }
        }

        public string NewValue
        {
            get
            {
                return this.newValueField;
            }
            set
            {
                this.newValueField = value;
            }
        }

        public string OldValue
        {
            get
            {
                return this.oldValueField;
            }
            set
            {
                this.oldValueField = value;
            }
        }


        private string fieldNameField;
        private string newValueField;
        private string oldValueField;
    }


}
