// Copyright (c) 2007 Readify Pty. Ltd.
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

using System;
using System.Collections.Generic;
using System.Text;
using Microsoft.TeamFoundation.VersionControl.Client;
using Readify.Useful.TeamFoundation.Common;

namespace TfsDeployer.Configuration
{
    static class TfsHelper
    {
        const string ConfigurationFileLocation = "{0}/TeamBuildTypes/{1}/Deployment/";
        public static string GetDeploymentItems(string teamProjectName, string buildType)
        {
            string workspaceDirectory = SourceCodeControlHelper.GetWorkspaceDirectory("TFSDeployerConfiguration2");
            TeamProject teamProject = GetTeamProject(teamProjectName);
            ItemSpec configurationFileItemSpec = new ItemSpec(string.Format(ConfigurationFileLocation,teamProject.ServerItem,buildType),RecursionType.Full);
            VersionSpec version = VersionSpec.Latest;
            GetRequest[] request = new GetRequest[] { new GetRequest(configurationFileItemSpec, version) };
            string directoryToPlaceFiles  = string.Format(ConfigurationFileLocation, teamProject.ServerItem, buildType);
            TraceHelper.TraceInformation(TraceSwitches.TfsDeployer, "Getting file from {0} to {1}",workspaceDirectory,directoryToPlaceFiles);
            SourceCodeControlHelper.GetLatestFromSourceCodeControl(directoryToPlaceFiles, workspaceDirectory, request);
            return workspaceDirectory;
        }

        private static TeamProject GetTeamProject(string teamProjectName)
        {
            VersionControlServer versionControlServer = ServiceHelper.GetService<VersionControlServer>();
            return versionControlServer.GetTeamProject(teamProjectName);
        }

    }
}
