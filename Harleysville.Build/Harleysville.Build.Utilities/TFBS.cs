using System;
using System.Collections.Generic;
using System.Text;

using Microsoft.TeamFoundation;
using Microsoft.TeamFoundation.Client;
using Microsoft.TeamFoundation.Build.Proxy;

namespace Harleysville.Build.Utilities
{
    public class TFBS
    {
        /// <summary>
        /// Check to see if a build with the same build number foot print (Major.Minor.Fix) is 
        /// already in Production.
        /// </summary>
        /// <param name="_project">The Team project the build is apart of</param>
        /// <param name="_buildType">The build type being built</param>
        /// <param name="_buildNumber">The build number to be created</param>
        /// <returns>
        /// True is returned if a matching Production build number is found
        /// </returns>
        public bool IsBuildInPRD(string _project, string _buildType, string _buildNumber)
        {
            TFVC oTfvc = new TFVC();
            TeamFoundationServer tfs = oTfvc.GetTfs();

            BuildStore bs = (BuildStore)tfs.GetService(typeof(BuildStore));

            foreach (BuildData build in bs.GetListOfBuilds(_project, _buildType))
            {
                if (build.BuildQuality.Equals("In-Production"))
                {
                    if (_buildNumber.Remove(_buildNumber.LastIndexOf(".")).Equals(build.BuildNumber.Remove(build.BuildNumber.LastIndexOf("."))))
                    {
                       return true;
                    }
                }

            }

            return false;

        }
    }
}
