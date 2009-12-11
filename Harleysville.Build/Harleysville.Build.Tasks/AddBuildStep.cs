using System;
using System.Collections.Generic;
using System.Text;

using Microsoft.Build.Framework;
using Microsoft.Build.Utilities;

using Harleysville.Build.Utilities;

namespace Harleysville.Build.Tasks
{
    public class AddBuildStep : Task
    {
        private string _buildUri;
        private string _buildStepName;
        private string _buildStepText;

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
        public string BuildStepText
        {
            get
            {
                return _buildStepText;
            }
            set
            {
                _buildStepText = value;
            }
        }

        public override bool Execute()
        {
            BuildStepController _bsc = new BuildStepController(_buildUri, _buildStepName);

            try
            {
                return (_bsc.AddBuildStep(_buildStepText));
            }
            catch (Exception _ex)
            {
                BuildEngine.LogErrorEvent(new BuildErrorEventArgs("Build Step add", "Build Step add",
                                                                  _ex.Source, 420, 69, 45, 25,
                                                                  "Build Step add failure " + _ex.Message + _ex.StackTrace,
                                                                  "Build Step add failure " + _ex.Message + _ex.StackTrace,
                                                                  "TFSBuild"));
                return (_bsc.AddExceptionBuildStep(_ex));
            }
        }


    }
}
