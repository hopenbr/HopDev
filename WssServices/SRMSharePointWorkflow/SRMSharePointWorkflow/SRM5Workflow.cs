using System;
using System.ComponentModel;
using System.ComponentModel.Design;
using System.Collections;
using System.Collections.Specialized;
using System.Drawing;
using System.Linq;
using System.Workflow.ComponentModel.Compiler;
using System.Workflow.ComponentModel.Serialization;
using System.Workflow.ComponentModel;
using System.Workflow.ComponentModel.Design;
using System.Workflow.Runtime;
using System.Workflow.Activities;
using System.Workflow.Activities.Rules;
using Microsoft.SharePoint;
using Microsoft.SharePoint.Workflow;
using Microsoft.SharePoint.WorkflowActions;
using Microsoft.SharePoint.Utilities;

using SRMSharePointWorkflow.Utilities;

namespace SRMSharePointWorkflow
{
    public sealed partial class SRM5Workflow : StateMachineWorkflowActivity
    {
        public SRM5Workflow()
        {
            InitializeComponent();
        }

        public SPWorkflowActivationProperties workflowProperties = new SPWorkflowActivationProperties();
        public Guid createTask_Approval_TaskId1 = default(System.Guid);
        public SPWorkflowTaskProperties createTask_Approval_TaskProperties1 = new Microsoft.SharePoint.Workflow.SPWorkflowTaskProperties();

        private void UpdateRequestDialog()
        {
        }



        private void createTask_Approval_MethodInvoking(object sender, EventArgs e)
        {
            SRMSharePointWorkflowUtil _lookup = new SRMSharePointWorkflowUtil();

            string _regionName = _lookup.GetFieldValueLookup(onWorkflowActivated1.WorkflowProperties.Item, "Region Name");

            string _requestType = _lookup.GetFieldValueLookup(onWorkflowActivated1.WorkflowProperties.Item, "SRM Request Type");

            string _listName = onWorkflowActivated1.WorkflowProperties.List.Title;

            createTask_Approval_TaskId1 = Guid.NewGuid();
            createTask_Approval_TaskProperties1.Title = "Review " + onWorkflowActivated1.WorkflowProperties.Item.Title;
            createTask_Approval_TaskProperties1.DueDate = DateTime.Now.AddDays(1.0);
            createTask_Approval_TaskProperties1.Description = "<b>Activities:</b><br>"
                + "Please Review Request<br>"
                + "To approve set status to \"Approved\"<br>"
                + "To reject set status to \"Rejected\"<br>"
                + "Rejected requests can be resubmitted <br>"
                + "<br>"
                + "<b>Request info</b><br>"
                + "Region: " + _regionName + "<br>"
                + "Request type: " + _requestType + "<br>";

            string _approver = _lookup.LookUpApprover(_regionName, _requestType, _listName + " RegionTypeConfig", onWorkflowActivated1.WorkflowProperties.Item.Web.Url);

            createTask_Approval_TaskProperties1.AssignedTo = _approver;

            onWorkflowActivated1.WorkflowProperties.Item[SPBuiltInFieldId.PercentComplete] = 0.0;
            onWorkflowActivated1.WorkflowProperties.Item["Status"] = "Pending Approval";
            onWorkflowActivated1.WorkflowProperties.Item.Update();

        }

        public SPWorkflowTaskProperties onTaskChanged_Approval_AfterProperties1 = new Microsoft.SharePoint.Workflow.SPWorkflowTaskProperties();
        public SPWorkflowTaskProperties onTaskChanged_Approval_BeforeProperties1 = new Microsoft.SharePoint.Workflow.SPWorkflowTaskProperties();

        private void onTaskChanged_Approval_Invoked(object sender, ExternalDataEventArgs e)
        {
            onTaskChanged_Approval_AfterProperties1 = onTaskChanged_Approval.AfterProperties;
            onTaskChanged_Approval_BeforeProperties1 = onTaskChanged_Approval.BeforeProperties;
        }

        private void onTaskChanged_Approval_IsTaskApproved(object sender, ConditionalEventArgs e)
        {
            if (onTaskChanged_Approval_AfterProperties1.ExtendedProperties.ContainsKey(GetWFTaskFieldGuid("Status")) &&
                onTaskChanged_Approval_AfterProperties1.ExtendedProperties[GetWFTaskFieldGuid("Status")].Equals("Approved"))
            {
                e.Result = true;
            }
            else
            {
                e.Result = false;
            }
        }

        private void onTaskChanged_Approval_IsTaskRejected(object sender, ConditionalEventArgs e)
        {
            if (onTaskChanged_Approval_AfterProperties1.ExtendedProperties.ContainsKey(GetWFTaskFieldGuid("Status")) &&
                onTaskChanged_Approval_AfterProperties1.ExtendedProperties[GetWFTaskFieldGuid("Status")].Equals("Rejected"))
            {
                e.Result = true;
            }
            else
            {
                e.Result = false;
            }
        }

        private void onTaskChanged_Approval_HasDialogBeenAdded(Object sender, ConditionalEventArgs e)
        {
            e.Result = HasDialogBeenAdded(onTaskChanged_Approval_AfterProperties1);
        }

        private bool HasDialogBeenAdded(SPWorkflowTaskProperties _spwtp)
        {

            if (_spwtp.ExtendedProperties.ContainsKey(GetWFTaskFieldGuid("Description")))
            {
                return true;
            }
            else
            {
                return false;
            }
        }


        private void onTaskChanged_Completion_IsTaskComplete(object sender, ConditionalEventArgs e)
        {
            if (onTaskChanged_Completion_AfterProperties1.ExtendedProperties.ContainsKey(GetWFTaskFieldGuid("Status")) &&
                onTaskChanged_Completion_AfterProperties1.ExtendedProperties[GetWFTaskFieldGuid("Status")].Equals("Completed"))
            {
                e.Result = true;
            }
            else
            {
                e.Result = false;
            }
        }

        private void onTaskChanged_Completion_IsTaskRejected(object sender, ConditionalEventArgs e)
        {
            if (onTaskChanged_Completion_AfterProperties1.ExtendedProperties.ContainsKey(GetWFTaskFieldGuid("Status")) &&
                onTaskChanged_Completion_AfterProperties1.ExtendedProperties[GetWFTaskFieldGuid("Status")].Equals("Rejected"))
            {
                e.Result = true;
            }
            else
            {
                e.Result = false;
            }
        }

        private void onTaskChanged_Rejected_IsTaskResubmitted(object sender, ConditionalEventArgs e)
        {
            if (onTaskChanged_Rejected_AfterProperties1.ExtendedProperties.ContainsKey(GetWFTaskFieldGuid("Status")) &&
                onTaskChanged_Rejected_AfterProperties1.ExtendedProperties[GetWFTaskFieldGuid("Status")].Equals("Resubmit"))
            {
                e.Result = true;
            }
            else
            {
                e.Result = false;
            }
        }

        private void onTaskChanged_Rejected_IsTaskClosed(object sender, ConditionalEventArgs e)
        {
            if (onTaskChanged_Rejected_AfterProperties1.ExtendedProperties.ContainsKey(GetWFTaskFieldGuid("Status")) &&
                onTaskChanged_Rejected_AfterProperties1.ExtendedProperties[GetWFTaskFieldGuid("Status")].Equals("Close"))
            {
                e.Result = true;
            }
            else
            {
                e.Result = false;
            }
        }

        private Guid GetWFTaskFieldGuid(string FieldName)
        {
            Guid _g = onWorkflowActivated1.WorkflowProperties.TaskList.Fields.GetField(FieldName).Id;

            return (_g);
        }

        public Guid createTask_Completion_TaskId1 = default(System.Guid);
        public SPWorkflowTaskProperties createTask_Completion_TaskProperties1 = new Microsoft.SharePoint.Workflow.SPWorkflowTaskProperties();

        private void createTask_Completion_MethodInvoking(object sender, EventArgs e)
        {
            SRMSharePointWorkflowUtil _lookup = new SRMSharePointWorkflowUtil();

            string _listName = onWorkflowActivated1.WorkflowProperties.List.Title;
            string _regionName = _lookup.GetFieldValueLookup(onWorkflowActivated1.WorkflowProperties.Item, "Region Name");
            string _requestType = _lookup.GetFieldValueLookup(onWorkflowActivated1.WorkflowProperties.Item, "SRM Request Type");


            createTask_Completion_TaskId1 = Guid.NewGuid();
            createTask_Completion_TaskProperties1.Title = "Complete " + onWorkflowActivated1.WorkflowProperties.Item.Title;
            createTask_Completion_TaskProperties1.DueDate = DateTime.Now.AddDays(1.0);
            createTask_Completion_TaskProperties1.Description = "<b>Activities:</b><br>"
                + "Complete work and set status to \"Completed\"<br>"
                + "Reject request by setting status to \"Rejected\"<br>"
                + "Rejected requests can be resubmitted"
                + "<br>"
                + "<b>Request info</b><br>"
                + "Region: " + _regionName + "<br>"
                + "Request type: " + _requestType + "<br>"; ;

            createTask_Completion_TaskProperties1.AssignedTo = _lookup.LookUpDeployer(_regionName, _requestType, _listName + " RegionTypeConfig", onWorkflowActivated1.WorkflowProperties.Item.Web.Url);

            onWorkflowActivated1.WorkflowProperties.Item["% Complete"] = 0.33;
            onWorkflowActivated1.WorkflowProperties.Item["Status"] = "Pending Completion";
            onWorkflowActivated1.WorkflowProperties.Item.Update();
        }

        public SPWorkflowTaskProperties onTaskChanged_Completion_AfterProperties1 = new Microsoft.SharePoint.Workflow.SPWorkflowTaskProperties();
        public SPWorkflowTaskProperties onTaskChanged_Completion_BeforeProperties1 = new Microsoft.SharePoint.Workflow.SPWorkflowTaskProperties();

        private void onTaskChanged_Completion_Invoked(object sender, ExternalDataEventArgs e)
        {
            onTaskChanged_Completion_AfterProperties1 = onTaskChanged_Completion.AfterProperties;
            onTaskChanged_Completion_BeforeProperties1 = onTaskChanged_Completion.BeforeProperties;
        }

        public Guid createTask_Rejected_TaskId1 = default(System.Guid);
        public SPWorkflowTaskProperties createTask_Rejected_TaskProperties1 = new Microsoft.SharePoint.Workflow.SPWorkflowTaskProperties();

        private void createTask_Rejected_MethodInvoking(object sender, EventArgs e)
        {
            SRMSharePointWorkflowUtil _lookup = new SRMSharePointWorkflowUtil();

            createTask_Rejected_TaskId1 = Guid.NewGuid();
            createTask_Rejected_TaskProperties1.Title = onWorkflowActivated1.WorkflowProperties.Item.Title + " rejected";
            createTask_Rejected_TaskProperties1.DueDate = DateTime.Now.AddDays(2.0);
            createTask_Rejected_TaskProperties1.Description = "<b>Activities:</b><br>"
                + "To close set status to \"Close\"<br>"
                + "Resubmit request by setting status to \"Resubmit\"<br>"
                + "Closed requests CANNOT be resubmitted";
            string _assignTo = _lookup.GetFieldValueUserLogin(onWorkflowActivated1.WorkflowProperties.Item, "Author");

            createTask_Rejected_TaskProperties1.AssignedTo = _assignTo;
            onWorkflowActivated1.WorkflowProperties.Item["Status"] = "Rejected";
            onWorkflowActivated1.WorkflowProperties.Item.Update();

        }

        public SPWorkflowTaskProperties onTaskChanged_Rejected_AfterProperties1 = new Microsoft.SharePoint.Workflow.SPWorkflowTaskProperties();
        public SPWorkflowTaskProperties onTaskChanged_Rejected_BeforeProperties1 = new Microsoft.SharePoint.Workflow.SPWorkflowTaskProperties();

        private void onTaskChanged_Rejected_Invoked(object sender, ExternalDataEventArgs e)
        {
            onTaskChanged_Rejected_AfterProperties1 = onTaskChanged_Rejected.AfterProperties;
            onTaskChanged_Rejected_BeforeProperties1 = onTaskChanged_Rejected.BeforeProperties;
        }


        private void codeActivity1_ExecuteCode(object sender, EventArgs e)
        {
            onWorkflowActivated1.WorkflowProperties.Item[SPBuiltInFieldId.PercentComplete] = 1.0;
            onWorkflowActivated1.WorkflowProperties.Item["Status"] = "Completed";

            onWorkflowActivated1.WorkflowProperties.Item.Update();



        }

        private void codeActivity_Approval_DialogChanged(object sender, EventArgs e)
        {

            Guid dialogGuid = GetWFTaskFieldGuid("Description");
            Guid modByGuid = GetWFTaskFieldGuid("Modified By");

            string modBy = workflowProperties.Originator;


            onWorkflowActivated1.WorkflowProperties.Item[dialogGuid] = modBy + ": " + onTaskChanged_Approval_AfterProperties1.ExtendedProperties[dialogGuid];

            onWorkflowActivated1.WorkflowProperties.Item.Update();

        }



        public String completeTask_completed2_TaskOutcome1 = default(System.String);
        private void completeTask_completed2_MethodInvoking(object sender, EventArgs e)
        {
            completeTask_completed2_TaskOutcome1 = "Request completed";
        }

        public String completeTask_approval_app_TaskOutcome1 = default(System.String);
        private void completeTask_approval_app_MethodInvoking(object sender, EventArgs e)
        {
            completeTask_approval_app_TaskOutcome1 = "Request Approved";
        }

        public String completeTask_approval_rej_TaskOutcome1 = default(System.String);
        private void completeTask_approval_rej_MethodInvoking(object sender, EventArgs e)
        {
            completeTask_approval_rej_TaskOutcome1 = "Request rejected";
        }

        public String completeTask_completed_rej_TaskOutcome1 = default(System.String);
        private void completeTask_completed_rej_MethodInvoking(object sender, EventArgs e)
        {
            completeTask_completed_rej_TaskOutcome1 = "Request rejected";

        }

        public String completaTask_rejected_resub_TaskOutcome1 = default(System.String);
        private void completaTask_rejected_resub_MethodInvoking(object sender, EventArgs e)
        {
            completaTask_rejected_resub_TaskOutcome1 = "Request resubmitted";
        }

        public String completeTask_rejected_closed_TaskOutcome1 = default(System.String);
        private void completeTask_rejected_closed_MethodInvoking(object sender, EventArgs e)
        {
            completeTask_rejected_closed_TaskOutcome1 = "Request closed";
        }

        private void codeActivity2_ExecuteCodeSetTitle(object sender, EventArgs e)
        {
            onWorkflowActivated1.WorkflowProperties.Item[SPBuiltInFieldId.Title] = "SR: " + onWorkflowActivated1.WorkflowProperties.Item[SPBuiltInFieldId.ID];
            onWorkflowActivated1.WorkflowProperties.Item.Update();

        }


        private void AreTherePeople2Alert(object sender, ConditionalEventArgs e)
        {
            SRMSharePointWorkflowUtil _lookup = new SRMSharePointWorkflowUtil();
            string emails = _lookup.GetFieldValueUserCollectionEmails(onWorkflowActivated1.WorkflowProperties.Item, "Alerts");

            if (String.IsNullOrEmpty(emails))
            {
                e.Result = false;
            }
            else
            {
                e.Result = true;
            }

        }

        private void codeActivity3_ExecuteCode(object sender, EventArgs e)
        {
            SRMSharePointWorkflowUtil _lookup = new SRMSharePointWorkflowUtil();

            StringDictionary header = new StringDictionary();

            header.Add("to", _lookup.GetFieldValueUserCollectionEmails(workflowProperties.Item, "Alerts"));

            header.Add("from", "SRMWSS@halreysvillegroup.com");

            header.Add("reply-to", workflowProperties.OriginatorEmail);

            header.Add("subject", "Request (" + workflowProperties.Item.Title + ") has been submitted");

            string sendAlert_Body1 = "Following request has been submitted by " +
                workflowProperties.Originator +
               "<br><a href=\"" +
                workflowProperties.WebUrl + "/Lists/" +
                workflowProperties.List.Title + "/" +
                "Dispform.aspx?ID=" +
                workflowProperties.ItemId + "\">" +
                workflowProperties.Item.Title +
                "</a><br>";


            SPUtility.SendEmail(workflowProperties.Web, header, sendAlert_Body1);

        }


    }
}
