using System;
using System.Collections.Generic;
using System.Text;
using System.Text.RegularExpressions;
using System.IO;
using System.Globalization;
using System.Diagnostics;

using Microsoft.Build.Framework;
using Microsoft.Build.Utilities;

using Harleysville.Build.Utilities;

namespace Harleysville.Build.Tasks
{
     
    public class ReturnTeamEmail : Task
    {
        private string team_Project;
        private string teamEmail;
        private Dictionary<string, string> config;

        [Required]
        public string Team_Project
        {
            get { return team_Project; }
            set { team_Project = value; }
        }

        [Output]
        public string TeamEmail
        {
            get { return teamEmail; }
        }

        public override bool Execute()
        {
            IO oOut = new IO();
            config = oOut.GetConfig();
            if (config.ContainsKey(team_Project + ".Team.Email"))
            {
                if (config[team_Project + ".Team.Email"].Contains(";"))
                {
                    //check to see if the Team email is a check or not
                    //if list it needs to be parsed

                    StringBuilder team = new StringBuilder();

                    int index = 0;

                    foreach (string member in config[team_Project + ".Team.Email"].Split(';'))
                    {
                        if (index != 0)
                        {
                            team.AppendFormat(";{0}{1}", member, config["Provider"]);
                        }
                        else
                        {
                            team.AppendFormat("{0}{1}", member, config["Provider"]);
                        }
                        index++;
                    }

                    teamEmail = team.ToString();
                }
                else
                {
                    teamEmail = config[team_Project + ".Team.Email"];
                }
            }
            else
            {
                teamEmail = config["Default.Email"];
            }

            return(true);
        }

    }
}
