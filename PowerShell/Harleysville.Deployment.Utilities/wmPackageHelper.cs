using System;
using System.Collections.Generic;
using System.Text;
using Harleysville.Powershell.Utilities;

namespace Harleysville.Deployment.Utilities
{
    public class wmPackageHelper
    {
        private PSHScriptHelper _psh;

        private string _results = "";

        public string Results
        {
            get { return _results; }
        }

        public wmPackageHelper(string _packageName, string _projType, string _hpp, string _confName, string _webUser)
        {
            try
            {
                _psh = new PSHScriptHelper();
                _psh.ScriptGlobalVariables.Add("packName", _packageName.Trim());
                _psh.ScriptGlobalVariables.Add("projType", _projType.Trim());
                _psh.ScriptGlobalVariables.Add("webUser", _webUser.Trim());
                _psh.ScriptGlobalVariables.Add("HPP", _hpp.Trim());
                _psh.ScriptGlobalVariables.Add("confName", _confName.Trim());
                _psh.ScriptText = _hpp + @"\InvokeScripts\Invoke-NewwMBuildPackage.ps1";
                _results = _psh.RunScript();
            }
            catch (Exception _e)
            {
                _results = _e.ToString();
            }

        }
    }
}
