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
using System.Threading;
using System.Diagnostics;
using System.IO;
using Microsoft.TeamFoundation.Build.Proxy;
using Readify.Useful.TeamFoundation.Common;

namespace TfsDeployer.Runner
{
    public class BatchFileRunner : IRunner
    {

        #region IRunner Members

        private string _scriptRun;
        public string ScriptRun
        {
            get { return _scriptRun; }
        }
	

        private bool _errorOccured;
        public bool ErrorOccured
        {
            get { return _errorOccured; }
        }
	

        private string _commandOutput;
        public string Output
        {
            get { return _commandOutput; }
        }
	
        public bool Execute(string workingDirectory, Mapping mapToRun, BuildData buildData)
        {
            

            _scriptRun = Path.Combine(workingDirectory, mapToRun.Script);

            if (!File.Exists(_scriptRun))
            {
                TraceHelper.TraceWarning(TraceSwitches.TfsDeployer, "BatchRunner - Could not find script: {0}", _scriptRun);
                _commandOutput = string.Format("BatchRunner - Could not find script: {0}", _scriptRun);
                _errorOccured = true;
                
            }
            else
            {



                // Create the ProcessInfo object
                ProcessStartInfo psi = new System.Diagnostics.ProcessStartInfo(_scriptRun);
                psi.UseShellExecute = false;
                psi.RedirectStandardOutput = true;
                psi.RedirectStandardInput = true;
                psi.RedirectStandardError = true;
                psi.WorkingDirectory = workingDirectory;
                psi.Arguments = CreateArguments(mapToRun, buildData);

                TraceHelper.TraceInformation(TraceSwitches.TfsDeployer, "BatchRunner - Executing Scripts: {0} with arguments {1} in working directory {2}", _scriptRun, psi.Arguments, psi.WorkingDirectory);

                // Start the process
                Process proc = Process.Start(psi);
                using (StreamReader sOut = proc.StandardOutput)
                {
                    proc.WaitForExit();
                    // Read the sOut to a string.
                    _commandOutput = sOut.ReadToEnd().Trim();
                    TraceHelper.TraceInformation(TraceSwitches.TfsDeployer, "BatchRunner - Output From Command: {0}", _commandOutput);
                }

                _errorOccured = false;
              
            }

            return !_errorOccured;
        }

        private string CreateArguments(Mapping mapping, BuildData buildData)
        {
            StringBuilder arguments = new StringBuilder(
            string.Format("{0}, {1} "
                , buildData.DropLocation
                , buildData.BuildNumber
                ));
            foreach (ScriptParameter param in mapping.ScriptParameters)
            {
                arguments.Append(", " + param.value);
            }
            return arguments.ToString();

        }


        #endregion
    }
}
