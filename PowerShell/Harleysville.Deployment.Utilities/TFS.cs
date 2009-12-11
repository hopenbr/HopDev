using System;
using System.Collections.Generic;
using System.Text;
using Microsoft.TeamFoundation;
using Microsoft.TeamFoundation.Client;
using Microsoft.TeamFoundation.VersionControl.Client;
using Microsoft.TeamFoundation.WorkItemTracking.Client;
using Microsoft.TeamFoundation.Build.Proxy;

namespace Harleysville.Deployment.Utilities
{
    /// <summary>
    /// TFS Utility classes, holds methods to work with TFS
    /// </summary>
    public class TFS
    {
        private TeamFoundationServer _tfs;

        public TFS(string _TFSServerUrl)
        {
            _tfs = new TeamFoundationServer(_TFSServerUrl);
        }

        public TFS()
        {
            _tfs = new TeamFoundationServer("http://as73tfs01:8080");
        }
       
       
        private VersionControlServer _vc
        {
            get
            {
                return (VersionControlServer)_tfs.GetService(typeof(VersionControlServer));
            }
        }

        /// <summary>
        /// Add local elements to TFVC
        /// </summary>
        /// <param name="_sourceControlPath">
        /// Source control path where new element needed to be added
        /// </param>
        /// <param name="_localPath">
        /// Full path to new elements
        /// </param>
        /// <returns>
        /// true if add was successful
        /// </returns>
        public bool Add2SourceControl (string _sourceControlPath, string _localPath)
        {
            try
            {
                Workspace _ws = GetWorkSpace(_sourceControlPath, _localPath);
                // Get the files from the repository.
                _ws.Get();
                // Now add everything.
                _ws.PendAdd(_localPath, true);

                if (CheckIn(_ws))
                {
                    _ws.Delete();
                    return true;

                }
                else
                {
                    return false;
                }

            }
            catch
            {
                return false;
            }

        }

        /// <summary>
        /// Get PRD Release build package from TFVC
        /// </summary>
        /// <param name="_project">
        /// The TFS Team project that holds the build
        /// </param>
        /// <param name="_buildNumber">
        /// Build Number of build must be PRD release
        /// </param>
        /// <returns>
        /// Full local path to parent directory of build package 
        /// </returns>
        public string GetBuildPackageFromTFS(string _project, string _buildNumber)
        {
            Workspace _ws = GetWorkSpace("$/" + _project + "/Releases/" + _buildNumber,
                                         @"C:\Temp\" + _buildNumber);
            _ws.Get();
            string _topDir =  _ws.Folders[0].LocalItem; //Top level folder is returned
            _ws.Delete(); //delete the workspace not the local folders
            return _topDir;

        }

        /// <summary>
        /// Create a new workspace that has the mapping given 
        /// </summary>
        /// <param name="_sourceControlPath">
        /// Source code to pull from
        /// </param>
        /// <param name="_localPath">
        /// Local folder where source code will be pushed to
        /// </param>
        /// <returns>
        /// Workspace object with mapping
        /// </returns>
        public Workspace GetWorkSpace(string _sourceControlPath, string _localPath)
        {
            
            // Create a workspace.
            Workspace _ws = _vc.TryGetWorkspace(_localPath);
            if (_ws == null)
            {
                _ws = _vc.CreateWorkspace(DateTime.Now.ToString("yyyymmdd"), _vc.AuthenticatedUser);
            }
            WorkingFolder _myWorkingFolder = new WorkingFolder(_sourceControlPath, _localPath);
            // Create a mapping.
            _ws.CreateMapping(_myWorkingFolder);

            return _ws;

        }

        /// <summary>
        /// Check In all pending changes within the workspace
        /// </summary>
        /// <param name="_ws">
        /// workspace with pending changes
        /// </param>
        /// <returns>
        /// true if check-in is successful
        /// </returns>
        public bool CheckIn(Workspace _ws)
        {
            try
            {
                _ws.CheckIn(_ws.GetPendingChanges(), null);
                return true;
            }
            catch
            {
                return false;
            }


        }

        #region OldMethod
        /*
        /// <summary>
        /// 
        /// </summary>
        /// <param name="_ws"></param>
        /// <param name="_wici"></param>
        /// <returns></returns>
        public bool CheckIn(Workspace _ws, WorkItemCheckedInfo[] _wici)
        {
            try
            {
                //_ws.CheckIn(_ws.GetPendingChanges(), null, null, _wici, null);
                return true;
            }
            catch
            {
                return false;
            }


        }

        
        /// <summary>
        /// 
        /// </summary>
        /// <param name="_type"></param>
        /// <param name="_project"></param>
        /// <param name="_title"></param>
        /// <param name="_description"></param>
        /// <returns></returns>
        public WorkItem GetWorkItem(string _type, string _project, string _title, string _description)
        {
            WorkItemStore _store = (WorkItemStore)_tfs.GetService(typeof(WorkItemStore));
            //WorkItemTypeCollection _workItemTypes = _store.Projects[_project].WorkItemTypes;
            //WorkItemType _wit = _workItemTypes[_type];
            WorkItem _workItem = new WorkItem(_store.Projects[_project].WorkItemTypes[_type]);
            _workItem.Title = _title;
            _workItem.Description = _description;

            _workItem.Save();

            return _workItem;

        }*/
        #endregion

        /// <summary></summary>
        /// <param name="_buildUri">
        /// The URI of the build 
        /// </param>
        /// <returns>
        /// BuildData object of corresponsing Build
        /// </returns>
        public BuildData GetBuildData(string _buildUri)
        {
            BuildStore _bs = (BuildStore)_tfs.GetService(typeof(BuildStore));
            return (_bs.GetBuildDetails(_buildUri));
        }

        /// <summary>
        /// This method will Get elements from TFVC and copy them to a local directory 
        /// </summary>
        /// <param name="SourceControlPath">
        /// The Fully qualified source control path (ie $/TeamProject/Dir/...) 
        /// </param>
        /// <param name="LocalPath">
        /// The Local path where you want to elements from Source control downloaded to
        /// </param>
        public void GetFromTFVC(string SourceControlPath, string LocalPath)
        {
            Workspace _ws = this.GetWorkSpace(SourceControlPath, LocalPath);
            _ws.Get(); //push elements to local mapping
            _ws.Delete();//delete the workspace, but the local elements will remain. 
        }

        public void GetFromTFVC(string SourceControlPath, string LocalPath, string Label)
        {
            Workspace _ws = this.GetWorkSpace(SourceControlPath, LocalPath);
            string[] _items = new string[]{SourceControlPath};
            LabelVersionSpec _Labelvs = new LabelVersionSpec(Label);
            _ws.Get(_items, _Labelvs, RecursionType.Full, GetOptions.GetAll); //push elements to local mapping
            _ws.Delete();//delete the workspace, but the local elements will remain. 
        }

    }
}
