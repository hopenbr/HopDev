param([string] $path2config =  $(throw 'Full UNC path to AQS service xml is required'), 
	  [string] $region = $(throw 'the Region where the services are is required'),
	  [string] $action = $(throw 'Action Stop or Start is required'), 
	  [bool] $silent = $($false))


[xml] $config = [xml] (gc $path2Config)

[string] $status = "Stopped"

[bool] $results = $true

Foreach($service in $config.Regions.SelectSingleNode("Region[@name='$($region.ToUpper())']").Services.Service)
{
	$so = new-Object System.ServiceProcess.ServiceController($($service.name),$($service.Server))
	
	if (-not $silent)
	{
		Write-Host "Current status of service: $($service.name) on $($service.Server) is $($so.Status)"
	}

	if ($action -eq "Start")
	{
		$status = "Running"
		
		if ($($so.Status) -eq $status)
		{
			if (-not $silent)
			{
				Write-Host "Service: $($service.name) on $($service.Server) already started"
			}
			
			continue
		}
		
		if (-not $silent)
		{
			Write-Host "Starting service: $($service.name) on $($service.Server)"
		}
		
		$so.Start()
		$so.WaitForStatus('Running',(new-timespan -seconds 5)) 

	}
	elseif ($action -eq "Stop")
	{
		if ($($so.Status) -eq $status)
		{
			if (-not $silent)
			{
				Write-Host "Service: $($service.name) on $($service.Server) already stopped"
			}
			
			continue
		}
		if (-not $silent)
		{
			Write-Host "Stoping service: $($service.name) on $($service.Server)"
		}
		
		$so.Stop() 
		$so.WaitForStatus('Stopped',(new-timespan -seconds 5)) 
	}
	else
	{
		throw "ERROR: Action type $action is invalid can only be 'Stop' or 'start'"
	}
	
	if ($so.Status -eq $status)
	{
		if (-not $silent)
		{
			Write-Host "Service: $($service.name) on $($service.Server) has been $($action)ed"
		}
		
	}
	else
	{
		if (-not $silent)
		{
			Write-Host "Service: $($service.name) on $($service.Server) TIMED OUT"
			$so.refresh()
			Write-Host "Current status of service: $($service.name) on $($service.Server) is $($so.Status)"
			
		}
		
		$results = $false
		
	}
	
	Write-Host "***"
	Write-Host
	
		
}

return $results