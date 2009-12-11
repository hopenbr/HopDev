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
using System.IO;
using Readify.Useful.TeamFoundation.Common;

namespace TfsDeployer.Configuration
{
    /// <summary>
    /// This class reads configuration information
    /// fromt the TeamBuild section of TFS and returns.
    /// </summary>
    public class TfsConfigReader : IConfigurationReader
    {

        string _workingDirectory;

        #region IConfigurationReader Members
        const string ConfigurationFileName = "DeploymentMappings.xml";
        
        public DeploymentMappings Read(string teamProjectName, Microsoft.TeamFoundation.Build.Proxy.BuildData teamBuild)
        {
            TraceHelper.TraceInformation(TraceSwitches.TfsDeployer, "Reading Configuration for Team Projet:{0} Team Build:{1}", teamProjectName, teamBuild.BuildType);
            _workingDirectory = TfsHelper.GetDeploymentItems(teamProjectName, teamBuild.BuildType);
            return ConfigurationReaderHelper.Read(Path.Combine(_workingDirectory, ConfigurationFileName)); ;
        }

      
        public string WorkingDirectory
        {
            get 
            {
                return _workingDirectory;
            }
        }

        #endregion
    }
}
