using System;
using System.Collections.Generic;
using System.Text;
using System.Management.Automation;
using System.Collections;
using System.DirectoryServices;

namespace Harleysville.Deployment.SnapIn
{
    [Cmdlet(VerbsCommon.Get, "IfAllowed2Deploy", SupportsShouldProcess = true)]
    public class Validate_Permissions : PSCmdlet
    {

        #region Parameters
        private string _userName;
        [Parameter(Position = 0,
            Mandatory = true,
            ValueFromPipelineByPropertyName = true,
            HelpMessage = "username to validate if they have the permissions to deploy")]
        [ValidateNotNullOrEmpty]
        public string Name
        {
            get { return _userName; }
            set { _userName = value; }
        }
 
        #endregion

        protected override void ProcessRecord()
        {
            try
            {
                DirectorySearcher _ds = new DirectorySearcher();
                _ds.SearchRoot = new DirectoryEntry("LDAP://dc=CORP,dc=Harleysvillegroup,dc=com");
                _ds.Filter = "(objectclass=group)";
                _ds.SearchScope = SearchScope.Subtree;
                foreach (SearchResult _sr in _ds.FindAll())
                {

                }
                
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
    }
}
