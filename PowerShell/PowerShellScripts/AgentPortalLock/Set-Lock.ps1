param( $lockValue = $(throw 'The lock value is required: Options (use numbers): AllAllowed=1, AllowedIPsOnly=2, DenyIPs=3, AllDenied=4'))
trap { trap-error $_.Exception $_.Exception.GetType().Name; break; }   
function trap-error
{
	throw("Error: $Args[1] $Args[0]")
}
function get-script
{
   if($myInvocation.ScriptName) { $myInvocation.ScriptName }
   else { $myInvocation.MyCommand.Definition }
}

function check-Permission ($_file)
{
	if ($(Get-childitem $file).IsReadOnly)
	{
		$(Get-childitem $file).Set_IsReadOnly($false)
	}
}

#Getting location of script running and then cd to it
$script = get-script
$script_folder = split-path $script
Push-Location $script_folder
#read in config info
$config = [xml] $(get-content .\Config.xml)

add-PSSnapin Harleysville.Deployment.SnapIn

#here update login web.Config to to passed in Access  Mode
foreach ($file in $config.Settings.Configs.Config)
{
	check-Permission $file
	$webConfig = [xml] $(get-content $file)
	foreach ($key in  $webConfig.configuration.AppSettings.Add)
	{
		if ($key.key.Equals("UserAccessMode"))
		{
			$key.value = $lockValue.ToString()
		}
	}
	
	$webConfig.Save($file)
	write-output "$file has been updated (UserAccessMode set to $lockValue)"
}

#Now need recycle website appPools 

foreach ($server in $config.Settings.Servers.Server)
{
	$appMessage = Clear-AppPool $server.Name $server.AppPool
	if (!$appMessage)
	{
		$appMessage = "IIS://" + $server.Name + "/W3SVC/AppPools/" + $server.AppPool + " was recycled"
	}
	
	Write-output $appMessage	
}

new-variable -Name message -value "Agent Portal has been"
switch ($lockValue)
{
	1 { $message += " opened to all users" }
	2 { $message += " opend to In-house users only"}
	3 { $message += " opend to IP addresses only"}
	4 { $message += " locked for all users"}
}
write-output $message




