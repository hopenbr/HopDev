if ($args.Length -lt 1) {
    write-host "usage: tsvn <command>"
    return
}

if ((test-path "HKLM:\Software\TortoiseSVN") -eq $false) {
 write-host -foregroundColor Red "Error: Could not find TortoiseProc.exe"
 return
}

$tortoiseKey = get-itemproperty "HKLM:\Software\TortoiseSVN"

if ($tortoiseKey -eq $null) {
 write-host -foregroundColor Red "Error: Could not find TortoiseProc.exe"
 return
}

$tortoise = $tortoiseKey.ProcPath

if ($tortoise -eq $null) {
 write-host -foregroundColor Red "Error: Could not find TortoiseProc.exe"
 return
}

$commandLine = '/command:' + $args[0] + ' /notempfile /path:"' + ((get-location).Path) + '"'
& $tortoise $commandLine
