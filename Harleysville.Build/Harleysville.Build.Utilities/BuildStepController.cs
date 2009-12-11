using System;
using System.Collections.Generic;
using System.Text;

using Microsoft.TeamFoundation;
using Microsoft.TeamFoundation.Client;
using Microsoft.TeamFoundation.Build.Proxy;


namespace Harleysville.Build.Utilities
{
    public class BuildStepController 
    {

        private BuildStore bs;

        private string _buildUri;
        //public string BuildUri
        //{
        //    set { _buildUri = value; }
        //    get { return _buildUri; }
        //}

        private string _buildStepName;
        /// <summary>
        /// Get/Set the name of the build step the controller is controlling 
        /// </summary>
        public string BuildStepName
        {
            set { _buildStepName = value; }
            get { return _buildStepName; }
        }

        private string _buildStepErrorMessage;
        /// <summary>
        /// Get the error message string thrown by the controller
        /// </summary>
        public string BuildStepControllerErrorMessage
        {
            get { return _buildStepErrorMessage; }
        }

        public BuildStepController(string buildUri)
        {
            bs = GetBuildStore();
            _buildUri = buildUri;
        }

        public BuildStepController(string buildUri, string buildStepName)
        {
            bs = GetBuildStore();
            _buildUri = buildUri;
            _buildStepName = buildStepName;
        }

        private BuildStore GetBuildStore()
        {
            TFVC oTfvc = new TFVC();
            TeamFoundationServer tfs = oTfvc.GetTfs();
            BuildStore _bs = (BuildStore)tfs.GetService(typeof(BuildStore));
            return (_bs);
        }

        /// <summary>
        /// Adds a build step to build report
        /// </summary>
        public bool AddBuildStep(string _text)
        {
            if (String.IsNullOrEmpty(_buildStepName) ||
                String.IsNullOrEmpty(_buildUri))
            {
                _buildStepErrorMessage = "BuildUri and/or BuildStepName cannnot be empty";
                return false;
            }
            else
            {
                
                bs.AddBuildStep(_buildUri, _buildStepName, _text);
                return true;
            }
        }

        /// <summary>
        /// This Method will update the status of a particular build step
        /// </summary>
        public bool UpdateBuildStep(bool _result)
        {
            if (String.IsNullOrEmpty(_buildStepName) ||
                String.IsNullOrEmpty(_buildUri))
            {
                _buildStepErrorMessage = "BuildUri and/or BuildStepName cannnot be empty";
                return false;
            }
            else
            {
                bool _isBuildStep = true;
                BuildStepStatus status = _result ? BuildStepStatus.Succeeded : BuildStepStatus.Failed;
                foreach (BuildStepData _bsd in bs.GetBuildSteps(_buildUri))
                {
                    
                    if (!string.IsNullOrEmpty(_bsd.BuildStepName) &&
                        _bsd.BuildStepName.Equals(_buildStepName))
                    {
                        _isBuildStep = true;
                        break;
                    }
                }

                if (_isBuildStep)
                {
                    bs.UpdateBuildStep(_buildUri, _buildStepName, DateTime.Now, status);
                    return true;
                }
                else
                {
                    _buildStepErrorMessage = "BuildStepName (" + _buildStepName + ") was not found within Build: " + _buildUri;
                    return false;
                }
            }
           
        }

        /// <summary>
        /// Adds exception message to build step of the build report with a failure status
        /// </summary>
        public bool AddExceptionBuildStep(Exception ex)
        {
            if (String.IsNullOrEmpty(_buildUri))
            {
                _buildStepErrorMessage = "BuildUri cannnot be empty";
                return false;
            }
            else
            {
                try
                {
                    bs.AddBuildStep(_buildUri, "Exception", ex.Message + ex.StackTrace);
                    bs.UpdateBuildStep(_buildUri, "Exception", DateTime.Now, BuildStepStatus.Failed);
                    return true;
                }
                catch (Exception _ex)
                {
                    _buildStepErrorMessage = "Error: " + _ex.Message;
                    return false;
                }
            }
        }



    }
}
