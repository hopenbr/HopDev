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
using System.Management.Automation.Host;
using System.Threading;
using System.Globalization;
using System.Reflection;

namespace TfsDeployer.Runner
{
    public class DeploymentHost : PSHost
    {
        public override CultureInfo CurrentCulture
        {
            get { return Thread.CurrentThread.CurrentCulture; }
        }

        public override CultureInfo CurrentUICulture
        {
            get { return Thread.CurrentThread.CurrentUICulture; }
        }

        public override void EnterNestedPrompt()
        {
        }

        public override void ExitNestedPrompt()
        {
        }

        private Guid m_InstanceId = Guid.Empty;

        public override Guid InstanceId
        {
            get
            {
                if (this.m_InstanceId == Guid.Empty)
                {
                    this.m_InstanceId = Guid.NewGuid();
                }

                return this.m_InstanceId;
            }
        }

        public override string Name
        {
            get { return typeof(DeploymentHost).Name;  }
        }

        public override void NotifyBeginApplication()
        {
        }

        public override void NotifyEndApplication()
        {
        }

        public override void SetShouldExit(int exitCode)
        {
        }

        public override PSHostUserInterface UI
        {
            get { return null; }
        }

        public override Version Version
        {
            get { return Assembly.GetExecutingAssembly().GetName().Version; }
        }
    }
}
