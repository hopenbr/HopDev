using System;
using System.Collections.Generic;
using System.Text;
using System.Diagnostics;
using System.Globalization;
using System.IO;

using Microsoft.TeamFoundation;
using Microsoft.TeamFoundation.Client;
using Microsoft.TeamFoundation.VersionControl.Client;
using Microsoft.TeamFoundation.VersionControl.Common;

namespace TFrename
{
    class Program
    {
        static void Main(string[] args)
        {
            bool _debug = false;
          //  string[] requiredOpts = new string[10] { "/teamproject", "/workspace", "/dir", "/id" };
            if (args.Length < 1)
            {
                throw new ArgumentException("A start-up parameter is required.");
            }
           

            Dictionary<string, string> opts = new Dictionary<string,string>();

            foreach (string a in args)
            {

                if (a.Contains("="))
                {
                    opts[a.Split('=')[0].ToLower()] = a.Split('=')[1];
                }
                else
                {
                    opts[a] = null;
                }

                if (_debug)
                {
                    foreach (string k in opts.Keys)
                    {
                        Console.WriteLine(k + " => " + opts[k]);
                    }
                }
            }

            if (opts.ContainsKey("/whatif"))
            {
                _debug = true;
            }

            TeamFoundationServer tfs = new TeamFoundationServer("HTTP://as73tfs01:8080");
            VersionControlServer vc = (VersionControlServer)tfs.GetService(typeof(VersionControlServer));
            TeamProject tp = vc.GetTeamProject(opts["/teamproject"]);
            Workspace ws = vc.GetWorkspace(opts["/workspace"]);
            Directory.SetCurrentDirectory(opts["/dir"]);

            foreach (string file in Directory.GetFiles(opts["/dir"]))
            {
                //Console.WriteLine(file + " => " + Path.GetExtension(file).ToString());

                if(Path.GetExtension(file).Contains(opts["/id"]))
                {
                   
                    if (opts.ContainsKey("/pre") && !Path.GetFileName(file).Contains(opts["/pre"]))
                    {
                        if (_debug)
                        {
                            Console.WriteLine(Path.GetFileName(file) + " => " + opts["/pre"] + Path.GetFileName(file));
                        }
                        else
                        {
                            ws.PendRename(Path.GetFileName(file), opts["/pre"] + Path.GetFileName(file));
                        }

                    }

                    if (opts.ContainsKey("/post") && !Path.GetFileName(file).Contains(opts["/post"]))
                    {
                        if (_debug)
                        {
                            Console.WriteLine(Path.GetFileName(file) + " => " + opts["/post"] + Path.GetFileName(file));
                        }
                        else
                        {
                            ws.PendRename(Path.GetFileName(file), Path.GetFileName(file) + opts["/post"]);
                        }

                    }
                    
                    
                } //end if (file

            } //end foreach

        } //end main

    }
}
