using System;
using System.Data;
using System.Configuration;
using System.Globalization;
using System.Text;
using System.IO;
using System.Collections.Generic;
using System.Xml;
using System.Text.RegularExpressions;
using System.Collections;

using TFSeventClasses;
using Harleysville.Powershell.Utilities;

namespace Harleysville.TFSEventServices
{
    /// <summary>
    /// The project label type
    /// </summary>
    public enum LabelTypes {PLDR, CLDR, AQS, LEGACY};

    /// <summary>
    ///  Infomatica Label Request helper class is the working class
    /// </summary>
    public class LBIHelper : WorkItemHelper
    {
        private string _label = string.Empty;
        /// <summary>
        /// Returns the label created in Informatica Repository
        /// </summary>
        public string Label
        {
            get { return _label; }
        }

        private bool _successful = false;
        /// <summary>
        /// Return status of label request, when true label was successfully created in the Infomatica repository
        /// </summary>
        public bool LabelCreated
        {
            get { return _successful; }
        }

        private LabelTypes _labelType;

        public LabelTypes LableType
        {
            get { return _labelType; }
        }

        public LBIHelper (WorkItemChangedEvent _wice, string tfsUrl)
        {
            SetWorkItemHelper(_wice, tfsUrl);
        }

        public void CreateLabel()
        {
            //Here I need to lock the global object to ensure that only one session at a time 
            //calls informatica
            //This is not a great solution is usage ramps up in a big way 
            //For now it is a solid solution 

            lock (Global.infoLockObj)
            {
                PSHScriptHelper _psh = new PSHScriptHelper();

                _psh.ScriptGlobalVariables.Add("LabelType", "APP_" + WiFields["HIC INFORMATICA LABEL TYPE"]);
                _psh.ScriptGlobalVariables.Add("region", WiFields["HIC INFORMATICA LABEL REGION"]);
                _psh.ScriptGlobalVariables.Add("hostName", ConfigurationManager.AppSettings.Get("InfoHostMachine_" + WiFields["HIC INFORMATICA LABEL REGION"]));
                _psh.ScriptGlobalVariables.Add("requestedBy", WiFields["Created By"]);

                string _lab = _psh.RunScript(ConfigurationManager.AppSettings.Get("Path2CreateLabel"));

                if (!_lab.Trim().Equals("False", StringComparison.CurrentCultureIgnoreCase))
                {
                    _label = _lab.Trim();
                    _successful = true;

                    AddLabel2GlobalList(_label, "List - Informatica Labels");
                }
            }

        }

        private void SetLabelType(string _lt)
        {
            switch (_lt)
            {
                case "PLDR":
                    _labelType = LabelTypes.PLDR;
                    break;
                case "CLDR":
                    _labelType = LabelTypes.CLDR;
                    break;
                case "AQS":
                    _labelType = LabelTypes.AQS;
                    break;
                case "LEGACY":
                    _labelType = LabelTypes.LEGACY;
                    break;
                default:
                    throw (new Exception("Error: Unknown Lable Type"));
            }
        }

        private void AddLabel2GlobalList(string _label, string _listType)
        {
            GlobalLists _gl = new GlobalLists(this.TFS.TFSServerUrl);
            //GlobalLists _gl = new GlobalLists("Http://as73tfstst01:8080");

            _gl.AddItem2GlobalList(_listType, _label, true);
        }
    }
}
