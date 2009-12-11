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

/// <summary>
/// Summary description for Harleysville.TFSEventServices
/// </summary>
namespace Harleysville.TFSEventServices
{
    public enum DBIActionType { Assembler, Approver, Deployer, IRB, AutoFiller, Auto = AutoFiller, Deferrend, Rejected, Deleted, Closed, Opened, Other };

    public class HarleysvilleDBIAlerts : HarelysvilleWorkItemAlerts 
    {
        private DBIActionType _dbiactionType;
        public  DBIActionType dbiActionType
        {
            get { return _dbiactionType; }
        }

        private Dictionary<string, bool> _webConfigKeys;
        private DBIHelper _dbihelper = new DBIHelper();
        //private BBIHelper _bbihelper;

        public HarleysvilleDBIAlerts(WorkItemChangedEvent _wice, TFSIdentity tfsId)
        {
            WIChangeEvent = _wice;
            _dbihelper.SetDBI(_wice, tfsId);
            SetMailPriority();
        }

        private void SetMailPriority()
        {
            switch (_dbihelper.WiFields["HIC Deployment Priority"])
            {
                case "1 - Normal":
                    MailPriority = 1;
                    break;
                case "2 - Expedited":
                    MailPriority = 2;
                    break;
                case "3 - Emergency hotfix":
                    MailPriority = 3;
                    break;
                default:
                    MailPriority = 1;
                    break;
            }
                
        }

        public override void WorkItemActions()
        {
            if (this.AlertApprover())
            {
                _dbiactionType = DBIActionType.Approver;
            }
            else if (this.AlertDeployer())
            {
                _dbiactionType = DBIActionType.Deployer;

            }
            else if (this.DBIDeferred())
            {
                _dbiactionType = DBIActionType.Deferrend;
            }
            else if (this.DBIDeleted())
            {
                _dbiactionType = DBIActionType.Deleted;
            }
            else if (this.CloseDBI())
            {
                _dbiactionType = DBIActionType.Closed;
            }
            else if (this.DBIRejected())
            {
                _dbiactionType = DBIActionType.Rejected;
            }
            else
            {
                _dbiactionType = DBIActionType.Other;
                Check4Actions();
            }

            if (_dbihelper.Dbi.Workitem.IsDirty)
            {
                if (string.IsNullOrEmpty(_dbihelper.Dbi.Workitem.Description))
                {
                    string _note = "Please deploy build(s): ";

                    foreach (string _s in _dbihelper.BuildNumbers)
                    {
                        _note += "\r\n" + _s;
                    }
         
                   _note += "\r\nTo: "  + _dbihelper.WiFields["New Test Environment"];

                   _dbihelper.Dbi.SetDescription(_note);
                }

                if (_dbihelper.ChangeType == ChangeTypes.New)
                {
                    AlertSubmited();
                }

                if (!_dbihelper.Dbi.SaveWorkItem())
                {
                    StringBuilder _sb = new StringBuilder();
                    foreach (string _f in _dbihelper.Dbi.WorkItemInvalidFields)
                    {
                        _sb.AppendLine(_f);
                    }

                    throw (new Exception("Error: Could not save Work item\nInvalid fields:\n" + _dbihelper.Dbi.WorkItemInvalidFields.Count.ToString()));
                }

            }
            else
            {
                this.AlertCreatedBy(_dbihelper.WiFields);
            }
        }

        /// <summary>
        /// This methods will check to see if there are any actions needed after a DBI has been saved
        /// IE workitem has been re-assigned 
        /// </summary>
        private bool Check4Actions ()
        {
            //TODO: 
            // - check for re-assignment
            // - change of build number
            // - change of deploy date and time 
            // - Emger DBI approved but not deployed changed to Lower priority
            //     * would need to chagne state to "Ready for IRB"
            // - etc

            if (_dbihelper.EventChanges.ContainsKey("Assigned To"))
            {
                  //TODO: Alert new assigned
            }

            if (_dbihelper.EventChanges.ContainsKey("Build Number"))
            {
                //TODO: unlink old BBI and link NEW
            }

            return true;
            
        }

        private string GetProjectApprover(string _hicProj, string _deploymentType, string _newTestEnv)
        {
            string _approver;
            string _appendStr = "_Approver";

            if (Check4ConfigKey(_hicProj + "_" + _deploymentType + "_" + _newTestEnv + _appendStr))
            {
                _approver = ConfigurationManager.AppSettings.Get(_lastSuccessfulConfigKeySearched);
            }
            else if (Check4ConfigKey(_hicProj + "_" + _deploymentType + _appendStr))
            {
                _approver = ConfigurationManager.AppSettings.Get(_lastSuccessfulConfigKeySearched);
            }
            else if (Check4ConfigKey(_hicProj + "_" + _newTestEnv + _appendStr))
            {
                _approver = ConfigurationManager.AppSettings.Get(_lastSuccessfulConfigKeySearched);
            }
            else if (Check4ConfigKey(_deploymentType + "_" + _newTestEnv + _appendStr))
            {
                _approver = ConfigurationManager.AppSettings.Get(_lastSuccessfulConfigKeySearched);
            }
            else if (Check4ConfigKey(_deploymentType + _appendStr))
            {
                _approver = ConfigurationManager.AppSettings.Get(_lastSuccessfulConfigKeySearched);
            }
            else if (Check4ConfigKey(_hicProj + _appendStr))
            {
                _approver = ConfigurationManager.AppSettings.Get(_lastSuccessfulConfigKeySearched);
            }
            else
            {
                _approver = ConfigurationManager.AppSettings.Get("Default_Approver");
            }

            return _approver;
        }


        private bool DBIDeferred()
        {
            if (_dbihelper.State == DBIHelper.DBIStates.Deferred && _dbihelper.StateChangeType == WIStateChangeType.New )
            {
                //assign DBI to person deferring it
                _dbihelper.Dbi.AssignWorkItemTo(_dbihelper.EventChanges["Changed By"][WIFieldChangeType.NewValue], _dbihelper.WICE.PortfolioProject +
                                                     ConfigurationManager.AppSettings.Get("Areapath4Open"));
               
                _dbihelper.Dbi.PopulateApprovedBy("Deferred");

                _dbihelper.Dbi.AddHistory2WorkItem("DBI was deferred by " + _dbihelper.EventChanges["Changed By"][WIFieldChangeType.NewValue]);

                //_dbihelper.Dbi.SaveWorkItem();

                Mailer _mailer = new Mailer();
                Dictionary<string, string> _wiFields = _dbihelper.Dbi.GetWorkItemFields(Convert.ToInt32(_dbihelper.EventChanges["ID"][WIFieldChangeType.NewValue]));
                StringBuilder _sb = new StringBuilder();
                
                _sb.AppendLine("<table>")
                  .AppendLine("<tr><td>")
                  .AppendLine("DBI: " + _wiFields["Title"])
                  .AppendLine("</td></tr>")
                  .AppendLine("<tr><td>")
                  .AppendLine("Number: " + _wiFields["ID"])
                  .AppendLine("</td></tr>")
                  .AppendLine("<tr><td>")
                  .AppendLine("WorkItem has been deferred by " + _dbihelper.EventChanges["Changed By"][WIFieldChangeType.NewValue])
                  .AppendLine("</td></tr>")
                  .AppendLine("<tr><td>")
                  .AppendLine("Use below link to view Workitem Details")
                  .AppendLine("</td></tr>")
                  .AppendLine("</table>");

                _mailer.Add2Body(GetBody(_sb.ToString(), _dbihelper.WiFields["ID"]));
                _mailer.SetSubject("DBI #: " + _dbihelper.EventChanges["ID"][WIFieldChangeType.NewValue] + " deferred");

                _mailer.Add2RecipientList(this.GetEmailAddress(GetProjectApprover(_wiFields["HIC Project"], _wiFields["Deployment Type"], _wiFields["New Test Environment"])));

                if (_dbihelper.EventChanges["State"][WIFieldChangeType.OldValue].Equals("Approved for deployment", StringComparison.CurrentCultureIgnoreCase))
                {
                    //DBI has been approved 
                    _mailer.Add2RecipientList(this.GetEmailAddress(GetDeployer(_wiFields["Deployment Type"], _wiFields["HIC Project"], _wiFields["New Test Environment"])));

                }
                else if (_dbihelper.EventChanges["State"][WIFieldChangeType.OldValue].Contains("IRB"))
                {
                    //DBI was in IRB
                    _mailer.Add2RecipientList(this.GetEmailAddress(GetDeployer(_wiFields["Deployment Type"], _wiFields["HIC Project"], _wiFields["New Test Environment"])));
                    _mailer.Add2RecipientList(this.GetEmailAddress(ConfigurationManager.AppSettings.Get("IRB_Approver")));

                }

                
                _mailer.Send();

                _dbihelper.Dbi.ChangeAreaPath(_dbihelper.WICE.PortfolioProject +
                                   ConfigurationManager.AppSettings.Get("Areapath4Open"));

                return true;
            }
            return false;
        }

        private bool DBIRejected()
        {
            if (_dbihelper.State == DBIHelper.DBIStates.Rejected &&
                _dbihelper.StateChangeType == WIStateChangeType.New &&
               (!_dbihelper.EventChanges.ContainsKey("HIC Deployment Approver") ||
               !_dbihelper.EventChanges["HIC Deployment Approver"][WIFieldChangeType.NewValue].Equals("Submission-Rejected")))
            {
                _dbihelper.Dbi.AssignWorkItemTo(_dbihelper.EventChanges["Changed By"][WIFieldChangeType.NewValue], _dbihelper.WICE.PortfolioProject +
                                                                    ConfigurationManager.AppSettings.Get("Areapath4Open"));

                _dbihelper.Dbi.PopulateApprovedBy("");

                Mailer _mailer = new Mailer();
                Dictionary<string, string> _wiFields = _dbihelper.Dbi.GetWorkItemFields(Convert.ToInt32(_dbihelper.EventChanges["ID"][WIFieldChangeType.NewValue]));
                StringBuilder _sb = new StringBuilder();

                string _rejector = _dbihelper.EventChanges["Changed By"][WIFieldChangeType.NewValue];

                _sb.AppendLine("<table>")
                  .AppendLine("<tr><td>")
                  .AppendLine("DBI: " + _wiFields["Title"])
                  .AppendLine("</td></tr>")
                  .AppendLine("<tr><td>")
                  .AppendLine("Number: " + _wiFields["ID"])
                  .AppendLine("</td></tr>")
                  .AppendLine("<tr><td>")
                  .AppendLine("WorkItem has been rejected by " + _rejector +
                              ".  Please view workitem history to see rejection reason or talk to rejector.")
                  .AppendLine("</td></tr>")
                  .AppendLine("<tr><td>")
                  .AppendLine("Use below links to view Workitem Details")
                  .AppendLine("</td></tr>")
                  .AppendLine("</table>");

                _mailer.Add2Body(GetBody(_sb.ToString(), _dbihelper.WiFields["ID"]));
                _mailer.SetSubject("DBI #: " + _dbihelper.EventChanges["ID"][WIFieldChangeType.NewValue] + " rejected");

                if (!_rejector.Equals(_wiFields["Created By"]))
                {
                    _mailer.Add2RecipientList(this.GetCreatedByEmialAddress(_wiFields["Created By"]));

                }

                if (_dbihelper.EventChanges["State"][WIFieldChangeType.OldValue].Equals("Not Done", StringComparison.CurrentCultureIgnoreCase) &&
                    !_rejector.Equals(GetProjectApprover(_wiFields["HIC Project"], _wiFields["Deployment Type"], _wiFields["New Test Environment"])))
                {
                    //DBI was successfully submitted and the approver got an alert therefore need to  alert that 
                    //dbi was reject
                    _mailer.Add2RecipientList(this.GetEmailAddress(GetProjectApprover(_wiFields["HIC Project"], _wiFields["Deployment Type"], _wiFields["New Test Environment"])));
                }
                else if (_dbihelper.EventChanges["State"][WIFieldChangeType.OldValue].Equals("Approved for deployment", StringComparison.CurrentCultureIgnoreCase) &&
                         !_rejector.Equals(GetDeployer(_wiFields["Deployment Type"], _wiFields["HIC Project"], _wiFields["New Test Environment"])))
                {
                    //DBI has been approved 
                    _mailer.Add2RecipientList(this.GetEmailAddress(GetDeployer(_wiFields["Deployment Type"], _wiFields["HIC Project"], _wiFields["New Test Environment"])));


                }
                else if (_dbihelper.EventChanges["State"][WIFieldChangeType.OldValue].Contains("IRB"))
                {
                    //DBI was in IRB
                    _mailer.Add2RecipientList(this.GetEmailAddress(GetDeployer(_wiFields["Deployment Type"], _wiFields["HIC Project"], _wiFields["New Test Environment"])));
                    _mailer.Add2RecipientList(this.GetEmailAddress(ConfigurationManager.AppSettings.Get("IRB_Approver")));

                }

                if (_mailer.Mail.To.Count > 0)
                {
                    _mailer.Send();
                }

                _dbihelper.Dbi.ChangeAreaPath(_dbihelper.WICE.PortfolioProject +
                                   ConfigurationManager.AppSettings.Get("AreaPath4Open"));

                return true;
            }
            else if (_dbihelper.EventChanges.ContainsKey("HIC Deployment Approver") &&
                     !String.IsNullOrEmpty(_dbihelper.EventChanges["HIC Deployment Approver"][WIFieldChangeType.NewValue]) &&
                     _dbihelper.EventChanges["HIC Deployment Approver"][WIFieldChangeType.NewValue].Equals("Submission-Rejected"))
            {//TFWI rejected the submission therefore need to make sure DBI is an area that anybody can change it 
                _dbihelper.Dbi.ChangeAreaPath(_dbihelper.WICE.PortfolioProject +
                                     ConfigurationManager.AppSettings.Get("Areapath4Open"));

                return true;
            }
            return false;
        }


        private bool DBIDeleted()
        {
            if (_dbihelper.State == DBIHelper.DBIStates.Deleted && 
                _dbihelper.StateChangeType == WIStateChangeType.New)
            {

                _dbihelper.Dbi.ChangeAreaPath(_dbihelper.WICE.PortfolioProject +
                                                     ConfigurationManager.AppSettings.Get("Areapath4Deleted"));
                _dbihelper.Dbi.AssignWorkItemToNull();

                //_dbihelper.Dbi.SaveWorkItem();

                return true;

            }
            return false;
        }

        private void AlertSubmited()
        {
            if (_dbihelper.State == DBIHelper.DBIStates.Rejected)
            {
                Mailer _mailer = new Mailer();
                string _to = GetCreatedByEmialAddress(_dbihelper.WiFields["Created By"]);
                string _sub = "WorkItem: (" + _dbihelper.WiFields["ID"] + ") \"" + _dbihelper.WiFields["Title"] + "\" submitted and rejected";
                string _body = GetBody("Workitem " + _dbihelper.WiFields["ID"] +
                                        " was rejected upon submittal.  Please view history tab to see why " + 
                                        "it was rejected.  Once corrected please change state back to " +
                                        "\"Not Done\" to re-enter into the backlog", _dbihelper.WiFields["ID"]);



                _mailer.Send("Tfs@harleysvillegroup.com", _to, _sub, _body);

            }
            else
            {
                AlertCreatedBy(_dbihelper.WiFields);
            }

            
        }

        //private bool FillOut()
        //{
        //    _dbihelper.Dbi.AreaPath = _dbihelper.WICE.PortfolioProject + ConfigurationManager.AppSettings.Get("AreaPath4Open");
        //    if (_dbihelper.Dbi.FillOutDBI())
        //    {
        //       // _dbihelper.Dbi.SaveWorkItem();
        //        return true;
        //    }
        //    else
        //    {
        //        return false;
        //    }
        //}

        private bool AlertChangedBy()
        {
            Mailer _mailer = new Mailer();
            foreach (string _changer in _dbihelper.Dbi.GetChangedByUsers(Convert.ToInt32(_dbihelper.EventChanges["ID"][WIFieldChangeType.NewValue])))            
            {
                if (!_changer.Equals(_dbihelper.EventChanges["Created By"][WIFieldChangeType.NewValue]))
                {
                    StringBuilder _sb = new StringBuilder();
                    
                    string _sub = "WorkItem: (" + _dbihelper.EventChanges["ID"][WIFieldChangeType.NewValue] + ") \"" 
                                + _dbihelper.EventChanges["Title"][WIFieldChangeType.NewValue] + "\" Changed";

                    _sb.AppendLine("<table>")
                       .AppendLine("<tr><td>")
                       .AppendLine("DBI: " + _dbihelper.EventChanges["Title"][WIFieldChangeType.NewValue])
                       .AppendLine("</td></tr>")
                       .AppendLine("<tr><td>")
                       .AppendLine("Number: " + _dbihelper.EventChanges["ID"][WIFieldChangeType.NewValue])
                       .AppendLine("</td></tr>")
                       .AppendLine("<tr><td>")
                       .AppendLine("Workitem changed")
                       .AppendLine("</td></tr>")
                       .AppendLine("<tr><td>")
                       .AppendLine("Use below link to view Workitem")
                       .AppendLine("</td></tr>")
                       .AppendLine("</table>");

                    _mailer.Send("Tfs@harleysvillegroup.com",
                                 GetCreatedByEmialAddress(_changer), 
                                 _sub,
                                 GetBody(_sb.ToString(), _dbihelper.WiFields["ID"]));
                }
            }

            return true;
        }

        private bool AlertDeployer()
        {
            if (_dbihelper != null &&
                _dbihelper.EventChanges["State"][WIFieldChangeType.NewValue].Contains("Approved") &&
                _dbihelper.StateChangeType == WIStateChangeType.New)
            {//needs to be a DBI
                Dictionary<string, string> _wiFields = _dbihelper.Dbi.GetWorkItemFields();
                _dbihelper.Dbi.DBIBuildNumbers.Add(_wiFields["Build Number"]);
                _dbihelper.Dbi.DBITeamProject = _dbihelper.WICE.PortfolioProject;
                _dbihelper.Dbi.LockDBI();

                if (!_dbihelper.IsInIRB)
                {
                    _dbihelper.Dbi.PopulateApprovedBy(_wiFields["HIC Last Changed By"]);
                }

                StringBuilder _sb = new StringBuilder();
                _sb.AppendLine("<table>")
                   .AppendLine("<tr><td>")
                   .AppendLine("DBI: " + _dbihelper.WiFields["Title"])
                   .AppendLine("</td></tr>")
                   .AppendLine("<tr><td>")
                   .AppendLine("Number: " + _dbihelper.EventChanges["ID"][WIFieldChangeType.NewValue])
                   .AppendLine("</td></tr>")
                   .AppendLine("<tr><td>")
                   .AppendLine("Has been approved for deployment")
                   .AppendLine("</td></tr>")
                   .AppendLine("<tr><td>")
                   .AppendLine("Use below link to view Workitem")
                   .AppendLine("</td></tr>")
                   .AppendLine("</table>");

                string _deployer = String.Empty;
                string _sub = "Deployment Backlog Item has been approved for deployment to " +
                             _wiFields["New Test Environment"];

                if (_dbihelper.IsPrd)
                {
                    _dbihelper.Dbi.AreaPath = _dbihelper.WICE.PortfolioProject +
                                   ConfigurationManager.AppSettings.Get("AreaPath4Prd");

                    if (_dbihelper.State == DBIHelper.DBIStates.Approved4Deployment)
                    {
                        bool _isImmediateHotfix = false;
                        if (_wiFields.ContainsKey("HIC Deployment Priority"))
                        {
                            if (_wiFields["HIC Deployment Priority"].Contains("3"))
                            {
                                //a priority level of three means this is critical hotifx that 
                                //will bypass IRB group and go straight to Prd (don't think it will collect 
                                //$200)
                                MailPriority = 3;
                                _isImmediateHotfix = true;

                            }

                        }

                        if (!_isImmediateHotfix)
                        {

                            //approver approved a production dbi for deployment, really this DBI needs to go
                            //to Ready for IRB 
                            _dbihelper.Dbi.ChangeWorkItemStateTo("Ready for IRB (Production Only)",
                                                       "Production deployment requires IRB approval, therefore state was changed to \"Ready for IRB (Production Only)\"");

                            //_dbihelper.Dbi.ChangeAreaPath(_dbihelper.WICE.PortfolioProject +
                            // ConfigurationManager.AppSettings.Get("Areapath4IRB"));

                            _dbihelper.IsInIRB = true;
                            SendAlert2Approver(ConfigurationManager.AppSettings.Get("IRB_approver"), _dbihelper.WiFields["ID"]);

                            return true;
                        }

                    }

                }
                else if (_dbihelper.TargetEnvironment == DBIHelper.DeploymentEnvironments.ASY ||
                         _dbihelper.TargetEnvironment == DBIHelper.DeploymentEnvironments.DEV)
                {
                    _dbihelper.Dbi.AreaPath = _dbihelper.WICE.PortfolioProject +
                                    ConfigurationManager.AppSettings.Get("Areapath4Open");

                }
                else
                {
                    _dbihelper.Dbi.AreaPath = _dbihelper.WICE.PortfolioProject +
                                     ConfigurationManager.AppSettings.Get("Areapath4Deployment");
                }

                bool _continue = true;

                if (_dbihelper.IsPrd)
                {
                    if (ConfigurationManager.AppSettings.Get("Deploy2TFVC").Equals("true", StringComparison.CurrentCultureIgnoreCase) &&
                        _dbihelper.Dbi.DeployBuild2TFVC(_wiFields["HIC Build Numbers"], _wiFields["HIC Team Build Project"]))
                    {
                        _sb.AppendLine("<br>")
                        .AppendLine("<p><font size=\"+1\" >Build packages (" + _wiFields["HIC Build Numbers"] + ") were successfully depoyed to IRB</font></p>")
                        .AppendLine("<br>");
                    }
                    else if (_dbihelper.DBIType == DBIHelper.DBITypes.dotNet ||
                             _dbihelper.DBIType == DBIHelper.DBITypes.webMethods)
                    {
                         _sb.AppendLine("<br>")
                         .AppendLine("<p><font color=\"RED\" size=\"+2\" >WARNING: The Build package(s) (" + _wiFields["HIC Build Numbers"] + ") were not found in build store, therefore the build(s) were not deployed to IRB</font></p>")
                         .AppendLine("<br>");

                    }
                }

                if (_continue)
                {
                    _deployer = GetDeployer(_wiFields["Deployment Type"],
                                            _wiFields["HIC Project"],
                                            _wiFields["New Test Environment"]);


                    if (_deployer.Contains("@"))
                    {//deployer key is actually email address most likely a group email 
                        if (_deployer.Contains(";"))
                        {
                            SendAlert(_deployer.Split(';')[0], _sub, GetBody(_sb.ToString(), _dbihelper.WiFields["ID"]));

                            _dbihelper.Dbi.AssignWorkItemTo(_deployer.Split(';')[1]);
                        }
                        else
                        {
                            SendAlert(_deployer, _sub, GetBody(_sb.ToString(), _dbihelper.WiFields["ID"]));
                        }
                    }
                    else
                    {
                        SendAlert(GetCreatedByEmialAddress(_deployer), _sub, GetBody(_sb.ToString(), _dbihelper.WiFields["ID"]));

                        _dbihelper.Dbi.AssignWorkItemTo(_deployer);
                    }

                    //_dbihelper.Dbi.SaveWorkItem();

                    return true;
                }
                else
                {
                    return false;
                }
            }
            else
            {
                return false;
            }
            
        }

        private string GetDeployer(string _deployType, string _hicProject, string _targetEnv)
        {
            string _appendString = "_Deployer";
            string _deployer = String.Empty;
            string _default = "SRM@harleysvillegroup.com;SRM Group";
            
            if (_dbihelper.IsPrd)
            {
                _appendString = "_PrdDeployer";
            }

            if (Check4ConfigKey(_hicProject + "_" + _deployType + "_" + _targetEnv + _appendString))
            {
                _deployer = ConfigurationManager.AppSettings.Get(_hicProject + "_" + _deployType + "_" + _targetEnv + _appendString);
            }
            else if (Check4ConfigKey(_hicProject + "_" + _deployType + _appendString))
            {
                _deployer = ConfigurationManager.AppSettings.Get(_hicProject + "_" + _deployType + _appendString);
            }
            else if (Check4ConfigKey(_deployType + "_" + _targetEnv + _appendString))
            {
                _deployer = ConfigurationManager.AppSettings.Get(_deployType + "_" + _targetEnv + _appendString);
            }
            else if (Check4ConfigKey(_deployType + _appendString))
            {
                _deployer = ConfigurationManager.AppSettings.Get(_deployType + _appendString);
            }
            else
            {
                _deployer = _default;
            }

            return _deployer;

        }

        private bool AlertAssembler()
        {
            //this one will alert the assembly builder which is now Bob M 

            if (NeedsAssemblerAlert())
            {
               
                _dbihelper.Dbi.AssignWorkItemTo(ConfigurationManager.AppSettings.Get("AssemblerName"));
                //_dbihelper.Dbi.SaveWorkItem();
                return true;

            }
            else
            {
                return false;
            }
        }

        private string GetWorkItemTypeName()
        {
            return (_dbihelper.Dbi.GetWorkItemTypeName());
            
        }

        private bool CloseDBI()
        {
            if (_dbihelper.EventChanges.ContainsKey("State") &&
                _dbihelper.EventChanges["State"][WIFieldChangeType.NewValue].Contains("Deployed") &&
                !_dbihelper.EventChanges["State"][WIFieldChangeType.NewValue].Equals(_dbihelper.EventChanges["State"][WIFieldChangeType.OldValue]))
            {
                string _closeAreapath = _dbihelper.WICE.PortfolioProject + @"\DBI\Closed";
                _dbihelper.Dbi.ChangeAreaPath(_closeAreapath);

                if (_dbihelper.WiFields["HIC Deployment Approver"].Contains(",") ) //&&
                    //!_dbihelper.WiFields["HIC Deployment Approver"].Equals(_dbihelper.WiFields["Created By"]))
                { //ensure approver is person and not TFSBUILD which is the approver for auto approvals 
                    //and ensure that approver is not the creator no need to send to alerts 

                    StringBuilder _closeBody = new StringBuilder();

                    _closeBody.AppendLine("<p><b>DBI:</b> " + _dbihelper.WorkItemNumber.ToString())
                        .AppendLine("<br>")
                        .AppendLine("<b>TITLE:</b> " + _dbihelper.WiFields["Title"])
                        .AppendLine("<br>")
                        .AppendLine("<b>TARGET ENVIRONMENT:</b> " + _dbihelper.WiFields["New Test Environment"])
                        .AppendLine("<br>")
                        .AppendLine("<b>STATE:</b> Deployed")
                        .AppendLine("</p><br>");

                    foreach (string _app in _dbihelper.WiFields["HIC Deployment Approver"].Split('&'))
                    {
                        
                        SendAlert(GetEmailAddress(_app.Trim()), "DBI: " + _dbihelper.WorkItemNumber.ToString() + " Closed", GetBody(_closeBody.ToString(), _dbihelper.WorkItemNumber.ToString()));
                    }
                }

                return true;
            }
            else
            {
                return false;
            }
        }

        private bool AlertApprover()
        {
            string _approver = String.Empty;
            bool _isAlertNeeded = false;
            Dictionary<string, string> _wiFields = _dbihelper.Dbi.GetWorkItemFields();

            if (_wiFields["Work Item Type"].Equals("Deployment Backlog Item"))
            {//needs to be a DBI
                if (_dbihelper.ChangeType == ChangeTypes.Change)
                {
                    if ((_dbihelper.EventChanges["State"][WIFieldChangeType.OldValue].Equals("Rejected", StringComparison.CurrentCultureIgnoreCase) ||
                        _dbihelper.EventChanges["State"][WIFieldChangeType.OldValue].Equals("Deferred", StringComparison.CurrentCultureIgnoreCase)) &&
                        _dbihelper.StateChangeType == WIStateChangeType.New &&
                        _dbihelper.State == DBIHelper.DBIStates.NotDone)
                    {
                        //dbi corrected and re-added to backlog from rejected state 
                        _isAlertNeeded = true;                          
                    }
                
                }
                else if (!_wiFields["New Test Environment"].Equals("Assembly", StringComparison.CurrentCultureIgnoreCase)
                         || IsAssemblyApprovalNeeded(_wiFields["Deployment Type"])) 
                { //need aproval for all moves to SystemTest and above not Asy 
                    //some team want to approve move to assembly as well

                    _isAlertNeeded = true;
                }

                if (_isAlertNeeded)
                {
                    _dbihelper.Dbi.DBITeamProject = _dbihelper.WICE.PortfolioProject;
                    
                    if (_dbihelper.EventChanges.ContainsKey("Build Number") && 
                        !String.IsNullOrEmpty(_dbihelper.EventChanges["Build Number"][WIFieldChangeType.NewValue]))
                    {
                        _dbihelper.Dbi.DBIBuildNumbers.Add (_dbihelper.EventChanges["Build Number"][WIFieldChangeType.NewValue]);
                    }

                    if (_dbihelper.EventChanges.ContainsKey("HIC Deployment Priority"))
                    {
                        if (_dbihelper.EventChanges["HIC Deployment Priority"][WIFieldChangeType.NewValue].Contains("3"))
                        {
                            MailPriority = 3;
                        }
                        else if (_dbihelper.EventChanges["HIC Deployment Priority"][WIFieldChangeType.NewValue].Contains("2"))
                        {
                            MailPriority = 2;
                        }
                        else
                        {
                            MailPriority = 1;
                        }

                    }
                    else
                    {  //older DBI will not have this field there need to defualt it
                        Dictionary<WIFieldChangeType, string> _tempDic = new Dictionary<WIFieldChangeType, string>();
                        _tempDic.Add(WIFieldChangeType.NewValue, "1");
                        _dbihelper.EventChanges.Add("HIC Deployment Priority", _tempDic);
                        MailPriority = 1;
                    }

                    _approver = GetProjectApprover(_wiFields["HIC Project"], _wiFields["Deployment Type"], _wiFields["New Test Environment"]);

                    if (_approver.Equals(_wiFields["Created By"], StringComparison.CurrentCultureIgnoreCase) &&
                        _wiFields["HIC TR defect Numbers"] != String.Empty)
                    {//approver is the one who created the DBI therefore no need to ask to approve it
                        string _historyNote = String.Empty;
                        string _newState = String.Empty;

                        if (_wiFields["New Test Environment"].Equals("Production") &&
                            !_wiFields["HIC Deployment Priority"].Contains("3"))
                        {//if for prd and not a hotfix priority 3 need to get IRB approval
                            _historyNote = "DBI going to Production therefore needs to be approved by IRB first";
                            _newState = "Ready for IRB (Production Only)";
                            _dbihelper.Dbi.ChangeAreaPath(_dbihelper.WICE.PortfolioProject +
                                                     ConfigurationManager.AppSettings.Get("Areapath4IRB")); ;
                        }
                        else if (_wiFields["New Test Environment"].Equals("Production") &&
                                _wiFields["HIC Deployment Priority"].Contains("3"))
                        {
                            _historyNote = "DBI automatically approved; Item was created by the approver (" +
                                          _approver + ") and Deployment Priority was set to 3";
                            _newState = "Approved for Deployment";
                        }
                        else
                        {
                            _historyNote = "DBI automatically approved; Item was created by the approver (" +
                                              _approver + ")";
                            _newState = "Approved for Deployment";

                        }

                       
                        _dbihelper.Dbi.ChangeWorkItemStateTo(_newState,_historyNote);
                        // return true b/c I did do something that should alert 
                        _dbihelper.Dbi.PopulateApprovedBy("TFSBuild");
                    }
                    else if (_approver.Equals("AutomaticApproval", StringComparison.CurrentCulture))
                    {//approval is automatic for this particular DBI 
                        _dbihelper.Dbi.ChangeWorkItemStateTo("Approved for Deployment",
                                                    "DBI automatically approved, because the approver for this type of DBI is set to automatic Approval");
                        // return true b/c I did do something that should alert 
                        _dbihelper.Dbi.PopulateApprovedBy("Automatically approved");

                        _dbihelper.CheckDefectField();

                    }
                    else
                    {
                        SendAlert2Approver(_approver, _wiFields["ID"]);
                        //_dbihelper.Dbi.ChangeAreaPath(_dbihelper.WICE.PortfolioProject +
                        //                     ConfigurationManager.AppSettings.Get("Areapath4Open"));
                        _dbihelper.Dbi.PopulateApprovedBy("Approval pending");
                    }

                    
                    //_dbihelper.Dbi.SaveWorkItem();
                    return true; 
                }
                else
                {
                    return false;
                }
            }
            else
            {
                return false;
            }

        }

        private string _lastSuccessfulConfigKeySearched;

        private bool Check4ConfigKey(string _key)
        {
            if (_webConfigKeys == null)
            {
                _webConfigKeys = new Dictionary<string, bool>();

                foreach (string _k in ConfigurationManager.AppSettings.AllKeys)
                {
                    _webConfigKeys.Add(_k, true);
                }
            }

            if (_webConfigKeys.ContainsKey(_key))
            {
                _lastSuccessfulConfigKeySearched = _key;

                return (true);
            }
            else
            {
                return (false);
            }

        }

        private void SendAlert2Approver(string _approver, string _wiNum)
        {
            _dbihelper.Dbi.DBITeamProject = _dbihelper.WICE.PortfolioProject;
            StringBuilder _sb = new StringBuilder();
            Dictionary<string, string> _wiFields = _dbihelper.Dbi.GetWorkItemFields(Convert.ToInt32(_wiNum));
            _dbihelper.Dbi.DBIBuildNumbers.Add(_wiFields["Build Number"]);
            //above I need to go get all the fields of the wi b/c I am unsure what has changed 
            //which means the wice will might not hold some of the fields I need ie new test env 
            //b/c it didn't change
            _sb.AppendLine("<table>")
               .AppendLine("<tr><td>")
               .AppendLine("DBI: " + _wiFields["Title"])
               .AppendLine("</td></tr>")
               .AppendLine("<tr><td>")
               .AppendLine("Number: " + _wiFields["ID"])
               .AppendLine("</td></tr>")
               .AppendLine("<tr><td>")
               .AppendLine("Needs your approval before it can be deployed")
               .AppendLine("</td></tr>")
               .AppendLine("<tr><td>")
               .AppendLine("Use below link to view Workitem Details")
               .AppendLine("</td></tr>")
               .AppendLine("</table>");

            if (_approver.Contains("@"))
            {//appover key is actually email address most likely a group email 
                if (_approver.Contains(";"))
                {

                    SendAlert(_approver.Split(';')[0],
                          "Deployment Backlog Item needs approval for deployment to " +
                          _wiFields["New Test Environment"],
                          GetBody(_sb.ToString(), _dbihelper.WiFields["ID"]));

                    if (_dbihelper.IsInIRB)
                    {

                        _dbihelper.Dbi.AssignWorkItemTo(_approver.Split(';')[1],
                                              _dbihelper.WICE.PortfolioProject +
                                              ConfigurationManager.AppSettings.Get("AreaPath4IRB"));
                    }
                    else
                    {
                        _dbihelper.Dbi.AssignWorkItemTo(_approver.Split(';')[1]);
                    }

                    
                }
                else
                {
                    SendAlert(_approver,
                          "Deployment Backlog Item needs approval for deployment to " +
                          _wiFields["New Test Environment"],
                          GetBody(_sb.ToString(), _dbihelper.WiFields["ID"]));
                }


            }
            else
            {
                SendAlert(GetCreatedByEmialAddress(_approver),
                          "Deployment Backlog Item needs approval for deployment to " +
                          _wiFields["New Test Environment"],
                          GetBody(_sb.ToString(), _dbihelper.WiFields["ID"]));

                if (_dbihelper.IsInIRB)
                {

                    _dbihelper.Dbi.AssignWorkItemTo(_approver,
                                          _dbihelper.WICE.PortfolioProject +
                                          ConfigurationManager.AppSettings.Get("AreaPath4IRB"));
                }
                else
                {
                    _dbihelper.Dbi.AssignWorkItemTo(_approver);
                }

                
            }

        }

        private bool IsAssemblyApprovalNeeded(string _deploymentType)
        {
            bool _isNeeded = false;
            foreach (string _dtype in ConfigurationManager.AppSettings.Get("DeploymentTypesNeedApprovalInAsy").Split(';'))
            {
                if (_deploymentType.Equals(_dtype, StringComparison.CurrentCultureIgnoreCase))
                {
                    _isNeeded = true;
                    break;
                }
            }

            return _isNeeded;
        }

        private string GetVstfHelpMessage()
        {
            return "<a href=\"mailto:vstfhelp@harleysvillegroup.com\" > vstfhelp </a>";
             
        }

        private bool NeedsAssemblerAlert()
        {
            Dictionary<string, string> _changedHash = GetHashofChanged();
            if (_changedHash.ContainsKey("HIC Project") && _changedHash.ContainsKey("New Test Environment"))
            {
                bool _isPartofProjectSet = false;

                foreach (string proj in ConfigurationManager.AppSettings.Get("AssemblerProjects").Split(';'))
                {
                    if (_changedHash["HIC Project"].Equals(proj))
                    {
                        _isPartofProjectSet = true;
                        break;
                    }
                }

                if (_isPartofProjectSet && 
                    _changedHash["New Test Environment"].Equals("Assembly") &&
                    _changedHash["Deployment Type"].Equals(".Net"))
                {
                    return true;
                }
                else
                {
                    return false;
                }
            }
            else
            {
                return false;
            }
        }

        private Dictionary<string, string> GetHashofChanged()
        {
            Dictionary<string, string> _changedHash = new Dictionary<string, string>();
            List<StringField> _changedList = _dbihelper.WICE.ChangedFields.StringFields;
            List<IntegerField> _IntChangedList = _dbihelper.WICE.ChangedFields.IntegerFields;
            
            foreach (StringField _sf in _changedList)
            {
                _changedHash[_sf.Name] = _sf.NewValue;
            }

            foreach (IntegerField _if in _IntChangedList)
            {
                _changedHash[_if.Name] = _if.NewValue.ToString();
            }

            return (_changedHash);
        }

        #region Moved Method
        //private Dictionary<string, Dictionary<WIFieldChangeType, string>> ConvertList2Dic()
        //{
        //    Dictionary<string, Dictionary<WIFieldChangeType, string>> _dic = new Dictionary<string, Dictionary<WIFieldChangeType, string>>();

        //    foreach (StringField _sf in _dbihelper.EventChanges.CoreFields.StringFields)
        //    {
        //        Dictionary<WIFieldChangeType, string> _subDic = new Dictionary<WIFieldChangeType, string>();
        //        _subDic.Add(WIFieldChangeType.NewValue, _sf.NewValue);
        //        _subDic.Add(WIFieldChangeType.OldValue, _sf.OldValue);
        //        _dic.Add(_sf.Name, _subDic);
        //    }

        //    foreach (IntegerField _if in _dbihelper.EventChanges.CoreFields.IntegerFields)
        //    {
        //        Dictionary<WIFieldChangeType, string> _subDic = new Dictionary<WIFieldChangeType, string>();
        //        _subDic.Add(WIFieldChangeType.NewValue, _if.NewValue.ToString());
        //        _subDic.Add(WIFieldChangeType.OldValue, _if.OldValue.ToString());
        //        _dic.Add(_if.Name, _subDic);
        //    }

        //    foreach (StringField _sf in _dbihelper.EventChanges.ChangedFields.StringFields)
        //    {
        //        if (!_dic.ContainsKey(_sf.Name))
        //        {//alredy have Core fields even if they changed
        //            Dictionary<WIFieldChangeType, string> _subDic = new Dictionary<WIFieldChangeType, string>();
        //            _subDic.Add(WIFieldChangeType.NewValue, _sf.NewValue);
        //            _subDic.Add(WIFieldChangeType.OldValue, _sf.OldValue);
        //            _dic.Add(_sf.Name, _subDic);
        //        }
        //    }

        //    foreach (IntegerField _if in _dbihelper.EventChanges.ChangedFields.IntegerFields)
        //    {
        //        if (!_dic.ContainsKey(_if.Name))
        //        {
        //            Dictionary<WIFieldChangeType, string> _subDic = new Dictionary<WIFieldChangeType, string>();
        //            _subDic.Add(WIFieldChangeType.NewValue, _if.NewValue.ToString());
        //            _subDic.Add(WIFieldChangeType.OldValue, _if.OldValue.ToString());
        //            _dic.Add(_if.Name, _subDic);
        //        }
        //    }

        //    return _dic;

        //}
        #endregion
       

        static void WriteLog(string log, string _logPath)
        {

            //using (StreamWriter sw = new StreamWriter(_logPath, false))
            //{
            //    sw.WriteLine(log);
            //    sw.Flush();

            //}
        }



    }
}
