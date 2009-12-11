using System;
using System.Data;
using System.Configuration;
using System.Globalization;
using System.Text;
using System.IO;
using System.Collections.Generic;
using System.Web.UI.HtmlControls;
using System.Drawing;
using TFSeventClasses;
using System.Xml;
using System.Text.RegularExpressions;

namespace Harleysville.TFSEventServices
{
    public enum WIFieldChangeType { NewValue, OldValue };
    public enum WIStateChangeType { New, Same }; 

    /// <summary>
    /// Summary description for Harleysville.WI.Helper
    /// </summary>
    [Serializable]
    public class WorkItemHelper
    {
        private TFWI _tfs;
        public virtual TFWI TFS
        {
            get { return _tfs; }
            set { _tfs = value; }
        }

        private WorkItemChangedEvent _wice;
        public WorkItemChangedEvent WICE
        {
            get { return _wice; }
            set { _wice = value; }
        }

        private Dictionary<string, Dictionary<WIFieldChangeType, string>> _wiChangeDic;
        public Dictionary<string, Dictionary<WIFieldChangeType, string>> EventChanges
        {
            get { return _wiChangeDic; }
            //set { _wiChangeDic = value; }
        }

        private ChangeTypes _changeType;
        public ChangeTypes ChangeType
        {
            get { return _changeType; }
        }

        private Dictionary<string, string> _wiFields;
        public Dictionary<string, string> WiFields
        {
            get { return _wiFields; } 
        }

        private int _wiNumber;
        public int WorkItemNumber
        {
            get { return _wiNumber; }
        }

        private string _wiState;
        public string WorkItemState
        {
            get { return _wiState; }
        }

        private void SetWorkItemHelper()
        {
            _wiChangeDic = ConvertList2Dic();
            _changeType = _wice.ChangeType;
            _wiNumber = Convert.ToInt32(_wiChangeDic["ID"][WIFieldChangeType.NewValue]);

        }

        public void SetWorkItemHelper(WorkItemChangedEvent wice, string tfsUrl)
        {
            _wice = wice;
            SetWorkItemHelper();
            _tfs = new TFWI(tfsUrl, _wiNumber);
            _wiFields = _tfs.GetWorkItemFields();
            _wiState = _wiFields["State"];
            
            
        }

        public void SetWorkItemHelper(WorkItemChangedEvent wice, string tfsUrl, int _wiNum)
        {
            _wice = wice;
            SetWorkItemHelper();
            _wiNumber = _wiNum;
            _tfs = new TFWI(tfsUrl, _wiNumber);
            _wiFields = _tfs.GetWorkItemFields();
            _wiState = _wiFields["State"];


        }

        public void SetWorkItemHelper(WorkItemChangedEvent wice, TFWI tfs)
        {
            _wice = wice;
            SetWorkItemHelper();
            _tfs = tfs;
            _wiFields = _tfs.GetWorkItemFields();
            _wiState = _wiFields["State"];
        }

        public void ResetWIFields()
        {
            _wiFields = _tfs.GetWorkItemFields();
        }

        private Dictionary<string, Dictionary<WIFieldChangeType, string>> ConvertList2Dic()
        {
            Dictionary<string, Dictionary<WIFieldChangeType, string>> _dic = new Dictionary<string, Dictionary<WIFieldChangeType, string>>();

            foreach (StringField _sf in _wice.CoreFields.StringFields)
            {
                Dictionary<WIFieldChangeType, string> _subDic = new Dictionary<WIFieldChangeType, string>();
                _subDic.Add(WIFieldChangeType.NewValue, _sf.NewValue);
                _subDic.Add(WIFieldChangeType.OldValue, _sf.OldValue);
                _dic.Add(_sf.Name, _subDic);
            }

            foreach (IntegerField _if in _wice.CoreFields.IntegerFields)
            {
                Dictionary<WIFieldChangeType, string> _subDic = new Dictionary<WIFieldChangeType, string>();
                _subDic.Add(WIFieldChangeType.NewValue, _if.NewValue.ToString());
                _subDic.Add(WIFieldChangeType.OldValue, _if.OldValue.ToString());
                _dic.Add(_if.Name, _subDic);
            }

            foreach (StringField _sf in _wice.ChangedFields.StringFields)
            {
                if (!_dic.ContainsKey(_sf.Name))
                {//alredy have Core fields even if they changed
                    Dictionary<WIFieldChangeType, string> _subDic = new Dictionary<WIFieldChangeType, string>();
                    _subDic.Add(WIFieldChangeType.NewValue, _sf.NewValue);
                    _subDic.Add(WIFieldChangeType.OldValue, _sf.OldValue);
                    _dic.Add(_sf.Name, _subDic);
                }
            }

            foreach (IntegerField _if in _wice.ChangedFields.IntegerFields)
            {
                if (!_dic.ContainsKey(_if.Name))
                {
                    Dictionary<WIFieldChangeType, string> _subDic = new Dictionary<WIFieldChangeType, string>();
                    _subDic.Add(WIFieldChangeType.NewValue, _if.NewValue.ToString());
                    _subDic.Add(WIFieldChangeType.OldValue, _if.OldValue.ToString());
                    _dic.Add(_if.Name, _subDic);
                }
            }

            return _dic;

        }
    }
}
