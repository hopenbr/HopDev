using System;
using System.Collections.Generic;
using System.Text;
using Microsoft.Build.Utilities;
using Microsoft.Build.Framework;
using System.Diagnostics;
using System.Xml;

using Harleysville.Powershell.Utilities;

namespace Harleysville.Build.Tasks
{
    public class Invoke_PSHScript : Task
    {
        private string _script = string.Empty;
        [Required]
        public string Script
        {
            set {_script = value; }
            get { return _script; }
        }

        private Dictionary<string, string> _parameters = new Dictionary<string, string>();
        /// <summary>
        /// Parameters is a string of key value pairs syntax: "key=value;key=value;"
        /// the key will be variable name with its value set 
        /// </summary>
        public string Parameters
        {
            set 
            {
                foreach (string param in value.Split(';'))
                {
                    if (param.Contains("="))
                    {
                        string k = param.Split('=')[0];
                        string v = param.Split('=')[1];

                        _parameters.Add(k, v);
                    }
                }
            }
        }

        private string _returnString = "";

        [Output]
        public string ReturnString
        {
            get { return _returnString; }
        }

        public override bool Execute()
        {
            try
            {
                PSHScriptHelper _psh = new PSHScriptHelper();

                if (_parameters.Count > 0)
                {
                    _psh.ScriptGlobalVariables = _parameters;
                }

                _psh.ScriptText = _script;

                _returnString = _psh.RunScript();

                return true;
            }
            catch (Exception _ex)
            {
                string _msg = "PSH script failure: Error message " + _ex.ToString();
                BuildEngine.LogErrorEvent(new BuildErrorEventArgs("PSH Failure", "PSH Failure",
                                                                  _ex.Source, 420, 69, 45, 25,
                                                                  _msg,
                                                                  "Check scripts and try again",
                                                                  "TFSBuild"));


                return false;

            }
        }
    }
}
