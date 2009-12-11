using System;
using System.Collections.Generic;
using System.Text;

using Microsoft.TeamFoundation;
using Microsoft.TeamFoundation.Client;
using Microsoft.TeamFoundation.Build.Proxy;

namespace TFSeventClasses
{
    public enum Enviroments : byte {Dev, End2End, Assembly, SystemTest2, Training, PrePrd, Prodcution, IRB, asy=Assembly, qa2=SystemTest2, e2e=End2End, trn=Training, pre=PrePrd, prd=Prodcution, tfvc=IRB}
    class TFTB
    {

        
        private TeamFoundationServer _tfs;
        private BuildStore _bs;
        private BuildData _buildData;
        private string[] _bqAppend = new string[2] {"In-", "Deploy2-"};

        private string _buildUri;
        public string BuildUri
        {
            //set { _buildUri = value; }
            get { return _buildUri; }
        }

        private string _buildNumber;
        public string BuildNumber
        {
            //set { _buildNumber = value; }
            get { return _buildNumber; }
        }

        private string _teamProject;
        public string TeamProject
        {
            //set { _teamProject = value; }
            get { return _teamProject; }
        }

        private Exception _exhandler;
        public Exception Exception
        {
            //set { _teamProject = value; }
            get { return _exhandler; }
        }

        private bool _isValid = true;
        /// <summary>
        /// True if build package was successfully found 
        /// </summary>
        public bool IsValid
        {
            get { return _isValid; }
        }
 
       
        public TFTB(TeamFoundationServer tfs, string buildUri)
        {
            SetVariables(tfs, buildUri);
            
        }

        public TFTB(TeamFoundationServer tfs, string buildNumber, string teamProject)
        {
            SetVariables(tfs, buildNumber, teamProject);
            
        }

        private void SetVariables(TeamFoundationServer tfs)
        {
            _tfs = tfs;
            _bs = GetBuildStore();

        }

        private void SetVariables(TeamFoundationServer tfs, string buildUri)
        {
            SetVariables(tfs);
            GetBuildData(buildUri);
            

        }

        private void SetVariables(TeamFoundationServer tfs, string buildNumber, string teamProject)
        {
            SetVariables(tfs);
            string _uri= _bs.GetBuildUri(teamProject, buildNumber);
            
            
            if (!String.IsNullOrEmpty(_uri))
            {
                GetBuildData(_uri);
            }
            else
            {
                Catcher(new Exception("Error: Could not find build data for build: " + buildNumber  + " in " + teamProject + " build store"));
            }

        }

        private BuildStore GetBuildStore()
        {
            return ((BuildStore)_tfs.GetService(typeof(BuildStore)));
        }

        private void GetBuildData(string buildUri)
        {
            try
            {
                _buildData = _bs.GetBuildDetails(buildUri);
                _buildNumber = _buildData.BuildNumber;
                _teamProject = _buildData.TeamProject;
                _buildUri = "vstfs:///Build/Build/" + _buildData.BuildUri;
            }
            catch (Exception ex)
            {
                Catcher(ex);
            }

        }

        /// <summary>
        /// This will update the build quality for the build 
        /// </summary>
        /// <param name="env">The environment you want the build to be in, 
        /// ex/ Assembly will change build quality "In-Assembly" 
        /// </param>
        /// <returns></returns>
        public bool ChangeBuildQuality(Enviroments env)
        {
            return (ChangeBuildQuality("In-" + env.ToString()));

        }
        private bool ChangeBuildQuality(string newQuality)
        {
            bool _returnCode = true;
            try
            {
                
                _bs.UpdateBuildQuality(_buildUri, newQuality);
            }
            catch (Exception _ex)
            {
                Catcher(_ex);
                _returnCode = false;
            }

            return _returnCode;

        }

        /// <summary>
        /// This will deploy the build package to the given test environment
        /// </summary>
        /// <param name="env"></param>
        /// <returns></returns>
        public bool DeployBuildTo(Enviroments env)
        {
            bool _wasSuccessfullyDeployed = true;

            //reason for this duoble change of buildQuality
            //The Deployer has a set path of how builds can be deploy to and from
            //there4 you cannot deploy from some env to others, but you can redeploy 
            //to any env.  This way we can ensure that we get a deployer triggered 
            //running a redeploy, 
            //which is change the BQ to In-env then change it again to Deploy2-env
            //ex/ if deploying to IRB you would first change the BQ to "In-IRB" then
            //change it to "Deploy2-IRB" 

           
            foreach (string _app in _bqAppend)
            {
                string _bq = _app + env.ToString();

                if (_bq.Equals("In-IRB"))
                {
                    _bq = "In-PrePrd";
                    // IRB is only env that does not have redeploys set up
                }

                _wasSuccessfullyDeployed = ChangeBuildQuality(_bq); 
            }

            return (_wasSuccessfullyDeployed);
            
        }


        private void Catcher(Exception ex)
        {
            _exhandler = ex;
            _isValid = false;
        }

    }
}
