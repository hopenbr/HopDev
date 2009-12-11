##Get-SQLDeployer
#Ths script will return the username name a password of the 
#SQL deployer account used for DB migrations

param($deployer = $(throw "HPP deployer object required"))

###MAIN###

[bool] $foundRegistryEntries = $true
[string] $errmsg = "" 

if (-not (Test-Path $deployer.Config.Deployment.RegPaths.DBDeployer))
{
	$errmsg = "Error: Invalid path to register keys for DB Deployer, $($deployer.Config.Deployment.RegPaths.DBDeployer)"
	$foundRegistryEntries = $false
}

if (-not (Test-Path $deployer.Config.Deployment.RegPaths.SecureCodes))
{
	$errmsg = "Error: Invalid path to register keys for TFSDeployer Secure Codes, $($deployer.Config.Deployment.RegPaths.SecureCodes)"
	$foundRegistryEntries = $false
}

if (-not $foundRegistryEntries)
{
	$deployer.logger.log($errmsg, "Error")
	throw $errmsg
}

[bool] $didPush = $false

if (-not ($PWD -eq $($depolyer.Config.Deployment.CommonScriptsLocation)))
{
	pushd $depolyer.Config.Deployment.CommonScriptsLocation
	$didPush = $true
}

[Object] $sqlUser = New-Object Object

$dbDeployer = Get-ItemProperty -Path $($deployer.config.Deployment.RegPaths.DBDeployer)
$secureCodes = Get-ItemProperty -Path $($deployer.config.Deployment.RegPaths.SecureCodes)

$sqlUser | Add-Member -MemberType NoteProperty -Name "Username" -Value $(..\new-Encryption.ps1 $($dbDeployer.user) $($secureCodes.salt) $($secureCodes.pass) -decrypt)
$sqlUser | Add-Member -MemberType NoteProperty -Name "Password" -Value $(..\new-Encryption.ps1 $($dbDeployer.pswd) $($secureCodes.salt) $($secureCodes.pass) -decrypt)

if ($didPush)
{
	popd
}


return $sqlUser