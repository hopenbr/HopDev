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
using System.IO;
using System.Xml.Serialization;
using Microsoft.TeamFoundation.Build.Proxy;
using Readify.Useful.TeamFoundation.Common;

namespace TfsDeployer.Configuration
{
    /// <summary>
    /// Responsible for reading the configuration items from whatever form it will take
    /// </summary>
    public static class ConfigurationReaderHelper
    {
        /// <summary>
        /// Read the config file from a stream
        /// </summary>
        /// <param name="reader"></param>
        /// <returns></returns>
        private  static DeploymentMappings Read(TextReader reader)
        {
            
            XmlSerializer serializer = new XmlSerializer(typeof(DeploymentMappings));
            DeploymentMappings config = (DeploymentMappings)serializer.Deserialize(reader);
            reader.Close();
            return config;
        }

        public static DeploymentMappings Read(string configFileName)
        {
            //Verify that the deployment mappings file is a valid file
            TraceHelper.TraceInformation(TraceSwitches.TfsDeployer, "Reading Configuration File:{0}", configFileName);

            
            TraceHelper.TraceInformation(TraceSwitches.TfsDeployer, "Verifying Configuration File:{0}", configFileName);
            if (Properties.Settings.Default.SignDeploymentMappingFile)
            {
                if (!Encrypter.VerifyXml(configFileName,Properties.Settings.Default.KeyFile))
                {

                    TraceHelper.TraceWarning(TraceSwitches.TfsDeployer, "Verification Failed for the deployment mapping file:{0} and key file {1}", configFileName, Properties.Settings.Default.KeyFile);
                    return null;
                }
                TraceHelper.TraceInformation(TraceSwitches.TfsDeployer, "Verification Succeeded for the deployment mapping file:{0}", configFileName);

            }

            if (File.Exists(configFileName))
            {
                using (TextReader reader = new StreamReader(configFileName))
                {
                    DeploymentMappings config = Read(reader);
                    return config;
                }
            }
            else
            {
                TraceHelper.TraceWarning(TraceSwitches.TfsDeployer, "Reading Configuration File:{0} failed.", configFileName);

                return null;
            }
        }

      
        
    }
}
