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
    public class DeleteAll : Task 
    {
        private string dir;

        [Required]
        public string Dir
        {
            get { return dir; }
            set { dir = value; }
        }

        public override bool Execute()
        {
            foreach (string f in Directory.GetFiles(dir))
            {
                File.Delete(f);
            }
            
            foreach (string d in Directory.GetDirectories(dir))
            {
                Directory.Delete(d, true);
            }

            return true;
        }

      
    }
}
