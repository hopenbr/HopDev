using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Microsoft.SharePoint;

namespace SRMSharePointWorkflow.Utilities
{
	class SRMSharePointWorkflowUtil
	{
        public string LookUpRegionUser(string _regionName, string _requestType, string _listName, string _siteCollectionUrl, string _type)
        {
            using (SPSite _site = new SPSite(_siteCollectionUrl))
            {
                using (SPWeb _web = _site.OpenWeb())
                {
                    SPList _list = _web.Lists[_listName];

                    foreach (SPListItem _item in _list.Items)
                    {
                        if (_item.Fields.ContainsField("Region Name") &&
                            _item.Fields.ContainsField("SRM Request Type"))
                        {
                            SPFieldLookupValue _lookupvalue = new SPFieldLookupValue(_item["Region Name"] as string);
                            SPFieldLookupValue _requestTypeVal = new SPFieldLookupValue(_item["SRM Request Type"] as string);

                            if (_lookupvalue.LookupValue == _regionName &&
                                _requestTypeVal.LookupValue == _requestType)
                            {
                                if (_item.Fields.ContainsField(_type))
                                {
                                    SPFieldUserValue _user = new SPFieldUserValue(_item.Web, _item[_type] as string);

                                    string _v = string.Empty;

                                    if (_user.User == null)
                                    {
                                        _v = _user.LookupValue;
                                    }
                                    else
                                    {
                                        _v = _user.User.LoginName;
                                    }

                                    return _v;
                                }
                            }
                        }

                    }

                    return _web.AssociatedOwnerGroup.Name;
                }
            }

        }

        public string LookUpApprover(string _regionName, string _requestType, string _listName, string _siteCollectionUrl)
        {
            return LookUpRegionUser(_regionName, _requestType, _listName, _siteCollectionUrl, "Approvers");
        }

        public string LookUpDeployer(string _regionName, string _requestType, string _listName, string _siteCollectionUrl)
        {
            return LookUpRegionUser(_regionName, _requestType, _listName, _siteCollectionUrl, "Deployers");
        }


        public string GetFieldValueUserLogin(SPListItem item, string fieldName)
        {
            if (item != null)
            {
                
                SPFieldUserValue userValue = new SPFieldUserValue(item.Web, item[fieldName] as string);
                
                return userValue.User.LoginName;
            }
            else
            {
                return string.Empty;
            }
        }

        public string GetFieldValueUserCollectionEmails(SPListItem item, 
                                                        string fieldName)
        {
            string emails = "";

            if (item != null &&
                item.Fields.ContainsField(fieldName) &&
                item[fieldName] != null)
            {
                string fieldVal = item[fieldName].ToString();

                SPFieldUserValueCollection usersV = 
                    new SPFieldUserValueCollection(item.Web, fieldVal);
                
                foreach (SPFieldUserValue uv in usersV)
                {
                    emails += uv.User.Email + "; ";
                }

                return emails;
                
            }
            else
            {
                return string.Empty;
            }
        }

        /// <summary>
        /// Returns the value of a Lookup Field.
        /// </summary>
        public string GetFieldValueLookup(SPListItem item, string fieldName)
        {
            if (item != null)
            {
                SPFieldLookupValue lookupValue =
                    new SPFieldLookupValue(item[fieldName] as string);
                return lookupValue.LookupValue;
            }
            else
            {
                return string.Empty;
            }
        }


	}
}
