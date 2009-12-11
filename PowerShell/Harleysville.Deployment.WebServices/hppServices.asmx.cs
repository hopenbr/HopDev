using System;
using System.Data;
using System.Web;
using System.Collections;
using System.Collections.Generic;
using System.Web.Services;
using System.Web.Services.Protocols;
using System.Xml;
using System.ComponentModel;
using System.Configuration;
using System.Text;

using Harleysville.Deployment.Utilities;
using Harleysville.Powershell.Utilities;
using Harleysville.Utilities.Hlogger;

namespace Harleysville.Deployment.WebServices
{
    /// <summary>
    /// Summary description for hppServices
    /// </summary>
    [WebService(Namespace = "http://HarleysvilleGroup.com/hppServices")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    [ToolboxItem(false)]
    public class hppServices : System.Web.Services.WebService
    {
        private Hlogger _hlog;

        public hppServices()
        {
            _hlog = new Hlogger();
        }


        /// <summary>
        /// This script will run HPP script that been opened up to Web Services call 
        /// For more info about what scripts are available please look at the InvokeScripts 
        /// folder in the HPP 
        /// </summary>
        /// <param name="ScriptName">The name of the script in the invokeScripts folder</param>
        /// <param name="ParametersXml">The Parameters XML see XSD for more info</param>
        /// <returns></returns>
        [WebMethod]
        public string RunScript (string ScriptName, string ParametersXml)
        {
            try
            {
                _hlog.Write2Log("HPP service started", HloggerCategories.Info, HloggerPriority.Low);

                PSHScriptHelper _psh = new PSHScriptHelper();

                _psh = AddCommonGlobaleVariables(_psh);

                _psh.ScriptGlobalVariables.Add("pXml", ParametersXml);

                string script = ConfigurationManager.AppSettings.Get("Path2Hpp") + @"\InvokeScripts\" + ScriptName;

                _hlog.Write2Log("Running Scripts: " + script, HloggerCategories.Info, HloggerPriority.Low);

                _psh.ScriptText = script;

                return _psh.RunScript();
            }
            catch (Exception _ex)
            {
                return (_ex.ToString());
            }
            
        }

        /// <summary>
        /// Use this service to run at hoc PSH cmds
        /// </summary>
        /// <param name="Cmd">the cmds you want to invoke</param>
        /// <returns></returns>
        [WebMethod]
        public string RunCmd(string Cmd)
        {
            try
            {
                
                _hlog.Write2Log("HPP service started to at hoc cmd", HloggerCategories.Info, HloggerPriority.Low);

                PSHScriptHelper _psh = new PSHScriptHelper();

                _psh = AddCommonGlobaleVariables(_psh);

                _hlog.Write2Log("Running Scripts: " + Cmd, HloggerCategories.Info, HloggerPriority.Low);

                _psh.ScriptText = Cmd;

                return _psh.RunScript();
            }
            catch (Exception _ex)
            {
                return (_ex.ToString());
            }

        }

        /// <summary>
        /// This method will get the state of a service and a server
        /// 
        /// </summary>
        /// <param name="ServerName">
        /// The Full name of the server where the service is running
        /// </param>
        /// <param name="ServiceName">
        /// The service name Regular Expressions are supported
        /// </param>
        /// <returns></returns>
        [WebMethod]
        public bool IsServiceRunning (string ServerName, string ServiceName)
        {
           
            try
            {
                _hlog.Write2Log("HPP service started, GetServiceInfo", HloggerCategories.Info, HloggerPriority.Low);

                PSHScriptHelper _psh = new PSHScriptHelper();

                _psh = AddCommonGlobaleVariables(_psh);

                _psh.ScriptGlobalVariables.Add("serverName", ServerName);

                _psh.ScriptGlobalVariables.Add("matchString", ServiceName);

                string script = _psh.ScriptGlobalVariables["path2Hpp"] + @"\InvokeScripts\Invoke-IsServiceRunning.ps1";

                _hlog.Write2Log("Running Scripts: " + script, HloggerCategories.Info, HloggerPriority.Low);

                _psh.ScriptText = script;

                string _rval = _psh.RunScript();

                if (_rval.Equals("True"))
                {
                    return true;
                }
                else
                {
                    return false;
                }


            }
            catch (Exception _ex)
            {
                return false;
            }
        }

        
        private PSHScriptHelper AddCommonGlobaleVariables(PSHScriptHelper _ph)
        {
            StringBuilder _sb = new StringBuilder();
            string globalIndicator = "pshGlobal_";

            _sb.AppendLine("Set Global Variables:");

            foreach (string key in ConfigurationManager.AppSettings.AllKeys)
            {
                if (key.StartsWith(globalIndicator))
                {
                    string k = key.Remove(0, globalIndicator.Length);
                    string val = ConfigurationManager.AppSettings.Get(key);
                    _ph.ScriptGlobalVariables.Add(k, val);

                    _sb.AppendLine(k + " => " + val);
                }

            }

            _hlog.Write2Log(_sb.ToString(),
                          HloggerCategories.Debug,
                          HloggerPriority.Low);


            return _ph;
        }
    }



}
