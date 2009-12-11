cd C:\TFSWorkspaces\VS2008\SRM\Branches\DEVELOPMENT\PowerShell\PowerShellScripts\

$x = "C:\TFSWorkspaces\VS2008\SRM\TeamBuildTypes\Deployer.TST\Deployment\DeploymentConfig.xml" 


#
##$s = "http://as73tfsbuild01/TFSDeployerConfigMapping.xsd" 
##$u = "http://as73tfsbuild01/TFSDeployerConfigMapping.xsd"
#
#
$s = "urn:schema-Harleysvillegroup-com:TFSDeployerConfig" 
$u = "..\TFSDeployerScripts\XSD\TFSDeployerConfigMapping.xsd"
#
.\Validate-Xml.ps1 $x $s $u