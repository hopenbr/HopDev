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

/// <summary>
/// Summary description for Harleysville.TFSEventServices
/// </summary>
namespace Harleysville.TFSEventServices
{
    /// <summary>
    /// Base class for all workitem type alerts
    /// </summary>
    public class HarelysvilleWorkItemAlerts : IHarleysvilleWorkItemAlerts
    {
        public enum WorkItemTypes
        {
            DeploymentBacklogItem, DBI = DeploymentBacklogItem,
            BuildBacklogItem, BBI = BuildBacklogItem,
            SprintBacklogItem, SBI = SprintBacklogItem,
            ProductBacklogItem, PBI = ProductBacklogItem,
            ReleaseBacklogItem, RBI = ReleaseBacklogItem,
            WorkItem
        };

        private int _mailPriority = 1;
        public int MailPriority
        {
            get { return _mailPriority; }
            set { _mailPriority = value; }
        }

        private WorkItemChangedEvent _wice;
        public WorkItemChangedEvent WIChangeEvent
        {
            get { return _wice; }
            set {_wice = value; }
        }

        private WorkItemHelper _wiHelper;

        public HarelysvilleWorkItemAlerts()
        {
            _wiHelper = new WorkItemHelper();
        }

        /// <summary>
        /// Main class that that all child class need to override 
        /// </summary>
        
        public virtual void WorkItemActions()
        {
           //AlertCreatedBy(_wiHelper.WiFields);
        }

        public void DebugMailer(string _sub, string _body)
        {
            Mailer mail = new Mailer();
            mail.MailPriority = System.Net.Mail.MailPriority.High;
            mail.Send("Tfs@harleysvillegroup.com", ConfigurationManager.AppSettings.Get("DebugEmail"), _sub, _body);
        }

        public void SendAlert(string _to, string _sub, string _body)
        {
            Mailer mail = new Mailer();
            if (_mailPriority > 1)
            {
                mail.MailPriority = System.Net.Mail.MailPriority.High;
            }
            _body += AddAlertFooter();
            mail.Send(ConfigurationManager.AppSettings.Get("AlertSenderAddress"), _to, _sub, _body);
        }

        public void SendAlert(Mailer mail)
        {
            mail.Add2Body(AddAlertFooter());
            mail.Send();
        }

        public string AddAlertFooter()
        {
            StringBuilder _sb = new StringBuilder();

            _sb.AppendLine("<br>")
               .AppendLine("<br>")
               .AppendLine("<table>")
               .AppendLine("<tr>")
               .AppendLine("<td>")
                 .AppendLine("Alert server: " + ConfigurationManager.AppSettings.Get("RunningOn"))
               .AppendLine("</td>")
               .AppendLine("</tr>")
                .AppendLine("<tr>")
               .AppendLine("<td>")
                 .AppendLine("Alert time: " + DateTime.Now.ToLongTimeString())
               .AppendLine("</td>")
               .AppendLine("</tr>")
               .AppendLine("</table>");

            return _sb.ToString();
        }

        public string GetEmailAddress(string _str)
        {
            if (_str.Contains("@"))
            {
                if (_str.Contains(";"))
                {
                    return (_str.Split(';')[0]);
                }
                else
                {
                    return (_str);
                }
            }
            else
            {
                return (this.GetCreatedByEmialAddress(_str));
            }
        }

        public string GetCreatedByEmialAddress(string _name)
        {
            //check to make sure it comes in "Last, First"
            if (_name.Contains(","))
            {
                Mailer _m = new Mailer();

                //fix for bug 14731 
                string _email = _m.GetEmailAddress(_name);

                if (_email == String.Empty)
                {

                    _email = _name.Split(',')[1].ToCharArray()[1] + _name.Split(',')[0] + "@harleysvillegroup.com";

                    Regex _regex = new Regex(@"\s+?", RegexOptions.Compiled);

                    if (_regex.IsMatch(_email))
                    {
                        _email = _regex.Replace(_email, string.Empty);
                    }
                }

                return _email; 
            }
            else
            {
                //user name not in std format IE TFSBuild
                return ("VSTFhelp@harleysvillegroup.com");
            }
        }

        public string CreateTable()
        {

            StringBuilder _table = new StringBuilder();

            _table.AppendLine("<table border=1>");
            _table.AppendLine("<tr bgcolor=CCCCCC>");
            _table.AppendLine("<th>Fields</th>");
            _table.AppendLine("<th>Old Value</th>");
            _table.AppendLine("<th>New Value</th>");
            _table.AppendLine("<tr>");
            _table.AppendLine(GetCoreStringRows(_wice.CoreFields.StringFields));
            _table.AppendLine(GetCoreIntRows(_wice.CoreFields.IntegerFields));
            _table.AppendLine(GetChangedStringRows(_wice.ChangedFields.StringFields));
            _table.AppendLine(GetChangedIntRows(_wice.ChangedFields.IntegerFields));
            _table.AppendLine("</table>");
            return _table.ToString();

        }

       private string GetCoreStringRows(List<StringField> _coreStringFields)
        {
            return (GetChangedStringRows(_coreStringFields));
        }

        private string GetCoreIntRows(List<IntegerField> _coreIntFields)
        {
            return (GetChangedIntRows(_coreIntFields));
        }

        private string GetChangedStringRows(List<StringField> _changedList)
        {

            StringBuilder _row = new StringBuilder();

            foreach (StringField _csf in _changedList)
            {
                if (!_csf.OldValue.Equals(_csf.NewValue))
                {
                    _row.AppendLine("<tr>");
                    _row.AppendLine("<td>" + _csf.Name + "</td>");
                    _row.AppendLine("<td>" + _csf.OldValue + "</td>");
                    _row.AppendLine("<td>" + _csf.NewValue + "</td>");
                    _row.AppendLine("</tr>");
                }

            }

            return _row.ToString();

        }

        private string GetChangedIntRows(List<IntegerField> _changedList)
        {
            StringBuilder _row = new StringBuilder();
            foreach (IntegerField _cif in _changedList)
            {
                if (!_cif.OldValue.Equals(_cif.NewValue))
                {
                    _row.AppendLine("<tr>");
                    _row.AppendLine("<td>" + _cif.Name + "</td>");
                    _row.AppendLine("<td>" + _cif.OldValue.ToString() + "</td>");
                    _row.AppendLine("<td>" + _cif.NewValue.ToString() + "</td>");
                    _row.AppendLine("</tr>");
                }

            }
            return _row.ToString();

        }

        private string GetTextFiledRows(TextField[] _textFields)
        {
            StringBuilder _sb = new StringBuilder();

            foreach (TextField _tf in _textFields)
            {
                _sb.AppendLine("<tr>")
                .AppendLine("<td>" + _tf.Name + "</td>")
                .AppendLine("<td colspan=2>" + _tf.Value + "</td>")
                .AppendLine("</tr>");
            }

            return _sb.ToString();
        }

        public string GetBody(string _wiNum)
        {
            StringBuilder _sb = new StringBuilder();
            string _bodyTitle = String.Empty;
            if (_wice.ChangeType == ChangeTypes.New)
            {
                _bodyTitle = "The workitem has been submitted, below is a link to a summary of the new workitem.";
            }
            else
            {
                _bodyTitle = "The workitem you submitted was changed, below is a summary of those changes.";
            }


            _sb.AppendLine("<table>")
               .AppendLine("<tr><td>")
               .AppendLine(_bodyTitle)
               .AppendLine("</td></tr>")
               .AppendLine("<tr><td>")
               .AppendLine("<a href=\"" + _wice.DisplayUrl + "\">" + _wice.WorkItemTitle + "</a>")
               .AppendLine("</td></tr>");

            if (_wice.ChangeType == ChangeTypes.Change)
            {
                _sb.AppendLine("<tr><td>")
                   .AppendLine("Changed Fields:")
                   .AppendLine("</td></tr>")
                   .AppendLine("<tr><td>")
                   .AppendLine(CreateTable())
                   .AppendLine("</td></tr>");
            }

            _sb.AppendLine("</table>");

            return GetBody(_sb.ToString(), _wiNum);
        }

        public string GetBody(string _bodyTitle, string _wiNum)
        {
            string _webAccessUrl = "http://TFS/wi.aspx?id=" + _wiNum;

            StringBuilder _sb = new StringBuilder();

            _sb.AppendLine("<table>")
               .AppendLine("<tr><td>")
               .AppendLine(_bodyTitle)
               .AppendLine("</td></tr>")
               .AppendLine("<tr><td>")
               .AppendLine("Links:")
               .AppendLine("</td></tr>")
               .AppendLine("<tr>")
               .AppendLine("<td>")
               .AppendLine("<table>")
               .AppendLine("<tr>")
               .AppendLine("<td>")
               .AppendLine("Detailed static report: ")
               .AppendLine("</td>")
               .AppendLine("<td>")
               .AppendLine("<a href=\"" + _wice.DisplayUrl + "\">(" + _wiNum + ") " + _wice.WorkItemTitle + "</a>")
               .AppendLine("</td>")
               .AppendLine("</tr>")
               .AppendLine("<tr>")
               .AppendLine("<td>")
               .AppendLine("Dynamic Web Access: ")
               .AppendLine("</td>")
               .AppendLine("<td>")
               .AppendLine("<a href=\"" + _webAccessUrl + "\">(" +  _wiNum + ") " +  _wice.WorkItemTitle + "</a>")
               .AppendLine("</td>")
               .AppendLine("</tr>")
               .AppendLine("</table>")
               .AppendLine("</td>")
               .AppendLine("</tr>")
               .AppendLine("</table>");

            return _sb.ToString();

        }


        /// <summary>
        /// Alerts via email that person that created the workitem 
        /// </summary>
        /// <param name="_fields">Dictionary of all Workitem fields</param>
        public void AlertCreatedBy(Dictionary<string, string> _fields)
        {
            Mailer _mailer = new Mailer();
            string _to = GetCreatedByEmialAddress(_fields["Created By"]);
            string _sub = String.Empty;
            string _body = String.Empty;

            if (_wice.ChangeType == ChangeTypes.New)
            {
                _sub = "WorkItem: (" + _fields["ID"] + ") \"" + _fields["Title"] + "\" submitted";
                _body = GetBody(_fields["ID"]);

            }
            else
            {
                _sub = "WorkItem: (" + _fields["ID"]+ ") \"" + _fields["Title"] + "\" Changed";
                _body = GetBody(_fields["ID"]);
            }

            _mailer.Send("Tfs@harleysvillegroup.com", _to, _sub, _body);

        }
       
    }
}
