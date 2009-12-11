using System;
using System.Collections.Generic;
using System.Text;
using System.Xml;
using System.Data;

namespace Harleysville.Deployment.Utilities
{
    public class ConfigReader
    {
        public void GetServiceSettings(DataSet ds)
        {
            ds.WriteXml("c:\\DsXml.xml");
        }
    }
}
