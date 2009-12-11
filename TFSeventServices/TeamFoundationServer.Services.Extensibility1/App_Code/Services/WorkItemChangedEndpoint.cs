#region Directives
using System;
using System.Web.Services;
using System.Web.Services.Protocols;
using System.IO;
using System.Text;
using System.Collections.Generic;
using Harleysville.TFSEventServices;
using System.Configuration;
using System.Threading;
#endregion

/// <summary>
/// Web Service Endpoint for the <see cref="WorkItemChangedEvent"/>
/// </summary>
/// <remarks>
/// To Register this Notification Endpoint you will need to use the <see cref="http://blogs.msdn.com/psheill/archive/2006/02/01/522386.aspx">BisSubscribe.exe</see> tool. 
/// For more information about Team Foundation Server Notifications <see cref="http://blogs.msdn.com/buckh/archive/2006/04/10/event_filtering.aspx"/>
/// </remarks>
[WebService(Namespace = "http://schemas.conchango.com/TeamFoundation/2005/06/Services/Notification/Extensibility", Description = "")]
[WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
public class WorkItemChangedEndpoint : TeamFoundationServer.Services.Extensibility1.EndpointBase
{
    private int _notifyRunCount = 0;

    /// <summary>
    /// Endpoint required to accept incoming <see cref="WorkItemChangedEvent"/> notifications
    /// </summary>
    /// <param name="eventXml">Serialized version of the <see cref="WorkItemChangedEvent"/></param>
    /// <param name="tfsIdentityXml">Serialized version of <see cref="TFSIdentity"/></param>
    [WebMethod]
    [SoapDocumentMethod("http://schemas.microsoft.com/TeamFoundation/2005/06/Services/Notification/03/Notify", RequestNamespace = "http://schemas.microsoft.com/TeamFoundation/2005/06/Services/Notification/03")]
    public void Notify(string eventXml, string tfsIdentityXml)
    {
        WorkItemChangedEvent workItemChangedEvent = this.CreateInstance<WorkItemChangedEvent>(eventXml);
        TFSIdentity tfsIdentity = this.CreateInstance<TFSIdentity>(tfsIdentityXml);

        Thread.Sleep(Convert.ToInt32(ConfigurationManager.AppSettings.Get("SleepTime")));
           //Need to wait when in PRD b/c 
           //this gives the user some time to make quick changes
        

        //double try is b/c Debug Mailer method is not avaiable until Factory is complete
        try
        {
            HarleysvilleWorkItemAlertsFactory _factory = new HarleysvilleWorkItemAlertsFactory();
            IHarleysvilleWorkItemAlerts _Iha = _factory.GetWorkItem(workItemChangedEvent, tfsIdentity);

            try
            {
                if (ConfigurationManager.AppSettings.Get("DebugMode").Equals("on", StringComparison.CurrentCultureIgnoreCase))
                {
                    WriteLog(eventXml + Environment.NewLine + tfsIdentityXml);
                }

                _notifyRunCount++;
                _Iha.WorkItemActions();
            }
            catch (Microsoft.TeamFoundation.WorkItemTracking.Client.ItemAlreadyUpdatedOnServerException _quickSave)
            {
                // fix for the quick save bug
                if (_notifyRunCount > 4)
                {
                    _notifyRunCount++;
                    this.Notify(eventXml, tfsIdentityXml);
                }
                else
                {
                     this.Catcher((Exception)_quickSave, _Iha, workItemChangedEvent);
                }
                    
            }
            catch (Exception ex)
            {
                this.Catcher(ex, _Iha, workItemChangedEvent);
            }
        }
        catch (Exception ex)
        {
            this.Catcher(ex, workItemChangedEvent);
        }
        
    }

    private void Catcher(Exception ex, IHarleysvilleWorkItemAlerts _Iha, WorkItemChangedEvent _wice)
    {
        //WriteLog(ex.ToString());
        StringBuilder _sb = new StringBuilder();

        _sb.AppendLine(ex.ToString())
            .AppendLine()
            .AppendLine("Below is URL to Work item: ")
            .AppendLine(_wice.DisplayUrl);

        _Iha.DebugMailer(ConfigurationManager.AppSettings.Get("DebugEmailSubject"), _sb.ToString());

        WriteErrorLog(_sb.ToString());

        if (ConfigurationManager.AppSettings.Get("DebugMode").Equals("on", StringComparison.CurrentCultureIgnoreCase))
        {
            WriteLog(_sb.ToString());
        }

    }

    private void Catcher(Exception ex, WorkItemChangedEvent _wice)
    {
        WriteErrorLog("ERROR: " + ex.ToString() + "\n" + _wice.DisplayUrl);
    }

    static void WriteLog(string log)
    {
        
        FileInfo _log = new FileInfo(@"C:\Temp\TFSEventLog.log");
        
        long _maxSize = 10485760; // Ten MB
        if (_log.Exists && _log.Length > _maxSize)
        {
            _log.Delete();
        }

        log = System.DateTime.Now + "> " + log;

        
        using (StreamWriter sw = new StreamWriter(_log.FullName, true))
        {
            sw.WriteLine(log);
            sw.Flush();
            sw.Dispose();

        }

    }

    static void WriteErrorLog(string log)
    {

        FileInfo _log = new FileInfo("C:\\Temp\\TFSEventErrorLog_" + DateTime.Now.ToString("yyyyMMddHHmmss") + ".log");

        if (!_log.Exists)
        {
            _log.Create();
        }

        long _maxSize = 10485760;
        if (_log.Length > _maxSize)
        {
            _log.Delete();
        }

        log = System.DateTime.Now + "> " + log;


        using (StreamWriter sw = new StreamWriter(_log.FullName, true))
        {
            sw.WriteLine(log);
            sw.Flush();
            sw.Dispose();

        }

    }
 }

