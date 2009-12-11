namespace TeamFoundationServer.Services.Extensibility1
{
    #region Directives
    using System.Web.Services;
    using System.Xml;
    using System.Xml.Serialization; 
    #endregion
    
    /// <summary>
    /// Base Class that contains common methods used by all the Endpoint Services.
    /// </summary>
    public class EndpointBase : WebService
    {
        /// <summary>
        /// Deserializes a Type
        /// </summary>
        /// <typeparam name="T">Type to deserialize</typeparam>
        /// <param name="serializedType">serialized version of the type</param>
        /// <returns>DeSerialized version of the type</returns>
        protected T CreateInstance<T>(string serializedType) where T : new()
        {
            T customType = new T();

            XmlSerializer serializer = new XmlSerializer(typeof (T));

            XmlDocument xmlDocument = new XmlDocument();
            xmlDocument.LoadXml(serializedType);
            XmlNodeReader xmlNodeReader = new XmlNodeReader(xmlDocument);

            try
            {
                customType = (T) serializer.Deserialize(xmlNodeReader);
            }
            catch
            {
                //TODO: Add Logging etc here...
                throw;
            }

            return customType;
        }
    }
}