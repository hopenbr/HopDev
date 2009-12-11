using System;
using System.Collections.Generic;
using System.Text;
using System.Management.Automation;
using System.ComponentModel;

namespace Harleysville.Deployment.SnapIn
{
    [RunInstaller(true)]
    public class DeploymentSnapIn : PSSnapIn
    {
        public override string Name
        {
            get { return "Harleysville.Deployment.SnapIn"; }
        }
        public override string Vendor
        {
            get { return "Harleysville Insurance"; }
        }
        public override string VendorResource
        {
            get { return "Harleysville.Deployment.SnapIn,Harleysville Insurance"; }
        }
        public override string Description
        {
            get { return "This SnapIn will host custom cmdlet needed to deployment build packages"; }
        }
        public override string DescriptionResource
        {
            get { return "Harleysville.Deployment.SnapIn,Registers the CmdLets and Providers in this assembly"; }
        }


    }
}
