using System;
using System.Collections.Generic;
using System.Text;
using System.Text.RegularExpressions;
using System.IO;
using System.Globalization;
using System.Diagnostics;

using Microsoft.TeamFoundation;
using Microsoft.TeamFoundation.Client;
using Microsoft.TeamFoundation.WorkItemTracking.Client;
using Microsoft.TeamFoundation.WorkItemTracking.Common;
using Microsoft.TeamFoundation.VersionControl.Client;

using Microsoft.Build.Framework;
using Microsoft.Build.Utilities;

using Harleysville.Build.Utilities;

namespace Harleysville.Build.Tasks
{
    public class UpdateWorkItem : Task
    {
        private int _winum;
        private string _history;
        private string _description;
        private string _title;
        private string _areapath;
        private string _state;
        private string _bn;
        

        [Required]
        public int WorkItemNumber
        {
            get { return _winum; }
            set { _winum = value; }
        }

        
        public string History
        {
            get { return _history; }
            set { _history = value; }
        }

        
        public string Title   
        {
            get { return _title; }
            set { _title = value; }
        }

        public string BuildNumber
        {
            get { return _bn; }
            set { _bn = value; }
        }

        public string Description
        {
            get { return _description; }
            set { _description = value; }
        }

        public string Areapath
        {
            get { return _areapath; }
            set { _areapath = value; }
        }

        public string State
        {
            get { return _state; }
            set { _state = value; }
        }

        public override bool Execute()
        {
            TFVC oTfvc = new TFVC();
            TeamFoundationServer tfs = oTfvc.GetTfs();
            WorkItemStore store = (WorkItemStore)tfs.GetService(typeof(WorkItemStore));
            WorkItem wi = store.GetWorkItem(_winum);

            wi.Open();
            wi = Update(wi);
            wi.Save();
            return true;

        }

        public WorkItem Update( WorkItem wi)
        {

            wi.State = _state;
            if (_areapath != null)
            {
                wi.AreaPath = _areapath;
            }
            else
            {
                wi.AreaPath = "Software.Release.Management\\Builds";
            }

            if (_title != null)
            {
                wi.Title = _title;
                wi.Fields["Build Number"].Value = _title;
            }

            if (_bn != null)
            {
                wi.Title = _bn;
                wi.Fields["Build Number"].Value = _bn;
            }

            if (_history != null)
            {
                wi.History =  _history;
            }

            return wi;
           
        }


        private void writeout(string text, string path)
        {
            IO oOut = new IO();
            oOut.OutputInText(text, path);
        }

        //public void UpdateWorkItemHistory(int _winum, string history)
        //{
        //    TeamFoundationServer tfs = GetTfs();
        //    WorkItemStore store = (WorkItemStore)tfs.GetService(typeof(WorkItemStore));
        //    WorkItem wi = store.GetWorkItem(_winum);
        //    wi.History = history;

        //    wi.State = nextState;


        //}
    }
}
