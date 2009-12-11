using System;
using System.Collections.Generic;
using System.Text;
using System.Diagnostics;
using System.Web.Services;
using System.IO;
using System.Threading;

using Microsoft.TeamFoundation.Client;
using Microsoft.TeamFoundation.VersionControl.Client;
using Microsoft.TeamFoundation.Build.Proxy;

namespace NightlyBuilder
{
    class Program
    {
        static void Main(string[] args)
        {
            Dictionary<string, string> opts = new Dictionary<string,string>();
            string[] requiredOpts = new string[6] { "/tfs.server", 
                                                    "/teamproject", 
                                                    "/buildbranch", 
                                                    "/buildtype", 
                                                    "/buildmachine", 
                                                    "/builddirectory" };
            StringBuilder log = new StringBuilder();
            log.AppendLine("------" + DateTime.Now.ToString() + "------");
            log.AppendLine("Check to see if build if needed");

            foreach (string a in args)
            {
                if (a.Contains("="))
                {
                    string key = a.Split('=')[0];
                    string val = a.Split('=')[1];
                    opts[key.ToLower()] = val;
                   
                }
                else
                {
                    opts[a] = null;
                }

            }

            foreach (string req in requiredOpts)
            {
                
                if (!opts.ContainsKey(req))
                {
                    throw new ArgumentException("ERROR: Missing Parameter (/" + req + ")");
                }

                if (opts[req] == null)
                {
                    throw new ArgumentException("ERROE: Missing Parameter value. " + req + "needs to have a value passed in with it.");
                }

                log.AppendLine(req + " => " + opts[req]);

            }
            bool nightlyBuildNeeded = false;

            TeamFoundationServer tfs = new TeamFoundationServer(opts["/tfs.server"]);
            VersionControlServer vc = (VersionControlServer)tfs.GetService(typeof(VersionControlServer));


            DateTime yesterday = DateTime.Now.AddDays(-1);
            string yday = "D" + yesterday.Month + "/" + yesterday.Day + "/" + yesterday.Year;

            log.AppendLine("Yesterdays => " + yesterday);
            log.AppendLine("yday => " + yday);

            foreach (Changeset cs in vc.QueryHistory(
                            "$/" + opts["/teamproject"] + "/" + opts["/buildbranch"] + "/*.*",
                            VersionSpec.ParseSingleSpec(yday, null),
                            0,
                            RecursionType.Full,
                            null,
                            VersionSpec.ParseSingleSpec(yday, null),
                            null,
                            int.MaxValue,
                            false,
                            false))
            #region QueryHistory Parameter list
            //public IEnumerable QueryHistory (
            //    string path,
            //    VersionSpec version,
            //    int deletionId,
            //    RecursionType recursion,
            //    string user,
            //    VersionSpec versionFrom,
            //    VersionSpec versionTo,
            //    int maxCount,
            //    bool includeChanges,
            //    bool slotMode
            //)
            #endregion
            {
                log.AppendLine("Changeset creation date => " + cs.CreationDate.ToString());
                if (cs.CreationDate > yesterday)
                {
                    nightlyBuildNeeded = true;
                    break;

                }

            } //end foreach

            if (nightlyBuildNeeded)
            {
                log.AppendLine("Build needed");
                bool didItBuild = false;
                int count = 0;
                do
                {
                    log.AppendLine("Calling Builder");
                    didItBuild = BuildIt(opts, tfs);
                    count++;

                    if (!didItBuild)
                    {
                        log.AppendLine("Sleeping for 6 minutes b/c there is a build in progress");
                        Thread.Sleep(360000);
                    }


                } while (!didItBuild || count >= 5);

            }
            else
            {
                log.AppendLine("No build required");
            }

            log.AppendLine("-----END----");

            if (opts.ContainsKey("/logpath"))
            {
                WriteLog(log.ToString(), opts["/logpath"]);
            }
            else
            {
                WriteLog(log.ToString(), @"E:\TFS\Nightlybuilder\logs\" + opts["/teamproject"] + ".log");
            }
        }

        static void WriteLog(string log, string outputpath)
        {
            DateTime LastMonth = DateTime.Now.AddMonths(-1);
            bool append = true;
            //if log file was created more then a month ago set append to false
            //which is create a new log file 
            if (File.GetCreationTime(outputpath) < LastMonth)
            {
                append = false;
            }

            using (StreamWriter sw = new StreamWriter(outputpath,append))
            {
                sw.WriteLine(log);
                sw.Flush();

            }
        }

        static bool BuildIt(Dictionary<string, string> opts, TeamFoundationServer tfs)
        {
            try
            {
               
                BuildController bc = (BuildController)tfs.GetService(typeof(BuildController));
                BuildParameters buildParameters = new BuildParameters();
                buildParameters.TeamFoundationServer = opts["/tfs.server"];
                buildParameters.TeamProject = opts["/teamproject"];
                buildParameters.BuildType = opts["/buildtype"];
                buildParameters.BuildMachine = opts["/buildmachine"];
                buildParameters.BuildDirectory = opts["/builddirectory"];


                bc.StartBuild(buildParameters);

                return true;
            }
            catch
            {
                return false;
            }
        }

    }

       
}
