$x = [xml] (gc C:\TFSWorkspaces\VS2008\SRM\Branches\DEVELOPMENT\PowerShell\PowerShellScripts\TFSDeployerScripts\Config.xml)

$d = New-Object Object

$d | Add-Member -MemberType NoteProperty -Name Config -Value $x 

C:\TFSWorkspaces\VS2008\SRM\Branches\DEVELOPMENT\PowerShell\PowerShellScripts\TFSDeployerScripts\New-TFSDeployerEncryption.ps1 $d "Harleys" -encrypt
C:\TFSWorkspaces\VS2008\SRM\Branches\DEVELOPMENT\PowerShell\PowerShellScripts\TFSDeployerScripts\New-TFSDeployerEncryption.ps1 $d "uPtc4vCU3HfeVL3TbxMrbg==" -decrypt
