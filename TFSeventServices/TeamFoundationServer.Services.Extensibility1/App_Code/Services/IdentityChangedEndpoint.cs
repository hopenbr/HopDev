#region Directives
using System.Web.Services;
using System.Web.Services.Protocols;
#endregion

/// <summary>
/// Web Service Endpoint for the <see cref="IdentityChangedEvent"/>
/// </summary>
/// <remarks>
/// To Register this Notification Endpoint you will need to use the <see cref="http://blogs.msdn.com/psheill/archive/2006/02/01/522386.aspx">BisSubscribe.exe</see> tool. 
/// For more information about Team Foundation Server Notifications <see cref="http://blogs.msdn.com/buckh/archive/2006/04/10/event_filtering.aspx"/>
/// </remarks>
[WebService(Namespace = "http://schemas.conchango.com/TeamFoundation/2005/06/Services/Notification/Extensibility", Description = "")]
[WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
public class IdentityChangedEndpoint : TeamFoundationServer.Services.Extensibility1.EndpointBase
{
    /// <summary>
    /// Endpoint required to accept incoming <see cref="IdentityChangedEvent"/> notifications
    /// </summary>
    /// <param name="eventXml">Serialized version of the <see cref="IdentityChangedEvent"/></param>
    /// <param name="tfsIdentityXml">Serialized version of <see cref="TFSIdentity"/></param>
    [WebMethod]
    [SoapDocumentMethod("http://schemas.microsoft.com/TeamFoundation/2005/06/Services/Notification/03/Notify", RequestNamespace = "http://schemas.microsoft.com/TeamFoundation/2005/06/Services/Notification/03")]
    public void Notify(string eventXml, string tfsIdentityXml)
    {
        IdentityChangedEvent identityChangedEvent = this.CreateInstance<IdentityChangedEvent>(eventXml);
        TFSIdentity tfsIdentity = this.CreateInstance<TFSIdentity>(tfsIdentityXml);
    }
}