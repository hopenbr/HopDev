##############################################
#Team Build kick starter 
#This script will kick off a team build type 
#Person invoking script must have right to start the 
#build in the team project for this to work
#
#Returns [string] Build URI
##############################################

param([String] $TeamProject = $(throw 'The TFS Team project is Required'),     
[String] $BuildType = $(throw 'The Team Build Type being built is required'),   
[String] $BuildDirectory = $("E:\Builds"),    
[String] $BuildMachine = $("AS73TFSBUILD01"),
[String] $TeamFoundationServer = $("HTTP://AS73TFS01:8080")   
)



###MAIN###
[void] [Reflection.Assembly]::LoadWithPartialName("Microsoft.TeamFoundation.Client")
[void] [Reflection.Assembly]::LoadWithPartialName("Microsoft.TeamFoundation.Build.Common")

$tfs = New-Object Microsoft.TeamFoundation.Client.TeamFoundationServer($teamFoundationServer)
$bc = $tfs.GetService([Microsoft.TeamFoundation.Build.Proxy.BuildController])
$bp = New-Object Microsoft.TeamFoundation.Build.Proxy.BuildParameters

$bp.TeamFoundationServer = $TeamFoundationServer
$bp.BuildType = $BuildType
$bp.BuildDirectory = $BuildDirectory
$bp.BuildMachine = $BuildMachine 
$bp.TeamProject = $TeamProject

$bc.StartBuild($bp)