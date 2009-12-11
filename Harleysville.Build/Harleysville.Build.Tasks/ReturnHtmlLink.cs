using System;
using System.Collections.Generic;
using System.Text;
using System.Text.RegularExpressions;
using System.IO;
using System.Globalization;
using System.Diagnostics;

using Microsoft.Build.Framework;
using Microsoft.Build.Utilities;

namespace Harleysville.Build.Tasks
{
    public class ReturnHtmlLink : Task
    {
        private string link;
        private string htmllink;

        [Required]
        public string Links
        {
            get { return link; }
            set { link = value; }
        }

        [Output]
        public string HtmlLink
        {
            get { return htmllink; }
        }

        public override bool Execute()
        {
            if (link.Length < 1)
            {
                //no links to be converted
                return true;
            }
            StringBuilder hln = new StringBuilder();
            hln.AppendFormat("<br>");

            if (link.Contains(";"))
            {
                foreach (string ln in link.Split(';'))
                {
                    if (ln.Contains("="))
                    {
                        hln.AppendFormat("<a href=\"{0}\" > {1} </a>", ln.Split('=')[1], ln.Split('=')[0]);
                    }
                    else
                    {
                        hln.AppendFormat("<a href=\"{0}\" > {1} </a>", ln, ln);

                    }

                    hln.AppendFormat("<br>");
                }  //End foreach

              
            }
            else if (link.Contains("="))
            {

                hln.AppendFormat("<a href=\"{0}\" > {1} </a>", link.Split('=')[1], link.Split('=')[0]);
               
            }
            else
            {
                hln.AppendFormat("<a href=\"{0}\" > {1} </a>", link, link);
               
            }

            hln.AppendFormat("<br>");
            htmllink = hln.ToString();

            return true;
        }
    }
}
