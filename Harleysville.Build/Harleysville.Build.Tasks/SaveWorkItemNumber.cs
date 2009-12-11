using System;
using System.Collections.Generic;
using System.Text;
using Microsoft.Build.Utilities;
using Microsoft.Build.Framework;
using System.Diagnostics;
using System.Xml;

namespace Harleysville.Build.Tasks
{
    public class SaveWorkItemNumber : Task
    {
        private string _dropLocation;
        private int _winum;
        private string _teamProject;
        private string _buildNumber;

        [Required]
        public string DropLocation
        {
            get { return _dropLocation; }
            set { _dropLocation = value; }
        }

        [Required]
        public string BuildNumber
        {
            get { return _buildNumber; }
            set { _buildNumber = value; }
        }

        [Required]
        public int WorkItemNumber
        {
            get { return _winum; }
            set { _winum = value; }
        }

        [Required]
        public string TeamProject
        {
            get { return _teamProject; }
            set { _teamProject = value; }
        }

        public override bool Execute()
        {
            string _file = _dropLocation + @"\" + _buildNumber + @"\BuildWorkItemNumber.xml";
            XmlTextWriter tw = new XmlTextWriter(_file,null);
            tw.Formatting = Formatting.Indented;  //for xml tags to be indented//
            tw.WriteStartDocument(); 
            tw.WriteStartElement("Project");			
            tw.WriteAttributeString("Name",_teamProject);
            tw.WriteStartElement("Build");
            tw.WriteAttributeString("Name", _buildNumber);
            tw.WriteElementString("WorkItemNumber",_winum.ToString());
            tw.WriteEndElement();
            tw.WriteEndElement();
            tw.WriteEndDocument();			
            tw.Flush();
            tw.Close();

            return true;
        }

    }
}
