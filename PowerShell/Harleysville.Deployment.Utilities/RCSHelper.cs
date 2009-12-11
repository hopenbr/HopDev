using System;
using System.Collections.Generic;
using System.Text;

using Harleysville.Powershell.Utilities;

namespace Harleysville.Deployment.Utilities
{
    public class RCSHelper
    {
        private PSHScriptHelper _psh;

        private string _results = "";

        public string Results
        {
            get { return _results; }
        }

        public RCSHelper(string _dbi, string _hpp, string _webUser)
        {
            try
            {
                _psh = new PSHScriptHelper();

                _psh.ScriptGlobalVariables.Add("dbi_num", _dbi.Trim());
                _psh.ScriptGlobalVariables.Add("webUser", _webUser.Trim());
                _psh.ScriptText = _hpp + "\\TestPartner\\ImportAutomation.ps1";

                //_psh.ScriptText = "return $(get-date).ToString(\"yyyyMMdd:hhmmss\")";

                _results = _psh.RunScript();
            }
            catch (Exception _e)
            {
                _results = _e.ToString();
            }

        }

    }
}
