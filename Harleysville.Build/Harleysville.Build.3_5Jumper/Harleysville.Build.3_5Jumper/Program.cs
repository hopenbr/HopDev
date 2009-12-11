using System;

using System.Collections.Generic;

using System.Linq;

using System.Text;

using System.Diagnostics;

using System.Configuration;

namespace MSBuild

{

    /// <summary>

    /// This class takes the given arguments and routes it to a new executable. You could

    /// use it i.e. to reroute a call to msbuild.exe to another version of msbuild.exe by

    /// specify the location within the app.config:

    ///

    /// <?xml version="1.0" encoding="utf-8" ?>

    /// <configuration><appSettings>

    /// <add key="msbuild" value="C:\WINDOWS\Microsoft.NET\Framework\v3.5\MSBuild.exe"/>

    /// </appSettings></configuration>

    ///

    /// </summary>

    class MSBuild

    {

        public static int Main(string[] args)

        {

            // something like "C:\\WINDOWS\\Microsoft.NET\\Framework\\v3.5\\MSBuild.exe";

            string msbuildexe = ConfigurationSettings.AppSettings["msbuild"];

            System.Console.Out.WriteLine("MSBUILD call routed to : " + msbuildexe);

            // grep the msbuild.exe from the command line

            string envs = Environment.CommandLine;

            int pos = envs.ToLower().IndexOf("msbuild.exe");

            string arguments = envs.Substring(pos + 13);

            // now we should have the plain args escaped and all well done as the executor has called us

            System.Console.Out.WriteLine("arguments= " + arguments);

            // fire the new msbuild with the actual arguments

            Process process = Process.Start(msbuildexe, arguments);

            process.WaitForExit();

            return process.ExitCode;

        }

    }

}
