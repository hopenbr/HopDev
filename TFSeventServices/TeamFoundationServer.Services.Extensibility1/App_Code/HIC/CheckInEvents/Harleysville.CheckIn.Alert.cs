using System;
using System.Data;
using System.Configuration;
using System.Globalization;
using System.Text;
using System.IO;
using System.Collections.Generic;
using System.Collections;
using System.Web.UI.HtmlControls;
using System.Drawing;
using TFSeventClasses;
using System.Xml;
using System.Text.RegularExpressions;

using Harleysville.Powershell.Utilities;


/// <summary>
/// Summary description for Harleysville
/// </summary>
/// 
namespace Harleysville.TFSEventServices
{
    public enum CheckInAlertType {envConfig, teamProjectConfig, earBuild }

    public class HarleysvilleCheckInAlert
    {
        private CheckinEvent _ciEvent;
        private TFVC _tfvc;
        private Dictionary<CheckInAlertType, ArrayList> _Messages;

        public HarleysvilleCheckInAlert(CheckinEvent _cie, TFSIdentity _tfsUrl)
        {
            _ciEvent = _cie;
            _tfvc = new TFVC(_tfsUrl.Url);
            _teamAddress = ConfigurationManager.AppSettings.Get("ConfigCheckInAlertAddress");
            SeedCheckInHash();
            _Messages = GetAlertTypeMessages();
        }

        private string _teamAddress;
        public string TeamAddress
        {
            get { return _teamAddress; }
        }

        private Dictionary<CheckInAlertType, List<string>> _checkInHash = new Dictionary<CheckInAlertType, List<string>>();
        /// <summary>
        /// This Dictionary hash collection has a key of CheckInAlertType with the checkin elements to 
        /// correspond to that alert
        /// </summary>
        public Dictionary<CheckInAlertType, List<string>> CheckInHash
        {
            get { return _checkInHash; }
        }

        protected CheckInAlertType _checkInAlertType;
        public CheckInAlertType CheckInAlertType
        {
            get { return _checkInAlertType; }
        }

        public void AlertOnCheckIn()
        {
            try
            {
                foreach (CheckInAlertType _ciat in _checkInHash.Keys)
                {
                    switch (_ciat)
                    {
                        case CheckInAlertType.teamProjectConfig:
                            AlertOnCheckIn(_checkInHash[_ciat], GetCommiterEmialAddress(_ciEvent.Committer), _ciat);
                            //RunEarDeployment("helo");
                            break;
                        case CheckInAlertType.envConfig:
                            AlertOnCheckIn(_checkInHash[_ciat], GetCommiterEmialAddress(_ciEvent.Committer), _ciat);
                            break;
                        case CheckInAlertType.earBuild:
                            break;

                    }
                }

            }
            catch (Exception ex)
            {
                StringBuilder _sb = new StringBuilder();
                _sb.AppendLine("*****");
                _sb.AppendLine("Number: " + _ciEvent.Number);
                _sb.AppendLine("Committer: " + _ciEvent.Committer);
                _sb.AppendLine("contitle: " + _ciEvent.ContentTitle);
                _sb.AppendLine("*****");
                _sb.AppendLine(ex.Message);
                _sb.AppendLine(ex.StackTrace);
                DebugMailer("Error in CheckInAlert", _sb.ToString());
            }

        }

        private void SeedCheckInHash()
        {
            string _expEnvConfig = Regex.Escape("$") + "/.+?/TeamBuildTypes/.+?/Env" + Regex.Escape(".") + "Config";
            Regex _regexEnvConfig = new Regex(_expEnvConfig, RegexOptions.IgnoreCase);

            List<string> _configFiles = _tfvc.GetListOfAllTeamProjectConfigFiles(_ciEvent.TeamProject);

            foreach (string _element in _tfvc.GetElementsInChangeSet(_ciEvent.Number))
            {

                if (_regexEnvConfig.IsMatch(_element))
                {
                    if (!_checkInHash.ContainsKey(CheckInAlertType.envConfig))
                    {
                        _checkInHash.Add(CheckInAlertType.envConfig, new List<string>());
                    }

                    _checkInHash[CheckInAlertType.envConfig].Add(_element);
               
                }
                else if (_element.EndsWith(".Ear", StringComparison.CurrentCultureIgnoreCase))
                {
                    if (!_checkInHash.ContainsKey(CheckInAlertType.earBuild))
                    {
                        _checkInHash.Add(CheckInAlertType.earBuild, new List<string>());
                    }

                    _checkInHash[CheckInAlertType.earBuild].Add(_element);
                }
                else if (SearchStringWithList(_configFiles, _element))
                {
                    if (!_checkInHash.ContainsKey(CheckInAlertType.teamProjectConfig))
                    {
                        _checkInHash.Add(CheckInAlertType.teamProjectConfig, new List<string>());
                    }

                    _checkInHash[CheckInAlertType.teamProjectConfig].Add(_element);
                }
                
                
            }
        }

        private void RunEarDeployment(string _earFile)
        {
            PSHScriptHelper _psh = new PSHScriptHelper();

            _psh.RunScript("write-output \"Hello World\" > C:\\Temp\\HelloWorld.Txt");
        }

        private bool SearchStringWithList(List<string> _list, string _search)
        {
            bool _wasFound = false;

            foreach (string _str in _list)
            {
                if (_search.Contains(_str))
                {
                    _wasFound = true;
                    break;
                }
            }

            return _wasFound;
        }

        /// <summary>
        /// This method creates a Dictionary hash that holds the alert messages for each alert type
        /// The ArrayList has two string elements:
        ///     [0]: The Subject of the alert type
        ///     [1]: The body of the alert 
        /// </summary>
        /// <returns></returns>
        private Dictionary<CheckInAlertType, ArrayList> GetAlertTypeMessages()
        {
            Dictionary<CheckInAlertType, ArrayList> _atm = new Dictionary<CheckInAlertType, ArrayList>();
            _atm.Add(CheckInAlertType.envConfig, new ArrayList());
            _atm.Add(CheckInAlertType.teamProjectConfig, new ArrayList());

            _atm[CheckInAlertType.envConfig].Add("Env.Config element");
            _atm[CheckInAlertType.envConfig].Add("You just checked in an Env.Config file, please ensure that " +
                    "are propagated to the proper build packages via DBIs'.  If these changes are " +
                    "these changes needed in a build package that is already built.  If not, no action " +
                    "is required  these changes will automatically be apart of the next build.");

            _atm[CheckInAlertType.teamProjectConfig].Add("Team Config file");
            _atm[CheckInAlertType.teamProjectConfig].Add("You just checked in a Config file(s), please ensure that these changes " +
                    "are propagated to the proper ENV.Config areas.  These changes will not " +
                    "show up in a build package until they are added to the proper " +
                    "ENV.Config area.");


            return _atm;

        }

        private void AlertOnCheckIn(List<string> _configs, string _emailAddress, CheckInAlertType _ciat)
        {
            Mailer _mailer = new Mailer();

            string _sub = "Alert: " + (string)_Messages[_ciat][0] + " check-in";
            StringBuilder _body = new StringBuilder();
            List<string> _recipients = new List<string>();

            _recipients.Add(_teamAddress);
            _recipients.Add(_emailAddress);

            _body.AppendLine("<table>")
                 .AppendLine("<tr><td>")
                 .AppendLine((string)_Messages[_ciat][1])
                 .AppendLine("</td><tr>")
                 .AppendLine("<tr><td>")
                 .AppendLine("Elements checked in were: ")
                 .AppendLine("</td></tr>")
                 .AppendLine("<tr><td>")
                 .AppendLine("<ul>");
                

            foreach (string _file in _configs)
            {
                _body.AppendLine("<li>" + _file + "</li>");
            }

            _body.AppendLine("</ul>")
                 .AppendLine("</td></tr>")
                 .AppendLine("<tr><td><br></td></tr>")
                 .AppendLine("<tr><td>")
                 .AppendLine("If you have any questions please contact your team lead or ")
                 .AppendLine("<a href=\"" + _teamAddress + "\" > SRM </a>")
                 .AppendLine("</td></tr>")
                 .AppendLine("</table>");

            _mailer.Add2RecipientList(_recipients.ToArray());
            _mailer.IsMailBodyHTML(true);

            _mailer.Send(_sub, _body.ToString());

        }

        private string GetCommiterEmialAddress(string _name)
        {
            //check to ensure it comes in "DOMAIN\USERID"

            if (_name.Contains("\\"))
            {
                return (_name.Split('\\')[1] + "@harleysvillegroup.com");
            }
            else
            {
                //not in std format
                return ("VSTFHelp@harleysvillegroup.com");
            }
        }

        public void DebugMailer(string _sub, string _body)
        {
            Mailer mail = new Mailer();
            mail.MailPriority = System.Net.Mail.MailPriority.High;
            mail.Send("Tfs@harleysvillegroup.com", ConfigurationManager.AppSettings.Get("DebugEmail"), _sub, _body);
        }
    }
}