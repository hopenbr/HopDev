using System;
using System.Collections.Generic;
using System.Text;
using System.Text.RegularExpressions;
using System.IO;
using System.Globalization;
using System.Diagnostics;

using Microsoft.Build.Framework;
using Microsoft.Build.Utilities;

using Microsoft.TeamFoundation;
using Microsoft.TeamFoundation.Client;
using Microsoft.TeamFoundation.VersionControl.Client;
using Microsoft.TeamFoundation.VersionControl.Common;

using Harleysville.Build.Utilities;

namespace Harleysville.Build.Tasks
{
    public class WhoKickedIt : Task
    {
        private string nameOfKicker;
        private string writePath;
        private string team_Project;
        private string build_Branch;
        //private string configXmlPath;
        private Dictionary<string, string> Config;
      


        [Output]
        public string NameOf
        {
            get { return nameOfKicker; }

        }

        [Required]
        public string WritePath
        {
            get { return writePath; }
            set { writePath = value; }
        }

        [Required]
        public string Team_Project
        {
            get { return team_Project; }
            set { team_Project = value; }
        }

        [Required]
        public string Build_Branch
        {
            get { return build_Branch; }
            set { build_Branch = value; }
        }
        #region Old Code
        //[Required]
        //public string ConfigXmlPath
        //{
        //    get { return configXmlPath; }
        //    set { configXmlPath = value; }
        //}
        #endregion

        public override bool Execute()
        {
            IO oOut = new IO();
            Config = oOut.GetConfig();

            QueryKicker();
            //GetKicker();

            
            if (nameOfKicker == null || nameOfKicker.Contains("tfsbuild"))
            {
                //No check-in today, maunal build called
                nameOfKicker = "VSTFhelp";
            }

            if (writePath.Length > 1)
            {
                oOut.OutputInText(nameOfKicker, writePath);
                return (true);
            }
            else
            {
                Log.LogMessage(MessageImportance.High, "Invalid WritePath: {0}", writePath);
                //writepath invalid
                return (false);
            }

        }

        private void GetKicker()
        {
            TeamFoundationServer tfs = new TeamFoundationServer(Config["TFS.Server"]);
            VersionControlServer vc = (VersionControlServer)tfs.GetService(typeof(VersionControlServer));
            TeamProject tp = vc.GetTeamProject(team_Project);
            Changeset cs = tp.VersionControlServer.GetChangeset(tp.VersionControlServer.GetLatestChangesetId());
           
            nameOfKicker = RemoveDomainFromUsername(cs.Committer.ToString());

        }

        private void QueryKicker()
        {
            TeamFoundationServer tfs = new TeamFoundationServer(Config["TFS.Server"]);
            VersionControlServer vc = (VersionControlServer)tfs.GetService(typeof(VersionControlServer));

            string today = "D" + DateTime.Today.Month + "/" + DateTime.Today.Day + "/" + DateTime.Today.Year;

            //should only run thought this once b/c MaxCount is set to 1 C:\\Projects\\BillingAdmin\\Branches\\Development
            foreach (Changeset cs in vc.QueryHistory(
                            "$/" + team_Project + "/Branches/" + build_Branch +"/*.*", 
                            VersionSpec.ParseSingleSpec(today, null),
                            0,
                            RecursionType.Full,
                            null,
                            VersionSpec.ParseSingleSpec(today, null),
                            null,
                            1,
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
                nameOfKicker = RemoveDomainFromUsername(cs.Committer.ToString());
            }
            tfs.Dispose();
            


        }

        static string RemoveDomainFromUsername(string user)
        {
            string pattern = @"^\w+\\";
            //matches word at begining of string ending with a '\'
            // ex\ CORP\BHOPENW ==> BHOPENW the CORP\ is deleted or replace with null
            Regex rgx = new Regex(pattern);
            return (rgx.Replace(user, ""));
        }

      

    }
}
