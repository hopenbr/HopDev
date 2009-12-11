using System;
using System.Data;
using System.Configuration;
using System.Globalization;
using System.Text;
using System.IO;
using TFSeventClasses;

/// <summary>
/// Summary description for Harleysville.TFSEventServices
/// </summary>
namespace Harleysville.TFSEventServices
{
    /// <summary>
    /// The factory is a simple designer based factory that figures out what type of Workitem has
    /// been changed and returns that correct child class of Workitem Alerts 
    /// </summary>
    public class HarleysvilleWorkItemAlertsFactory
    {
 
        /// <summary>
        /// Main factory method that determines the workitem type 
        /// </summary>
        /// <param name="_wice">
        /// Workitem Change Event object
        /// </param>
        /// <returns>
        /// Correct child object for workitem changed
        /// </returns>
        public IHarleysvilleWorkItemAlerts GetWorkItem(WorkItemChangedEvent _wice, TFSIdentity _tfsId)
        {
            IHarleysvilleWorkItemAlerts _Ihar = null;

            foreach (StringField _sf in _wice.CoreFields.StringFields)
            {
                if (_sf.Name.Equals("Work Item Type", StringComparison.CurrentCultureIgnoreCase))
                {
                    switch (_sf.NewValue)
                    {
                        case "Deployment Backlog Item":
                            _Ihar = new HarleysvilleDBIAlerts(_wice, _tfsId);
                            break;
                        case "Build Backlong Item":
                            _Ihar = new HarelysvilleWorkItemAlerts();
                            break;
                        case "Sprint Backlog Item":
                            _Ihar = new HarelysvilleWorkItemAlerts();
                            break;
                        case "Release Backlog Item":
                            _Ihar = new HarelysvilleWorkItemAlerts();
                            break;
                        case "Product Backlog Item":
                            _Ihar = new HarelysvilleWorkItemAlerts();
                            break;
                        case "Label Backlog Item":
                            _Ihar = new HarleysvilleLBIAlerts(_wice, _tfsId);
                            break;
                        default :
                            _Ihar = new HarelysvilleWorkItemAlerts();
                            break;
                    }
                }
            }

            return _Ihar;

        }

        
    }
}
