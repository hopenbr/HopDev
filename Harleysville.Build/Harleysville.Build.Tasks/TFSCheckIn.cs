using System;
using System.Collections.Generic;
using System.Text;
using System.Text.RegularExpressions;
using System.IO;
using System.Globalization;
using System.Diagnostics;

using Microsoft.TeamFoundation;
using Microsoft.TeamFoundation.Client;
using Microsoft.TeamFoundation.VersionControl.Client;
using Microsoft.TeamFoundation.VersionControl.Common;
using Microsoft.TeamFoundation.WorkItemTracking.Client;

using Microsoft.Build.Framework;
using Microsoft.Build.Utilities;

using Harleysville.Build.Utilities;

namespace Harleysville.Build.Tasks
{
    public class TFSCheckIn : Task
    {
        private string element;
        private string workspace;
        private string owner;
        private string comment;
        private int winum;
        private string witype;
        private string project;
        private Dictionary<string, string> Config;

        [Required]
        public string Element
        {
            get { return element; }
            set { element = value; }
        }

        [Required]
        public string Workspace
        {
            get { return workspace; }
            set { workspace = value; }
        }

        [Required]
        public string Owner
        {
            get { return owner; }
            set { owner = value; }
        }

         [Required]
        public string Comment
        {
            get { return comment; }
            set { comment = value; }
        }

        [Required]
        public int WorkItemNumber
        {
            get { return winum; }
            set { winum = value; }
        }

        [Required]
        public string WorkItemType
        {
            get { return witype; }
            set { witype = value; }
        }

        [Required]
        public string TeamProject
        {
            get { return project; }
            set { project = value; }
        }

        public override bool Execute()
        {

            TFVC oTfvc = new TFVC();
            oTfvc.Checkin(element, workspace, owner, comment, witype, winum, project);
            return true;

        }


    }
}
