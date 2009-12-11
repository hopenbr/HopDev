using System;
using System.Collections;
using System.Collections.Generic;
using System.Text;
using Microsoft.TeamFoundation.Client;
using Microsoft.TeamFoundation.WorkItemTracking.Client;
using System.Xml;

namespace TFSeventClasses
{
    public class GlobalLists : TFWI
    {

        public GlobalLists(string tfsUrl)
        {
            SetupTFWI(tfsUrl);
        
        }

        /// <summary>
        /// Add a list item value to a global list
        /// </summary>
        /// <param name="_listName">Full name of the list </param>
        /// <param name="_itemValue">the List item value</param>
        /// <param name="_createNew">true if a new global list should be created if not found</param>
        public bool AddItem2GlobalList(string _listName, string _itemValue, bool _createNew)
        {
            XmlDocument _xgl = WorkitemStore.ExportGlobalLists();
            XmlElement _xList = (XmlElement) _xgl.SelectSingleNode("//GLOBALLIST[@name='" + _listName + "']");

            if (_xList == null && _createNew)
            {
                WorkitemStore.ImportGlobalLists("<?xml version=\"1.0\" encoding=\"utf-8\"?><gl:GLOBALLISTS xmlns:gl=\"http://schemas.microsoft.com/VisualStudio/2005/workitemtracking/globallists\"><GLOBALLIST name=\"" + _listName + "\"><LISTITEM value=\"" + _itemValue + "\" /></GLOBALLIST></gl:GLOBALLISTS>");
                return true;
            }
            else if (_xList != null)
            {
                //all labels are the same between region therefore if the label is already in the list  
                //from a different regions LBI don't need to do anything
                //this list is only for suggested values in the DBI 
                if (!_xList.InnerXml.Contains(_itemValue))
                {
                    WorkitemStore.ImportGlobalLists("<?xml version=\"1.0\" encoding=\"utf-8\"?><gl:GLOBALLISTS xmlns:gl=\"http://schemas.microsoft.com/VisualStudio/2005/workitemtracking/globallists\"><GLOBALLIST name=\"" + _listName + "\">" + _xList.InnerXml + "<LISTITEM value=\"" + _itemValue + "\" /></GLOBALLIST></gl:GLOBALLISTS>");
                }

                return true;
            }
            else
            {
                return false;
            }
        }

        /// <summary>
        /// Add list item values to a global list
        /// </summary>
        /// <param name="_listName">Full name of the list </param>
        /// <param name="_itemValues">Array the List item values</param>
        /// <param name="_createNew">true if a new global list should be created if not found</param>
        public bool AddItem2GlobalList(string _listName, string[] _itemValues, bool _createNew)
        {
            XmlDocument _xgl = WorkitemStore.ExportGlobalLists();
            XmlElement _xList = (XmlElement)_xgl.SelectSingleNode("//GLOBALLIST[@name='" + _listName + "']");

            StringBuilder _itemsXml = new StringBuilder();

            foreach (string _value in _itemValues)
            {
                _itemsXml.Append("<LISTITEM value=\"" + _value + "\" />");
            }

            if (_xList == null && _createNew)
            {
                WorkitemStore.ImportGlobalLists("<?xml version=\"1.0\" encoding=\"utf-8\"?><gl:GLOBALLISTS xmlns:gl=\"http://schemas.microsoft.com/VisualStudio/2005/workitemtracking/globallists\"><GLOBALLIST name=\"" + _listName + "\">" + _itemsXml.ToString() + "</GLOBALLIST></gl:GLOBALLISTS>");
                return true;
            }
            else if (_xList != null)
            {
                WorkitemStore.ImportGlobalLists("<?xml version=\"1.0\" encoding=\"utf-8\"?><gl:GLOBALLISTS xmlns:gl=\"http://schemas.microsoft.com/VisualStudio/2005/workitemtracking/globallists\"><GLOBALLIST name=\"" + _listName + "\">" + _xList.InnerXml + _itemsXml.ToString() + "</GLOBALLIST></gl:GLOBALLISTS>");
                return true;
            }
            else
            {
                return false;
            }

        }

        /// <summary>
        /// This will remove a set of list items in a global list
        /// </summary>
        /// <param name="_listName">The Full name of the Global list</param>
        /// <param name="_itemValues">Array of item values to be deleted</param>
        /// <returns>boolean as to success of the delete; Delete is all or nothing if one of list item is not found none of the list items are removed</returns>
        public bool RemoveItemFromGlobalList(string _listName, string[] _itemValues)
        {
            XmlDocument _xgl = WorkitemStore.ExportGlobalLists();
            XmlElement _xList = (XmlElement)_xgl.SelectSingleNode("//GLOBALLIST[@name='" + _listName + "']");

            if (_xList == null)
            {
                foreach (string _value in _itemValues)
                {
                   XmlNode _itemNode = _xList.SelectSingleNode("ListItem[@value='" + _value + "']");

                   if (_itemNode != null)
                   {
                       _xList.RemoveChild(_itemNode);
                   }
                   else
                   {
                       return false;
                   }

                }

                WorkitemStore.ImportGlobalLists("<?xml version=\"1.0\" encoding=\"utf-8\"?><gl:GLOBALLISTS xmlns:gl=\"http://schemas.microsoft.com/VisualStudio/2005/workitemtracking/globallists\"><GLOBALLIST name=\"" + _listName + "\">" + _xList.InnerXml + "</GLOBALLIST></gl:GLOBALLISTS>");

                return true;
            }
            else
            {
                return false;
            }
        }

    }
}
