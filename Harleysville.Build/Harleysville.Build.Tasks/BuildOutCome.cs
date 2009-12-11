using System;
using System.Collections.Generic;
using System.Text;
using Microsoft.Build.Framework;
using Microsoft.Build.Utilities;

using Harleysville.Build.Utilities;

namespace Harleysville.Build.Tasks
{
    public class BuildOutCome : Task
    {
        private bool successful;
        private string writePath;

        [Required]
        public bool Successful
        {
            get { return successful; }
            set { successful = value; }
        }

        [Required]
        public string WritePath
        {
            get { return writePath; }
            set { writePath = value; }
        }

        public override bool Execute()
        {
            IO oOut = new IO();
            if (successful)
            {
                oOut.OutputInText("true", writePath);
            }
            else
            {
                oOut.OutputInText("false", writePath);
            }

            return (true);
            
            //throw new Exception("The method or operation is not implemented.");
        }
    }
}
