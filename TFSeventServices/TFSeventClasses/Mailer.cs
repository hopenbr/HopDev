using System;
using System.Collections.Generic;
using System.Text;
using System.Net.Mail;
using System.Net.Mime;
using System.DirectoryServices;
using Microsoft.Practices.EnterpriseLibrary.Common;
using Microsoft.Practices.EnterpriseLibrary.Logging;
using Microsoft.Practices.EnterpriseLibrary.Logging.TraceListeners;

namespace TFSeventClasses
{
    public class Mailer
    {
        private SmtpClient SmtpMail = new SmtpClient();
        //default server is local SMTP using smart host	which is defined in web.
        
        private const string _smtpIP = "172.20.2.15";
        private const string _ccCollectionConst = "VSTFHelp@harleysvilleGroup.com";
        private MailAddress _defaultSender = new MailAddress("SRM@harleysvilleGroup.com");
        public string SMTPServerIPAddress
        {
            get { return _smtpIP; }
        }

        private MailMessage mail = new MailMessage();
        /// <summary>
        /// get current MailMessage Object
        /// </summary>
        public MailMessage Mail
        {
            get { return mail; }
        }

        private MailAddressCollection _ccCollection = new MailAddressCollection();
        public MailAddressCollection corbonCopyCollection
        {
            set { _ccCollection = value; }
            get { return _ccCollection; }
        }

        private MailPriority _mailPriority = new MailPriority();
        public MailPriority MailPriority 
        {
            set { _mailPriority = value; }
            get { return _mailPriority; }
        }

        public Mailer()
        {
            this.SetMailerDefaults();
            
        }

        public Mailer(MailAddressCollection _mailAddressColletion4CC)
        {
            this.SetMailerDefaults(); //set defaults 
            _ccCollection = _mailAddressColletion4CC;
            
        }

        public Mailer(MailPriority _priority)
        {
            this.SetMailerDefaults(); //set defaults 
            _mailPriority = _priority;
        }

        public Mailer(int _priority)
        {
            this.SetMailerDefaults(); //set defaults
            switch (_priority)
            {
                case 1: _mailPriority = MailPriority.Normal;
                    break;
                case 2: _mailPriority = MailPriority.High;
                    break;
                case 3: _mailPriority = MailPriority.High;
                    break;
                default: _mailPriority = MailPriority.Normal;
                    break;
            }
        }

        private void SetMailerDefaults()
        {
            _ccCollection.Add(_ccCollectionConst);
            _mailPriority = MailPriority.Normal;
            mail.IsBodyHtml = true;
            mail.From = _defaultSender;
           
        }

        public void Add2RecipientList(string[] _to)
        {
            foreach (string _address in _to)
            {
                mail.To.Add(_address);
            }
        }

        public void Add2RecipientList(string _to)
        {
            mail.To.Add(_to);

        }

        public void Add2RecipientList(MailAddress _to)
        {
            mail.To.Add(_to);

        }

        public void Add2RecipientList(MailAddressCollection _to)
        {
            foreach (MailAddress _address in _to)
            {
                mail.To.Add(_address);
            }

        }

        public void IsMailBodyHTML(bool _bool)
        {
            mail.IsBodyHtml = _bool;
        }

        public void Add2Body(string _body)
        {
            mail.Body += _body;
        }

        public void SetSubject(string _subject)
        {
            mail.Subject = _subject;
        }

        public void Send(string from, string to, string sub, string body)
        {
            MailAddress sender = new MailAddress(from);
            MailAddress rec = new MailAddress(to);
            mail.To.Add(to);
            mail.Sender = sender;
            mail.IsBodyHtml = true;
            mail.Subject = sub;
            mail.Body = body;
            this.Send();
           
        }

        public void Send(string sub, string body)
        {
            if (mail.To.Count == 0)
            {
                mail.To.Add(_defaultSender);
            }

            mail.Subject = sub;
            mail.Body = body;

            this.Send();

        }

        public void Send(string sub)
        {
            mail.Subject = sub;
            this.Send();
        }

        public void Send()
        {
            bool _isInError = false;

            if (string.IsNullOrEmpty(mail.Body))
            {
                mail.Body = "Error: message body blank";
                _isInError = true;

            }
            else if (string.IsNullOrEmpty(mail.Subject))
            {
                mail.Subject = "Error: message subject cannot be empty";
                _isInError = true;
            }

            if (_isInError)
            {
                mail.To.Clear();
                mail.To.Add(_defaultSender);
                mail.Priority = MailPriority.High;
                mail.CC.Clear();
            }
            else
            {
                mail.Priority = _mailPriority;

                MailAddressCollection _ccList = mail.CC;
                foreach (MailAddress _ma in _ccCollection)
                {
                    _ccList.Add(_ma);
                }
            }
            
            SmtpMail.Send(mail);
            

            mail.Dispose();
        }

        public string GetEmailAddress(string _name)
        {
            DirectorySearcher _ds = new DirectorySearcher();

            _ds.Filter = "(&(objectcategory=person)(name=" + _name + "))";

            SearchResultCollection _results =  _ds.FindAll();

            if (_results.Count == 1)
            {
                ResultPropertyValueCollection _prp = _results[0].Properties["mail"];

                return _prp[0].ToString();
            }
            else
            {
                return String.Empty;
            }
        }

    }
}
