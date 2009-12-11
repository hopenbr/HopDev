using System;
using System.ComponentModel;
using System.ComponentModel.Design;
using System.Collections;
using System.Drawing;
using System.Reflection;
using System.Workflow.ComponentModel.Compiler;
using System.Workflow.ComponentModel.Serialization;
using System.Workflow.ComponentModel;
using System.Workflow.ComponentModel.Design;
using System.Workflow.Runtime;
using System.Workflow.Activities;
using System.Workflow.Activities.Rules;

namespace SRMSharePointWorkflow
{
    public sealed partial class SRM5Workflow
    {
        #region Designer generated code

        /// <summary> 
        /// Required method for Designer support - do not modify 
        /// the contents of this method with the code editor.
        /// </summary>
        [System.Diagnostics.DebuggerNonUserCode]
        private void InitializeComponent()
        {
            this.CanModifyActivities = true;
            System.Workflow.Runtime.CorrelationToken correlationtoken1 = new System.Workflow.Runtime.CorrelationToken();
            System.Workflow.ComponentModel.ActivityBind activitybind1 = new System.Workflow.ComponentModel.ActivityBind();
            System.Workflow.ComponentModel.ActivityBind activitybind2 = new System.Workflow.ComponentModel.ActivityBind();
            System.Workflow.Runtime.CorrelationToken correlationtoken2 = new System.Workflow.Runtime.CorrelationToken();
            System.Workflow.ComponentModel.ActivityBind activitybind3 = new System.Workflow.ComponentModel.ActivityBind();
            System.Workflow.ComponentModel.ActivityBind activitybind4 = new System.Workflow.ComponentModel.ActivityBind();
            System.Workflow.Runtime.CorrelationToken correlationtoken3 = new System.Workflow.Runtime.CorrelationToken();
            System.Workflow.ComponentModel.ActivityBind activitybind5 = new System.Workflow.ComponentModel.ActivityBind();
            System.Workflow.ComponentModel.ActivityBind activitybind6 = new System.Workflow.ComponentModel.ActivityBind();
            System.Workflow.Activities.CodeCondition codecondition1 = new System.Workflow.Activities.CodeCondition();
            System.Workflow.Activities.CodeCondition codecondition2 = new System.Workflow.Activities.CodeCondition();
            System.Workflow.Activities.CodeCondition codecondition3 = new System.Workflow.Activities.CodeCondition();
            System.Workflow.ComponentModel.ActivityBind activitybind7 = new System.Workflow.ComponentModel.ActivityBind();
            System.Workflow.ComponentModel.ActivityBind activitybind8 = new System.Workflow.ComponentModel.ActivityBind();
            System.Workflow.ComponentModel.ActivityBind activitybind9 = new System.Workflow.ComponentModel.ActivityBind();
            System.Workflow.ComponentModel.ActivityBind activitybind10 = new System.Workflow.ComponentModel.ActivityBind();
            System.Workflow.ComponentModel.ActivityBind activitybind11 = new System.Workflow.ComponentModel.ActivityBind();
            System.Workflow.ComponentModel.ActivityBind activitybind12 = new System.Workflow.ComponentModel.ActivityBind();
            System.Workflow.Activities.CodeCondition codecondition4 = new System.Workflow.Activities.CodeCondition();
            System.Workflow.Activities.CodeCondition codecondition5 = new System.Workflow.Activities.CodeCondition();
            System.Workflow.Activities.CodeCondition codecondition6 = new System.Workflow.Activities.CodeCondition();
            System.Workflow.Activities.CodeCondition codecondition7 = new System.Workflow.Activities.CodeCondition();
            System.Workflow.Activities.CodeCondition codecondition8 = new System.Workflow.Activities.CodeCondition();
            System.Workflow.ComponentModel.ActivityBind activitybind13 = new System.Workflow.ComponentModel.ActivityBind();
            System.Workflow.ComponentModel.ActivityBind activitybind14 = new System.Workflow.ComponentModel.ActivityBind();
            System.Workflow.ComponentModel.ActivityBind activitybind15 = new System.Workflow.ComponentModel.ActivityBind();
            System.Workflow.ComponentModel.ActivityBind activitybind16 = new System.Workflow.ComponentModel.ActivityBind();
            System.Workflow.ComponentModel.ActivityBind activitybind17 = new System.Workflow.ComponentModel.ActivityBind();
            System.Workflow.ComponentModel.ActivityBind activitybind18 = new System.Workflow.ComponentModel.ActivityBind();
            System.Workflow.ComponentModel.ActivityBind activitybind19 = new System.Workflow.ComponentModel.ActivityBind();
            System.Workflow.ComponentModel.ActivityBind activitybind20 = new System.Workflow.ComponentModel.ActivityBind();
            System.Workflow.ComponentModel.ActivityBind activitybind21 = new System.Workflow.ComponentModel.ActivityBind();
            System.Workflow.ComponentModel.ActivityBind activitybind22 = new System.Workflow.ComponentModel.ActivityBind();
            System.Workflow.ComponentModel.ActivityBind activitybind23 = new System.Workflow.ComponentModel.ActivityBind();
            System.Workflow.ComponentModel.ActivityBind activitybind24 = new System.Workflow.ComponentModel.ActivityBind();
            System.Workflow.ComponentModel.ActivityBind activitybind25 = new System.Workflow.ComponentModel.ActivityBind();
            System.Workflow.ComponentModel.ActivityBind activitybind26 = new System.Workflow.ComponentModel.ActivityBind();
            System.Workflow.ComponentModel.ActivityBind activitybind27 = new System.Workflow.ComponentModel.ActivityBind();
            System.Workflow.Runtime.CorrelationToken correlationtoken4 = new System.Workflow.Runtime.CorrelationToken();
            System.Workflow.ComponentModel.ActivityBind activitybind28 = new System.Workflow.ComponentModel.ActivityBind();
            this.completeTask_rejected_closed = new Microsoft.SharePoint.WorkflowActions.CompleteTask();
            this.logToHistoryListActivity8 = new Microsoft.SharePoint.WorkflowActions.LogToHistoryListActivity();
            this.setStateActivity7 = new System.Workflow.Activities.SetStateActivity();
            this.completeTask_completed_rej = new Microsoft.SharePoint.WorkflowActions.CompleteTask();
            this.setStateActivity4 = new System.Workflow.Activities.SetStateActivity();
            this.logToHistoryListActivity4 = new Microsoft.SharePoint.WorkflowActions.LogToHistoryListActivity();
            this.completeTask_approval_rej = new Microsoft.SharePoint.WorkflowActions.CompleteTask();
            this.setStateActivity3 = new System.Workflow.Activities.SetStateActivity();
            this.ifElseBranchActivity12 = new System.Workflow.Activities.IfElseBranchActivity();
            this.ifElseBranchActivity11 = new System.Workflow.Activities.IfElseBranchActivity();
            this.ifElseBranchActivity8 = new System.Workflow.Activities.IfElseBranchActivity();
            this.ifElseBranchActivity7 = new System.Workflow.Activities.IfElseBranchActivity();
            this.ifElseBranchActivity4 = new System.Workflow.Activities.IfElseBranchActivity();
            this.ifElseBranchActivity3 = new System.Workflow.Activities.IfElseBranchActivity();
            this.ifElseActivity6 = new System.Workflow.Activities.IfElseActivity();
            this.completaTask_rejected_resub = new Microsoft.SharePoint.WorkflowActions.CompleteTask();
            this.logToHistoryListActivity7 = new Microsoft.SharePoint.WorkflowActions.LogToHistoryListActivity();
            this.setStateActivity6 = new System.Workflow.Activities.SetStateActivity();
            this.ifElseActivity4 = new System.Workflow.Activities.IfElseActivity();
            this.completeTask_completed2 = new Microsoft.SharePoint.WorkflowActions.CompleteTask();
            this.setState_Completed = new System.Workflow.Activities.SetStateActivity();
            this.codeActivity2 = new System.Workflow.Activities.CodeActivity();
            this.ifElseActivity2 = new System.Workflow.Activities.IfElseActivity();
            this.logToHistoryListActivity3 = new Microsoft.SharePoint.WorkflowActions.LogToHistoryListActivity();
            this.completeTask_approval_app = new Microsoft.SharePoint.WorkflowActions.CompleteTask();
            this.setStateActivity2 = new System.Workflow.Activities.SetStateActivity();
            this.codeActivity3 = new System.Workflow.Activities.CodeActivity();
            this.ifElseBranchActivity10 = new System.Workflow.Activities.IfElseBranchActivity();
            this.ifElseBranchActivity9 = new System.Workflow.Activities.IfElseBranchActivity();
            this.ifElseBranchActivity6 = new System.Workflow.Activities.IfElseBranchActivity();
            this.ifElseBranchActivity5 = new System.Workflow.Activities.IfElseBranchActivity();
            this.ifElseBranchActivity14 = new System.Workflow.Activities.IfElseBranchActivity();
            this.ifElseBranchActivity13 = new System.Workflow.Activities.IfElseBranchActivity();
            this.ifElseBranchActivity2 = new System.Workflow.Activities.IfElseBranchActivity();
            this.ifElseBranchActivity1 = new System.Workflow.Activities.IfElseBranchActivity();
            this.ifElseBranchActivity16 = new System.Workflow.Activities.IfElseBranchActivity();
            this.ifElseBranchActivity15 = new System.Workflow.Activities.IfElseBranchActivity();
            this.codeActivity1 = new System.Workflow.Activities.CodeActivity();
            this.setStateActivity5 = new System.Workflow.Activities.SetStateActivity();
            this.logToHistoryListActivity9 = new Microsoft.SharePoint.WorkflowActions.LogToHistoryListActivity();
            this.ifElseActivity5 = new System.Workflow.Activities.IfElseActivity();
            this.onTaskChanged_Rejected = new Microsoft.SharePoint.WorkflowActions.OnTaskChanged();
            this.createTask_Rejected = new Microsoft.SharePoint.WorkflowActions.CreateTask();
            this.logToHistoryListActivity6 = new Microsoft.SharePoint.WorkflowActions.LogToHistoryListActivity();
            this.ifElseActivity3 = new System.Workflow.Activities.IfElseActivity();
            this.onTaskChanged_Completion = new Microsoft.SharePoint.WorkflowActions.OnTaskChanged();
            this.createTask_Completion = new Microsoft.SharePoint.WorkflowActions.CreateTask();
            this.logToHistoryListActivity5 = new Microsoft.SharePoint.WorkflowActions.LogToHistoryListActivity();
            this.ifElseActivity7 = new System.Workflow.Activities.IfElseActivity();
            this.ifElseActivity1 = new System.Workflow.Activities.IfElseActivity();
            this.onTaskChanged_Approval = new Microsoft.SharePoint.WorkflowActions.OnTaskChanged();
            this.ifElseActivity8 = new System.Workflow.Activities.IfElseActivity();
            this.createTask_Approval = new Microsoft.SharePoint.WorkflowActions.CreateTask();
            this.logToHistoryListActivity2 = new Microsoft.SharePoint.WorkflowActions.LogToHistoryListActivity();
            this.SetTitle = new System.Workflow.Activities.CodeActivity();
            this.setStateActivity1 = new System.Workflow.Activities.SetStateActivity();
            this.logToHistoryListActivity1 = new Microsoft.SharePoint.WorkflowActions.LogToHistoryListActivity();
            this.onWorkflowActivated1 = new Microsoft.SharePoint.WorkflowActions.OnWorkflowActivated();
            this.stateFinalizationActivity1 = new System.Workflow.Activities.StateFinalizationActivity();
            this.stateInitializationActivity3 = new System.Workflow.Activities.StateInitializationActivity();
            this.eventDrivenActivity4 = new System.Workflow.Activities.EventDrivenActivity();
            this.stateInitializationActivity4 = new System.Workflow.Activities.StateInitializationActivity();
            this.eventDrivenActivity3 = new System.Workflow.Activities.EventDrivenActivity();
            this.stateInitializationActivity2 = new System.Workflow.Activities.StateInitializationActivity();
            this.stateFinalizationActivity2 = new System.Workflow.Activities.StateFinalizationActivity();
            this.eventDrivenActivity2 = new System.Workflow.Activities.EventDrivenActivity();
            this.stateInitializationActivity1 = new System.Workflow.Activities.StateInitializationActivity();
            this.eventDrivenActivity1 = new System.Workflow.Activities.EventDrivenActivity();
            this.state_Closed = new System.Workflow.Activities.StateActivity();
            this.state_Completed = new System.Workflow.Activities.StateActivity();
            this.state_Rejected = new System.Workflow.Activities.StateActivity();
            this.state_Approved = new System.Workflow.Activities.StateActivity();
            this.state_Pending = new System.Workflow.Activities.StateActivity();
            this.Workflow1InitialState = new System.Workflow.Activities.StateActivity();
            // 
            // completeTask_rejected_closed
            // 
            correlationtoken1.Name = "Token_Rejected";
            correlationtoken1.OwnerActivityName = "state_Rejected";
            this.completeTask_rejected_closed.CorrelationToken = correlationtoken1;
            this.completeTask_rejected_closed.Name = "completeTask_rejected_closed";
            activitybind1.Name = "SRM5Workflow";
            activitybind1.Path = "createTask_Rejected_TaskId1";
            activitybind2.Name = "SRM5Workflow";
            activitybind2.Path = "completeTask_rejected_closed_TaskOutcome1";
            this.completeTask_rejected_closed.MethodInvoking += new System.EventHandler(this.completeTask_rejected_closed_MethodInvoking);
            this.completeTask_rejected_closed.SetBinding(Microsoft.SharePoint.WorkflowActions.CompleteTask.TaskIdProperty, ((System.Workflow.ComponentModel.ActivityBind)(activitybind1)));
            this.completeTask_rejected_closed.SetBinding(Microsoft.SharePoint.WorkflowActions.CompleteTask.TaskOutcomeProperty, ((System.Workflow.ComponentModel.ActivityBind)(activitybind2)));
            // 
            // logToHistoryListActivity8
            // 
            this.logToHistoryListActivity8.Duration = System.TimeSpan.Parse("-10675199.02:48:05.4775808");
            this.logToHistoryListActivity8.EventId = Microsoft.SharePoint.Workflow.SPWorkflowHistoryEventType.WorkflowComment;
            this.logToHistoryListActivity8.HistoryDescription = "Rejected request closed";
            this.logToHistoryListActivity8.HistoryOutcome = "";
            this.logToHistoryListActivity8.Name = "logToHistoryListActivity8";
            this.logToHistoryListActivity8.OtherData = "";
            this.logToHistoryListActivity8.UserId = -1;
            // 
            // setStateActivity7
            // 
            this.setStateActivity7.Name = "setStateActivity7";
            this.setStateActivity7.TargetStateName = "state_Completed";
            // 
            // completeTask_completed_rej
            // 
            correlationtoken2.Name = "Token_Approved";
            correlationtoken2.OwnerActivityName = "state_Approved";
            this.completeTask_completed_rej.CorrelationToken = correlationtoken2;
            this.completeTask_completed_rej.Name = "completeTask_completed_rej";
            activitybind3.Name = "SRM5Workflow";
            activitybind3.Path = "createTask_Completion_TaskId1";
            activitybind4.Name = "SRM5Workflow";
            activitybind4.Path = "completeTask_completed_rej_TaskOutcome1";
            this.completeTask_completed_rej.MethodInvoking += new System.EventHandler(this.completeTask_completed_rej_MethodInvoking);
            this.completeTask_completed_rej.SetBinding(Microsoft.SharePoint.WorkflowActions.CompleteTask.TaskIdProperty, ((System.Workflow.ComponentModel.ActivityBind)(activitybind3)));
            this.completeTask_completed_rej.SetBinding(Microsoft.SharePoint.WorkflowActions.CompleteTask.TaskOutcomeProperty, ((System.Workflow.ComponentModel.ActivityBind)(activitybind4)));
            // 
            // setStateActivity4
            // 
            this.setStateActivity4.Name = "setStateActivity4";
            this.setStateActivity4.TargetStateName = "state_Rejected";
            // 
            // logToHistoryListActivity4
            // 
            this.logToHistoryListActivity4.Duration = System.TimeSpan.Parse("-10675199.02:48:05.4775808");
            this.logToHistoryListActivity4.EventId = Microsoft.SharePoint.Workflow.SPWorkflowHistoryEventType.WorkflowComment;
            this.logToHistoryListActivity4.HistoryDescription = "Request Rejected by Approver";
            this.logToHistoryListActivity4.HistoryOutcome = "";
            this.logToHistoryListActivity4.Name = "logToHistoryListActivity4";
            this.logToHistoryListActivity4.OtherData = "";
            this.logToHistoryListActivity4.UserId = -1;
            // 
            // completeTask_approval_rej
            // 
            correlationtoken3.Name = "Token_Pending";
            correlationtoken3.OwnerActivityName = "state_Pending";
            this.completeTask_approval_rej.CorrelationToken = correlationtoken3;
            this.completeTask_approval_rej.Name = "completeTask_approval_rej";
            activitybind5.Name = "SRM5Workflow";
            activitybind5.Path = "createTask_Approval_TaskId1";
            activitybind6.Name = "SRM5Workflow";
            activitybind6.Path = "completeTask_approval_rej_TaskOutcome1";
            this.completeTask_approval_rej.MethodInvoking += new System.EventHandler(this.completeTask_approval_rej_MethodInvoking);
            this.completeTask_approval_rej.SetBinding(Microsoft.SharePoint.WorkflowActions.CompleteTask.TaskIdProperty, ((System.Workflow.ComponentModel.ActivityBind)(activitybind5)));
            this.completeTask_approval_rej.SetBinding(Microsoft.SharePoint.WorkflowActions.CompleteTask.TaskOutcomeProperty, ((System.Workflow.ComponentModel.ActivityBind)(activitybind6)));
            // 
            // setStateActivity3
            // 
            this.setStateActivity3.Name = "setStateActivity3";
            this.setStateActivity3.TargetStateName = "state_Rejected";
            // 
            // ifElseBranchActivity12
            // 
            this.ifElseBranchActivity12.Name = "ifElseBranchActivity12";
            // 
            // ifElseBranchActivity11
            // 
            this.ifElseBranchActivity11.Activities.Add(this.setStateActivity7);
            this.ifElseBranchActivity11.Activities.Add(this.logToHistoryListActivity8);
            this.ifElseBranchActivity11.Activities.Add(this.completeTask_rejected_closed);
            codecondition1.Condition += new System.EventHandler<System.Workflow.Activities.ConditionalEventArgs>(this.onTaskChanged_Rejected_IsTaskClosed);
            this.ifElseBranchActivity11.Condition = codecondition1;
            this.ifElseBranchActivity11.Name = "ifElseBranchActivity11";
            // 
            // ifElseBranchActivity8
            // 
            this.ifElseBranchActivity8.Name = "ifElseBranchActivity8";
            // 
            // ifElseBranchActivity7
            // 
            this.ifElseBranchActivity7.Activities.Add(this.setStateActivity4);
            this.ifElseBranchActivity7.Activities.Add(this.completeTask_completed_rej);
            codecondition2.Condition += new System.EventHandler<System.Workflow.Activities.ConditionalEventArgs>(this.onTaskChanged_Completion_IsTaskRejected);
            this.ifElseBranchActivity7.Condition = codecondition2;
            this.ifElseBranchActivity7.Name = "ifElseBranchActivity7";
            // 
            // ifElseBranchActivity4
            // 
            this.ifElseBranchActivity4.Name = "ifElseBranchActivity4";
            // 
            // ifElseBranchActivity3
            // 
            this.ifElseBranchActivity3.Activities.Add(this.setStateActivity3);
            this.ifElseBranchActivity3.Activities.Add(this.completeTask_approval_rej);
            this.ifElseBranchActivity3.Activities.Add(this.logToHistoryListActivity4);
            codecondition3.Condition += new System.EventHandler<System.Workflow.Activities.ConditionalEventArgs>(this.onTaskChanged_Approval_IsTaskRejected);
            this.ifElseBranchActivity3.Condition = codecondition3;
            this.ifElseBranchActivity3.Name = "ifElseBranchActivity3";
            // 
            // ifElseActivity6
            // 
            this.ifElseActivity6.Activities.Add(this.ifElseBranchActivity11);
            this.ifElseActivity6.Activities.Add(this.ifElseBranchActivity12);
            this.ifElseActivity6.Name = "ifElseActivity6";
            // 
            // completaTask_rejected_resub
            // 
            this.completaTask_rejected_resub.CorrelationToken = correlationtoken1;
            this.completaTask_rejected_resub.Name = "completaTask_rejected_resub";
            activitybind7.Name = "SRM5Workflow";
            activitybind7.Path = "createTask_Rejected_TaskId1";
            activitybind8.Name = "SRM5Workflow";
            activitybind8.Path = "completaTask_rejected_resub_TaskOutcome1";
            this.completaTask_rejected_resub.MethodInvoking += new System.EventHandler(this.completaTask_rejected_resub_MethodInvoking);
            this.completaTask_rejected_resub.SetBinding(Microsoft.SharePoint.WorkflowActions.CompleteTask.TaskIdProperty, ((System.Workflow.ComponentModel.ActivityBind)(activitybind7)));
            this.completaTask_rejected_resub.SetBinding(Microsoft.SharePoint.WorkflowActions.CompleteTask.TaskOutcomeProperty, ((System.Workflow.ComponentModel.ActivityBind)(activitybind8)));
            // 
            // logToHistoryListActivity7
            // 
            this.logToHistoryListActivity7.Duration = System.TimeSpan.Parse("-10675199.02:48:05.4775808");
            this.logToHistoryListActivity7.EventId = Microsoft.SharePoint.Workflow.SPWorkflowHistoryEventType.WorkflowComment;
            this.logToHistoryListActivity7.HistoryDescription = "Rejected request resubmitted for approval";
            this.logToHistoryListActivity7.HistoryOutcome = "";
            this.logToHistoryListActivity7.Name = "logToHistoryListActivity7";
            this.logToHistoryListActivity7.OtherData = "";
            this.logToHistoryListActivity7.UserId = -1;
            // 
            // setStateActivity6
            // 
            this.setStateActivity6.Name = "setStateActivity6";
            this.setStateActivity6.TargetStateName = "state_Pending";
            // 
            // ifElseActivity4
            // 
            this.ifElseActivity4.Activities.Add(this.ifElseBranchActivity7);
            this.ifElseActivity4.Activities.Add(this.ifElseBranchActivity8);
            this.ifElseActivity4.Name = "ifElseActivity4";
            // 
            // completeTask_completed2
            // 
            this.completeTask_completed2.CorrelationToken = correlationtoken2;
            this.completeTask_completed2.Name = "completeTask_completed2";
            activitybind9.Name = "SRM5Workflow";
            activitybind9.Path = "createTask_Completion_TaskId1";
            activitybind10.Name = "SRM5Workflow";
            activitybind10.Path = "completeTask_completed2_TaskOutcome1";
            this.completeTask_completed2.MethodInvoking += new System.EventHandler(this.completeTask_completed2_MethodInvoking);
            this.completeTask_completed2.SetBinding(Microsoft.SharePoint.WorkflowActions.CompleteTask.TaskIdProperty, ((System.Workflow.ComponentModel.ActivityBind)(activitybind9)));
            this.completeTask_completed2.SetBinding(Microsoft.SharePoint.WorkflowActions.CompleteTask.TaskOutcomeProperty, ((System.Workflow.ComponentModel.ActivityBind)(activitybind10)));
            // 
            // setState_Completed
            // 
            this.setState_Completed.Name = "setState_Completed";
            this.setState_Completed.TargetStateName = "state_Completed";
            // 
            // codeActivity2
            // 
            this.codeActivity2.Name = "codeActivity2";
            this.codeActivity2.ExecuteCode += new System.EventHandler(this.codeActivity_Approval_DialogChanged);
            // 
            // ifElseActivity2
            // 
            this.ifElseActivity2.Activities.Add(this.ifElseBranchActivity3);
            this.ifElseActivity2.Activities.Add(this.ifElseBranchActivity4);
            this.ifElseActivity2.Name = "ifElseActivity2";
            // 
            // logToHistoryListActivity3
            // 
            this.logToHistoryListActivity3.Duration = System.TimeSpan.Parse("-10675199.02:48:05.4775808");
            this.logToHistoryListActivity3.EventId = Microsoft.SharePoint.Workflow.SPWorkflowHistoryEventType.WorkflowComment;
            this.logToHistoryListActivity3.HistoryDescription = "Request Approved";
            this.logToHistoryListActivity3.HistoryOutcome = "";
            this.logToHistoryListActivity3.Name = "logToHistoryListActivity3";
            this.logToHistoryListActivity3.OtherData = "";
            this.logToHistoryListActivity3.UserId = -1;
            // 
            // completeTask_approval_app
            // 
            this.completeTask_approval_app.CorrelationToken = correlationtoken3;
            this.completeTask_approval_app.Name = "completeTask_approval_app";
            activitybind11.Name = "SRM5Workflow";
            activitybind11.Path = "createTask_Approval_TaskId1";
            activitybind12.Name = "SRM5Workflow";
            activitybind12.Path = "completeTask_approval_app_TaskOutcome1";
            this.completeTask_approval_app.MethodInvoking += new System.EventHandler(this.completeTask_approval_app_MethodInvoking);
            this.completeTask_approval_app.SetBinding(Microsoft.SharePoint.WorkflowActions.CompleteTask.TaskIdProperty, ((System.Workflow.ComponentModel.ActivityBind)(activitybind11)));
            this.completeTask_approval_app.SetBinding(Microsoft.SharePoint.WorkflowActions.CompleteTask.TaskOutcomeProperty, ((System.Workflow.ComponentModel.ActivityBind)(activitybind12)));
            // 
            // setStateActivity2
            // 
            this.setStateActivity2.Name = "setStateActivity2";
            this.setStateActivity2.TargetStateName = "state_Approved";
            // 
            // codeActivity3
            // 
            this.codeActivity3.Name = "codeActivity3";
            this.codeActivity3.ExecuteCode += new System.EventHandler(this.codeActivity3_ExecuteCode);
            // 
            // ifElseBranchActivity10
            // 
            this.ifElseBranchActivity10.Activities.Add(this.ifElseActivity6);
            this.ifElseBranchActivity10.Name = "ifElseBranchActivity10";
            // 
            // ifElseBranchActivity9
            // 
            this.ifElseBranchActivity9.Activities.Add(this.setStateActivity6);
            this.ifElseBranchActivity9.Activities.Add(this.logToHistoryListActivity7);
            this.ifElseBranchActivity9.Activities.Add(this.completaTask_rejected_resub);
            codecondition4.Condition += new System.EventHandler<System.Workflow.Activities.ConditionalEventArgs>(this.onTaskChanged_Rejected_IsTaskResubmitted);
            this.ifElseBranchActivity9.Condition = codecondition4;
            this.ifElseBranchActivity9.Name = "ifElseBranchActivity9";
            // 
            // ifElseBranchActivity6
            // 
            this.ifElseBranchActivity6.Activities.Add(this.ifElseActivity4);
            this.ifElseBranchActivity6.Name = "ifElseBranchActivity6";
            // 
            // ifElseBranchActivity5
            // 
            this.ifElseBranchActivity5.Activities.Add(this.setState_Completed);
            this.ifElseBranchActivity5.Activities.Add(this.completeTask_completed2);
            codecondition5.Condition += new System.EventHandler<System.Workflow.Activities.ConditionalEventArgs>(this.onTaskChanged_Completion_IsTaskComplete);
            this.ifElseBranchActivity5.Condition = codecondition5;
            this.ifElseBranchActivity5.Name = "ifElseBranchActivity5";
            // 
            // ifElseBranchActivity14
            // 
            this.ifElseBranchActivity14.Name = "ifElseBranchActivity14";
            // 
            // ifElseBranchActivity13
            // 
            this.ifElseBranchActivity13.Activities.Add(this.codeActivity2);
            codecondition6.Condition += new System.EventHandler<System.Workflow.Activities.ConditionalEventArgs>(this.onTaskChanged_Approval_HasDialogBeenAdded);
            this.ifElseBranchActivity13.Condition = codecondition6;
            this.ifElseBranchActivity13.Description = "Check weather the Dialog box has been updated ";
            this.ifElseBranchActivity13.Name = "ifElseBranchActivity13";
            // 
            // ifElseBranchActivity2
            // 
            this.ifElseBranchActivity2.Activities.Add(this.ifElseActivity2);
            this.ifElseBranchActivity2.Name = "ifElseBranchActivity2";
            // 
            // ifElseBranchActivity1
            // 
            this.ifElseBranchActivity1.Activities.Add(this.setStateActivity2);
            this.ifElseBranchActivity1.Activities.Add(this.completeTask_approval_app);
            this.ifElseBranchActivity1.Activities.Add(this.logToHistoryListActivity3);
            codecondition7.Condition += new System.EventHandler<System.Workflow.Activities.ConditionalEventArgs>(this.onTaskChanged_Approval_IsTaskApproved);
            this.ifElseBranchActivity1.Condition = codecondition7;
            this.ifElseBranchActivity1.Name = "ifElseBranchActivity1";
            // 
            // ifElseBranchActivity16
            // 
            this.ifElseBranchActivity16.Name = "ifElseBranchActivity16";
            // 
            // ifElseBranchActivity15
            // 
            this.ifElseBranchActivity15.Activities.Add(this.codeActivity3);
            codecondition8.Condition += new System.EventHandler<System.Workflow.Activities.ConditionalEventArgs>(this.AreTherePeople2Alert);
            this.ifElseBranchActivity15.Condition = codecondition8;
            this.ifElseBranchActivity15.Name = "ifElseBranchActivity15";
            // 
            // codeActivity1
            // 
            this.codeActivity1.Name = "codeActivity1";
            this.codeActivity1.ExecuteCode += new System.EventHandler(this.codeActivity1_ExecuteCode);
            // 
            // setStateActivity5
            // 
            this.setStateActivity5.Name = "setStateActivity5";
            this.setStateActivity5.TargetStateName = "state_Closed";
            // 
            // logToHistoryListActivity9
            // 
            this.logToHistoryListActivity9.Duration = System.TimeSpan.Parse("-10675199.02:48:05.4775808");
            this.logToHistoryListActivity9.EventId = Microsoft.SharePoint.Workflow.SPWorkflowHistoryEventType.WorkflowComment;
            this.logToHistoryListActivity9.HistoryDescription = "Request completed and closed";
            this.logToHistoryListActivity9.HistoryOutcome = "";
            this.logToHistoryListActivity9.Name = "logToHistoryListActivity9";
            this.logToHistoryListActivity9.OtherData = "";
            this.logToHistoryListActivity9.UserId = -1;
            // 
            // ifElseActivity5
            // 
            this.ifElseActivity5.Activities.Add(this.ifElseBranchActivity9);
            this.ifElseActivity5.Activities.Add(this.ifElseBranchActivity10);
            this.ifElseActivity5.Name = "ifElseActivity5";
            // 
            // onTaskChanged_Rejected
            // 
            activitybind13.Name = "SRM5Workflow";
            activitybind13.Path = "onTaskChanged_Rejected_AfterProperties1";
            activitybind14.Name = "SRM5Workflow";
            activitybind14.Path = "onTaskChanged_Rejected_BeforeProperties1";
            this.onTaskChanged_Rejected.CorrelationToken = correlationtoken1;
            this.onTaskChanged_Rejected.Executor = null;
            this.onTaskChanged_Rejected.Name = "onTaskChanged_Rejected";
            activitybind15.Name = "SRM5Workflow";
            activitybind15.Path = "createTask_Rejected_TaskId1";
            this.onTaskChanged_Rejected.Invoked += new System.EventHandler<System.Workflow.Activities.ExternalDataEventArgs>(this.onTaskChanged_Rejected_Invoked);
            this.onTaskChanged_Rejected.SetBinding(Microsoft.SharePoint.WorkflowActions.OnTaskChanged.AfterPropertiesProperty, ((System.Workflow.ComponentModel.ActivityBind)(activitybind13)));
            this.onTaskChanged_Rejected.SetBinding(Microsoft.SharePoint.WorkflowActions.OnTaskChanged.BeforePropertiesProperty, ((System.Workflow.ComponentModel.ActivityBind)(activitybind14)));
            this.onTaskChanged_Rejected.SetBinding(Microsoft.SharePoint.WorkflowActions.OnTaskChanged.TaskIdProperty, ((System.Workflow.ComponentModel.ActivityBind)(activitybind15)));
            // 
            // createTask_Rejected
            // 
            this.createTask_Rejected.CorrelationToken = correlationtoken1;
            this.createTask_Rejected.ListItemId = -1;
            this.createTask_Rejected.Name = "createTask_Rejected";
            this.createTask_Rejected.SpecialPermissions = null;
            activitybind16.Name = "SRM5Workflow";
            activitybind16.Path = "createTask_Rejected_TaskId1";
            activitybind17.Name = "SRM5Workflow";
            activitybind17.Path = "createTask_Rejected_TaskProperties1";
            this.createTask_Rejected.MethodInvoking += new System.EventHandler(this.createTask_Rejected_MethodInvoking);
            this.createTask_Rejected.SetBinding(Microsoft.SharePoint.WorkflowActions.CreateTask.TaskIdProperty, ((System.Workflow.ComponentModel.ActivityBind)(activitybind16)));
            this.createTask_Rejected.SetBinding(Microsoft.SharePoint.WorkflowActions.CreateTask.TaskPropertiesProperty, ((System.Workflow.ComponentModel.ActivityBind)(activitybind17)));
            // 
            // logToHistoryListActivity6
            // 
            this.logToHistoryListActivity6.Duration = System.TimeSpan.Parse("-10675199.02:48:05.4775808");
            this.logToHistoryListActivity6.EventId = Microsoft.SharePoint.Workflow.SPWorkflowHistoryEventType.WorkflowComment;
            this.logToHistoryListActivity6.HistoryDescription = "Request rejected task created";
            this.logToHistoryListActivity6.HistoryOutcome = "";
            this.logToHistoryListActivity6.Name = "logToHistoryListActivity6";
            this.logToHistoryListActivity6.OtherData = "";
            this.logToHistoryListActivity6.UserId = -1;
            // 
            // ifElseActivity3
            // 
            this.ifElseActivity3.Activities.Add(this.ifElseBranchActivity5);
            this.ifElseActivity3.Activities.Add(this.ifElseBranchActivity6);
            this.ifElseActivity3.Name = "ifElseActivity3";
            // 
            // onTaskChanged_Completion
            // 
            activitybind18.Name = "SRM5Workflow";
            activitybind18.Path = "onTaskChanged_Completion_AfterProperties1";
            activitybind19.Name = "SRM5Workflow";
            activitybind19.Path = "onTaskChanged_Completion_BeforeProperties1";
            this.onTaskChanged_Completion.CorrelationToken = correlationtoken2;
            this.onTaskChanged_Completion.Executor = null;
            this.onTaskChanged_Completion.Name = "onTaskChanged_Completion";
            activitybind20.Name = "SRM5Workflow";
            activitybind20.Path = "createTask_Completion_TaskId1";
            this.onTaskChanged_Completion.Invoked += new System.EventHandler<System.Workflow.Activities.ExternalDataEventArgs>(this.onTaskChanged_Completion_Invoked);
            this.onTaskChanged_Completion.SetBinding(Microsoft.SharePoint.WorkflowActions.OnTaskChanged.AfterPropertiesProperty, ((System.Workflow.ComponentModel.ActivityBind)(activitybind18)));
            this.onTaskChanged_Completion.SetBinding(Microsoft.SharePoint.WorkflowActions.OnTaskChanged.BeforePropertiesProperty, ((System.Workflow.ComponentModel.ActivityBind)(activitybind19)));
            this.onTaskChanged_Completion.SetBinding(Microsoft.SharePoint.WorkflowActions.OnTaskChanged.TaskIdProperty, ((System.Workflow.ComponentModel.ActivityBind)(activitybind20)));
            // 
            // createTask_Completion
            // 
            this.createTask_Completion.CorrelationToken = correlationtoken2;
            this.createTask_Completion.ListItemId = -1;
            this.createTask_Completion.Name = "createTask_Completion";
            this.createTask_Completion.SpecialPermissions = null;
            activitybind21.Name = "SRM5Workflow";
            activitybind21.Path = "createTask_Completion_TaskId1";
            activitybind22.Name = "SRM5Workflow";
            activitybind22.Path = "createTask_Completion_TaskProperties1";
            this.createTask_Completion.MethodInvoking += new System.EventHandler(this.createTask_Completion_MethodInvoking);
            this.createTask_Completion.SetBinding(Microsoft.SharePoint.WorkflowActions.CreateTask.TaskIdProperty, ((System.Workflow.ComponentModel.ActivityBind)(activitybind21)));
            this.createTask_Completion.SetBinding(Microsoft.SharePoint.WorkflowActions.CreateTask.TaskPropertiesProperty, ((System.Workflow.ComponentModel.ActivityBind)(activitybind22)));
            // 
            // logToHistoryListActivity5
            // 
            this.logToHistoryListActivity5.Duration = System.TimeSpan.Parse("-10675199.02:48:05.4775808");
            this.logToHistoryListActivity5.EventId = Microsoft.SharePoint.Workflow.SPWorkflowHistoryEventType.WorkflowComment;
            this.logToHistoryListActivity5.HistoryDescription = "Work Task Created";
            this.logToHistoryListActivity5.HistoryOutcome = "";
            this.logToHistoryListActivity5.Name = "logToHistoryListActivity5";
            this.logToHistoryListActivity5.OtherData = "";
            this.logToHistoryListActivity5.UserId = -1;
            // 
            // ifElseActivity7
            // 
            this.ifElseActivity7.Activities.Add(this.ifElseBranchActivity13);
            this.ifElseActivity7.Activities.Add(this.ifElseBranchActivity14);
            this.ifElseActivity7.Name = "ifElseActivity7";
            // 
            // ifElseActivity1
            // 
            this.ifElseActivity1.Activities.Add(this.ifElseBranchActivity1);
            this.ifElseActivity1.Activities.Add(this.ifElseBranchActivity2);
            this.ifElseActivity1.Name = "ifElseActivity1";
            // 
            // onTaskChanged_Approval
            // 
            activitybind23.Name = "SRM5Workflow";
            activitybind23.Path = "onTaskChanged_Approval_AfterProperties1";
            activitybind24.Name = "SRM5Workflow";
            activitybind24.Path = "onTaskChanged_Approval_BeforeProperties1";
            this.onTaskChanged_Approval.CorrelationToken = correlationtoken3;
            this.onTaskChanged_Approval.Executor = null;
            this.onTaskChanged_Approval.Name = "onTaskChanged_Approval";
            activitybind25.Name = "SRM5Workflow";
            activitybind25.Path = "createTask_Approval_TaskId1";
            this.onTaskChanged_Approval.Invoked += new System.EventHandler<System.Workflow.Activities.ExternalDataEventArgs>(this.onTaskChanged_Approval_Invoked);
            this.onTaskChanged_Approval.SetBinding(Microsoft.SharePoint.WorkflowActions.OnTaskChanged.TaskIdProperty, ((System.Workflow.ComponentModel.ActivityBind)(activitybind25)));
            this.onTaskChanged_Approval.SetBinding(Microsoft.SharePoint.WorkflowActions.OnTaskChanged.AfterPropertiesProperty, ((System.Workflow.ComponentModel.ActivityBind)(activitybind23)));
            this.onTaskChanged_Approval.SetBinding(Microsoft.SharePoint.WorkflowActions.OnTaskChanged.BeforePropertiesProperty, ((System.Workflow.ComponentModel.ActivityBind)(activitybind24)));
            // 
            // ifElseActivity8
            // 
            this.ifElseActivity8.Activities.Add(this.ifElseBranchActivity15);
            this.ifElseActivity8.Activities.Add(this.ifElseBranchActivity16);
            this.ifElseActivity8.Name = "ifElseActivity8";
            // 
            // createTask_Approval
            // 
            this.createTask_Approval.CorrelationToken = correlationtoken3;
            this.createTask_Approval.ListItemId = -1;
            this.createTask_Approval.Name = "createTask_Approval";
            this.createTask_Approval.SpecialPermissions = null;
            activitybind26.Name = "SRM5Workflow";
            activitybind26.Path = "createTask_Approval_TaskId1";
            activitybind27.Name = "SRM5Workflow";
            activitybind27.Path = "createTask_Approval_TaskProperties1";
            this.createTask_Approval.MethodInvoking += new System.EventHandler(this.createTask_Approval_MethodInvoking);
            this.createTask_Approval.SetBinding(Microsoft.SharePoint.WorkflowActions.CreateTask.TaskIdProperty, ((System.Workflow.ComponentModel.ActivityBind)(activitybind26)));
            this.createTask_Approval.SetBinding(Microsoft.SharePoint.WorkflowActions.CreateTask.TaskPropertiesProperty, ((System.Workflow.ComponentModel.ActivityBind)(activitybind27)));
            // 
            // logToHistoryListActivity2
            // 
            this.logToHistoryListActivity2.Duration = System.TimeSpan.Parse("-10675199.02:48:05.4775808");
            this.logToHistoryListActivity2.EventId = Microsoft.SharePoint.Workflow.SPWorkflowHistoryEventType.WorkflowComment;
            this.logToHistoryListActivity2.HistoryDescription = "Approval Task created";
            this.logToHistoryListActivity2.HistoryOutcome = "";
            this.logToHistoryListActivity2.Name = "logToHistoryListActivity2";
            this.logToHistoryListActivity2.OtherData = "";
            this.logToHistoryListActivity2.UserId = -1;
            // 
            // SetTitle
            // 
            this.SetTitle.Name = "SetTitle";
            this.SetTitle.ExecuteCode += new System.EventHandler(this.codeActivity2_ExecuteCodeSetTitle);
            // 
            // setStateActivity1
            // 
            this.setStateActivity1.Name = "setStateActivity1";
            this.setStateActivity1.TargetStateName = "state_Pending";
            // 
            // logToHistoryListActivity1
            // 
            this.logToHistoryListActivity1.Duration = System.TimeSpan.Parse("-10675199.02:48:05.4775808");
            this.logToHistoryListActivity1.EventId = Microsoft.SharePoint.Workflow.SPWorkflowHistoryEventType.WorkflowComment;
            this.logToHistoryListActivity1.HistoryDescription = "Request Recieved";
            this.logToHistoryListActivity1.HistoryOutcome = "";
            this.logToHistoryListActivity1.Name = "logToHistoryListActivity1";
            this.logToHistoryListActivity1.OtherData = "";
            this.logToHistoryListActivity1.UserId = -1;
            // 
            // onWorkflowActivated1
            // 
            correlationtoken4.Name = "workflowToken";
            correlationtoken4.OwnerActivityName = "SRM5Workflow";
            this.onWorkflowActivated1.CorrelationToken = correlationtoken4;
            this.onWorkflowActivated1.EventName = "OnWorkflowActivated";
            this.onWorkflowActivated1.Name = "onWorkflowActivated1";
            activitybind28.Name = "SRM5Workflow";
            activitybind28.Path = "workflowProperties";
            this.onWorkflowActivated1.SetBinding(Microsoft.SharePoint.WorkflowActions.OnWorkflowActivated.WorkflowPropertiesProperty, ((System.Workflow.ComponentModel.ActivityBind)(activitybind28)));
            // 
            // stateFinalizationActivity1
            // 
            this.stateFinalizationActivity1.Activities.Add(this.codeActivity1);
            this.stateFinalizationActivity1.Name = "stateFinalizationActivity1";
            // 
            // stateInitializationActivity3
            // 
            this.stateInitializationActivity3.Activities.Add(this.logToHistoryListActivity9);
            this.stateInitializationActivity3.Activities.Add(this.setStateActivity5);
            this.stateInitializationActivity3.Name = "stateInitializationActivity3";
            // 
            // eventDrivenActivity4
            // 
            this.eventDrivenActivity4.Activities.Add(this.onTaskChanged_Rejected);
            this.eventDrivenActivity4.Activities.Add(this.ifElseActivity5);
            this.eventDrivenActivity4.Name = "eventDrivenActivity4";
            // 
            // stateInitializationActivity4
            // 
            this.stateInitializationActivity4.Activities.Add(this.logToHistoryListActivity6);
            this.stateInitializationActivity4.Activities.Add(this.createTask_Rejected);
            this.stateInitializationActivity4.Name = "stateInitializationActivity4";
            // 
            // eventDrivenActivity3
            // 
            this.eventDrivenActivity3.Activities.Add(this.onTaskChanged_Completion);
            this.eventDrivenActivity3.Activities.Add(this.ifElseActivity3);
            this.eventDrivenActivity3.Name = "eventDrivenActivity3";
            // 
            // stateInitializationActivity2
            // 
            this.stateInitializationActivity2.Activities.Add(this.logToHistoryListActivity5);
            this.stateInitializationActivity2.Activities.Add(this.createTask_Completion);
            this.stateInitializationActivity2.Name = "stateInitializationActivity2";
            // 
            // stateFinalizationActivity2
            // 
            this.stateFinalizationActivity2.Name = "stateFinalizationActivity2";
            // 
            // eventDrivenActivity2
            // 
            this.eventDrivenActivity2.Activities.Add(this.onTaskChanged_Approval);
            this.eventDrivenActivity2.Activities.Add(this.ifElseActivity1);
            this.eventDrivenActivity2.Activities.Add(this.ifElseActivity7);
            this.eventDrivenActivity2.Name = "eventDrivenActivity2";
            // 
            // stateInitializationActivity1
            // 
            this.stateInitializationActivity1.Activities.Add(this.logToHistoryListActivity2);
            this.stateInitializationActivity1.Activities.Add(this.createTask_Approval);
            this.stateInitializationActivity1.Activities.Add(this.ifElseActivity8);
            this.stateInitializationActivity1.Name = "stateInitializationActivity1";
            // 
            // eventDrivenActivity1
            // 
            this.eventDrivenActivity1.Activities.Add(this.onWorkflowActivated1);
            this.eventDrivenActivity1.Activities.Add(this.logToHistoryListActivity1);
            this.eventDrivenActivity1.Activities.Add(this.setStateActivity1);
            this.eventDrivenActivity1.Activities.Add(this.SetTitle);
            this.eventDrivenActivity1.Name = "eventDrivenActivity1";
            // 
            // state_Closed
            // 
            this.state_Closed.Name = "state_Closed";
            // 
            // state_Completed
            // 
            this.state_Completed.Activities.Add(this.stateInitializationActivity3);
            this.state_Completed.Activities.Add(this.stateFinalizationActivity1);
            this.state_Completed.Name = "state_Completed";
            // 
            // state_Rejected
            // 
            this.state_Rejected.Activities.Add(this.stateInitializationActivity4);
            this.state_Rejected.Activities.Add(this.eventDrivenActivity4);
            this.state_Rejected.Name = "state_Rejected";
            // 
            // state_Approved
            // 
            this.state_Approved.Activities.Add(this.stateInitializationActivity2);
            this.state_Approved.Activities.Add(this.eventDrivenActivity3);
            this.state_Approved.Name = "state_Approved";
            // 
            // state_Pending
            // 
            this.state_Pending.Activities.Add(this.stateInitializationActivity1);
            this.state_Pending.Activities.Add(this.eventDrivenActivity2);
            this.state_Pending.Activities.Add(this.stateFinalizationActivity2);
            this.state_Pending.Name = "state_Pending";
            // 
            // Workflow1InitialState
            // 
            this.Workflow1InitialState.Activities.Add(this.eventDrivenActivity1);
            this.Workflow1InitialState.Name = "Workflow1InitialState";
            // 
            // SRM5Workflow
            // 
            this.Activities.Add(this.Workflow1InitialState);
            this.Activities.Add(this.state_Pending);
            this.Activities.Add(this.state_Approved);
            this.Activities.Add(this.state_Rejected);
            this.Activities.Add(this.state_Completed);
            this.Activities.Add(this.state_Closed);
            this.CompletedStateName = "state_Closed";
            this.DynamicUpdateCondition = null;
            this.InitialStateName = "Workflow1InitialState";
            this.Name = "SRM5Workflow";
            this.CanModifyActivities = false;

        }

        #endregion

        private CodeActivity codeActivity3;
        private IfElseBranchActivity ifElseBranchActivity16;
        private IfElseBranchActivity ifElseBranchActivity15;
        private IfElseActivity ifElseActivity8;
        private CodeActivity codeActivity2;
        private IfElseBranchActivity ifElseBranchActivity14;
        private IfElseBranchActivity ifElseBranchActivity13;
        private IfElseActivity ifElseActivity7;
        private CodeActivity SetTitle;
        private StateFinalizationActivity stateFinalizationActivity2;
        private Microsoft.SharePoint.WorkflowActions.CompleteTask completaTask_rejected_resub;
        private Microsoft.SharePoint.WorkflowActions.CompleteTask completeTask_rejected_closed;
        private Microsoft.SharePoint.WorkflowActions.CompleteTask completeTask_completed_rej;
        private Microsoft.SharePoint.WorkflowActions.CompleteTask completeTask_completed2;
        private Microsoft.SharePoint.WorkflowActions.LogToHistoryListActivity logToHistoryListActivity8;
        private Microsoft.SharePoint.WorkflowActions.LogToHistoryListActivity logToHistoryListActivity7;
        private Microsoft.SharePoint.WorkflowActions.LogToHistoryListActivity logToHistoryListActivity9;
        private StateFinalizationActivity stateFinalizationActivity1;
        private CodeActivity codeActivity1;
        private SetStateActivity setStateActivity7;
        private IfElseBranchActivity ifElseBranchActivity12;
        private IfElseBranchActivity ifElseBranchActivity11;
        private IfElseActivity ifElseActivity6;
        private SetStateActivity setStateActivity6;
        private IfElseBranchActivity ifElseBranchActivity10;
        private IfElseBranchActivity ifElseBranchActivity9;
        private IfElseActivity ifElseActivity5;
        private Microsoft.SharePoint.WorkflowActions.OnTaskChanged onTaskChanged_Rejected;
        private EventDrivenActivity eventDrivenActivity4;
        private Microsoft.SharePoint.WorkflowActions.CreateTask createTask_Rejected;
        private Microsoft.SharePoint.WorkflowActions.LogToHistoryListActivity logToHistoryListActivity6;
        private StateInitializationActivity stateInitializationActivity4;
        private SetStateActivity setStateActivity4;
        private IfElseBranchActivity ifElseBranchActivity8;
        private IfElseBranchActivity ifElseBranchActivity7;
        private IfElseActivity ifElseActivity4;
        private SetStateActivity setState_Completed;
        private IfElseBranchActivity ifElseBranchActivity6;
        private IfElseBranchActivity ifElseBranchActivity5;
        private IfElseActivity ifElseActivity3;
        private SetStateActivity setStateActivity5;
        private StateInitializationActivity stateInitializationActivity3;
        private Microsoft.SharePoint.WorkflowActions.OnTaskChanged onTaskChanged_Completion;
        private EventDrivenActivity eventDrivenActivity3;
        private SetStateActivity setStateActivity3;
        private IfElseBranchActivity ifElseBranchActivity4;
        private IfElseBranchActivity ifElseBranchActivity3;
        private IfElseActivity ifElseActivity2;
        private SetStateActivity setStateActivity2;
        private IfElseBranchActivity ifElseBranchActivity2;
        private IfElseBranchActivity ifElseBranchActivity1;
        private IfElseActivity ifElseActivity1;
        private Microsoft.SharePoint.WorkflowActions.CompleteTask completeTask_approval_app;
        private Microsoft.SharePoint.WorkflowActions.CompleteTask completeTask_approval_rej;
        private Microsoft.SharePoint.WorkflowActions.LogToHistoryListActivity logToHistoryListActivity4;
        private Microsoft.SharePoint.WorkflowActions.LogToHistoryListActivity logToHistoryListActivity3;
        private Microsoft.SharePoint.WorkflowActions.CreateTask createTask_Completion;
        private Microsoft.SharePoint.WorkflowActions.LogToHistoryListActivity logToHistoryListActivity5;
        private StateInitializationActivity stateInitializationActivity2;
        private Microsoft.SharePoint.WorkflowActions.OnTaskChanged onTaskChanged_Approval;
        private EventDrivenActivity eventDrivenActivity2;
        private Microsoft.SharePoint.WorkflowActions.LogToHistoryListActivity logToHistoryListActivity2;
        private SetStateActivity setStateActivity1;
        private Microsoft.SharePoint.WorkflowActions.LogToHistoryListActivity logToHistoryListActivity1;
        private StateInitializationActivity stateInitializationActivity1;
        private StateActivity state_Closed;
        private StateActivity state_Completed;
        private StateActivity state_Rejected;
        private StateActivity state_Approved;
        private StateActivity state_Pending;
        private Microsoft.SharePoint.WorkflowActions.CreateTask createTask_Approval;
        private Microsoft.SharePoint.WorkflowActions.OnWorkflowActivated onWorkflowActivated1;
        private EventDrivenActivity eventDrivenActivity1;
        private StateActivity Workflow1InitialState;





































































































































































    }
}
