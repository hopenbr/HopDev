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

using Microsoft.Build.Framework;
using Microsoft.Build.Utilities;

using Harleysville.Build.Utilities;

namespace Harleysville.Build.Tasks
{
   public class TFSCheckOut : Task 
    {
        private string element;
        private string workspace;
        private string owner;
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

       public override bool Execute()
       {
           TFVC oTfvc = new TFVC();
           oTfvc.GetLatest(element, workspace, owner);
           oTfvc.Checkout(element, workspace, owner);
           return true;

       }


    }
}
