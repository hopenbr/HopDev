using System;
using System.Collections;
using System.Collections.Generic;
using System.Text;
using Microsoft.TeamFoundation.Client;
using Microsoft.TeamFoundation.WorkItemTracking.Client;

namespace TFSeventClasses
{
    public class TFWI : TFS 
    {

        #region Old prop
        //private string _tp = String.Empty;
        //public string TeamProject
        //{
        //    get { return _tp; }
        //    set { _tp = value; }
        //}

        //private string _fullAreaPath = String.Empty;
        //public string AreaPath
        //{
        //    get { return _fullAreaPath; }
        //    set { _fullAreaPath = value; }
        //}
        #endregion

        private WorkItem _workitem;

        public WorkItem Workitem
        {
            get { return _workitem; }
        }

        private WorkItemStore _wstore;

        public WorkItemStore WorkitemStore
        {
            get { return _wstore; }
        }


        private string _areaPath = String.Empty;
        public string AreaPath
        {
            get { return _areaPath; }
            set { _areaPath = value; }
        }

        private List<string> _wiInvalidFields = new List<string>();
        public List<string> WorkItemInvalidFields
        {
            get { return _wiInvalidFields; }
        }

        public TFWI() { }

        public TFWI(string tfsUrl)
        {
            this.SetupTFWI(tfsUrl);
        }

        protected void SetupTFWI (string _tfsUrl)
        {
            SetTFS(_tfsUrl);
            _wstore = (WorkItemStore)Tfs.GetService(typeof(WorkItemStore));
        }

        public TFWI(string tfsUrl, int _wiNumber)
        {
            this.SetupTFWI(tfsUrl);
            _workitem = this.GetWorkItem(_wiNumber);
            OpenWorkItem();
        }

        public WorkItem OpenWorkItem(WorkItem _wi)
        {
            _wi.Open();
            return _wi;
        }

        public void OpenWorkItem()
        {
            if (!_workitem.IsOpen)
            {
                _workitem.Open();
            }

        }

        public Dictionary<string, string> GetWorkItemFields()
        {
            if (_workitem != null)
            {
                return this.GetWorkItemFields(_workitem);
            }
            else
            {
                return null;
            }
        }

        public Dictionary<string, string> GetWorkItemFields(int _wiNumber)
        {
            WorkItem _wi = GetWorkItem(_wiNumber);

            return this.GetWorkItemFields(_wi);
        }

        public Dictionary<string, string> GetWorkItemFields(WorkItem _wi)
        {
            Dictionary<string, string> _wiFileds = new Dictionary<string, string>();

            foreach (Field _f in _wi.Fields)
            {
                if (_f.Value != null)
                {
                    _wiFileds.Add(_f.Name, _f.Value.ToString());
                }
                else
                {
                    _wiFileds.Add(_f.Name, String.Empty);
                }
            }

            return _wiFileds;
        }

        public WorkItem GetWorkItem(int _wiNum)
        {
            if (_workitem != null)
            {
                if (_workitem.Id == _wiNum)
                {
                    return _workitem;
                }
            }

            WorkItemStore _store = (WorkItemStore)Tfs.GetService(typeof(WorkItemStore));
            WorkItem _wi = _store.GetWorkItem(_wiNum);
            return (_wi);

        }

        private void ChangeAreaPath()
        {
            _workitem.AreaPath = _areaPath;
        }

        public void ChangeAreaPath(string _aPath)
        {
            _areaPath = _aPath;
            ChangeAreaPath();
        }


        public WorkItem ChangeAreaPath(WorkItem _wi, string _areaPath)
        {
            _wi.AreaPath = _areaPath;
            return _wi;
        }

        public WorkItem ChangeAreaPath(int _wiNum, string _areaPath)
        {
            WorkItem _wi = GetWorkItem(_wiNum);
            _wi.AreaPath = _areaPath;
            return _wi;
        }

        public void SetDescription(string _note)
        {
           // _workitem.Fields[CoreField.Description].Value = (object)_note;
            _workitem.Description = _note;
        }

        public void AssignWorkItemTo(int _wiNumber, string _userName)
        {
            _workitem = GetWorkItem(_wiNumber);
            AssignWorkItemTo(_userName);
        }

        public void AssignWorkItemTo(int _wiNumber, string _userName, string _aPath)
        {
            _workitem = GetWorkItem(_wiNumber);
            ChangeAreaPath(_aPath);
            this.AssignWorkItemTo(_userName);

        }

        public void AssignWorkItemTo(string _userName, string _aPath)
        {
            ChangeAreaPath(_aPath);
            this.AssignWorkItemTo(_userName);
            
        }

        protected void SetWorkItem(WorkItem _wi)
        {
            _workitem = _wi;
        }

        public virtual void AssignWorkItemTo(string _userName)
        {
            if (_workitem != null)
            {
                if (_workitem.Fields["Assigned To"].IsLimitedToAllowedValues)
                {

                    if (_workitem.Fields["Assigned To"].AllowedValues.Contains(_userName))
                    {
                        _workitem.Fields["Assigned To"].Value = _userName;

                    }
                }
                else
                {
                    _workitem.Fields["Assigned To"].Value = _userName;
                }

            }
            else
            {
                Exception _ex = new Exception("Workitem can not be null");
                throw (_ex);
            }

        }

        public void AssignWorkItemToNull()
        {
            if (_workitem != null)
            {
                _workitem.Fields["Assigned To"].Value = String.Empty;

            }
            else
            {
                Exception _ex = new Exception("Workitem can not be null");
                throw (_ex);
            }


        }

        public string GetWorkItemTypeName()
        {
            if (_workitem != null)
            {
                return _workitem.Type.Name;
            }
            else
            {
                return String.Empty;
            }
        }

        public string GetWorkItemTypeName(int _wiNum)
        {
            WorkItem _wi = GetWorkItem(_wiNum);
            if (_wi != null)
            {
                return _wi.Type.Name;
            }
            else
            {
                return String.Empty;
            }
        }


        public void AddHistory2WorkItem(string _historyNote)
        {
            if (_workitem != null)
            {
                _workitem.History += _historyNote;
            }
            else
            {
                Exception _ex = new Exception("Work item cannot be null");
                throw (_ex);
            }
        }

        public bool ChangeWorkItemStateTo(string _newState, string _historyNote)
        {
            if (_workitem != null)
            {
                if (_workitem.IsValid())
                {
                    WorkItem _tempWI = _workitem;
                    _workitem.History = _historyNote;
                    if (ChangeWorkItemStateTo(_newState))
                    {
                        return true;
                    }
                    else
                    {
                        _workitem = _tempWI;
                        return false;
                    }
                }
                else
                {
                    return false;
                }
            }
            else
            {
                Exception _ex = new Exception("Work Item cannot be null");
                throw (_ex);
            }
        }

        public bool ChangeWorkItemStateTo(string _newState)
        {
            if (_workitem != null)
            {
                if (_workitem.IsValid())
                {
                    WorkItem _tempWi = _workitem;

                    _workitem.State = _newState;

                    if (_workitem.IsValid())
                    {
                        return true;
                    }
                    else
                    {
                        _workitem = _tempWi; // reverting back to how the WI was before state change 
                        return false;
                    }
                }
                else
                {
                    return false;
                }
            }
            else
            {
                Exception _ex = new Exception("Work Item cannot be null");
                throw (_ex);
            }
        }

        public List<string> GetChangedByUsers(int _wiNumber)
        {
            List<string> _users = new List<string>();
            WorkItem _wi = GetWorkItem(_wiNumber);
            foreach (Revision _rev in _wi.Revisions)
            {
                if (!_users.Contains(_rev.Fields["Changed By"].Value.ToString()))
                {
                    _users.Add(_rev.Fields["Changed By"].Value.ToString());
                }

            }
            return (_users);
        }


        public virtual bool SaveWorkItem()
        {
            if (_workitem.IsDirty && _workitem.IsValid())
            {// ensure that there are changes to save 
                _workitem.Save();

                return true;
            }
            else
            {

                foreach (object _o in _workitem.Validate())
                {
                    Field _f = (Field)_o;
                    _wiInvalidFields.Add("Field Name: " + _f.Name);

                }

                return false;
            }
        }


        #region Moved methods to DBI
        //private bool WasDBIAutoFilled(WorkItem _dbi)
        //{
        //    if (_dbi.Fields["HIC Auto Fill Count"].Value == null || 
        //        _dbi.Id == (int)_dbi.Fields["HIC Auto Fill Count"].Value)
        //    {
        //        return false;
        //    }
        //    else
        //    {
        //        //HIC Auto Fill Count will equal BBI number if autofilled
        //        return true;
        //    }
                 
        //}

        //private void UpdateBBI(WorkItem _dbi)
        //{
            
        //    WorkItem _bbi = UpdateRelatedWorkItemComment(GetWorkItem(_bbiNumber), 
        //                                                _dbi.Id, 
        //                                                GetBBILinkComment(_dbi));
        //    _bbi = SyncBBI2DBI(_dbi, _bbi);

        //    if (_bbi.IsDirty)
        //    {
        //        _bbi.Save();
        //    }
        //}

        //private string GetBBILinkComment(WorkItem _dbi)
        //{
        //    string _comment;

        //    switch (_dbi.State)
        //    {
        //        case "Not Done":
        //            _comment = "Approval pending";
        //            break;
        //        case "Ready for IRB (Production Only)":
        //            _comment = "IRB approval pending";
        //            break;
        //        case "Deployed":
        //            _comment = "Deployed";
        //            break;
        //        case "Rejected":
        //            _comment = "Deployment rejected";
        //            break;
        //        case "Deferred":
        //            _comment = "Deployment deferred";
        //            break;
        //        default:
        //            _comment = "Deployment pending";
        //            break;

        //    }

            
        //    return _comment;
            
        //}

        //private WorkItem SyncBBI2DBI(WorkItem _dbi, WorkItem _bbi)
        //{
        //    //this is a pain I the field name are not the same between BBI and DBI 
        //    // I am going to need to add to this as we go

        //    if (((string)_dbi.Fields["HIC TR defect Numbers"].Value != String.Empty &&
        //         (string)_bbi.Fields["HIC TR defect Numbers"].Value == String.Empty) ||
        //        ((string)_dbi.Fields["HIC TR defect Numbers"].Value != (string)_bbi.Fields["HIC TR defect Numbers"].Value &&
        //         (string)_dbi.Fields["HIC TR defect Numbers"].Value != String.Empty))
        //    {
        //        _bbi.Fields["HIC TR defect Numbers"].Value = _dbi.Fields["HIC TR defect Numbers"].Value;
        //    }

        //    if (_dbi.Fields.Contains("HIC DBI Deployment Impact"))
        //    {
        //       if  ((string)_dbi.Fields["HIC DBI Deployment Impact"].Value != String.Empty &&
        //            ((string)_bbi.Fields["HIC DBI Deployment Impact"].Value == String.Empty ||
        //            ((string)_bbi.Fields["HIC DBI Deployment Impact"].Value != (string)_dbi.Fields["HIC DBI Deployment Impact"].Value)))
        //        {
        //           _bbi.Fields["HIC DBI Deployment Impact"].Value = _dbi.Fields["HIC DBI Deployment Impact"].Value;
        //        }

        //    }

        //    if ((string)_dbi.Fields["HIC Project"].Value != String.Empty &&
        //        (string)_bbi.Fields["HIC DBI Project"].Value == String.Empty)
        //    {
        //        _bbi.Fields["HIC DBI Project"].Value = _dbi.Fields["HIC Project"].Value;
        //    }

        //    return _bbi;

        //}

        //private WorkItem SyncDBI2BBI(WorkItem _dbi, WorkItem _bbi)
        //{
        //    if (_bbi != null)
        //    {
        //        if ((string)_dbi.Fields["HIC Team Build Project"].Value == String.Empty &&
        //            (string)_bbi.Fields["HIC Team Build Project"].Value != String.Empty)
        //        {
        //            _dbi.Fields["HIC Team Build Project"].Value = _bbi.Fields["HIC Team Build Project"].Value;
        //        }

        //        if ((string)_dbi.Fields["HIC Team Build Type"].Value == String.Empty &&
        //            (string)_bbi.Fields["HIC Team Build Type"].Value != String.Empty)
        //        {
        //            _dbi.Fields["HIC Team Build Type"].Value = _bbi.Fields["HIC Team Build Type"].Value;
        //        }

        //        if ((string)_dbi.Fields["HIC TR defect Numbers"].Value == String.Empty &&
        //             (string)_bbi.Fields["HIC TR defect Numbers"].Value != String.Empty)
        //        {
        //            _dbi.Fields["HIC TR defect Numbers"].Value = _bbi.Fields["HIC TR defect Numbers"].Value;
        //        }
        //    }

        //    return _dbi;
        //}
        //#region Old Method "IsThereABBI"
        ////private bool IsThereABBI(WorkItem _dbi)
        ////{
        ////    if (!_isBuildNumberLinked)
        ////    {
        ////        WorkItemCollection _wic = Query4BBI(_dbi.Store, _dbi.Project.Name);

        ////        if (_wic.Count > 0)
        ////        {
                    
        ////            return true;
        ////        }
        ////        else
        ////        {
        ////            return false;
        ////        }
        ////    }
        ////    else
        ////    {
                
        ////        return true;
        ////    }

        ////}
        //#endregion

        //private WorkItemCollection Query4BBI(WorkItemStore _wis, string _teamProject, string _buildNumber)
        //{
        //    StringBuilder _wiql = new StringBuilder();
        //    _wiql.AppendLine("SELECT [System.ID], [System.Title]")
        //         .AppendLine("FROM WORKITEMS")
        //         .AppendLine("WHERE ([HIC.Build.Number] == '" + _buildNumber + "'")
        //         .AppendLine("OR")
        //         .AppendLine("[System.Title] == '" + _buildNumber + "')")
        //         .AppendLine("AND")
        //         .AppendLine("[System.TeamProject] == '" + _teamProject + "'")
        //         .AppendLine("AND")
        //         .AppendLine("[System.WorkItemType] == 'Build Backlog Item'");

        //    return (_wis.Query(_wiql.ToString()));
        //}

        //public WorkItem LinkBuildWorkItem(WorkItem _wi, string _buildNumber)
        //{
        //    if (!String.IsNullOrEmpty(_buildNumber))
        //    {
        //        WorkItemCollection _wic = Query4BBI(_wi.Store, _wi.Project.Name, _buildNumber);

        //        if (_wic.Count > 0)
        //        {
        //            foreach (WorkItem _workitem in _wic)
        //            {
        //                RelatedLink _rl = new RelatedLink(_workitem.Id);
        //                bool _isLinkAlreadyThere = false;

        //                foreach (Link _ln in _wi.Links)
        //                {
        //                    if (_ln.ArtifactLinkType.Name.Contains("Related"))
        //                    {
        //                        RelatedLink _rrl = (RelatedLink)_ln;
        //                        if (_rrl.RelatedWorkItemId == _rl.RelatedWorkItemId)
        //                        {
        //                            _isLinkAlreadyThere = true;
        //                            _bbiNumber = _rrl.RelatedWorkItemId;
        //                        }
        //                    }
        //                }

        //                if (!_isLinkAlreadyThere)
        //                {
        //                    _wi.Links.Add(_rl);
        //                    _bbiNumber = _rl.RelatedWorkItemId;

        //                }
        //            }
        //        }

               
        //    }

        //    return _wi;
        //}
#endregion

        public WorkItem UpdateRelatedWorkItemComment(WorkItem _wi, int _relatedWorkItemID, string _newComment)
        {
            foreach (Link _ln in _wi.Links)
            {
                if (_ln.ArtifactLinkType.Name.Contains("Related"))
                {
                    RelatedLink _rrl = (RelatedLink)_ln;
                    if (_rrl.RelatedWorkItemId == _relatedWorkItemID)
                    {
                        _ln.Comment = _newComment;
                        break;
                    }
                }
            }

            return _wi;
        }

        #region Moved Mehtods to TFWI_DBI
        //public WorkItem PopulateApprovedBy(string _approver, WorkItem _wi)
        //{
        //    if (_wi.Type.Name.Equals("Deployment Backlog Item") &&
        //        _wi.Fields.Contains("HIC Deployment Approver"))
        //    {
        //        _wi.Fields["HIC Deployment Approver"].Value = _approver;
        //    }

        //    return _wi;
        //}

        //private WorkItem GetRelatedBBI(WorkItem _wi)
        //{
        //    foreach (Link _ln in _wi.Links)
        //    {
        //        if (_ln.ArtifactLinkType.Name.Contains("Related"))
        //        {
        //            RelatedLink _rl = (RelatedLink)_ln;
        //            WorkItem _rwi = GetWorkItem(_rl.RelatedWorkItemId);

        //            if (_rwi.Type.Name.Equals("Build Backlog Item", StringComparison.CurrentCultureIgnoreCase))
        //            {
        //                return _rwi;
        //            }
        //            else if (_rwi.Type.Name.Equals("Deployment Backlog Item", StringComparison.CurrentCultureIgnoreCase) &&
        //                    (!DoesLinkCollectionsContainBBI(_wi.Links)))
        //            {
        //                if (DoesLinkCollectionsContainBBI(_rwi.Links))
        //                {
        //                    WorkItem _bbi = this.GetRelatedBBI(_rwi);
        //                    if (_bbi != null)
        //                    {
        //                        _wi.Links.Add(new RelatedLink(_bbi.Id));
        //                        return _bbi;
        //                    }
        //                }
        //            }
        //        }
        //    }

        //    return null; //no BBI related link found

        //}

        //private bool DoesLinkCollectionsContainBBI(LinkCollection _links)
        //{
        //    bool _foundIt = false;
        //    foreach (Link _ln in _links)
        //    {
        //       if (_ln.ArtifactLinkType.Name.Contains("Related"))
        //        {
        //            RelatedLink _rl = (RelatedLink)_ln;
        //            WorkItem _rwi = GetWorkItem(_rl.RelatedWorkItemId);
        //            if (_rwi.Type.Name.Equals("Build Backlog Item", StringComparison.CurrentCultureIgnoreCase))
        //            {
        //                _foundIt = true;
        //            }
        //       }
                    
        //    }

        //    return _foundIt;
        //}

        //public WorkItem FillOutDBI(WorkItem _dbi)
        //{
        //    bool _need2Fill = true;

        //    if (_dbi.Fields["HIC Auto Fill Count"].Value != null)
        //    {
        //        int _hasAutoFillRan = (int)_dbi.Fields["HIC Auto Fill Count"].Value;

        //        if (_hasAutoFillRan > 0)
        //        {
        //            _need2Fill = false;
        //        }
        //    }

        //    if (_need2Fill)
        //    {

        //        WorkItem _bbi = GetRelatedBBI(_dbi);

        //        if (_bbi != null)
        //        {
        //            _bbiNumber = _bbi.Id;
        //            _dbi.Title = _bbi.Fields["Build Number"].Value + " Deployment to: " + _dbi.Fields["New Test Environment"].Value;

        //            _dbi.Fields["Build Number"].Value = _bbi.Fields["Build Number"].Value;

        //            if (_bbi.Fields["HIC Current Test Env"].Value != null)
        //            {
        //                string _currentEnv = (string)_bbi.Fields["HIC Current Test Env"].Value;
        //                if (_currentEnv.EndsWith("CL"))
        //                {
        //                    _currentEnv = _currentEnv.Remove(_currentEnv.Length - 2);
        //                }
        //                _dbi.Fields["Current Test Environment"].Value = _currentEnv;
        //            }

        //            if (_dbi.Fields["Deployment Type"].Value != null)
        //            {
        //                if (!_dbi.Fields["Deployment Type"].Value.Equals("DataBase"))
        //                {
        //                    _dbi.Fields["Deployment Type"].Value = _bbi.Fields["HIC DBI Deployment Type"].Value;
        //                }
        //            }
        //            else
        //            {
        //                _dbi.Fields["Deployment Type"].Value = _bbi.Fields["HIC DBI Deployment Type"].Value;
        //            }

        //            _dbi.Fields["HIC Team Build Project"].Value = _bbi.Fields["HIC Team Build Project"].Value;

        //            _dbi.Fields["HIC Team Build Type"].Value = _bbi.Fields["HIC Team Build Type"].Value;

        //            _dbi.History = "DBI automatically filled out\n BBI# " + _bbi.Id.ToString();

        //            _dbi.Fields["HIC Auto Fill Count"].Value = _bbi.Fields["ID"].Value;

        //           // _dbi.AreaPath = _fullAreaPath;

        //            if (_bbi.Fields["HIC DBI Project"].Value != null &&
        //                _dbi.Fields["HIC Project"].AllowedValues.Contains(_bbi.Fields["HIC DBI Project"].Value.ToString()))
        //            {
        //                _dbi.Fields["HIC Project"].Value = _bbi.Fields["HIC DBI Project"].Value;

        //            }

        //            if (_bbi.Fields["HIC DBI Sub-Project"].Value != null)
        //            {
        //                _dbi.Fields["HIC Sub-Project"].Value = _bbi.Fields["HIC DBI Sub-Project"].Value;
        //            }

        //            //changes to BBI to better link DBI
        //            if ((string)_dbi.Fields["HIC TR defect Numbers"].Value != String.Empty &&
        //                (string)_bbi.Fields["HIC TR defect Numbers"].Value == String.Empty)
        //            {
        //                _bbi = UpdateWorkItemField(_bbi, "HIC TR defect Numbers", _dbi.Fields["HIC TR defect Numbers"].Value);
        //                SaveWorkItem(_bbi);

        //            }
        //            else if ((string)_dbi.Fields["HIC TR defect Numbers"].Value == String.Empty &&
        //                     (string)_bbi.Fields["HIC TR defect Numbers"].Value != String.Empty)
        //            {
        //                _dbi.Fields["HIC TR defect Numbers"].Value = _bbi.Fields["HIC TR defect Numbers"].Value;
        //            }

        //        }
        //        else if (_dbi.Title.StartsWith("Related to work item", StringComparison.CurrentCultureIgnoreCase))
        //        {
        //            _dbi.State = "Rejected";

        //            _dbi.History += "This DBI was not properly linked to a Build Backlog Item (BBI) causing the Auto Filler method to reject it";

        //            _dbi.Fields["HIC Auto Fill Count"].Value = _dbi.Fields["ID"].Value;
        //            //ensure auto filler is not called again

        //            _dbi = this.PopulateApprovedBy("Submission-Rejected", _dbi);

        //        }
        //        else
        //        {
        //            _dbi.Fields["HIC Auto Fill Count"].Value = _dbi.Fields["ID"].Value;
        //            //ensure auto filler is not called again
        //        }
        //    }

        //    return _dbi;
        //}
        #endregion

        public bool UpdateWorkItemField(string _fieldName, object _fieldValue)
        {
            WorkItem _preChange = _workitem;

            _workitem.Fields[_fieldName].Value = _fieldValue;

            if (_workitem.IsValid())
            {
                return true;
            }
            else
            {
                _workitem = _preChange;
                return false;
            }


        }

        public WorkItem  UpdateWorkItemField(WorkItem _wi, string _fieldName, object _fieldValue)
        {
            WorkItem _preChange = _wi;

            _wi.Fields[_fieldName].Value = _fieldValue;

            if (_wi.IsValid())
            {
                return _wi;
            }
            else
            {
                return _preChange;
            }

            
        }
    }
}
