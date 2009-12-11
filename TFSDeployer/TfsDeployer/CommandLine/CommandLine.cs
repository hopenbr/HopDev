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
using Genghis;
using System.IO;

namespace TfsDeployer
{
    public class CommandLine:CommandLineParser
    {
        [ValueUsage("Deployment Mapping File Name", Name = "m", Optional = true)]
        public string DeploymentMappingFileName;

        [ValueUsage("Key File Name", Name = "k", Optional = true)]
        public string KeyFileName;

        [ValueUsage("Create Key File", Name = "g", Optional = true)]
        public string CreateKeyFileName;

        public bool CreateKeyFile
        {
            get
            {
                return !string.IsNullOrEmpty(CreateKeyFileName);
            }
        }
        public bool EncyptDeploymentFile
        {
            get
            {
                return !string.IsNullOrEmpty(DeploymentMappingFileName);
            }
        }


        protected override void Parse(string[] args, bool ignoreFirstArg)
        {
            base.Parse(args, ignoreFirstArg);
            if (!string.IsNullOrEmpty(CreateKeyFileName) && !string.IsNullOrEmpty(KeyFileName))
            {
                throw new ApplicationException("Key File and Create Key File cannot be specified at the same time");
            }

            if (!CreateKeyFile && (!File.Exists(KeyFileName)))
            {
                throw new ArgumentOutOfRangeException("Key File Name",KeyFileName,"Cannot find the specified key file.");
            }

            if (!CreateKeyFile && !File.Exists(DeploymentMappingFileName))
            {
                throw new ArgumentOutOfRangeException("Deploymnet Mapping File", DeploymentMappingFileName, "Deploymentpping file is missing");
            }
        }
        
        

    }
}
