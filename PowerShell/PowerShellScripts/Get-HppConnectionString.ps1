#Get-HppConnectionString
#this script returns the connection string 
#using HPP DB dpeloyer

param([string] $pathHppReg = $(throw 'the PS Path to top level HPP registry key is required'),
      [string] $server = $(throw 'the server name is requied'),
	  [string] $database = $(throw 'the database name is required'))

[bool] $foundRegistryEntries = $true
[string] $errmsg = "" 

[string] $DBDeployerReg = $pathHppReg + "\DBDeployer"
[string] $SecureCodesReg = $pathHppReg + "\SecureCodes"

if (-not (Test-Path $pathHppReg))
{
	$errmsg = "Error: Invalid path to register keys for Hpp, $($pathHppReg)"
	$foundRegistryEntries = $false
}

if (-not (Test-Path $DBDeployerReg))
{
	$errmsg = "Error: Invalid path to register keys for DB Deployer, $($DBDeployerReg)"
	$foundRegistryEntries = $false
}

if (-not (Test-Path $SecureCodesReg))
{
	$errmsg = "Error: Invalid path to register keys for TFSDeployer Secure Codes, $($SecureCodesReg)"
	$foundRegistryEntries = $false
}

if (-not $foundRegistryEntries)
{
	throw $errmsg
}

cd $(Get-ItemProperty -Path $pathHppReg).Path

[bool] $didPush = $false
[Object] $sqlUser = New-Object Object

$dbDeployer = Get-ItemProperty -Path $($DBDeployerReg)
$secureCodes = Get-ItemProperty -Path $($SecureCodesReg)

$sqlUser | Add-Member -MemberType NoteProperty -Name "Username" -Value $(.\new-Encryption.ps1 $($dbDeployer.user) $($secureCodes.salt) $($secureCodes.pass) -decrypt)
$sqlUser | Add-Member -MemberType NoteProperty -Name "Password" -Value $(.\new-Encryption.ps1 $($dbDeployer.pswd) $($secureCodes.salt) $($secureCodes.pass) -decrypt)


[string] $connectionString="data source=$($server);Initial Catalog=$($database);User ID=$($sqlUser.Username);pwd=$($sqlUser.Password);"

return $connectionString