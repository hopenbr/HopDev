param(
    [string] $base = $(throw 'base dir path is required'),
    [string] $startWith = $(throw 'start search is required'),
    [string] $replace =  $(throw 'replace search is required'),
    [string] $project = $(throw 'project is required'),
    [bool] $releaseReady = $($false),
    [bool] $isInTfs = $($false)
)

function get-script
{
   if($myInvocation.ScriptName) { $myInvocation.ScriptName }
   else { $myInvocation.MyCommand.Definition }
}

$script = get-script
$script_folder = split-path $script
Push-Location $script_folder
$tfs = .\Get-tfs.ps1 "Http://as73tfs01:8080"
$ws = .\Get-Tfsworkspace.ps1 "C:\TFSworkspaces\wM" $false $tfs
$ws.Get()
pop-location


foreach ($dir in (Get-Childitem $base | Where-object {$_.Mode.Contains("d")}))
{
	write-host $dir
	
	if ($dir.Name.StartsWith($startWith))
	{
		write-host $dir.Name 
		
		foreach ($file in (Get-Childitem $dir.FullName -include *.* ))
		{
			if ($file.IsReadOnly)
			{
				if (!$isInTfs)
				{
					$file.set_IsReadOnly($false)
				}
				else
				{
					$ws.PendEdit($file.FullName)
				}
			}
				
			write-host $file.FullName
			
			$content = (Get-Content $file.FullName)
			
			$packageName = $($dir.Name.Split("."))[2]
			
			#$content = $content -replace $replace, $packageName
			#$content = $content -replace "Agency", $project
			
			
			
			
			if ($file.FullName.EndsWith(".rsp") -and $dir.Name.EndsWith(".Release"))
			{
				write-host $file.Fullname
				
				if ($releaseReady)
				{
					$content = $content -replace "/p:Deploy=false", "/p:Deploy=true"
					$content = $content -replace "/p:Deploy2Drop=false", "/p:Deploy2Drop=true"
					$content = $content -replace "/p:UpdateBuildNumber=false", "/p:UpdateBuildNumber=true"
					$content = $content -replace "/p:UseBuildNumber=false", "/p:UseBuildNumber=true"
				}
				else
				{
					$content = $content -replace "/p:Deploy=true", "/p:Deploy=false"
					$content = $content -replace "/p:Deploy2Drop=true", "/p:Deploy2Drop=false"
					$content = $content -replace "/p:UpdateBuildNumber=true", "/p:UpdateBuildNumber=false"
					$content = $content -replace "/p:UseBuildNumber=true", "/p:UseBuildNumber=false"
				}
				
				$content = $content -replace "/p:NewBuildQuality=`"Unexamined`"", "/p:NewBuildQuality=`"Deploy2-Assembly`""
				#Set-Content -Path $file.FullName -Value $content -force
			}
			
			
			Set-Content -Path $file.FullName -Value $content -force
			
			
			
		}
	}
}