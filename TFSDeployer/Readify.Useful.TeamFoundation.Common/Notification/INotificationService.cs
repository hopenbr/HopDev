using System;
using System.Collections.Generic;
using System.Text;
using System.ServiceModel;

namespace Readify.Useful.TeamFoundation.Common.Notification
{
    [ServiceContract(Namespace = "http://schemas.microsoft.com/TeamFoundation/2005/06/Services/Notification/03")]
    public interface INotificationService
    {
        [OperationContract(
            Action = "http://schemas.microsoft.com/TeamFoundation/2005/06/Services/Notification/03/Notify",
            ReplyAction = "*")]
        [XmlSerializerFormat(Style = OperationFormatStyle.Document)] // Took me hours to figure this out!
        void Notify(string eventXml, string tfsIdentityXml);
        
    }
}
