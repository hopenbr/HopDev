using System;
using System.Collections.Generic;
using System.Text;
using System.Xml;

namespace TFSeventClasses
{
    public class XMLReader
    {
        public string[] GetTeamAddresses(string file, int workItemNumber)
        {
            XmlDocument _xml = new XmlDocument();
           
            try
            {
                _xml.Load(file);
            }
            catch (Exception ex)
            {
                throw ex;
            }

            string xpath = "WorkItemChange/Workitem[Number = \'" + workItemNumber + "\']/TeamEmail";
            XmlNode _node = _xml.DocumentElement;
            XmlNode _teamAddressNode = _node.SelectSingleNode(xpath);
            XmlNodeList _teamAdressList = _teamAddressNode.ChildNodes;
            string[] _teamAddresses = new string[_teamAdressList.Count];
            int count = 0;
            foreach (XmlNode address in _teamAdressList)
            {
                _teamAddresses[count] = address.InnerText.ToString();
                count++;
            }

            return _teamAddresses;

        }

        public string GetCreatedByAddress(string file, int workItemNumber)
        {
            XmlDocument _xml = new XmlDocument();

            try
            {
                _xml.Load(file);
            }
            catch (Exception ex)
            {
                throw ex;
            }

            string xpath = "WorkItemChange/Workitem[Number = \'" + workItemNumber + "\']/CreatedBy/Address";
            XmlNode _node = _xml.DocumentElement;
            XmlNode _cBAddressNode = _node.SelectSingleNode(xpath);
            return _cBAddressNode.InnerText.ToString();

        }


    }
}
