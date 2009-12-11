using System;
using System.Collections.Generic;
using System.Text;
using System.Management.Automation;
using System.Collections;
using System.IO;
using Microsoft.Office.Tools.Excel;

namespace Harleysville.Deployment.SnapIn
{
    [Cmdlet(VerbsCommon.Get, "Export_MappingXml2Excel", SupportsShouldProcess = true)]
    public class Export_MappingXml2Excel : PSCmdlet
    {

        #region Parameters
        /*
        [Parameter(Position = 0,
            Mandatory = false,
            ValueFromPipelineByPropertyName = true,
            HelpMessage = "Help Text")]
        [ValidateNotNullOrEmpty]
        public string Name
        {
            
        }
 */
        #endregion

        protected override void ProcessRecord()
        {
            try
            {
                throw new NotImplementedException();
            }
            catch (Exception)
            {
            }
        }

        private bool Export(FileInfo _fi)
        {
            Workbook _wb = new Workbook();

            

            return true;
        }
    }


}
