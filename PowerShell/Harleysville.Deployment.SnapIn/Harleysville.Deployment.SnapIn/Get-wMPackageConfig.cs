using System;
using System.Collections.Generic;
using System.Text;
using System.Management.Automation;
using System.Collections;
using System.IO;

namespace Harleysville.Deployment.SnapIn
{
    [Cmdlet(VerbsCommon.Get, "wMPackageConfig", SupportsShouldProcess = true)]
    public class Get_wMPackageConfig : PSCmdlet
    {

        #region Parameters

        private FileInfo _path2PackageZip;

        [Parameter(Position = 0,
            Mandatory = false,
            ValueFromPipelineByPropertyName = true,
            HelpMessage = "Help Text")]
        [ValidateNotNullOrEmpty]
        public string Path2PackageZip
        {
            set { _path2PackageZip = new FileInfo(value); }
        }

        private DirectoryInfo _outputPath;

        [Parameter(Position = 1,
            Mandatory = false,
            ValueFromPipelineByPropertyName = true,
            HelpMessage = "Help Text")]
        [ValidateNotNullOrEmpty]
        public string OutputPath
        {
            set { _outputPath = new DirectoryInfo(value); }
        }
 
 
        #endregion

        protected override void ProcessRecord()
        {
            try
            {
                ZipHelper _zh = new ZipHelper();
                if (!_outputPath.Exists)
                {
                    Directory.CreateDirectory(_outputPath.FullName);
                }

                _zh.Unzip_wMCnf(_path2PackageZip.FullName, Path.Combine(_outputPath.FullName, "Config"));
            }
            catch (Exception)
            {
            }
        }
    }
}
