using System;
using System.Collections;
using System.Collections.Generic;
using System.Text;
using Microsoft.TeamFoundation.Client;
using Microsoft.TeamFoundation.WorkItemTracking.Client;

namespace TFSeventClasses
{
    [Serializable]
    public class DBI : TFWI
    {

        private string _dbiTp = "Software.Release.Management";
        public string DBITeamProject
        {
            get { return _dbiTp; }
            set { _dbiTp = value; }
        }

        private List<string> _dbiBuildNumbers = new List<string>();
        public List<string> DBIBuildNumbers
        {
            get { return _dbiBuildNumbers; }
            set { _dbiBuildNumbers = value; }
        }

        private List<int> _bbiNumbers = new List<int>();
        public List<int> BBINumbers
        {
            get { return _bbiNumbers; }
        }

        public DBI (int _dbiNum, string tfsUrl)
        {
            SetTFS(tfsUrl);
            SetWorkItem(GetWorkItem(_dbiNum));
            OpenWorkItem();
            GetLinkedBBIs();
            Workitem.FieldChanged += new WorkItemFieldChangeEventHandler(Workitem_FieldChanged);
        }

        void Workitem_FieldChanged(object sender, WorkItemEventArgs e)
        {
            if (e.Field != null &&
               e.Field.Name == "Area Path")
            {
                string _path = (string)e.Field.Value;
                string _lock = "HIc Fields Lock";

                if (_path.EndsWith("Open", StringComparison.CurrentCultureIgnoreCase) &&
                    (int)Workitem.Fields[_lock].Value != 0)
                {
                    this.UpdateWorkItemField(_lock, (object)0);
                }
            }
        }

        #region Old methods IsBBILinked2DBI
        //public bool IsBBILinked2DBI()
        //{
        //    bool _isBBILinked = false;

        //    if (_bbiNum > 0)
        //    {
        //        foreach (Link _ln in Workitem.Links)
        //        {
        //            if (_ln.ArtifactLinkType.Name.Contains("Related"))
        //            {

        //                RelatedLink _rrl = (RelatedLink)_ln;
        //                if (_rrl.RelatedWorkItemId == _bbiNum)
        //                {
        //                    _isBBILinked = true;
        //                }

        //            }
        //        }
        //    }
        //    else if (_bbiNum == 0)
        //    {
        //        // BBI has not been checked
        //        WorkItem _bbi = GetRelatedBBI(Workitem);

        //        if (_bbi != null)
        //        {
        //            _bbiNumbers.Add(_bbi.Id);
        //            _isBBILinked = true;
        //        }
        //    }


        //    return _isBBILinked;

        //}

        #endregion

        private bool WasDBIAutoFilled()
        {
            if (Workitem.Fields["HIC Auto Fill Count"].Value == null ||
                Workitem.Id == (int)Workitem.Fields["HIC Auto Fill Count"].Value)
            {
                return false;
            }
            else
            {
                //HIC Auto Fill Count will equal BBI number if autofilled
                return true;
            }

        }

        private void UpdateBBI()
        {
            foreach (int _bbiNum in _bbiNumbers)
            {
                WorkItem _bbi = UpdateRelatedWorkItemComment(GetWorkItem(_bbiNum),
                                                            Workitem.Id,
                                                            GetBBILinkComment());

                _bbi = SyncBBI2DBI(_bbi);

                if (_bbi.IsDirty)
                {
                    _bbi.Save();
                }
            }
        }

        private string GetBBILinkComment()
        {
            string _comment;

            switch (Workitem.State)
            {
                case "Not Done":
                    _comment = "Approval pending";
                    break;
                case "Ready for IRB (Production Only)":
                    _comment = "IRB approval pending";
                    break;
                case "Deployed":
                    _comment = "Deployed";
                    break;
                case "Rejected":
                    _comment = "Deployment rejected";
                    break;
                case "Deferred":
                    _comment = "Deployment deferred";
                    break;
                default:
                    _comment = "Deployment pending";
                    break;

            }


            return _comment;

        }

        private WorkItem SyncBBI2DBI(WorkItem _bbi)
        {
            //this is a pain I the field name are not the same between BBI and DBI 
            // I am going to need to add to this as we go

            if (((string)Workitem.Fields["HIC TR defect Numbers"].Value != String.Empty &&
                 (string)_bbi.Fields["HIC TR defect Numbers"].Value == String.Empty) ||
                ((string)Workitem.Fields["HIC TR defect Numbers"].Value != (string)_bbi.Fields["HIC TR defect Numbers"].Value &&
                 (string)Workitem.Fields["HIC TR defect Numbers"].Value != String.Empty))
            {
                _bbi.Fields["HIC TR defect Numbers"].Value = Workitem.Fields["HIC TR defect Numbers"].Value;
            }

            if (Workitem.Fields.Contains("HIC DBI Deployment Impact"))
            {
                if ((string)Workitem.Fields["HIC DBI Deployment Impact"].Value != String.Empty &&
                     ((string)_bbi.Fields["HIC DBI Deployment Impact"].Value == String.Empty ||
                     ((string)_bbi.Fields["HIC DBI Deployment Impact"].Value != (string)Workitem.Fields["HIC DBI Deployment Impact"].Value)))
                {
                    _bbi.Fields["HIC DBI Deployment Impact"].Value = Workitem.Fields["HIC DBI Deployment Impact"].Value;
                }

            }

            if ((string)Workitem.Fields["HIC Project"].Value != String.Empty &&
                (string)_bbi.Fields["HIC DBI Project"].Value == String.Empty)
            {
                _bbi.Fields["HIC DBI Project"].Value = Workitem.Fields["HIC Project"].Value;
            }

            return _bbi;

        }

        private void SyncDBI2BBI(WorkItem _bbi)
        {
            if (_bbi != null)
            {
                if ((string)Workitem.Fields["HIC Team Build Project"].Value == String.Empty &&
                    (string)_bbi.Fields["HIC Team Build Project"].Value != String.Empty)
                {
                    Workitem.Fields["HIC Team Build Project"].Value = _bbi.Fields["HIC Team Build Project"].Value;
                }

                if ((string)Workitem.Fields["HIC Team Build Type"].Value == String.Empty &&
                    (string)_bbi.Fields["HIC Team Build Type"].Value != String.Empty)
                {
                    Workitem.Fields["HIC Team Build Type"].Value = _bbi.Fields["HIC Team Build Type"].Value;
                }

                if ((string)Workitem.Fields["HIC TR defect Numbers"].Value == String.Empty &&
                     (string)_bbi.Fields["HIC TR defect Numbers"].Value != String.Empty)
                {
                    Workitem.Fields["HIC TR defect Numbers"].Value = _bbi.Fields["HIC TR defect Numbers"].Value;
                }
            }
        }

        #region Old Method "IsThereABBI"
        //private bool IsThereABBI(WorkItem _dbi)
        //{
        //    if (!_isBuildNumberLinked)
        //    {
        //        WorkItemCollection _wic = Query4BBI(_dbi.Store, _dbi.Project.Name);

        //        if (_wic.Count > 0)
        //        {

        //            return true;
        //        }
        //        else
        //        {
        //            return false;
        //        }
        //    }
        //    else
        //    {

        //        return true;
        //    }

        //}
        #endregion

        private WorkItemCollection Query4BBI(WorkItemStore _wis, string _teamProject, string _buildNumber)
        {
            StringBuilder _wiql = new StringBuilder();
            _wiql.AppendLine("SELECT [System.ID], [System.Title]")
                 .AppendLine("FROM WORKITEMS")
                 .AppendLine("WHERE ([HIC.Build.Number] == '" + _buildNumber + "'")
                 .AppendLine("OR")
                 .AppendLine("[System.Title] == '" + _buildNumber + "')")
                 .AppendLine("AND")
                 .AppendLine("[System.TeamProject] == '" + _teamProject + "'")
                 .AppendLine("AND")
                 .AppendLine("[System.WorkItemType] == 'Build Backlog Item'");

            return (_wis.Query(_wiql.ToString()));
        }

        public void LinkBuildWorkItem(string _buildNumber)
        {
            if (!String.IsNullOrEmpty(_buildNumber))
            {
                WorkItemCollection _wic = Query4BBI(Workitem.Store, Workitem.Project.Name, _buildNumber);

                if (_wic.Count > 0)
                {
                    foreach (WorkItem _workItem in _wic)
                    {
                        string _bbiBuildNumber = (string)_workItem.Fields["Build Number"].Value;

                        if (!_dbiBuildNumbers.Contains(_bbiBuildNumber))
                        {
                            _dbiBuildNumbers.Add(_bbiBuildNumber);
                        }

                        RelatedLink _rl = new RelatedLink(_workItem.Id);
                        bool _isLinkAlreadyThere = false;

                        foreach (Link _ln in Workitem.Links)
                        {
                            if (_ln.ArtifactLinkType.Name.Contains("Related"))
                            {
                                RelatedLink _rrl = (RelatedLink)_ln;
                                if (_rrl.RelatedWorkItemId == _rl.RelatedWorkItemId)
                                {
                                    _isLinkAlreadyThere = true;

                                    if (!_bbiNumbers.Contains(_rrl.RelatedWorkItemId))
                                    {
                                        _bbiNumbers.Add(_rrl.RelatedWorkItemId);
                                    }
                                }
                            }
                        }

                        if (!_isLinkAlreadyThere)
                        {
                            Workitem.Links.Add(_rl);

                            if (!_bbiNumbers.Contains(_rl.RelatedWorkItemId))
                            {
                                _bbiNumbers.Add(_rl.RelatedWorkItemId);
                            }

                            SyncDBI2BBI(_workItem);
                         
                        }

                    }

                    UpdateRelatedWorkItemComment(GetBBILinkComment());
                }


            }
        }

        public void UpdateRelatedWorkItemComment(string _newComment)
        {
            foreach (Link _ln in Workitem.Links)
            {
                if (_ln.ArtifactLinkType.Name.Contains("Related"))
                {
                    RelatedLink _rrl = (RelatedLink)_ln;

                    if (GetWorkItemTypeName(_rrl.RelatedWorkItemId).Equals("Build Backlog Item", StringComparison.CurrentCultureIgnoreCase))
                    {
                        _ln.Comment = _newComment;
                    }
                }
            }
        }

        public bool PopulateApprovedBy(string _approver)
        {
            if (Workitem.Fields.Contains("HIC Deployment Approver"))
            {
                if (Workitem.Fields["HIC Deployment Approver"].Value != null)
                {
                    string _val = (string)Workitem.Fields["HIC Deployment Approver"].Value;

                    if (_val.Contains(",") && _approver.Contains(",") && !_val.Equals(_approver))
                    { //both old value and new are people meaning this approval is IRB

                        _approver += " & " + _val;
                    }
                }
                    
                Workitem.Fields["HIC Deployment Approver"].Value = _approver;
            }

            return Workitem.IsDirty;
        }

        public void LockDBI()
        {
            Workitem.Fields["HIC Fields Lock"].Value = 1;
        }

        public override bool SaveWorkItem()
        {
            //if (!WasDBIAutoFilled(Workitem))
            //{
            //    SyncDBI2BBI(GetRelatedBBI(Workitem));
            //}

            if (Workitem.IsValid())
            {
                Workitem.Save();

                if (_bbiNumbers.Count > 0)
                {
                    UpdateBBI();
                }

                return true;
            }
            else
            {
                return false;
            }

            

        }

        public void GetLinkedBBIs()
        {
            foreach (Link _ln in Workitem.Links)
            {
                if (_ln.ArtifactLinkType.Name.Contains("Related"))
                {
                    RelatedLink _rrl = (RelatedLink)_ln;
                    WorkItem _w = GetWorkItem(_rrl.RelatedWorkItemId);

                    if (_w.Type.Name.Equals("Build Backlog Item", StringComparison.CurrentCultureIgnoreCase))
                    {
                        if (!_bbiNumbers.Contains(_w.Id))
                        {
                            _bbiNumbers.Add(_w.Id);
                            _dbiBuildNumbers.Add((string)_w.Fields["Build Number"].Value);
                        }
                    }

                }
            }
        }

        private WorkItem GetRelatedBBI(WorkItem _wi)
        {
            foreach (Link _ln in _wi.Links)
            {
                if (_ln.ArtifactLinkType.Name.Contains("Related"))
                {
                    RelatedLink _rl = (RelatedLink)_ln;
                    WorkItem _rwi = GetWorkItem(_rl.RelatedWorkItemId);

                    if (_rwi.Type.Name.Equals("Build Backlog Item", StringComparison.CurrentCultureIgnoreCase))
                    {
                        return _rwi;
                    }
                    else if (_rwi.Type.Name.Equals("Deployment Backlog Item", StringComparison.CurrentCultureIgnoreCase) &&
                            (!DoesLinkCollectionsContainBBI(_wi.Links)))
                    {
                        if (DoesLinkCollectionsContainBBI(_rwi.Links))
                        {
                            WorkItem _bbi = this.GetRelatedBBI(_rwi);
                            if (_bbi != null)
                            {
                                _wi.Links.Add(new RelatedLink(_bbi.Id));
                                return _bbi;
                            }
                        }
                    }
                }
            }

            return null; //no BBI related link found

        }


        private string GetAreaPath()
        {
            if (!String.IsNullOrEmpty(AreaPath))
            {
                return (AreaPath);
            }
            else if (!String.IsNullOrEmpty(_dbiTp))
            {
                return (_dbiTp + @"\DBI\Open");
            }
            else
            {
                Exception _ex = new Exception("Error: Area Path could not be determined.");
                throw (_ex);
            }
        }

        public override void AssignWorkItemTo(string _userName)
        {
            Workitem.AreaPath = GetAreaPath();
            base.AssignWorkItemTo(_userName);
        }

        private bool DoesLinkCollectionsContainBBI(LinkCollection _links)
        {
            bool _foundIt = false;
            foreach (Link _ln in _links)
            {
                if (_ln.ArtifactLinkType.Name.Contains("Related"))
                {
                    RelatedLink _rl = (RelatedLink)_ln;
                    WorkItem _rwi = GetWorkItem(_rl.RelatedWorkItemId);
                    if (_rwi.Type.Name.Equals("Build Backlog Item", StringComparison.CurrentCultureIgnoreCase))
                    {
                        _foundIt = true;
                    }
                }

            }

            return _foundIt;
        }

        public void FillOutDBI()
        {
            bool _need2Fill = true;

            if (Workitem.Fields["HIC Auto Fill Count"].Value != null)
            {
                int _hasAutoFillRan = (int)Workitem.Fields["HIC Auto Fill Count"].Value;

                if (_hasAutoFillRan > 0)
                {
                    _need2Fill = false;
                }
            }

            if (_need2Fill)
            {
                //AutoFiller being phased out 
                //therefore I just set it itself

                Workitem.Fields["HIC Auto Fill Count"].Value = Workitem.Fields["ID"].Value;
            }
#region Old Code to auto filled DBI, should be moved to TFWI.BBI

                //WorkItem _bbi = GetRelatedBBI(Workitem);

                //if (_bbi != null)
                //{
                //    _bbiNumbers.Add(_bbi.Id);
                //    Workitem.Title = _bbi.Fields["Build Number"].Value + " Deployment to: " + Workitem.Fields["New Test Environment"].Value;

                //    Workitem.Fields["Build Number"].Value = _bbi.Fields["Build Number"].Value;

                //    if (_bbi.Fields["HIC Current Test Env"].Value != null)
                //    {
                //        string _currentEnv = (string)_bbi.Fields["HIC Current Test Env"].Value;
                //        if (_currentEnv.EndsWith("CL"))
                //        {
                //            _currentEnv = _currentEnv.Remove(_currentEnv.Length - 2);
                //        }
                //        Workitem.Fields["Current Test Environment"].Value = _currentEnv;
                //    }

                //    if (Workitem.Fields["Deployment Type"].Value != null)
                //    {
                //        if (!Workitem.Fields["Deployment Type"].Value.Equals("DataBase"))
                //        {
                //            Workitem.Fields["Deployment Type"].Value = _bbi.Fields["HIC DBI Deployment Type"].Value;
                //        }
                //    }
                //    else
                //    {
                //        Workitem.Fields["Deployment Type"].Value = _bbi.Fields["HIC DBI Deployment Type"].Value;
                //    }

                //    Workitem.Fields["HIC Team Build Project"].Value = _bbi.Fields["HIC Team Build Project"].Value;

                //    Workitem.Fields["HIC Team Build Type"].Value = _bbi.Fields["HIC Team Build Type"].Value;

                //    Workitem.History = "DBI automatically filled out\n BBI# " + _bbi.Id.ToString();

                //    Workitem.Fields["HIC Auto Fill Count"].Value = _bbi.Fields["ID"].Value;

                //    // Workitem.AreaPath = _fullAreaPath;

                //    if (_bbi.Fields["HIC DBI Project"].Value != null &&
                //        Workitem.Fields["HIC Project"].AllowedValues.Contains(_bbi.Fields["HIC DBI Project"].Value.ToString()))
                //    {
                //        Workitem.Fields["HIC Project"].Value = _bbi.Fields["HIC DBI Project"].Value;

                //    }

                //    if (_bbi.Fields["HIC DBI Sub-Project"].Value != null)
                //    {
                //        Workitem.Fields["HIC Sub-Project"].Value = _bbi.Fields["HIC DBI Sub-Project"].Value;
                //    }

                //    //changes to BBI to better link DBI
                //    if ((string)Workitem.Fields["HIC TR defect Numbers"].Value != String.Empty &&
                //        (string)_bbi.Fields["HIC TR defect Numbers"].Value == String.Empty)
                //    {
                //        _bbi = UpdateWorkItemField(_bbi, "HIC TR defect Numbers", Workitem.Fields["HIC TR defect Numbers"].Value);
                //        _bbi.Save();

                //    }
                //    else if ((string)Workitem.Fields["HIC TR defect Numbers"].Value == String.Empty &&
                //             (string)_bbi.Fields["HIC TR defect Numbers"].Value != String.Empty)
                //    {
                //        Workitem.Fields["HIC TR defect Numbers"].Value = _bbi.Fields["HIC TR defect Numbers"].Value;
                //    }

                //}
                //else if (Workitem.Title.StartsWith("Related to work item", StringComparison.CurrentCultureIgnoreCase))
                //{
                //    Workitem.State = "Rejected";

                //    Workitem.History += "This DBI was not properly linked to a Build Backlog Item (BBI) causing the Auto Filler method to reject it";

                //    Workitem.Fields["HIC Auto Fill Count"].Value = Workitem.Fields["ID"].Value;
                //    //ensure auto filler is not called again

                //    this.PopulateApprovedBy("Submission-Rejected");

                //}
                //else
                //{
                //    Workitem.Fields["HIC Auto Fill Count"].Value = Workitem.Fields["ID"].Value;
                //    //ensure auto filler is not called again
                //}
#endregion
        }


    }
}
