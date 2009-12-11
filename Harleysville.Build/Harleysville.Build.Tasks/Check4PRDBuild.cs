using System;
using System.Collections.Generic;
using System.Text;

using Microsoft.Build.Framework;
using Microsoft.Build.Utilities;

using Microsoft.TeamFoundation;
using Microsoft.TeamFoundation.Client;
using Microsoft.TeamFoundation.Build.Proxy;

using Harleysville.Build.Utilities;

namespace Harleysville.Build.Tasks
{
    public class Check4PRDBuild : Task
    {
        private string _project;
        private string _buildType;
        private string _buildNumber;

        [Required]
        public string TeamProject
        {
            get { return _project; }
            set { _project = value; }
        }

        [Required]
        public string BuildType
        {
            get { return _buildType; }
            set { _buildType = value; }
        }

        [Required]
        public string BuildNumber
        {
            get { return _buildNumber; }
            set { _buildNumber = value; }
        }

        [Output]
        public bool PRDBuildNumberFound
        {
            get { return _buildNumberFound;  }
            set { _buildNumberFound = value; }
        }
        private bool _buildNumberFound = false;

        public override bool Execute()
        {
            return true;
            // task has been merge into GetBuildNumber during update
            
        }


    }
}
