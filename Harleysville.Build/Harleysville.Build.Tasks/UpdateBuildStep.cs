using System;
using System.Collections.Generic;
using System.Text;

using Microsoft.Build.Framework;
using Microsoft.Build.Utilities;

using Harleysville.Build.Utilities;

namespace Harleysville.Build.Tasks
{
    public class UpdateBuildStep : Task
    {
        private string _buildUri;
        private string _buildStepName;
        private string _buildStepText;
        private bool _buildStepResult;

        /// <summary>
        /// The Uri of the Build for which this task is executing.
        /// </summary>
        [Required]
        public string BuildUri
        {
            get
            {
                return _buildUri;
            }
            set
            {
                _buildUri = value;
            }
        }

        /// <summary>
        /// The Name of the Build step for which this task is executing.
        /// </summary>
        [Required]
        public string BuildStepName
        {
            get
            {
                return _buildStepName;
            }
            set
            {
                _buildStepName = value;
            }
        }

        /// <summary>
        /// The Text for the Build step for which this task is executing.
        /// </summary>
        [Required]
        public string BuildStepResult
        {
            get
            {
                return _buildStepResult.ToString();
            }
            set
            {
                if (value.Equals("true", StringComparison.CurrentCultureIgnoreCase))
                {
                    _buildStepResult = true;
                }
                else
                {
                    _buildStepResult = false;
                }
            }
        }

        public override bool Execute()
        {
            BuildStepController _bsc = new BuildStepController(_buildUri, _buildStepName);
            
            try
            {
                return (_bsc.UpdateBuildStep(_buildStepResult));
            }
            catch (Exception _ex)
            {
                BuildEngine.LogErrorEvent(new BuildErrorEventArgs("Build Step Update", "Build Step Update",
                                                                  _ex.Source, 420, 69, 45, 25,
                                                                  "Build Step Update failure " + _ex.Message + _ex.StackTrace,
                                                                  "Build Step Update failure " + _ex.Message + _ex.StackTrace,
                                                                  "TFSBuild"));
                return (_bsc.AddExceptionBuildStep(_ex));
            }
        }


    }
}
