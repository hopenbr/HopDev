using System;
using System.Collections.Generic;
using System.Text;
using Microsoft.Practices.EnterpriseLibrary.Logging;
using System.Configuration;
using System.Diagnostics;

namespace Harleysville.Utilities.Hlogger
{
    public enum HloggerCategories { Debug, Info, Warning, Error };
    public enum HloggerPriority { High, Med, Low, None};

    public class Hlogger
    {
        private int _eid = 4220;
        /// <summary>
        /// The default Log Event ID
        /// </summary>
        public int EventId
        {
            get { return _eid; }
        }

        private int _priority = 3;
        /// <summary>
        /// The default Event priority
        /// </summary>
        public int EventPriority
        {
            get { return _priority; }
            set { _priority = value; }
        }

        private TraceEventType _traceType = TraceEventType.Information;
        /// <summary>
        /// The Default Trace Event Type is Information 
        /// </summary>
        public TraceEventType TraceEventType
        {
            get { return _traceType; }
        }

        private string _cat = "Info";
        /// <summary>
        /// The default Log Event Category
        /// </summary>
        public string EventCategory
        {
            get { return _cat; }
            set { _cat = value; }
        }


        private void LogIt(string category, string message, int priority, int eventId)
        {
            LogEntry log = new LogEntry();
            log.Categories.Add(category);
            log.EventId = eventId;
            log.Priority = priority;
            log.Message = message;
            log.Severity = _traceType;
            Logger.Write(log);

        }

        private void LogIt(string category, string message, int priority)
        {
           
            LogIt(category, message,priority, getEventId(category));
        }

        private string getCategory(HloggerCategories category)
        {
            string cat = "";

            switch (category)
            {
                case HloggerCategories.Debug:
                    _traceType = TraceEventType.Verbose;
                    cat = "Debug";
                    break;
                case HloggerCategories.Info:
                    cat = "Info";
                    break;
                case HloggerCategories.Warning:
                    _traceType = TraceEventType.Warning;
                    cat = "Warning";
                    break;
                case HloggerCategories.Error:
                    _traceType = TraceEventType.Error;
                    cat = "Error";
                    break;
                default:
                    cat = "Info";
                    break;
            }

            return cat;

        }

        private int getEventId(string _cat)
        {
            int _eventId = 0;

            switch (_cat)
            {
                case "Debug":
                    Int32.TryParse(ConfigurationSettings.AppSettings.Get("EventID4Debug"), out _eventId);
                    break;
                case "Info":
                    Int32.TryParse(ConfigurationSettings.AppSettings.Get("EventID4Info"), out _eventId);
                    break;
                case "Warning":
                    Int32.TryParse(ConfigurationSettings.AppSettings.Get("EventID4Warning"), out _eventId);
                    break;
                case "Error":
                    Int32.TryParse(ConfigurationSettings.AppSettings.Get("EventID4Error"), out _eventId);
                    break;
                default:
                    _eventId = _eid;
                    break;
            }

            if (_eventId == 0)
            {
                _eventId = _eid;
            }

            return _eventId;
        }

        private int getPriority(HloggerPriority priority)
        {
            int pri = 5;

            switch (priority)
            {
                case HloggerPriority.High:
                    if (_traceType != TraceEventType.Error)
                    {
                        _traceType = TraceEventType.Critical;
                    }
                    pri = 1;
                    break;
                case HloggerPriority.Med:
                    pri = 2;
                    break;
                case HloggerPriority.Low:
                    pri = 3;
                    break;
                case HloggerPriority.None:
                    pri = 5;
                    break;
                default:
                    pri = 5;
                    break;
            }

            return pri;
        }


        public void Write2Log(string message, HloggerCategories category, HloggerPriority priority, int eventId)
        {
            LogIt(getCategory(category), message, getPriority(priority), eventId);
        }

        public void Write2Log(string message, HloggerCategories category, HloggerPriority priority)
        {
            LogIt(getCategory(category), message, getPriority(priority));
        }

        /// <summary>
        /// Writes to local application Event log with priority of 3 
        /// </summary>
        /// <param name="message">Message for Log </param>
        /// <param name="category">Log category</param>
        public void Write2Log(string message, HloggerCategories category)
        {
            LogIt(getCategory(category), message, _priority);
        }

        /// <summary>
        /// Writes to local Application Event Log with all default setting 
        /// Info, with Priority of 3 
        /// </summary>
        /// <param name="message">Message for log</param>
        public void Write2Log(string message)
        {
            LogIt(_cat, message, _priority);
        }
     

    }
}
