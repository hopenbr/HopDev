using System;
using System.Collections.Generic;
using System.Text;
using System.Management.Automation;
using System.Collections;
using System.IO;

using Harleysville.Deployment.Utilities;

namespace Harleysville.Deployment.SnapIn
{
    [Cmdlet(VerbsCommon.Set, "wMCnfEnv", SupportsShouldProcess = true)]
    public class Set_wMCnfEnv : PSCmdlet
    {

        #region Parameters
        bool _getEnvListOnly = false; 
        [Parameter(Position = 0,
            Mandatory = false,
            ValueFromPipelineByPropertyName = true,
            HelpMessage = "Help Text")]
        [ValidateNotNullOrEmpty]
        public bool GetEnvListOnly
        {
            set { _getEnvListOnly = value; } 
        }
        
        #endregion

        protected override void ProcessRecord()
        {
            string[] _envList = new string[7] { "ASY", "E2E", "TST1", "TST2", "TRN", "PRE", "PRD" };

            try
            {
                if (!_getEnvListOnly)
                {
                    TFS _tfs = new TFS();
                    ZipHelper _zh = new ZipHelper();

                    DirectoryInfo _wMTFVC = new DirectoryInfo(@"C:\temp\TFVCwmPackages");
                    _tfs.GetFromTFVC("$/wMProjects/WmSourceControl", _wMTFVC.FullName);

                    foreach (string _env in _envList)
                    {
                        foreach (FileInfo _file in _wMTFVC.GetFiles("*.zip", SearchOption.AllDirectories))
                        {
                            _zh.UnZipFiles(_file.FullName, @"C:\Temp\wM\" + _env + @"\Packages\" + Path.GetFileNameWithoutExtension(_file.Name), null, false);
                        }
                    }
                }

                WriteObject(_envList);

            }
            catch (Exception _ex)
            {
                throw (_ex);
            }
        }
    }
}
