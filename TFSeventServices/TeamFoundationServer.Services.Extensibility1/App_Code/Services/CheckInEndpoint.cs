#region Directives
using System;
using System.Web.Services;
using System.Web.Services.Protocols;
using Harleysville.TFSEventServices;
using System.Configuration;
using System.IO;

#endregion

/// <summary>
/// Web Service Endpoint for the <see cref="CheckinEvent"/>
/// </summary>
/// <remarks>
/// To Register this Notification Endpoint you will need to use the <see cref="http://blogs.msdn.com/psheill/archive/2006/02/01/522386.aspx">BisSubscribe.exe</see> tool. 
/// For more information about Team Foundation Server Notifications <see cref="http://blogs.msdn.com/buckh/archive/2006/04/10/event_filtering.aspx"/>
/// </remarks>
[WebService(Namespace = "http://schemas.conchango.com/TeamFoundation/2005/06/Services/Notification/Extensibility", Description = "")]
[WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
public class CheckInEndpoint : TeamFoundationServer.Services.Extensibility1.EndpointBase
{
    /// <summary>
    /// Endpoint required to accept incoming <see cref="CheckinEvent"/> notifications
    /// </summary>
    /// <param name="eventXml">Serialized version of the <see cref="CheckinEvent"/></param>
    /// <param name="tfsIdentityXml">Serialized version of <see cref="TFSIdentity"/></param>
    [WebMethod]
    [SoapDocumentMethod("http://schemas.microsoft.com/TeamFoundation/2005/06/Services/Notification/03/Notify", RequestNamespace = "http://schemas.microsoft.com/TeamFoundation/2005/06/Services/Notification/03")]
    public void Notify(string eventXml, string tfsIdentityXml)
    {
        CheckinEvent checkInEvent = this.CreateInstance<CheckinEvent>(eventXml);
        TFSIdentity tfsIdentity = this.CreateInstance<TFSIdentity>(tfsIdentityXml);
        try
        {
            HarleysvilleCheckInAlert _ha = new HarleysvilleCheckInAlert(checkInEvent, tfsIdentity);

            if (ConfigurationManager.AppSettings.Get("DebugMode").Equals("On", StringComparison.CurrentCultureIgnoreCase))
            {
                WriteLog(eventXml + Environment.NewLine + tfsIdentityXml);
            }

            try
            {
                _ha.AlertOnCheckIn();
            }
            catch (Exception ex)
            {
                _ha.DebugMailer("TFSEventService Error: Checkin endpoint", ex.Message + "\n" + ex.StackTrace);
            }
        }
        catch (Exception ex)
        {
            WriteLog(ex.Message + "\n" + ex.StackTrace);
        }
    }

    static void WriteLog(string log)
    { 

        FileInfo _log = new FileInfo("C:\\Temp\\TFSEventLogCI.log");
        
        long _maxSize = 10485760;
        if (_log.Exists && _log.Length > _maxSize)
        {
            _log.Delete();
        }

        log = "\n<" + System.DateTime.Now + ">\n" + log + "\n</" + System.DateTime.Now + ">\n";


        using (StreamWriter sw = new StreamWriter(_log.FullName, true))
        {
            sw.WriteLine(log);
            sw.Flush();
            sw.Dispose();

        }

    }

}