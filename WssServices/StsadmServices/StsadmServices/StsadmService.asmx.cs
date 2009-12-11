using System;
using System.Data;
using System.Web;
using System.Collections;
using System.Web.Services;
using System.Web.Services.Protocols;
using System.ComponentModel;
using System.Configuration;
using System.Text;
using System.Xml;

//using Microsoft.SharePoint.Administration;
//using Microsoft.Office.InfoPath.Server;
//using Microsoft.Office.InfoPath.Server.Administration;


using Harleysville.Powershell.Utilities;
using Harleysville.Utilities.Hlogger;

namespace StsadmServices
{
    /// <summary>
    /// StsadmServices are a collection of Services that will allow Stsadm tasks to run on local MOSS/WSS server 
    /// via powershell scripts and batch files 
    /// </summary>
    [WebService(Namespace = "http://harleysvillegroup.com/StsadmServices")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    [ToolboxItem(false)]
    public class StsadmServices : System.Web.Services.WebService
    {
        private Hlogger _hlog;

        public StsadmServices()
        {
            _hlog = new Hlogger();
        }

        /// <summary>
        /// The AddSolutionWsp web service will add a wsp solution file to 
        /// local WSS/MOSS server and deploy to 
        /// </summary>
        /// <param name="Path2Wsp">FUll UNC path to .wsp file</param>
        /// <returns>XML results string</returns>
        [WebMethod]
        public string AddSolutionWsp(string Path2Wsp)
        {
            try
            {
                _hlog.Write2Log("WSP Deployment: " + Path2Wsp + " started",
                                HloggerCategories.Info,
                                HloggerPriority.Low);

                PSHScriptHelper _psh = new PSHScriptHelper();

                _psh = AddCommonGlobaleVariables(_psh);

                _psh.ScriptGlobalVariables.Add("wspFile", Path2Wsp);

                _psh.ScriptText = ConfigurationManager.AppSettings.Get("Path2Scripts") + @"\Add-WspSolution.ps1";

                string _result =  _psh.RunScript();

                _hlog.Write2Log(_result,
                               HloggerCategories.Info,
                               HloggerPriority.Low);

                return _result;
            }
            catch (Exception ex)
            {
                return Catcher(ex);
            }
        }

        /// <summary>
        /// This Method will add a solution to a particular site collection
        /// </summary>
        /// <param name="Path2Wsp">Full UNC path to wsp file</param>
        /// <param name="siteUrl">Full Url to top level of site collection http://server:port</param>
        /// <returns>The string of results xml</returns>
        [WebMethod]
        public string AddSolutionWSP2SiteCollection(string Path2Wsp, string SiteUrl)
        {
            try
            {
                _hlog.Write2Log("WSP Deployment of " + Path2Wsp + " to " + SiteUrl + " started",
                                HloggerCategories.Info,
                                HloggerPriority.Low);

                PSHScriptHelper _psh = new PSHScriptHelper();

                _psh = AddCommonGlobaleVariables(_psh);

                _psh.ScriptGlobalVariables.Add("wspFile", Path2Wsp);

                _psh.ScriptGlobalVariables.Add("siteUrl", SiteUrl);

                _psh.ScriptText = ConfigurationManager.AppSettings.Get("Path2Scripts") + @"\Add-WspSolution.ps1";

                string _result = _psh.RunScript();

                _hlog.Write2Log(_result,
                               HloggerCategories.Info,
                               HloggerPriority.Low);

                return _result;
            }
            catch (Exception ex)
            {
                return Catcher(ex);
            }
        }


        /// <summary>
        /// The Run Stsadm cmd is a method that will allow you pass a string stsadm cmd in that will be run on
        /// local MOSS/WSS server
        /// </summary>
        /// <param name="Cmd">The stsadm  command</param>
        /// <returns>The output of the cmd</returns>
        [WebMethod]
        public string RunStsadmCmd(string Cmd)
        {
            try
            {
                _hlog.Write2Log("Run Stsadm Cmd : " + Cmd + " started",
                               HloggerCategories.Info,
                               HloggerPriority.Low);

                PSHScriptHelper _psh = new PSHScriptHelper();

                _psh = AddCommonGlobaleVariables(_psh);

                _psh.ScriptGlobalVariables.Add("cmd", Cmd);

                _psh.ScriptText = ConfigurationManager.AppSettings.Get("Path2Scripts") + @"\Run-StsadmCmd.ps1";

                _hlog.Write2Log("Run Stsadm Cmd : " + Cmd + " done",
                               HloggerCategories.Debug,
                               HloggerPriority.Low);

                string _result = _psh.RunScript();

                _hlog.Write2Log(_result,
                               HloggerCategories.Info,
                               HloggerPriority.Low);

                return _result;
            }
            catch (Exception ex)
            {
                return Catcher(ex);
            }
        }

        /// <summary>
        /// The Run Stsadm cmd is a method that will allow you pass a string stsadm cmd in that will be run on
        /// local MOSS/WSS server
        /// </summary>
        /// <param name="Cmd">The stsadm  command</param>
        /// <returns>The output of the cmd</returns>
        [WebMethod]
        public XmlDocument ExecStsadmCmd(string Cmd)
        {
            XmlDocument _xd = new XmlDocument();

            try
            {
                _hlog.Write2Log("Run Stsadm Cmd : " + Cmd + " started",
                               HloggerCategories.Info,
                               HloggerPriority.Low);

                PSHScriptHelper _psh = new PSHScriptHelper();

                _psh = AddCommonGlobaleVariables(_psh);

                _psh.ScriptGlobalVariables.Add("cmd", Cmd);

                _psh.ScriptText = ConfigurationManager.AppSettings.Get("Path2Scripts") + @"\Run-StsadmCmd.ps1";

                _hlog.Write2Log("Run Stsadm Cmd : " + Cmd + " done",
                               HloggerCategories.Debug,
                               HloggerPriority.Low);

                 _xd.InnerText = "<Results><Result>" + _psh.RunScript() + "</Reuslt></Results>";
            }
            catch (Exception ex)
            {
                _xd.InnerText = Catcher(ex);
            }

            return _xd;
        }

        /// <summary>
        /// This method will add a compile InfoPath 2007 form to WSS 
        /// </summary>
        /// <param name="path2Xsn">The full UNC path to the compile Info Path 2007 form with ext .xsn</param>
        /// <param name="mossUrl">The URL to MOSS site that Info Path form needs to be activated on</param>
        /// <returns>The output of the cmd</returns>
        [WebMethod]
        public string AddInfoPathXsn(string path2Xsn, string mossUrl, string xsnSha1)
        {
            try
            {
                _hlog.Write2Log("Add infopath xsn : " + path2Xsn + " started",
                               HloggerCategories.Info,
                               HloggerPriority.Med);

                PSHScriptHelper _psh = new PSHScriptHelper();

                _psh = AddCommonGlobaleVariables(_psh);

                _psh.ScriptGlobalVariables.Add("path2Xsn", path2Xsn);

                _psh.ScriptGlobalVariables.Add("mossUrl", mossUrl);

                _psh.ScriptGlobalVariables.Add("xsnSha1", xsnSha1);

                _psh.ScriptText = ConfigurationManager.AppSettings.Get("Path2Scripts") + @"\Add-InfoPathForm.ps1";

                _hlog.Write2Log("Running Add infopath xsn : " + path2Xsn,
                              HloggerCategories.Debug,
                              HloggerPriority.Low);

                string _result = _psh.RunScript();

                _hlog.Write2Log(_result,
                               HloggerCategories.Info,
                               HloggerPriority.Med);

                return _result;
            }
            catch (Exception ex)
            {
                return Catcher(ex);
            }
        }

        /// <summary>
        /// This method will 
        /// </summary>
        /// <param name="sha1"></param>
        /// <param name="formName"></param>
        /// <returns></returns>
        //[WebMethod]
        //public bool CheckInfoPathDeployment(string sha1, string formName)
        //{
        //    bool match = true;

        //    FormsService lfs = new FormsService("FormsService", SPFarm.Local);

        //    FormTemplate xsn = lfs.FormTemplates[formName];

        //    if (xsn.Properties.ContainsKey("SHA1"))
        //    {
        //        string currentSha1 = (string)xsn.Properties["SHA1"];

        //        if (currentSha1 == sha1)
        //        {
        //            match = false;
        //        }
        //    }

        //   return match;
        //}

        /// <summary>
        /// This Method will upload a collection of Udcx files to a MOSS data connection library
        /// It will also update each udcx file to have correct endpoints pointing the 
        /// passed in web service Url 
        /// </summary>
        /// <param name="path2UdcxDir">
        /// Full UNC path to Directory holding collection of .udcx files to uploaded
        /// </param>
        /// <param name="dataConnectionLibUrl">
        /// The Full url to the sites data connection library 
        /// I.E. http://as73mossdev01:21603/sites/Srm/Test%20Udcx
        /// </param>
        /// <param name="relSiteUrl">
        /// The relitive pass from main site to site 
        /// I.E. /sites/Srm
        /// </param>
        /// <param name="webServiceUrl">
        /// The server name and port to be used for the endpoints in udcx 
        /// I.E. AS73mossdev:9001
        /// </param>
        /// <returns></returns>
        [WebMethod]
        public string UploadUdcx(string path2UdcxDir,
                                 string dataConnectionLibUrl,
                                 string relSiteUrl,
                                 string webServiceUrl)
        {
            try
            {
                _hlog.Write2Log("Udcx upload to " + dataConnectionLibUrl + " started",
                               HloggerCategories.Info,
                               HloggerPriority.Med);

                PSHScriptHelper _psh = new PSHScriptHelper();

                _psh = AddCommonGlobaleVariables(_psh);

                _psh.ScriptGlobalVariables.Add("path2UdcxDir", path2UdcxDir);

                _psh.ScriptGlobalVariables.Add("dataConnectionLibUrl", dataConnectionLibUrl);

                _psh.ScriptGlobalVariables.Add("relSiteUrl", relSiteUrl);

                _psh.ScriptGlobalVariables.Add("webServiceHost", webServiceUrl);

                _hlog.Write2Log("Method Variables:\npath2UdcxDir => " + path2UdcxDir + "\ndataConnectionLibUrl => " + dataConnectionLibUrl + "\nrelSiteUrl =>" + relSiteUrl + "\nwebServiceUrl =>" + webServiceUrl,
                               HloggerCategories.Debug,
                               HloggerPriority.Low);

                _psh.ScriptText = ConfigurationManager.AppSettings.Get("Path2Scripts") + @"\Upload-MossUdcx.ps1";

                _hlog.Write2Log("Udcx upload to " + dataConnectionLibUrl + "call complete",
                              HloggerCategories.Debug,
                              HloggerPriority.Low);

                string _result = _psh.RunScript();

                _hlog.Write2Log(_result,
                               HloggerCategories.Info,
                               HloggerPriority.Low);

                return _result;
            }
            catch (Exception ex)
            {
                return Catcher(ex);
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

        private string Catcher(Exception _ex)
        {
            Hlogger _hl = new Hlogger();

            _hl.Write2Log(_ex.ToString(),
                          HloggerCategories.Error,
                          HloggerPriority.High);
            string _rtn =  "<Results><Result><ERROR>" + _ex.ToString() + "</ERROR></Result></Results>";

            return _rtn;

        }
    }
}
