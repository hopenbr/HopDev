Param([string] $server="As73tfsbldtst01")

$objWMI = [WmiSearcher] "Select * From IIsApplicationPool"
$objWMI.Scope.Path = "\\$server\root\microsoftiisv2"
$objWMI.Scope.Options.Authentication = [System.Management.AuthenticationLevel]::PacketPrivacy
$pools = $objWMI.Get()
$pools | %{$_.Name}


