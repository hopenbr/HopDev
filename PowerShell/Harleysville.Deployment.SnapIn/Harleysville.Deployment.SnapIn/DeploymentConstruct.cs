using System;
using System.Collections.Generic;
using System.Text;
using System.Management.Automation;
using System.Collections;
using Microsoft.TeamFoundation.Build.Client;
using Microsoft.TeamFoundation.Build.Proxy;

namespace Harleysville.Deployment.SnapIn
{
    [Cmdlet(VerbsCommon.Get, "DeploymentConstruct", SupportsShouldProcess = true)]
    public class DeploymentConstruct : PSCmdlet
    {

        #region Parameters

        private string _buildUri;
        [Parameter(Position = 0,
            Mandatory = true,
            ValueFromPipelineByPropertyName = true,
            HelpMessage = "The Build URI for the build being deployed")]
        [ValidateNotNullOrEmpty]
        public string BuildURI
        {
            set { _buildUri = value; }
            get { return _buildUri; }
            
        }

        #endregion

        #region struct definition 

        private struct DeploymentInfo
        {
            public string Env;
            public List<string> DeploymentPaths;
            public string StringProperty1;
            public bool ConfigDeploymentOnly;
            public bool isConfirmationNeeded;
            public bool isCleanNeeded;
            public bool BoolProperty;
            public BuildData BuildData;


            public DeploymentInfo(string _env, BuildData _buildData)
            {
                Env = _env;
                DeploymentPaths = new List<string>();
                BuildData = _buildData;
                isCleanNeeded = true;
                isConfirmationNeeded = true;
                BoolProperty = true;
                ConfigDeploymentOnly = false;
                StringProperty1 = String.Empty;
               

            }


        }

        #endregion 

        protected override void ProcessRecord()
        {
            try
            {
                BuildData _bd = GetBuildData();
                
                if (String.IsNullOrEmpty(_bd.BuildUri))
                {
                    WriteObject(new DeploymentInfo());
                }
                else
                {

                    WriteObject(new DeploymentInfo(_bd.BuildQuality.Replace("Deploy2", "In"), _bd));
                }
               
            }
            catch (Exception _ex)
            {
                WriteObject(new DeploymentInfo());
                WriteError(new ErrorRecord(_ex, "1678", ErrorCategory.InvalidOperation, _ex));
            }
        }

        private string ConversionBuidlQuality2Env(string _bq)
        {
            return (_bq.Replace("Deploy2", "In"));
        }

        private BuildData GetBuildData()
        {
            TFS _tfs = new TFS();
            return (_tfs.GetBuildData(_buildUri));
        }
    }
}
