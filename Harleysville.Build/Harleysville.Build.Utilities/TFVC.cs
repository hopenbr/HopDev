using System;
using System.Collections;
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
using Microsoft.TeamFoundation.WorkItemTracking.Common;

namespace Harleysville.Build.Utilities
{
    public class TFVC
    {
        private string _gErrorMsg = "";

        public string ErrorMsg
        {
            get { return _gErrorMsg; }
        }

        public bool Checkout(string element, string wsname, string owner)
        {
            Workspace ws = this.GetWorkSpace(wsname, owner);
            ws.PendEdit(element);

            return true;

        }

        public bool Checkin(string element, string wsname, string owner, string comment, string witype, int winum, string project)
        {
            TeamFoundationServer tfs = GetTfs();
            WorkItemStore store = (WorkItemStore)tfs.GetService(typeof(WorkItemStore));
            WorkItemTypeCollection workItemTypes = store.Projects[project].WorkItemTypes;
            Workspace ws = this.GetWorkSpace(wsname, owner);
            PendingChange[] pendingChanges = ws.GetPendingChanges(element);
            WorkItemType wi = workItemTypes[witype];
            WorkItemCheckinInfo[] wici= new WorkItemCheckinInfo[1];

            wici[0] = new WorkItemCheckinInfo( wi.Store.GetWorkItem(winum), 
                                               WorkItemCheckinAction.Associate);
           
            int changesetNumber = ws.CheckIn(pendingChanges, comment, null, wici, null);
            return true;

        }

         public bool CheckinAll(string wsname, string owner, string comment, int winum)
         {
             TeamFoundationServer tfs = GetTfs();
             WorkItemStore store = (WorkItemStore)tfs.GetService(typeof(WorkItemStore));
             Workspace ws = this.GetWorkSpace(wsname, owner);
             PendingChange[] pendingChanges = ws.GetPendingChanges();
             WorkItemCheckinInfo[] wici = new WorkItemCheckinInfo[1];
             wici[0] = new WorkItemCheckinInfo(store.GetWorkItem(winum), WorkItemCheckinAction.Associate);

             if (pendingChanges.Length > 0)
             {
                 int changesetNumber = ws.CheckIn(pendingChanges, comment, null, wici, null);
                 return true;
             }
             else
             {
                 return false;
             }

         }

         public bool Merge(string _source, string _target, string _wsName, string _owner)
         {
             Workspace _ws = GetWorkSpace(_wsName, _owner);
             GetStatus _gs = _ws.Merge(_source, 
                                       _target, 
                                       null, 
                                       VersionSpec.Latest, 
                                       LockLevel.CheckOut, 
                                       RecursionType.Full, 
                                       MergeOptions.None);

             Conflict[] _mergeConflicts = _ws.QueryConflicts(new string[2] { _target, _source }, true);
             bool _wasMergeSuccessful = true; 

             if (_mergeConflicts.Length > 0)
             {
                 foreach (Conflict _c in _mergeConflicts)
                 {
                     _ws.MergeContent(_c, false);

                     if (_c.ContentMergeSummary.TotalConflicting == 0)
                     {
                         _c.Resolution = Resolution.AcceptMerge;
                         _ws.ResolveConflict(_c);

                     }
                     else
                     {
                         _ws.Undo(_ws.GetPendingChanges());
                         _wasMergeSuccessful = false;
                         _gErrorMsg = _c.GetFullMessage();
                         break;
                     }
                     
                 }
                 
             }

             return (_wasMergeSuccessful);
         }

         public bool AddToTFVC(string[] _files, WorkItem _wi, Workspace _ws)
         {
             try
             {
                 _ws.Get();
                 // Now add everything.
                 _ws.PendAdd(_files, false);
                 WorkItemCheckinInfo[] _wici = new WorkItemCheckinInfo[1];

                 _wici[0] = new WorkItemCheckinInfo(_wi, WorkItemCheckinAction.Associate);

                 if (_ws.CheckIn(_ws.GetPendingChanges(), null, null, _wici, null) > 0)
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

         public Workspace CreateWorkSpace(string _sourceControlPath, string _localPath)
         {
             TeamFoundationServer tfs = GetTfs();
             VersionControlServer _vc = (VersionControlServer)tfs.GetService(typeof(VersionControlServer));
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

         public Workspace GetWorkSpace(string _workspaceName, string _workspaceOwner)
         {
             TeamFoundationServer tfs = GetTfs();
             VersionControlServer _vc = (VersionControlServer)tfs.GetService(typeof(VersionControlServer));

             if (_workspaceName.Length > 64)
             {
                 _workspaceName =  _workspaceName.Remove(64); 
                 //zero base count there it will remove everything after the 64th char
             }

             return  _vc.GetWorkspace(_workspaceName, _workspaceOwner);
         }

         public WorkItem CreateNewWorkItem(string type, string project)
         {

             TeamFoundationServer tfs = GetTfs();
             WorkItemStore store = (WorkItemStore)tfs.GetService(typeof(WorkItemStore));
             WorkItemTypeCollection workItemTypes = store.Projects[project].WorkItemTypes;
             WorkItemType wit = workItemTypes[type];
             WorkItem workItem = new WorkItem(wit);
            
             return workItem;
             
         }

         public TeamFoundationServer GetTfs()
         {
             Dictionary<string, string> Config;
             IO oOut = new IO();
             Config = oOut.GetConfig();
             TeamFoundationServer tfs = new TeamFoundationServer(Config["TFS.Server"]);
             return tfs;
         }

         private void writeout(string text, string path)
         {
             IO oOut = new IO();
             oOut.OutputInText(text, path);
         }

         public void GetLatest(string element, string wsname, string owner)
         {
             Workspace ws = this.GetWorkSpace(wsname, owner);
             GetRequest getreq = new GetRequest(element, RecursionType.None, VersionSpec.Latest);
             ws.Get(getreq, GetOptions.Overwrite, null, null);
             

         }

         private IEnumerable GetLatestChangeSets(string _label, string _vcPath)
         {
             TeamFoundationServer _tfs = GetTfs();
             VersionControlServer _vc = (VersionControlServer)_tfs.GetService(typeof(VersionControlServer));
             VersionControlLabel[] _matchingLabels = _vc.QueryLabels(_label, _vcPath, null, true);

             if (_matchingLabels == null || _matchingLabels.Length == 0)
             {
                 // no label found
                 Exception _ex = new Exception("No label found with that name: " + _label);
                 throw (_ex);
             }

             if (_matchingLabels.Length > 1)
             {
                 //"More than one matching label found")
                 Exception _ex = new Exception("More then one label (" + _label + ") with that name found.");
                 throw (_ex);
             }

             VersionControlLabel _matchingLabel = _matchingLabels[0];
             //IEnumerable _changeSets;
             // Changeset cs;
             int _highestChangesetId = 0;

             //Find the highest changeset id for all files matching the label
             foreach (Item item in _matchingLabel.Items)
             {
                 if (_highestChangesetId < item.ChangesetId)
                 {
                     _highestChangesetId = item.ChangesetId;
                 }
             }

             return (_vc.QueryHistory(_vcPath, VersionSpec.Latest, 0, RecursionType.Full, null, VersionSpec.Parse("C" + _highestChangesetId.ToString(), null)[0], VersionSpec.Latest, Int32.MaxValue, true, true));
         }

         public bool DownloadLatestChangeSets(string _lastGoodBuild, string _vcPath, string _buildPackagePath, string[] _validExts)
         {
             foreach (Changeset _cs in GetLatestChangeSets(_lastGoodBuild, _vcPath))
             {
                 foreach (Change _change in _cs.Changes)
                 {
                     if (!_validExts[0].Equals("*"))
                     {
                         foreach (string _ext in _validExts)
                         {
                             if (Path.GetExtension(_change.Item.ServerItem).Equals("." + _ext, StringComparison.CurrentCultureIgnoreCase))
                             {
                                 _change.Item.DownloadFile(_buildPackagePath + @"\" + Path.GetFileName(_change.Item.ServerItem));
                             }
                         }
                     }
                     else
                     {
                         if (Path.GetExtension(_change.Item.ServerItem).Length != 0)
                         {
                             _change.Item.DownloadFile(_buildPackagePath + @"\" + Path.GetFileName(_change.Item.ServerItem));
                         }

                     }
                 }
             }

             return true;
             
         }

         private string _changesetsFound = String.Empty;
         public string ChangesetsFound
         {
             get { return _changesetsFound; }
         }

         private int _changesetsFoundCount = 0;
         public int ChangesetsFoundCount
         {
             get { return _changesetsFoundCount; }
         }


         public bool Check4ChangeSetsSinceLabel(string _label, string _vcPath)
         {
             int count = 0;
             StringBuilder _sb = new StringBuilder();

             foreach (Changeset _cs in GetLatestChangeSets(_label, _vcPath))
             {

                 if (!String.IsNullOrEmpty(_cs.Comment) &&
                     _cs.Comment.Equals("New build: " + _label, StringComparison.CurrentCultureIgnoreCase))
                 {
                     continue;
                 }

                 _sb.AppendLine(_cs.ChangesetId.ToString());
                 count++;

             }

             if (count.Equals(0))
             {
                 return false;
             }
             else
             {
                 _changesetsFoundCount = count;
                 _changesetsFound = _sb.ToString();
                 return true;
             }

         }

         public List<string> GetWorkspaceWorkingFolderServerMappings(string _wsName, string _owner)
         {
             List<string> _serverItemList = new List<string>();
             Workspace _ws = this.GetWorkSpace(_wsName, _owner);
             foreach (WorkingFolder _wf in _ws.Folders)
             {

                 if (!_wf.IsCloaked)
                 {
                     foreach (string _mapping in _serverItemList)
                     {
                         WorkingFolder _mapwf = new WorkingFolder(_mapping, _ws.GetLocalItemForServerItem(_mapping));

                         if (!_wf.ServerItem.Contains(_mapping))
                         {
                             continue;
                         }
                         else
                         {
                             _serverItemList.Remove(_mapping);
                             break;
                         }

                     }

                     _serverItemList.Add(_wf.ServerItem);


                 }
                 else
                 {
                     foreach (string _mapping in _serverItemList)
                     {
                         if (_mapping.Equals(_wf.ServerItem))
                         {
                             _serverItemList.Remove(_mapping);
                             break;
                         }

                         WorkingFolder _mapwf = new WorkingFolder(_mapping, _ws.GetLocalItemForServerItem(_mapping));

                         if (!_wf.ServerItem.Contains(_mapwf.ServerItem))
                         {
                             continue;
                         }
                         else
                         {
                             _serverItemList.Remove(_mapping);
                             foreach (string _child in Directory.GetDirectories(_mapwf.LocalItem))
                             {
                                 _serverItemList.Add(_ws.GetServerItemForLocalItem(_child));
                             }
                             break;
                         }

                     }

                 }
             }

             return _serverItemList;
             

         }
    }
}
