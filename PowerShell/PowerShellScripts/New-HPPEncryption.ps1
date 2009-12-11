#New-HPPEncryption
#this is designed to encrytption string into the registry 
#for later use by the HPP, it will use the HPP base secure keys for the 
#encryption therefore, you need to run this on a machine that is setup for 
#HPP encryption

param ($string = $(throw 'The string to be encrypted or decrypted is required'),
	   $RegPath = $("HKLM:\software\HGIC\SRM\HPP\SecureCodes"),
       [switch] $encrypt,
	   [switch] $decrypt)
	   


###MAIN###

[bool] $foundRegistryEntries = $true
[string] $errmsg = "" 
[string] $hppReg = "HKLM:\software\HGIC\SRM\HPP"

if (-not (Test-Path $RegPath))
{
	$errmsg = "Error: Invalid path to register keys for TFSDeployer Secure Codes, $($regPath)"
	$foundRegistryEntries = $false
}

if (-not (Test-Path $hppReg))
{
	$errmsg = "Error: Invalid path to register to HPP, $hppReg"
	$foundRegistryEntries = $false
}

if (-not $foundRegistryEntries)
{
	return $errmsg
}

$Hpp = Get-ItemProperty $hppReg

Pushd $Hpp.Path

New-Variable -Name results

$secureCodes = Get-ItemProperty -Path $RegPath

if ($decrypt)
{
	$results = $(.\new-Encryption.ps1 $string $($secureCodes.salt) $($secureCodes.pass) $($secureCodes.init) -decrypt)
}
elseif($encrypt)
{
	$results = $(.\new-Encryption.ps1 $string $($secureCodes.salt) $($secureCodes.pass) $($secureCodes.init) -encrypt)
}
else
{
	$results = "Error: Encryption switch not passed in, [-encrypt|-Decrypt]"
}

popd

return $results