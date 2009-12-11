using System;
using System.Collections.Generic;
using System.Text;
using System.Text.RegularExpressions;
using System.IO;
using System.Globalization;
using System.Diagnostics;
using System.Configuration;

using Microsoft.TeamFoundation;
using Microsoft.TeamFoundation.Client;
using Microsoft.TeamFoundation.WorkItemTracking.Client;
using Microsoft.TeamFoundation.WorkItemTracking.Common;
using Microsoft.TeamFoundation.VersionControl.Client;
using Microsoft.TeamFoundation.Build.Proxy;

using Microsoft.Build.Framework;
using Microsoft.Build.Utilities;

using Harleysville.Build.Utilities;

namespace Harleysville.Build.Tasks
{
    public class GetWorkItem : Task
    {
        private string _witype;
        [Required]
        public string WorkItemType
        {
            get { return _witype; }
            set { _witype = value; }
        }

        private string _dbiProj;
        [Required]
        public string DBIProject
        {
            get { return _dbiProj; }
            set { _dbiProj = value; }
        }

        private string _buildUri;
        [Required]
        public string BuildUri
        {
            get { return _buildUri; }
            set { _buildUri = value; }
        }

        private string _bn;
        [Required]
        public string BuildNumber
        {
            get { return _bn; }
            set { _bn = value; }
        }

        private string _dbiType;
        public string DeploymentType
        {
            get { return _dbiType; }
            set { _dbiType = value; }
        }

        private string _dbiHicProject;
        public string HICProject
        {
            get { return _dbiHicProject; }
            set { _dbiHicProject = value; }
        }

        private string _dbiHicSubProject;
        public string HICSubProject
        {
            get { return _dbiHicSubProject; }
            set { _dbiHicSubProject = value; }
        }

        private int _wiNumber;
        [Output]
        public int WorkItemNumber
        {
            get { return _wiNumber; }
         
        }

        public override bool Execute()
        {
            try
            {
               
                TFVC _Tfvc = new TFVC();
                TeamFoundationServer _tfs = _Tfvc.GetTfs();
                BuildStore _bs = (BuildStore)_tfs.GetService(typeof(BuildStore));
                BuildData _bd = _bs.GetBuildDetails(_buildUri);
                WorkItem _wi = _Tfvc.CreateNewWorkItem(_witype, _dbiProj);
                _wi.Fields["Build Number"].Value = _bn;
                _wi.Fields["HIC Team Build Type"].Value = _bd.BuildType;
                _wi.Fields["HIC Build Requested By"].Value = _bd.RequestedBy;
                _wi.Fields["HIC Team Build Project"].Value = _bd.TeamProject;
                _wi.Title = _bn; // this keep link w/ TFS Deployer 

                if (!String.IsNullOrEmpty(_dbiHicProject))
                {
                    _wi.Fields["HIC DBI Project"].Value = _dbiHicProject;
                }

                if (!String.IsNullOrEmpty(_dbiHicSubProject))
                {
                    _wi.Fields["HIC DBI Sub-Project"].Value = _dbiHicSubProject;
                }

                if (!String.IsNullOrEmpty(_dbiType))
                {
                    _wi.Fields["HIC DBI Deployment Type"].Value = _dbiType;
                }
                else
                {
                    _wi.Fields["HIC DBI Deployment Type"].Value = ".Net";
                }

                _wi.Save();

                _wiNumber = _wi.Id;

            }
            catch (Exception _ex)
            {
                string _msg = "Get WorkItem failure:\n" + _ex.Message + "\n" + _ex.StackTrace;
                BuildEngine.LogErrorEvent(new BuildErrorEventArgs("Workitem Failure", "Get Failure",
                                                                  _ex.Source, 0, 0, 0, 0,
                                                                  _msg,
                                                                  "Creating an BBI was unsuccessful",
                                                                  "TFSBuild"));

                return false;
            }
                                                
            return true;

        }


        
    }
}
