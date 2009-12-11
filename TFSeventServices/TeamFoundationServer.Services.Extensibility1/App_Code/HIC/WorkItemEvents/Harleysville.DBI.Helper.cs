using System;
using System.Data;
using System.Configuration;
using System.Globalization;
using System.Text;
using System.IO;
using System.Collections.Generic;
using System.Web.UI.HtmlControls;
using System.Drawing;
using TFSeventClasses;
using System.Xml;
using System.Text.RegularExpressions;
using System.Collections;

namespace Harleysville.TFSEventServices
{
    /// <summary>
    /// Summary description for Harleysville.DBI.Helper
    /// </summary>
    public class DBIHelper : WorkItemHelper
    {
        public enum DBITypes 
        {
            dotNet, webMethods, Vendor, DataBase, Informatica, Other 
        };

        public enum DBIStates
        {
            NotDone, Approved4Deployment, Ready4IRB, IRBApproved, Deployed, Closed, Rejected, Deferred, Deleted
        };

        private List<BBIHelper> _bbis = new List<BBIHelper>();
        public  List<BBIHelper> BBIs
        {
            get { return _bbis; }
        }

        private DBITypes _dbiType;
        public DBITypes DBIType
        {
            get { return _dbiType; }
        }

        private List<string> _bnList = new List<string>();
        public List<string> BuildNumbers
        {
            get { return _bnList; }
        }

        private bool _isIRB = false;
        public bool IsInIRB
        {
            get { return _isIRB; }
            set { _isIRB = value; }
        }

        private bool _isPrd = false;
        public bool IsPrd
        {
            get { return _isPrd; }
        }

        private DBIStates _state;
        public DBIStates State
        {
            get { return _state; }
        }

        private WIStateChangeType _stateChange;
        public WIStateChangeType StateChangeType
        {
            get { return _stateChange; }
        }

        private DeploymentEnvironments _targetEnv;
        public DeploymentEnvironments TargetEnvironment
        {
            get { return _targetEnv; }
        }

        private DBI _dbi;
        public DBI Dbi
        {
            get { return _dbi; }
        }

        public override TFWI TFS
        {
            get
            {
                return (TFWI)_dbi;
            }
            //set
            //{
            //    base.TFS = value;
            //}
        }

        private int _maxCount = 8;

        public DBIHelper() { }

        public void SetDBI(WorkItemChangedEvent wice, TFSIdentity tfsId)
        {
            _dbi = new DBI(GetDBINumber(wice.CoreFields.IntegerFields), tfsId.Url);

            this.SetWorkItemHelper(wice, (TFWI)_dbi);
            
            _dbiType = GetDBIType();
            _state = GetState();
            _stateChange = GetStateChangeType();
            _targetEnv = GetTargetEnvironment();

            if (ChangeType == ChangeTypes.New || 
                !HasBeenAutoFilled() ||
                Check4NewBuildPackage())
            {
                this.AutoFill();
                SetBuildNumbersField();
                ResetWIFields();
                PopBuildNumbersList();
                LinkBBIs();
            }
            else
            {
                PopBuildNumbersList();
                LinkBBIs();
                
            }

            if (WiFields["New Test Environment"].Equals("Production", StringComparison.CurrentCultureIgnoreCase))
            {
                _isPrd = true;
            }

            if ((_state == DBIStates.Ready4IRB || _state == DBIStates.IRBApproved) && _stateChange == WIStateChangeType.New)
            {
                _isIRB = true;
            }

        }

        private int GetDBINumber(List<IntegerField> _ifList)
        {
            foreach (IntegerField _if in _ifList)
            {
                if (_if.Name.Equals("ID"))
                {
                    return _if.NewValue;
                }
            }

            return 0;

        }

        private WIStateChangeType GetStateChangeType()
        {
            if (EventChanges["State"][WIFieldChangeType.NewValue].Equals(EventChanges["State"][WIFieldChangeType.OldValue]))
            {
                return WIStateChangeType.Same;
            }
            else
            {
                return WIStateChangeType.New;
            }
        }


        private DBIStates GetState()
        {
            switch (WiFields["State"].ToLower())
            {
                case "not done":
                    return DBIStates.NotDone;
                case "approved for deployment":
                    return DBIStates.Approved4Deployment;
                case "ready for irb (production only)":
                    return DBIStates.Ready4IRB;
                case "rejected":
                    return DBIStates.Rejected;
                case "closed":
                    return DBIStates.Closed;
                case "approved by irb":
                    return DBIStates.IRBApproved;
                case "deployed":
                    return DBIStates.Deployed;
                case "deleted":
                    return DBIStates.Deleted;
                case "deferred":
                    return DBIStates.Deferred;
                default:
                    throw  new Exception("Error: Unknown state passed in");
            }

        }

        private bool HasBeenAutoFilled()
        {
            if (string.IsNullOrEmpty(WiFields["HIC Auto Fill Count"]))
            {
                return false;
            }
            else
            {
                return true;
            }
        }

        private DBITypes GetDBIType()
        {
            switch (WiFields["Deployment Type"])
            {
                case ".Net" :
                    return DBITypes.dotNet;
                case "DataBase" :
                    return DBITypes.DataBase;
                case "webMethods" :
                    return DBITypes.webMethods;
                case "Informatica" :
                    return DBITypes.Informatica;
                case "Other" :
                    return DBITypes.Other;
                case "Vendor" :
                    return DBITypes.Vendor;
                default :
                    return DBITypes.Other;

            }
        }

        public enum DeploymentEnvironments
        {
            DEV, ASY, QA2, TST1, E2E, TRN, PRE, PRD, TEST, STG, CVN
        };

        private DeploymentEnvironments GetTargetEnvironment()
        {
            switch (WiFields["New Test Environment"].ToUpper())
            {
                case "DEV":
                    return DeploymentEnvironments.DEV;
                case "TST1":
                    return DeploymentEnvironments.TST1;
                case "ASSEMBLY":
                    return DeploymentEnvironments.ASY;
                case "QA2":
                    return DeploymentEnvironments.QA2;
                case "END2END":
                    return DeploymentEnvironments.E2E;
                case "TRAINING":
                    return DeploymentEnvironments.TRN;
                case "PRE-PRD":
                    return DeploymentEnvironments.PRE;
                case "PRODUCTION":
                    return DeploymentEnvironments.PRD;
                case "TEST":
                    return DeploymentEnvironments.TEST;
                case "STAGING":
                    return DeploymentEnvironments.STG;
                case "CONVERSION":
                    return DeploymentEnvironments.CVN;
                default:
                    throw new Exception("Error: Invalid Target environment passed in");
            }
        }

        private string GetBuildNumbers()
        {
            string _buildNumbers = WiFields["Build Number"];

            if (_dbiType == DBITypes.webMethods && AreThereMultiplePackages())
            {
                for (int _i = 2; _i < _maxCount; _i++)
                {
                    string _currentFieldName = "HIC Build Package" + _i.ToString();
                    if (!string.IsNullOrEmpty(WiFields[_currentFieldName]))
                    {
                        _buildNumbers += "," + WiFields[_currentFieldName];
                    }
                }
            }

            return _buildNumbers;
        }

        private void SetBuildNumbersField()
        {

            _dbi.UpdateWorkItemField("HIC Build Numbers", (object)GetBuildNumbers());
            
        }

        private bool Check4NewBuildPackage()
        {
            if (WiFields["HIC Build Numbers"].Equals(GetBuildNumbers()))
            {
                return false;
            }
            else
            {
                return true;
            }

        }

        private void PopBuildNumbersList()
        {
            foreach (string _bn in WiFields["HIC Build Numbers"].Split(','))
            {
                _bnList.Add(_bn);
            }
        }

        private bool AreThereMultiplePackages()
        {
            bool _rtn = false;
           

            for (int _i = 2; _i < _maxCount; _i++)
            {
                if (!string.IsNullOrEmpty(WiFields["HIC Build Package" + _i.ToString()]))
                {
                    _rtn = true;
                    break;
                }
            }

            return _rtn;
        }

        private void AutoFill()
        {
            _dbi.AreaPath = WICE.PortfolioProject + ConfigurationManager.AppSettings.Get("AreaPath4Open");
            _dbi.FillOutDBI();
            ResetWIFields();
        }

        private void LinkBBIs()
        {
            foreach (string _b in _bnList)
            {
                _dbi.LinkBuildWorkItem(_b);
            }

            foreach (int _n in _dbi.BBINumbers)
            {
                BBIHelper _bhelp = new BBIHelper(WICE, _dbi.TFSServerUrl, _n);

                _bbis.Add(_bhelp);
                
            }

        }


        public void CheckDefectField()
        {
            if (string.IsNullOrEmpty(WiFields["HIC TR defect Numbers"]))
            {
                _dbi.UpdateWorkItemField("HIC TR defect Numbers", (object)"NA");
            }
        }



    }
}
