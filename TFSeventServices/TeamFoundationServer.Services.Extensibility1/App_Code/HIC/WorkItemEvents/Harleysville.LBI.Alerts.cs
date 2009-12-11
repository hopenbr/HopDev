using System;
using System.Data;
using System.Configuration;
using System.Globalization;
using System.Text;
using System.IO;
using System.Collections.Generic;
using System.Web.UI.HtmlControls;
using System.Drawing;
using TFSeventClasses;
using System.Xml;
using System.Text.RegularExpressions;

/// <summary>
/// Summary description for Harleysville.TFSEventServices
/// </summary>
namespace Harleysville.TFSEventServices
{

    public class HarleysvilleLBIAlerts : HarelysvilleWorkItemAlerts 
    {

        private LBIHelper _lbiHelper;

        public HarleysvilleLBIAlerts(WorkItemChangedEvent _wice, TFSIdentity tfsId)
        {
            WIChangeEvent = _wice;

            _lbiHelper = new LBIHelper(_wice, tfsId.Url);
        }

        public override void WorkItemActions()
        {
            if (_lbiHelper.ChangeType == ChangeTypes.New)
            {
                _lbiHelper.CreateLabel();

                string _to = this.GetCreatedByEmialAddress(_lbiHelper.WiFields["Created By"]);
               // _to += "; " + ConfigurationManager.AppSettings.Get("InfoReqMailBox");
                string _sub = string.Empty;
                string _body = string.Empty;

                if (_lbiHelper.LabelCreated)
                {
                    _sub = "Label: " + _lbiHelper.Label + " was successfully created.";

                    _body = "<b>label:</b> " + _lbiHelper.Label + " is ready to be used.<br>";
                    _body += "<b>Region:</b> " + _lbiHelper.WiFields["HIC INFORMATICA LABEL REGION"] + "<br>";
                    _body += "<b>LBI:</b> " + _lbiHelper.WiFields["ID"] + " was closed.<br>";

                    _lbiHelper.TFS.Workitem.SyncToLatest();
                    _lbiHelper.TFS.ChangeWorkItemStateTo("Closed");
                    _lbiHelper.TFS.UpdateWorkItemField("Title", (object)_lbiHelper.Label);
                    _lbiHelper.TFS.AddHistory2WorkItem("Label: " + _lbiHelper.Label + " was created");
                    _lbiHelper.TFS.ChangeAreaPath(_lbiHelper.WICE.PortfolioProject + @"\LBI\Closed");
                    _lbiHelper.TFS.SaveWorkItem();

                }
                else
                {
                    _sub = "Label request ERROR";
                    _body = "<p>There was an Error while trying to create your label</p>";
                    _body = "<p>LBI: " + _lbiHelper.WiFields["ID"] + "</p>";
                    _body += "<br><p>Please contact someone in the <a href=\"Mailto:SRM@harleysvilleGroup.com\">SRM group</a></p>";

                    _lbiHelper.TFS.Workitem.SyncToLatest();
                    _lbiHelper.TFS.AddHistory2WorkItem("There was an error when trying create a label");
                    _lbiHelper.TFS.ChangeAreaPath(_lbiHelper.WICE.PortfolioProject + @"\LBI\Open");
                    _lbiHelper.TFS.SaveWorkItem();
                }

                this.SendAlert(_to, _sub, _body);
                
            }

        }
    }
}
