param ([bool] $debugger = $($false))

function start-debug
{
   $scriptName = $MyInvocation.ScriptName
   function prompt
   {
      "Debugging [{0}]>" -f $(if ([String]::IsNullOrEmpty($scriptName)) { "globalscope" } else { $scriptName } )
   }
   $host.EnterNestedPrompt()
}

$DebugPreference = "Continue"
write-debug "Debuging output turned on"

$tfs =C:\TFSWorkspaces\VS2008\SRM\Branches\DEVELOPMENT\PowerShell\PowerShellScripts\get-tfs.ps1 

#[void][System.Reflection.Assembly]::LoadWithPartialName("Microsoft.TeamFoundation.Client")

#$tfb = [System.Reflection.Assembly]::LoadWithPartialName('Microsoft.TeamFoundation.Build.Common') > $null

#$b = $tfb.GetService([Microsoft.TeamFoundation.Build.Proxy.BuildStore])

$uri = $tfs.tbp.GetBuildUri("Software.Release.Management", "Deployer.TST_20090513.1")

#$uri = $tfs.tbp.GetBuildUri("HIC.Projects", "EAR.CLHIIS.WC-1.0.0.1")

#SRM.CLPortal.EAR.Release_20080819.1
#"Documaker.Audit.TST.Release_20080813.1")
#Deployer.TST_20080626.1

$tfs.tbp.UpdateBuildFinishTime($uri, $(Get-Date))

$TFSDeployerBuildData = $tfs.tbp.GetBuildDetails($uri)

$TFSDeployerBuildData.BuildQuality = "Deploy2-Assembly"

$TFSDeployerOriginalQuality = "In-Assembly"

write-debug "Calling Deployer"

#C:\Projects\SRM\Branches\DEVELOPMENT\PowerShell\PowerShellScripts\TFSDeployerScripts\Deployer.ps1 "C:\Projects\HIC.Projects\TeamBuildTypes\SRM.CLHIIS.WC.EAR.Release\Deployment\Deploy.ps1"

#C:\Projects\SRM\Branches\DEVELOPMENT\PowerShell\PowerShellScripts\TFSDeployerScripts\Deployer.ps1 "C:\Projects\SRM\TeamBuildTypes\Deployer.TST\Deployment\Deploy.ps1"

#C:\TFSWorkspaces\VS2008\SRM\Branches\DEVELOPMENT\PowerShell\PowerShellScripts\TFSDeployerScripts\Deployer.ps1 "C:\TFSWorkspaces\VS2008\SRM\TeamBuildTypes\Deployer.TST\Deployment\DeployV5.ps1"

C:\TFSWorkspaces\VS2008\SRM\Branches\DEVELOPMENT\PowerShell\PowerShellScripts\TFSDeployerScripts\Deployer.ps1 "C:\TFSWorkspaces\VS2008\SRM\Branches\DEVELOPMENT\PowerShell\PowerShellScripts\TFSDeployerScripts\TestBed\Start-Deployer.ps1"

#"C:\Projects\Documaker\TeamBuildTypes\Documaker.Audit.TST.Release\Deployment\fake.ps1"
#$myInvocation.MyCommand.Definition
