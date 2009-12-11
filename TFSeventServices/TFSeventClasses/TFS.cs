using System;
using System.Collections;
using System.Collections.Generic;
using System.Text;
using System.Net.Security;
using System.Security;
using System.Security.Permissions;
using Microsoft.TeamFoundation;
using Microsoft.TeamFoundation.Client;
using Microsoft.TeamFoundation.Common;
using Microsoft.TeamFoundation.Server;
using Microsoft.TeamFoundation.WorkItemTracking.Client;
using Microsoft.TeamFoundation.WorkItemTracking.Common;
using Microsoft.Practices.EnterpriseLibrary.Common;
using Microsoft.Practices.EnterpriseLibrary.Logging;
using Microsoft.Practices.EnterpriseLibrary.ExceptionHandling;
using Microsoft.Practices.EnterpriseLibrary.ExceptionHandling.Logging;

namespace TFSeventClasses
{
    [Serializable]
    public class TFS
    {
        private TeamFoundationServer _tfs; //= new TeamFoundationServer("HTTP://as73tfs01:8080");
        public TeamFoundationServer Tfs
        {
            get { return _tfs; }
        }

        private string _tfsServer; //= "HTTP://as73tfs01:8080";
        public string TFSServerUrl
        {
            get { return _tfsServer; }
            //set { _tfsServer = value; }
        }

        private string _tp = String.Empty;
        public string TeamProject
        {
            get { return _tp; }
            protected set { _tp = value; }
        }

        public TFS() { }

        public TFS(string tfsUrl)
        {
            SetTFS(tfsUrl);
        }

        protected void SetTFS (string tfsUrl)
        {
            _tfsServer = tfsUrl;
            _tfs = new TeamFoundationServer(_tfsServer);
        }

        public bool DeployBuild2TFVC(string _buildNumbers, string _teamProject)
        {
            if (!string.IsNullOrEmpty(_buildNumbers) &&
                !string.IsNullOrEmpty(_teamProject))
            {
                TFVC _tfvc = new TFVC(TFSServerUrl);

                foreach (string _buildNumber in _buildNumbers.Split(','))
                {
                    TFTB _tftb = new TFTB(_tfs, _buildNumber, _teamProject);

                    if (_tftb.IsValid)
                    {
                        if (!_tfvc.Check4DirectoryInTFVC("$/" + _teamProject + "/Releases/" + _buildNumber))
                        {
                            return (_tftb.DeployBuildTo(Enviroments.IRB));

                        }
                        else
                        {
                            //build package already in TFVC just need to change build quality to "In-IRB"
                            return (_tftb.ChangeBuildQuality(Enviroments.IRB));
                        }
                    }
                }
            }

            return false;

        }

        public List<string> GetTeamEmailAddresses(string _teamProject)
        {            
            ICommonStructureService _css = (ICommonStructureService)_tfs.GetService(typeof(ICommonStructureService));
            IGroupSecurityService _gss = (IGroupSecurityService)_tfs.GetService(typeof(IGroupSecurityService));
            IAuthorizationService _auth = (IAuthorizationService)_tfs.GetService(typeof(IAuthorizationService));
            ProjectInfo _tp = _css.GetProjectFromName(_teamProject);
            List<string> _teamAddresses = new List<string>();
            
            foreach (Identity _groupProject in _gss.ListApplicationGroups(_tp.Uri))
            {
                Identity _dirMembers = _gss.ReadIdentity(SearchFactor.Sid, _groupProject.Sid, QueryMembership.Direct);
                foreach (string _memSid in _dirMembers.Members)
                {
                    Identity _member = _gss.ReadIdentity(SearchFactor.Sid, _memSid, QueryMembership.None);
                    if (_member.SecurityGroup)
                    {
                        foreach (string _secureGroupMember in _member.Members)
                        {
                            _teamAddresses.Add("In Secure Group");
                            _teamAddresses.Add(_secureGroupMember);
                            
                        }
                    }
                    else if (_member.Type == IdentityType.WindowsGroup)
                    {
                        _teamAddresses.Add("Getting Group ID");
                        Identity _groupId = _gss.ReadIdentity(SearchFactor.Sid, _member.Sid, QueryMembership.None);
                        _teamAddresses.Add("SID ==> " + _groupId.Sid + " " + _groupId.DisplayName);
                        
                        if (_groupId.Members != null)
                        {
                            _teamAddresses.Add("Member Group ID");
                            foreach (string _workGroupMember in _groupId.Members)
                            {
                                if (_workGroupMember != null)
                                {
                                    _teamAddresses.Add(_workGroupMember);
                                }
                            }
                        }
                    }
                    _teamAddresses.Add(_member.Type.ToString());

                    _teamAddresses.Add(_member.MailAddress);
                }
            }

            return (_teamAddresses);
        }

        public Dictionary<string, string> GetUserInfo(string _user, string _teamProject)
        {
            Dictionary<string, string> _userInfo = new Dictionary<string, string>();
            IGroupSecurityService _gss = (IGroupSecurityService)_tfs.GetService(typeof(IGroupSecurityService));
            ICommonStructureService _css = (ICommonStructureService)_tfs.GetService(typeof(ICommonStructureService));
            IAuthorizationService _auth = (IAuthorizationService)_tfs.GetService(typeof(IAuthorizationService));
            ProjectInfo _tp = _css.GetProjectFromName(_teamProject);

            foreach (Identity _groupProject in _gss.ListApplicationGroups(_tp.Uri))
            {
                if (_groupProject.AccountName.Contains("Contributors"))
                {
                    Identity _dirMembers = _gss.ReadIdentity(SearchFactor.Sid, _groupProject.Sid, QueryMembership.Direct);
                    foreach (string _memSid in _dirMembers.Members)
                    {
                        Identity _member = _gss.ReadIdentity(SearchFactor.Sid, _memSid, QueryMembership.None);
                        if (_member.AccountName.Equals(_user))
                        {
                            _userInfo.Add("DisplayName", _member.DisplayName);
                            _userInfo.Add("AcctName", _member.AccountName);
                            _userInfo.Add("Email", _member.MailAddress);
                            _userInfo.Add("SID", _member.Sid);
                            break;
                        }
                    }

                }
            }

            return _userInfo;

        }

        //public bool UpdateWorkItemField(string _fieldName, object _fieldValue)
        //{
        //    _workItem = _tfwi.UpdateWorkItemField(_workItem, _fieldName, _fieldValue);
        //    return true;
        //}

        //public void LinkBuildWorkItem(string _buildNumber)
        //{
        //    _workItem = _tfwi.LinkBuildWorkItem(_workItem, _buildNumber);
        //}

    }
}
