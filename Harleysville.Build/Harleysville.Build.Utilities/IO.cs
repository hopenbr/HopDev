using System;
using System.Collections.Generic;
using System.Text;
using System.IO;
using System.Xml;
using System.Diagnostics;

namespace Harleysville.Build.Utilities
{
    public class IO
    {
        public void OutputInText(string str, string outputpath)
        {
            using (StreamWriter sw = new StreamWriter(outputpath))
            {
                sw.WriteLine(str);
                sw.Flush();

            }

            //return (true);
        }

        public Dictionary<string, string> GetConfig()
        {
            Dictionary<string, string> config = new Dictionary<string, string>();
            config.Add("TFS.Server", "http://AS73TFS01:8080");
            config.Add("SMTP.Server","XS73EMAIL1.CORP.HGICNET.NET");
            config.Add("Provider", "@harleysvillesgroup.com");
            config.Add("Default.Email", "VSTFHelp");
           // config.Add("BillingAdminProject.Team.Email", "RBurian;IGolden;BLin;SMCGOUG;RMetcal;MSzycho;Jtomeo;SVelaga;PWoods");
            config.Add("BillingAdminProject.Team.Email", "FieldAutomation");
            config.Add("AgentPortal.Team.Email", "WebDevelopment");

             #region Old Code with XML reader call
            //XmlTextReader reader = new XmlTextReader(@"Harleysville.TFS.xml");
            //while (reader.Read())
            //{
            //    if (reader.HasAttributes)
            //    {
            //        if (reader.GetAttribute("Name") != null &&
            //            reader.GetAttribute("Value") != null)
            //        {
            //            config.Add(reader.GetAttribute("Name"), reader.GetAttribute("Value"));
            //        }
            //    }
            //}
            #endregion

            return (config);

        }

        public Dictionary<string, string> XmlNodeRead(string file, string node)
        {
            XmlDocument oXmlDoc = new XmlDocument();
            Dictionary<string, string> dic = new Dictionary<string, string>();
            try
            {
                oXmlDoc.Load(file);
            }
            catch (Exception ex)
            {
                throw ex;
            }

            XmlNode oNode = oXmlDoc.DocumentElement;
            XmlNodeList oNodeList = oNode.SelectNodes(node);
            
            for (int x = 0; x < oNodeList.Count; x++)
            {
                XmlNodeList list = oNodeList.Item(x).ChildNodes;
                XmlAttributeCollection attr = oNodeList.Item(x).Attributes;

                foreach (XmlAttribute a in attr)
                {
                    dic.Add(a.Name.ToString(), a.Value.ToString());
                }
                foreach (XmlNode s in list)
                {
                    dic.Add(s.Name.ToString(), s.InnerText.ToString());
                }
                //dic.Add(x.ToString(), oNodeList.Item(x).InnerText.ToString());

            }

            return (dic);


        }

        

    }
}
