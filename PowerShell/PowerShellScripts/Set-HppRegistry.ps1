#Set-EncryptionCodes
#Will set the local registry with Secure Codes for encryption 
#Allowing the machine to encryption and decryption HPP encrypted strings 

function new-regDir ($rp)
{
	$parent = Split-Path $rp -Parent
	$name = Split-Path $rp -Leaf
	
	if(-not (Test-Path $parent))
	{
		new-regDir $parent
	}
	
	New-Item -Path $parent -Name $name | Out-Null
}

function get-script
{
   if($myInvocation.ScriptName) { $myInvocation.ScriptName }
   else { $myInvocation.MyCommand.Definition }
}


###MAIN###

[string] $hpp = $(split-Path get-script -Parent) 
[string] $salt = "The power of PowerShell is .Net 3.0!"
[string] $pass = "355 Maple Ave. Harleysville, PA USA 19438"
[string] $init = "Harleysville PowerPlatform"
[string] $regPath = "HKLM:\software\HGIC\SRM\HPP\SecureCodes"

new-regDir $regPath

$hppReg = Get-ItemProperty "HKLM:\software\HGIC\SRM\HPP" 

if (-not $hppReg.Path)
{
	new-ItemProperty -Path $hppReg -Name "Path" | Out-Null
}

Set-ItemProperty -Path $hppReg -Name "Path" -Value $hpp

$regProps = Get-ItemProperty $regPath

if (-not $regProps.Salt)
{
	new-ItemProperty -Path $regPath -Name "Salt"  | Out-Null
}

Set-ItemProperty -Path $regPath -Name "Salt" -Value $salt

if (-not $regProps.init)
{
	new-ItemProperty -Path $regPath -Name "Init"  | Out-Null
}

Set-ItemProperty -Path $regPath -Name "Init" -Value $init

if (-not $regProps.Pass)
{
	new-ItemProperty -Path $regPath -Name "Pass" | Out-Null
}

Set-ItemProperty -Path $regPath -Name "Pass" -Value $pass

