using System;
using System.Collections.Generic;
using System.IO;
using System.Text;
using System.Collections;
using System.Collections.ObjectModel;
using System.Management.Automation;
using System.Management.Automation.Runspaces;

namespace Harleysville.Powershell.Utilities
{
    /// <summary>
    /// PSH Script helper is a working class that allows you run a scipts and get a string representation 
    /// of the scripts output
    /// </summary>
    public class PSHScriptHelper
    {
        private Dictionary<string, string> _scriptVariables = new Dictionary<string, string>();
        /// <summary>
        /// Key, value pair, where the key will be varibale name with its value set to key's value. 
        /// All variables will be of string type
        /// All variables will be of global scoope, and readonly to script
        /// </summary>
        public Dictionary<string, string> ScriptGlobalVariables
        {
            set { _scriptVariables = value; }
            get { return _scriptVariables; }
        }

        private string _ScriptText = String.Empty;

        /// <summary>
        /// The entire Powershell scrit, can be multiple lines
        /// </summary>
        public string ScriptText
        {
            set { _ScriptText = value; }
            get { return _ScriptText; }
        }

        /// <summary>
        /// Run script in powrshell pipeline
        /// </summary>
        /// <returns>
        /// string representation of PSH script output
        /// </returns>
        public string RunScript()
        {
            // create Powershell runspace
            Runspace runspace = RunspaceFactory.CreateRunspace();

            // open it
            runspace.Open();

            //set global variables
            foreach (string key in _scriptVariables.Keys)
            {
                runspace.SessionStateProxy.SetVariable(key, (object)_scriptVariables[key]);
            }

            // create a pipeline and feed it the script text
            Pipeline pipeline = runspace.CreatePipeline();
            pipeline.Commands.AddScript(_ScriptText, true);

            // add an extra command to transform the script output objects into nicely formatted strings
            // remove this line to get the actual objects that the script returns. For example, the script
            // "Get-Process" returns a collection of System.Diagnostics.Process instances.
            pipeline.Commands.Add("Out-String");

            //runspace.SessionStateProxy.SetVariable("setVar", _str);
            // execute the script
            Collection<PSObject> results = pipeline.Invoke();

            object _c = runspace.SessionStateProxy.GetVariable("$catcher");
 
            // close the runspace
            runspace.Close();

            // convert the script result into a single string
            StringBuilder stringBuilder = new StringBuilder();
            foreach (PSObject obj in results)
            {
                stringBuilder.AppendLine(obj.ToString());
            }

            return stringBuilder.ToString().Trim();
        }


        /// <summary>
        /// Runs script in Powershell pipeline
        /// </summary>
        /// <param name="_sText">
        /// The entire Powershell script, can be multiple lines
        /// </param>
        /// <returns>
        ///  string representation of PSH script output
        /// </returns>
        public string RunScript(string _sText)
        {
            _ScriptText = _sText;
            return(this.RunScript());
        }
    }
}
