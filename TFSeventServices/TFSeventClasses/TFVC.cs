using System;
using System.Collections.Generic;
using System.Text;
using System.IO;
using System.Security.AccessControl;

using Microsoft.TeamFoundation;
using Microsoft.TeamFoundation.Client;
using Microsoft.TeamFoundation.VersionControl.Client;

namespace TFSeventClasses
{
    public class TFVC : TFS
    {
        private VersionControlServer _vc;

        public TFVC() 
        {
            if (Tfs != null)
            {
                SetTfvc();
            }
            else
            {
                throw new Exception("Error: TFS must be set to create a TFVC object");
            }
        }

        public TFVC(string _tfsUrl)
        {
            SetTFS(_tfsUrl);
            SetTfvc();
        }

        protected void SetTfvc()
        {
            _vc = (VersionControlServer)Tfs.GetService(typeof(VersionControlServer));
        }

        /// <summary>
        /// Get a list of elements contained within a changeset
        /// </summary>
        /// <param name="_changeSetNumber">
        /// The number of the changeset
        /// </param>
        /// <returns>
        /// string list of server item names
        /// </returns>
        public List<string> GetElementsInChangeSet(int _changeSetNumber)
        {
            List<string> _elements = new List<string>();
            Changeset _cs = _vc.GetChangeset(_changeSetNumber);

            foreach (Change _c in _cs.Changes)
            {
                _elements.Add(_c.Item.ServerItem);

            }

            return _elements;

        }
        /// <summary>
        /// Verify if a directoy is already in Team Foundation Version control
        /// </summary>
        /// <param name="folderPath">
        /// The source control path to directoy 
        /// Ex/ $/MyTeamProject/Branches/Development/TheDirectoryIamLookingFor
        /// </param>
        /// <returns>
        /// Returns true if the directory was successfully found.
        /// </returns>
        public bool Check4DirectoryInTFVC(string folderPath)
        {
            return (_vc.ServerItemExists(folderPath, ItemType.Folder));
            
        }

        public List<string> GetListOfAllTeamProjectConfigFiles(string TeamProjectName)
        {
            TeamProject _tp = _vc.TryGetTeamProject(TeamProjectName);
            List<string> _list = new List<string>();

            if (_tp != null)
            {
                string _randomString = GetRandomString(21, false);

                Workspace _ws = _vc.CreateWorkspace(_randomString);

                DirectoryInfo _localMapping = new DirectoryInfo(@"C:\temp\" + _randomString);

                if (_localMapping.Exists)
                {
                    _localMapping.Delete(true);
                }

                _localMapping.Create();

                _ws.Map(_tp.ServerItem + "/TeamBuildTypes", _localMapping.FullName);
                _ws.Get();

                foreach (WorkingFolder _wf in _ws.Folders)
                {
                    DirectoryInfo _di = new DirectoryInfo(_wf.LocalItem);

                    foreach (DirectoryInfo _dir in _di.GetDirectories("Env.Config", SearchOption.AllDirectories))
                    {
                        foreach (FileInfo _file in _dir.GetFiles("*.*", SearchOption.AllDirectories))
                        {
                            _list.Add(_file.Name);
                            File.SetAttributes(_file.FullName, FileAttributes.Normal);
                        }
                    }

                    _ws.DeleteMapping(_wf);
                }

                _ws.RefreshMappings();
                _ws.Delete();
                _localMapping.Delete(true);
            }

            return _list;

        }

        /// <summary>
        /// Generates a random string with the given length
        /// </summary>
        /// <param name="size">Size of the string</param>
        /// <param name="lowerCase">If true, generate lowercase string</param>
        /// <returns>Random string</returns>
        private string GetRandomString(int _size, bool _lowerCase)
        {
            StringBuilder _builder = new StringBuilder();
            Random _random = new Random();
            char ch;
            for (int i = 0; i < _size; i++)
            {
                ch = Convert.ToChar(Convert.ToInt32(Math.Floor(26 * _random.NextDouble() + 65)));
                _builder.Append(ch);
            }

            if (_lowerCase)
            {
                return _builder.ToString().ToLower();
            }
            else
            {
                return _builder.ToString();
            }
        }



    }
}
