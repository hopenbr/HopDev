﻿// The following code was generated by Microsoft Visual Studio 2005.
// The test owner should check each test for validity.
using Microsoft.VisualStudio.TestTools.UnitTesting;
using System;
using System.Text;
using System.Collections.Generic;
using TFSEventServicesTester.WorkItemChangeEndpoint;
namespace TFSEventServicesTester
{
    
    /// <summary>
    ///This is a test class for TFSEventServicesTester.WorkItemChangeEndpoint.WorkItemChangedEndpoint and is intended
    ///to contain all TFSEventServicesTester.WorkItemChangeEndpoint.WorkItemChangedEndpoint Unit Tests
    ///</summary>
    [TestClass()]
    public class WorkItemChangedEndpointTest
    {
        private string _tfsIDxml = "<TeamFoundationServer url=\"http://AS73TFS01:8080\" />";

        private TestContext testContextInstance;

        /// <summary>
        ///Gets or sets the test context which provides
        ///information about and functionality for the current test run.
        ///</summary>
        public TestContext TestContext
        {
            get
            {
                return testContextInstance;
            }
            set
            {
                testContextInstance = value;
            }
        }
        #region Additional test attributes
        // 
        //You can use the following additional attributes as you write your tests:
        //
        //Use ClassInitialize to run code before running the first test in the class
        //
        //[ClassInitialize()]
        //public static void MyClassInitialize(TestContext testContext)
        //{
        //}
        //
        //Use ClassCleanup to run code after all tests in a class have run
        //
        //[ClassCleanup()]
        //public static void MyClassCleanup()
        //{
        //}
        //
        //Use TestInitialize to run code before running each test
        //
        //[TestInitialize()]
        //public void MyTestInitialize()
        //{
        //}
        //
        //Use TestCleanup to run code after each test has run
        //
        //[TestCleanup()]
        //public void MyTestCleanup()
        //{
        //}
        //
        #endregion


        /// <summary>
        ///A test for Notify (string, string)
        ///</summary>
        [TestMethod()]
        public void DBIApproved2Deployed()
        {
            WorkItemChangedEndpoint target = new WorkItemChangedEndpoint(); // TODO: Use [AspNetDevelopmentServer] and TryUrlRedirection() to auto launch and bind web service.

            string eventXml = "<?xml version=\"1.0\" encoding=\"utf-16\"?><WorkItemChangedEvent xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\"><PortfolioProject>ITProjectPortal</PortfolioProject><ProjectNodeId>55f42118-7fd8-4423-aae7-512e1b798400</ProjectNodeId><AreaPath>\\ITProjectPortal\\DBI\\Deployment</AreaPath><Title>ITProjectPortal Work Item Changed: Deployment Backlog Item 11105 - Next test of new backend 5</Title><WorkItemTitle>Next test of new backend 5</WorkItemTitle><Subscriber>CORP\\BHOPENW</Subscriber><ChangerSid>S-1-5-21-220523388-861567501-725345543-36107</ChangerSid><DisplayUrl>http://as73tfs01:8080/WorkItemTracking/WorkItem.aspx?artifactMoniker=11105</DisplayUrl><TimeZone>Eastern Daylight Time</TimeZone><TimeZoneOffset>-04:00:00</TimeZoneOffset><ChangeType>Change</ChangeType><CoreFields><IntegerFields><Field><Name>ID</Name><ReferenceName>System.Id</ReferenceName><OldValue>11105</OldValue><NewValue>11105</NewValue></Field><Field><Name>Rev</Name><ReferenceName>System.Rev</ReferenceName><OldValue>4</OldValue><NewValue>5</NewValue></Field><Field><Name>AreaID</Name><ReferenceName>System.AreaId</ReferenceName><OldValue>174</OldValue><NewValue>174</NewValue></Field></IntegerFields><StringFields><Field><Name>Work Item Type</Name><ReferenceName>System.WorkItemType</ReferenceName><OldValue>Deployment Backlog Item</OldValue><NewValue>Deployment Backlog Item</NewValue></Field><Field><Name>Title</Name><ReferenceName>System.Title</ReferenceName><OldValue>Next test of new backend 5</OldValue><NewValue>Next test of new backend 5</NewValue></Field><Field><Name>Area Path</Name><ReferenceName>System.AreaPath</ReferenceName><OldValue>\\ITProjectPortal\\DBI\\Deployment</OldValue><NewValue>\\ITProjectPortal\\DBI\\Deployment</NewValue></Field><Field><Name>State</Name><ReferenceName>System.State</ReferenceName><OldValue>Approved for Deployment</OldValue><NewValue>Deployed</NewValue></Field><Field><Name>Reason</Name><ReferenceName>System.Reason</ReferenceName><OldValue>The package was approved by the team led for deployment</OldValue><NewValue>The Build package was deployed to the Target Environment</NewValue></Field><Field><Name>Assigned To</Name><ReferenceName>System.AssignedTo</ReferenceName><OldValue>webMethods Group</OldValue><NewValue>webMethods Group</NewValue></Field><Field><Name>Changed By</Name><ReferenceName>System.ChangedBy</ReferenceName><OldValue>TFSBUILD</OldValue><NewValue>Hopenwasser, Brian</NewValue></Field><Field><Name>Created By</Name><ReferenceName>System.CreatedBy</ReferenceName><OldValue>Hopenwasser, Brian</OldValue><NewValue>Hopenwasser, Brian</NewValue></Field><Field><Name>Changed Date</Name><ReferenceName>System.ChangedDate</ReferenceName><OldValue>3/24/2008 5:53:36 PM</OldValue><NewValue>3/25/2008 2:20:41 PM</NewValue></Field><Field><Name>Created Date</Name><ReferenceName>System.CreatedDate</ReferenceName><OldValue>3/24/2008 5:50:58 PM</OldValue><NewValue>3/24/2008 5:50:58 PM</NewValue></Field><Field><Name>Authorized As</Name><ReferenceName>System.AuthorizedAs</ReferenceName><OldValue>TFSBUILD</OldValue><NewValue>Hopenwasser, Brian</NewValue></Field><Field><Name>Iteration Path</Name><ReferenceName>System.IterationPath</ReferenceName><OldValue>\\ITProjectPortal</OldValue><NewValue>\\ITProjectPortal</NewValue></Field></StringFields></CoreFields><ChangedFields><IntegerFields /><StringFields><Field><Name>Changed By</Name><ReferenceName>System.ChangedBy</ReferenceName><OldValue>TFSBUILD</OldValue><NewValue>Hopenwasser, Brian</NewValue></Field><Field><Name>State</Name><ReferenceName>System.State</ReferenceName><OldValue>Approved for Deployment</OldValue><NewValue>Deployed</NewValue></Field><Field><Name>Reason</Name><ReferenceName>System.Reason</ReferenceName><OldValue>The package was approved by the team led for deployment</OldValue><NewValue>The Build package was deployed to the Target Environment</NewValue></Field><Field><Name>HIC Last Changed By</Name><ReferenceName>HIC.LastChangedBy</ReferenceName><OldValue>TFSBUILD</OldValue><NewValue>Hopenwasser, Brian</NewValue></Field></StringFields></ChangedFields></WorkItemChangedEvent>";

            string tfsIdentityXml = _tfsIDxml; 

            try
            {
                target.Notify(eventXml, tfsIdentityXml);
            }
            catch (Exception _ex)
            {
                Assert.Fail(_ex.Message);
            }

        }

        /// <summary>
        ///A test for Notify (string, string)
        /// The is a new submission of a webMethods DBI with multiple build numbers/packages attached 
        ///</summary>
        [TestMethod()]
        public void Submit_wM_MultipleBN()
        {
            WorkItemChangedEndpoint target = new WorkItemChangedEndpoint(); // TODO: Use [AspNetDevelopmentServer] and TryUrlRedirection() to auto launch and bind web service.

            string eventXml = "<?xml version=\"1.0\" encoding=\"utf-16\"?><WorkItemChangedEvent xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\"><PortfolioProject>ITProjectPortal</PortfolioProject><ProjectNodeId>55f42118-7fd8-4423-aae7-512e1b798400</ProjectNodeId><AreaPath>\\ITProjectPortal\\DBI\\Closed</AreaPath><Title>ITProjectPortal Work Item Created: Deployment Backlog Item 11099 - Next test of new backend 4</Title><WorkItemTitle>Next test of new backend 4</WorkItemTitle><Subscriber>CORP\\BHOPENW</Subscriber><ChangerSid>S-1-5-21-220523388-861567501-725345543-36107</ChangerSid><DisplayUrl>http://as73tfs01:8080/WorkItemTracking/WorkItem.aspx?artifactMoniker=11099</DisplayUrl><TimeZone>Eastern Daylight Time</TimeZone><TimeZoneOffset>-04:00:00</TimeZoneOffset><ChangeType>New</ChangeType><CoreFields><IntegerFields><Field><Name>ID</Name><ReferenceName>System.Id</ReferenceName><OldValue>0</OldValue><NewValue>11099</NewValue></Field><Field><Name>Rev</Name><ReferenceName>System.Rev</ReferenceName><OldValue>0</OldValue><NewValue>1</NewValue></Field><Field><Name>AreaID</Name><ReferenceName>System.AreaId</ReferenceName><OldValue>0</OldValue><NewValue>170</NewValue></Field></IntegerFields><StringFields><Field><Name>Work Item Type</Name><ReferenceName>System.WorkItemType</ReferenceName><OldValue /><NewValue>Deployment Backlog Item</NewValue></Field><Field><Name>Title</Name><ReferenceName>System.Title</ReferenceName><OldValue /><NewValue>Next test of new backend 4</NewValue></Field><Field><Name>Area Path</Name><ReferenceName>System.AreaPath</ReferenceName><OldValue /><NewValue>\\ITProjectPortal\\DBI\\Closed</NewValue></Field><Field><Name>State</Name><ReferenceName>System.State</ReferenceName><OldValue /><NewValue>Not Done</NewValue></Field><Field><Name>Reason</Name><ReferenceName>System.Reason</ReferenceName><OldValue /><NewValue>New</NewValue></Field><Field><Name>Assigned To</Name><ReferenceName>System.AssignedTo</ReferenceName><OldValue /><NewValue>webMethods Group</NewValue></Field><Field><Name>Changed By</Name><ReferenceName>System.ChangedBy</ReferenceName><OldValue /><NewValue>Hopenwasser, Brian</NewValue></Field><Field><Name>Created By</Name><ReferenceName>System.CreatedBy</ReferenceName><OldValue /><NewValue>Hopenwasser, Brian</NewValue></Field><Field><Name>Changed Date</Name><ReferenceName>System.ChangedDate</ReferenceName><OldValue /><NewValue>3/24/2008 3:12:36 PM</NewValue></Field><Field><Name>Created Date</Name><ReferenceName>System.CreatedDate</ReferenceName><OldValue /><NewValue>3/24/2008 3:12:36 PM</NewValue></Field><Field><Name>Authorized As</Name><ReferenceName>System.AuthorizedAs</ReferenceName><OldValue /><NewValue>Hopenwasser, Brian</NewValue></Field><Field><Name>Iteration Path</Name><ReferenceName>System.IterationPath</ReferenceName><OldValue /><NewValue>\\ITProjectPortal</NewValue></Field></StringFields></CoreFields><TextFields><TextField><Name>History</Name><ReferenceName>System.History</ReferenceName><Value>&lt;div contenteditable=false&gt;&lt;a class=ShowHist id=cpd1e22e50-2dde-4a13-9891-42bcf3130033a href=\"?cpd1e22e50-2dde-4a13-9891-42bcf3130033\"&gt;&lt;img id=cpd1e22e50-2dde-4a13-9891-42bcf3130033i border=0 width=9 height=9 style=\"cursor:hand;\" align=middle src=\"b2.bmp\" src2=\"b1.bmp\"&gt;&amp;nbsp;Copied from work item 11094&lt;/a&gt;&lt;span id=cpd1e22e50-2dde-4a13-9891-42bcf3130033 style=\"display:none;\"&gt;&lt;br&gt;&lt;table class=Hist border=1 width=90%&gt;&lt;tr&gt;&lt;td class=HdrCell width=20% valign=top align=left&gt;3/24/2008 3:51:57 PM&lt;/td&gt;&lt;td class=HdrCell width=80% valign=top align=left&gt;Created by Hopenwasser, Brian&lt;/td&gt;&lt;/tr&gt;&lt;tr&gt;&lt;td colspan=2 class=DataCell&gt;&lt;div contenteditable=false&gt;&lt;a class=ShowHist id=cpe56966ac-3269-4317-b3f8-b3126212c111a href=\"?cpe56966ac-3269-4317-b3f8-b3126212c111\"&gt;&lt;img id=cpe56966ac-3269-4317-b3f8-b3126212c111i border=0 width=9 height=9 style=\"cursor:hand;\" align=middle src=\"b2.bmp\" src2=\"b1.bmp\"&gt;&amp;nbsp;Copied from work item 11091&lt;/a&gt;&lt;span id=cpe56966ac-3269-4317-b3f8-b3126212c111 style=\"display:none;\"&gt;&lt;br&gt;&lt;table class=Hist border=1 width=90%&gt;&lt;tr&gt;&lt;td class=HdrCell width=20% valign=top align=left&gt;3/24/2008 2:55:40 PM&lt;/td&gt;&lt;td class=HdrCell width=80% valign=top align=left&gt;Created by Hopenwasser, Brian&lt;/td&gt;&lt;/tr&gt;&lt;tr&gt;&lt;td class=HdrCell width=20% valign=top align=left&gt;3/24/2008 2:56:33 PM&lt;/td&gt;&lt;td class=HdrCell width=80% valign=top align=left&gt;Edited by TFSBUILD&lt;/td&gt;&lt;/tr&gt;&lt;tr&gt;&lt;td class=HdrCell width=20% valign=top align=left&gt;3/24/2008 2:56:57 PM&lt;/td&gt;&lt;td class=HdrCell width=80% valign=top align=left&gt;Edited by TFSBUILD&lt;/td&gt;&lt;/tr&gt;&lt;/table&gt;&lt;/span&gt;&lt;/div&gt;&lt;/td&gt;&lt;/tr&gt;&lt;tr&gt;&lt;td class=HdrCell width=20% valign=top align=left&gt;3/24/2008 3:53:06 PM&lt;/td&gt;&lt;td class=HdrCell width=80% valign=top align=left&gt;Edited by TFSBUILD&lt;/td&gt;&lt;/tr&gt;&lt;tr&gt;&lt;td class=HdrCell width=20% valign=top align=left&gt;3/24/2008 3:56:46 PM&lt;/td&gt;&lt;td class=HdrCell width=80% valign=top align=left&gt;Edited (Not Done to Approved for Deployment) by Hopenwasser, Brian&lt;/td&gt;&lt;/tr&gt;&lt;tr&gt;&lt;td class=HdrCell width=20% valign=top align=left&gt;3/24/2008 3:57:19 PM&lt;/td&gt;&lt;td class=HdrCell width=80% valign=top align=left&gt;Edited by TFSBUILD&lt;/td&gt;&lt;/tr&gt;&lt;tr&gt;&lt;td class=HdrCell width=20% valign=top align=left&gt;3/24/2008 6:12:00 PM&lt;/td&gt;&lt;td class=HdrCell width=80% valign=top align=left&gt;Edited (Approved for Deployment to Deployed) by Hopenwasser, Brian&lt;/td&gt;&lt;/tr&gt;&lt;tr&gt;&lt;td class=HdrCell width=20% valign=top align=left&gt;3/24/2008 6:13:05 PM&lt;/td&gt;&lt;td class=HdrCell width=80% valign=top align=left&gt;Edited by TFSBUILD&lt;/td&gt;&lt;/tr&gt;&lt;/table&gt;&lt;/span&gt;&lt;/div&gt;</Value></TextField></TextFields><ChangedFields><IntegerFields><Field><Name>AreaID</Name><ReferenceName>System.AreaId</ReferenceName><OldValue>0</OldValue><NewValue>170</NewValue></Field><Field><Name>IterationID</Name><ReferenceName>System.IterationId</ReferenceName><OldValue>0</OldValue><NewValue>32</NewValue></Field><Field><Name>HIc Fields Lock</Name><ReferenceName>HIC.Fields.Lock</ReferenceName><OldValue>0</OldValue><NewValue>1</NewValue></Field><Field><Name>HIC Auto Fill Count</Name><ReferenceName>HIC.Auto.Fill.Count</ReferenceName><OldValue>0</OldValue><NewValue>11094</NewValue></Field></IntegerFields><StringFields><Field><Name>Assigned To</Name><ReferenceName>System.AssignedTo</ReferenceName><OldValue /><NewValue>webMethods Group</NewValue></Field><Field><Name>Created Date</Name><ReferenceName>System.CreatedDate</ReferenceName><OldValue /><NewValue>3/24/2008 3:12:36 PM</NewValue></Field><Field><Name>Created By</Name><ReferenceName>System.CreatedBy</ReferenceName><OldValue /><NewValue>Hopenwasser, Brian</NewValue></Field><Field><Name>Changed By</Name><ReferenceName>System.ChangedBy</ReferenceName><OldValue /><NewValue>Hopenwasser, Brian</NewValue></Field><Field><Name>Title</Name><ReferenceName>System.Title</ReferenceName><OldValue /><NewValue>Next test of new backend 4</NewValue></Field><Field><Name>State</Name><ReferenceName>System.State</ReferenceName><OldValue /><NewValue>Not Done</NewValue></Field><Field><Name>Reason</Name><ReferenceName>System.Reason</ReferenceName><OldValue /><NewValue>New</NewValue></Field><Field><Name>Work Item Type</Name><ReferenceName>System.WorkItemType</ReferenceName><OldValue /><NewValue>Deployment Backlog Item</NewValue></Field><Field><Name>Audit</Name><ReferenceName>Conchango.VSTS.Scrum.Audit</ReferenceName><OldValue /><NewValue>0</NewValue></Field><Field><Name>New Test Environment</Name><ReferenceName>HIC.Test.Environment.New</ReferenceName><OldValue /><NewValue>End2End</NewValue></Field><Field><Name>Deployment Date</Name><ReferenceName>HIC.Deploy.Date</ReferenceName><OldValue /><NewValue>3/24/2008 10:53:37 AM</NewValue></Field><Field><Name>Build Number</Name><ReferenceName>HIC.Build.Number</ReferenceName><OldValue /><NewValue>Agency.webMethods-1.0.0.8</NewValue></Field><Field><Name>Dependency</Name><ReferenceName>HIC.Dependency</ReferenceName><OldValue /><NewValue>No</NewValue></Field><Field><Name>HIC Project</Name><ReferenceName>HIC.Project</ReferenceName><OldValue /><NewValue>IntegratedServices</NewValue></Field><Field><Name>Deployment Type</Name><ReferenceName>HIC.Deployment.Type</ReferenceName><OldValue /><NewValue>webMethods</NewValue></Field><Field><Name>HIC Deployment Priority</Name><ReferenceName>HIC.Deployment.Priority</ReferenceName><OldValue /><NewValue>1 - Normal</NewValue></Field><Field><Name>HIC Last Changed By</Name><ReferenceName>HIC.LastChangedBy</ReferenceName><OldValue /><NewValue>Hopenwasser, Brian</NewValue></Field><Field><Name>HIC TR defect Numbers</Name><ReferenceName>HIC.TR.DefectNumbers</ReferenceName><OldValue /><NewValue>163</NewValue></Field><Field><Name>HIC Deployment Approver</Name><ReferenceName>HIC.Deployment.Approver</ReferenceName><OldValue /><NewValue>Hopenwasser, Brian</NewValue></Field><Field><Name>HIC Deployment Impact</Name><ReferenceName>HIC.Deployment.Impact</ReferenceName><OldValue /><NewValue>None</NewValue></Field><Field><Name>HIC Deployment Time</Name><ReferenceName>HIC.Deployment.Time</ReferenceName><OldValue /><NewValue>3 pm</NewValue></Field><Field><Name>HIC Test Environment Structure</Name><ReferenceName>HIC.Test.Envrionment.Structure</ReferenceName><OldValue /><NewValue>Access Harleysville</NewValue></Field><Field><Name>HIC Deployment Package Type</Name><ReferenceName>HIC.Deployment.Package.Type</ReferenceName><OldValue /><NewValue>Full</NewValue></Field><Field><Name>HIC Build Package2</Name><ReferenceName>HIC.Build.Package2</ReferenceName><OldValue /><NewValue>CL.Hotfix.webMethods-1.2.1.1</NewValue></Field><Field><Name>HIC Build Package3</Name><ReferenceName>HIC.Build.Package3</ReferenceName><OldValue /><NewValue>CL.IntegratedServices.webMethods-1.3.0.4</NewValue></Field><Field><Name>HIC Build Numbers</Name><ReferenceName>HIC.Build.Numbers</ReferenceName><OldValue /><NewValue>Agency.webMethods-1.0.0.8,CL.Hotfix.webMethods-1.2.1.1,CL.IntegratedServices.webMethods-1.3.0.4</NewValue></Field></StringFields></ChangedFields></WorkItemChangedEvent>";

            string tfsIdentityXml = _tfsIDxml;

            try
            {
                target.Notify(eventXml, tfsIdentityXml);
            }
            catch (Exception _ex)
            {
                Assert.Fail(_ex.Message);
            }

        }

    }


}