using System;
using System.Collections.Generic;
using System.Text;
using System.Web.Services;

using Microsoft.Build.Framework;
using Microsoft.Build.Utilities;

using Microsoft.TeamFoundation;
using Microsoft.TeamFoundation.Client;
using Microsoft.TeamFoundation.Build.Proxy;

using Harleysville.Build.Utilities;


namespace Harleysville.Build.Tasks
{
    public class UpdateBuildQuality4PreviousBuilds : Task
    {
        private string _project;
        private string _buildType;
        private string _buildQuality;

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
        public string BuildQuality
        {
            get { return _buildQuality; }
            set { _buildQuality = value; }
        }

        public override bool Execute()
        {
            UpdateBQ4PerviousBuilds();
            return (true);
        }

        private void writeout(string text, string path)
        {
            IO oOut = new IO();
            oOut.OutputInText(text, path);
        }

        private void UpdateBQ4PerviousBuilds()
        {
            TFVC oTfvc = new TFVC();
            TeamFoundationServer tfs = oTfvc.GetTfs();

            BuildStore bs = (BuildStore)tfs.GetService(typeof(BuildStore));

            BuildData[] bd = bs.GetListOfBuilds(_project, _buildType);

            foreach (BuildData build in bd)
            {
                if (build.BuildQuality.Contains(_buildQuality))
                {
                    bs.UpdateBuildQuality(build.BuildUri, "Rejected");
                }
            }

        }

    }
}
