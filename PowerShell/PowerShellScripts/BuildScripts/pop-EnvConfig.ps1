param($projectName = $("Web"), $folderType = $("Access"))
begin 
{
	$folderNames = @("In-Assembly", "In-QA2", "In-End2End", "In-Training", "In-PrePrd", "In-Production", "In-TST1")
	
	if ($folderType -ne "Access")
	{
		$folderNames = @("In-Test", "In-Staging", "In-Production")
	}
	
	foreach ($name in $folderNames)
	{
		
		if ($(split-path $(Get-Location) -Leaf) -ne "Env.Config")
		{
			New-Item -path . -Name "Env.Config" -ItemType Directory | Push-Location
		}
		
		if (!$(Test-Path ".\$name"))
		{
			New-Item -path . -Name $name -ItemType Directory 
		}
		
		if (!$(Test-Path ".\$name\$projectName"))
		{
			New-Item -Path ".\$name" -Name $projectName -ItemType Directory
		}
	}
}
process
{	
	Write-Debug "File => $_.FullName"
	
	foreach ($folder in @(Get-ChildItem | where {$_.Mode -match "d"}))
	{
		Write-Debug "Folder => $folder.FullName"
		
		$dest = (Join-Path $folder.FullName $projectName)
		
		Write-Debug "Dest => $dest"
		
		Push-Location $dest
		 
		copy-item -path $_.FullName -force -recurse -destination $dest
		
		Pop-Location
	}
}
end
{
	Write-Debug "Complete"
}