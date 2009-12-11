using System;
using System.Collections.Generic;
using System.Text;
using Microsoft.Build.Utilities;
using Microsoft.Build.Framework;
using System.Diagnostics;
using System.Xml;

using Microsoft.TeamFoundation;
using Microsoft.TeamFoundation.Client;
using Microsoft.TeamFoundation.VersionControl.Client;
using Microsoft.TeamFoundation.VersionControl.Common;

using Harleysville.Build.Utilities;

namespace Harleysville.Build.Tasks
{
    public class GetBuildNumber : Task
    {
        public bool DebugMode
        {
            get { return _debugMode; }
            set { _debugMode = value; }
        }
        private bool _debugMode = false;

        public string TeamProject
        {
            get { return _project; }
            set { _project = value; }
        }
        private string _project;

        public string BuildType
        {
            get { return _buildType; }
            set { _buildType = value; }
        }
        private string _buildType;

        [Required]
        public bool Update
        {
            get { return _update; }
            set { _update = value; }
        }
        private bool _update = true;

        public bool GetLatest
        {
            get { return _get; }
            set { _get = value; }
        }
        private bool _get = false;

        public string WorkspaceName
        {
            get { return _ws; }
            set { _ws = value; }
        }
        private string _ws;

        public string Owner
        {
            get { return _owner; }
            set { _owner = value; }
        }
        private string _owner;

        [Output]
        public string BuildNumber
        {
            get { return _buildNumber; }
            set { _buildNumber = value; }
        }
        private string _buildNumber = String.Empty;

        [Required]
        public string VersionXmlPath
        {
            get { return _versionXmlPath; }
            set { _versionXmlPath = value; }
        }
        private string _versionXmlPath;

        public string UpdateVersion
        {
            get { return _updateVersionType; }
            set { _updateVersionType = value.ToLower(); }
        }
        private string _updateVersionType;

        private bool _updateMinorVersion = false;
        private bool _updateFixVersion = false;
        private bool _updateMajorVersion = false;
        private Dictionary<string, string> _bn = new Dictionary<string, string>();
        
      public override bool Execute()
      {
         bool result = true;

         try
         {
            ValidateProperties();
            if (_update)
            {
                _buildNumber = GetNewBuildNumber();
            }
            else
            {
                _buildNumber = GetLastBuildNumber();
            }
         }
         catch (Exception e)
         {
            result = false;

            BuildErrorEventArgs eventArgs;
            eventArgs = new BuildErrorEventArgs
                (
                    "",
                    "",
                    BuildEngine.ProjectFileOfTaskNode,
                    BuildEngine.LineNumberOfTaskNode,
                    BuildEngine.ColumnNumberOfTaskNode,
                    0, 0, 
                    "GetBuildNumber failed: " + e.Message, 
                    "", ""
                );

            BuildEngine.LogErrorEvent(eventArgs);

            throw;
         }

         return result;
      }

        private Dictionary<string, string> ReadLastBuildNumber()
        {
            if (_bn.Count == 0)
            {
                IO oOut = new IO();

                if (_get && !String.IsNullOrEmpty(_ws) && !String.IsNullOrEmpty(_owner))
                {
                    TFVC _tfs = new TFVC();
                    _tfs.GetLatest(_versionXmlPath, _ws, _owner);
                }

                _bn = oOut.XmlNodeRead(_versionXmlPath,
                                      "/project/BuildNumber");

            }

            return (_bn);
        }

        private string GetLastBuildNumber()
        {
            Dictionary<string, string> bn = ReadLastBuildNumber();
            return (bn["Name"] + "-" + bn["Major"] + "." + bn["Minor"] + "." + bn["Fix"] + "." + bn["Build"]);

        }


        private string GetNewBuildNumber()
        {
            Dictionary<string, string> bn = ReadLastBuildNumber();
            
            string build = null;
            string buildNumber = null;

            if (_debugMode)
            {
                IO oOut = new IO();
                StringBuilder s = new StringBuilder();

                s.AppendLine("starting:");

                foreach (string k in bn.Keys)
                {
                    s.AppendLine(k + " ==> " + bn[k]);
                }

                oOut.OutputInText(s.ToString(), @"C:\temp\bn.out");
            }

            if (_updateMajorVersion)
            {
                LogIt("Log: Major ");
                bn["Major"] = IncrementStringNumber(bn["Major"]);
                bn["Minor"] = "0";
                bn["Fix"] = "0";
                bn["Build"] = "1";
            }
            else if (_updateMinorVersion)
            {
                LogIt("Log: Minor ");
                bn["Minor"] = IncrementStringNumber(bn["Minor"]);
                bn["Fix"] = "0";
                bn["Build"] = "1";
            }
            else if (_updateFixVersion)
            {
                LogIt("Log: fix ");
                bn["Fix"] = IncrementStringNumber(bn["Fix"]);
                bn["Build"] = "1";
            }
            else
            {
                LogIt("Log: build ");
                bn["Build"] = IncrementStringNumber(bn["Build"]);
            }


            buildNumber = bn["Name"] + "-" + bn["Major"] + "." + bn["Minor"] + "." + bn["Fix"] + "." + bn["Build"];
            LogIt("Log: New build number: " + buildNumber);
            if (String.IsNullOrEmpty(buildNumber))
            {
                throw new InvalidOperationException(
                      "Could not generate a valid build number"
                   );
            }


            if (UpdateBuildXml(_versionXmlPath,
                           "/project/BuildNumber",
                           bn))
            {

                return buildNumber;
            }
            else
            {
                throw new InvalidOperationException(
                     "Could not Update build version xml"
                  );
            }
           

        }

        #region Old.GetLastBuildNumber
        //private string GetLastBuildNumber()
      //{
      //   string buildNumber = null;

      //   // if there is no last build, or it looks as if the 
      //   // last build was not using our name, 
      //   // we will reset to ".1";
      //   if (String.IsNullOrEmpty(LastBuildNumber) ||
      //      !LastBuildNumber.StartsWith(BaseBuildName))
      //   {
      //      buildNumber = "1";
      //   }
      //   // otherwise we need to parse out the last number and increment it
      //   else
      //   {
      //      string[] parts = LastBuildNumber.Split('.');
      //      int number = 1;
      //      bool parseResult = Int32.TryParse(
      //            parts[parts.Length - 1], 
      //            out number
      //         );
            
      //      if (parseResult)
      //      {
      //         number++;
      //         buildNumber = number.ToString();
      //      }
      //   }

      //   if (String.IsNullOrEmpty(buildNumber))
      //   {
      //      throw new InvalidOperationException(
      //            "Could not generate a valid build number"
      //         );
      //   }

      //   return buildNumber;
        //}
        #endregion

        private bool IsBuildInPRD(string _buildNum)
        {
            LogIt("Log: Check for PRD build");
            TFBS _tfbs = new TFBS();
            return (_tfbs.IsBuildInPRD(_project, _buildType, _buildNum));  
        }

        private void ValidateProperties()
        {
            if (String.IsNullOrEmpty(VersionXmlPath))
            {
                throw new ArgumentException("The path to build version xml is null");
            }

            if (_update)
            {
                if (string.IsNullOrEmpty(_project))
                {
                    throw new ArgumentException("The Team project must not be blank when updating build number");
                }

                if (string.IsNullOrEmpty(_buildType))
                {
                    throw new ArgumentException("The build type must not be blank when updating build number");
                }

                if (string.IsNullOrEmpty(_ws))
                {
                    throw new ArgumentException("The workspace name can not be blank when updating build number");
                }

                if (string.IsNullOrEmpty(_owner))
                {
                    throw new ArgumentException("Theworkspace owner must not be blank when updating build number");
                }

                if (!_get)
                {
                    throw new ArgumentException("The get must set to true when updating the build number");
                }

                if (!string.IsNullOrEmpty(_updateVersionType))
                {
                    LogIt("Log: Update Type " + _updateVersionType);
                    switch (_updateVersionType)
                    {
                        case "major":
                            _updateMajorVersion = true;
                            break;
                        case "minor":
                            _updateMinorVersion = true;
                            break;
                        case "fix":
                            _updateFixVersion = true;
                            break;
                        default:
                            throw new ArgumentException("UpdateVersion string can only be one of the following: major, minor, or fix");
                            

                    }

                }
                else
                {
                    _updateMinorVersion = IsBuildInPRD(GetLastBuildNumber());

                }
            }
      }

        private bool UpdateBuildXml(string file, string node, Dictionary<string, string> bn)
        {

            XmlDocument oXmlDoc = new XmlDocument();
            //XmlTextWriter writer = new XmlTextWriter(file, null)

            try
            {
                oXmlDoc.Load(file);
            }
            catch (Exception ex)
            {
                throw new InvalidOperationException(
                   "Could not save new Build Number" + ex
                );
            }

            foreach (string key in bn.Keys)
            {
                LogIt("Log: " + key + " ==> " + bn[key]);
                if (!key.Equals("Name", StringComparison.CurrentCultureIgnoreCase))
                {
                    XmlNode oNode = oXmlDoc.DocumentElement;
                    XmlNode bNode = oNode.SelectSingleNode(node + "/" + key);
                    bNode.InnerText = bn[key];
                }
            }

            oXmlDoc.Save(file);

            return (true);

        }

        private string IncrementStringNumber (string _number)
        {
            LogIt("Log: Incrementing " + _number);
            int num = 0;
            bool parseResult = Int32.TryParse(_number, out num);

            if (parseResult)
            {
                num++;
                LogIt("Log: incremented to " + num.ToString());
                return( num.ToString());
            }
            else
            {
                throw new InvalidOperationException(
                     "Could not cast string to int"
                  );
            }
        }

        private void LogIt(string _log)
        {
            BuildEngine.LogMessageEvent(new BuildMessageEventArgs(_log, "BNhelper", "BN", MessageImportance.High));
        }

   }
}

