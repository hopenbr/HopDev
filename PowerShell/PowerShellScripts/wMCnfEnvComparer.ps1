#param($env = $(Throw 'The environment to be compared is required'))

function log ([string]$_msg)
{
	write-host $_msg
}

function Error ([string] $_err)
{
	write-warning $_err
}

function change_CNF ([string]$sdlc, [string]$package, [string]$cnfPath) 
{
	$searchXml = [xml] (Get-Content C:\Projects\SRM\Branches\DEVELOPMENT\PowerShell\PowerShellScripts\webMethodsScripts\wMEnvSearchAndReplaceMappings.xml)
	
	log ("Updating Service.cnf:`nPackage: " + $package + "`nPath: " + $cnfPath)
	
	if ($searchXml.Packages.SelectSingleNode("Package[@Name='$package']"))
	{
		if ($searchXml.Packages.SelectSingleNode("Package[@Name='$package']").Environments.SelectSingleNode("Environment[@Name='$sdlc']"))
		{
			[string] $log = ""
			$cnfPath += ($searchXml.Packages.SelectSingleNode("Package[@Name='$package']").Environments.SelectSingleNode("Environment[@Name='$sdlc']").Searches.GetAttribute("FileName2Search"))
			$cnf = (get-content $cnfPath)
			
			foreach ($search in $searchXml.Packages.SelectSingleNode("Package[@Name='$package']").Environments.SelectSingleNode("Environment[@Name='$sdlc']").Searches.Search)
			{
				$regex = [regex] $search.GetAttribute("Regex")
				$replace = $search.GetAttribute("Replace")
				
				if ($regex.IsMatch($cnf))
				{
					$cnf = $cnf -replace $regex, $replace
					
					$log += ("`nSearched (" + ($regex.ToString()) + ") Replaced with (" + $replace + ")`n")
				}
				else
				{
					Error ("Wm Deployer Error: CNF update package " + $package + " empty search results. `nSearch: " + ($regex.ToString()) + "`nCNF: " + $cnfPath)
						
				}
			}
			
			set-content -path $cnfPath -value $cnf
			
			log ("Update Complete:`nPackage: " + $package + "`nPath: " + $cnfPath + "`n" + $log)
		}
		else
		{
			Error ("Wm Deployer Error: CNF update package " + $package + " No environment (" + $sdlc + ") Searches found" )
		}
		
	}
	else
	{
		$warn =  ("WmDeployer: "  + $package + " No Searches to update" )
		
		#.\Write-EventLog.ps1 $warn $wMconfig.wM.EventSource "4201" "Warning"
	}

}

log $("Starting conversion")

add-pssnapin Harleysville.Deployment.SnapIn -ea silentlycontinue

$envList = Set-wMCnfEnv $true
$envCnfList = @{}
log $("Environments: " + $envList)
foreach ($_env in $envList)
{
	$cnfFiles = get-childitem $("C:\Temp\wM\" + $_env + "\Packages") -include *.cnf -recurse | foreach {$_.FullName}
	$envCnfList.Add($_env, $cnfFiles);
	
	#log $("Cnf list: " + $cnfFiles)
	
	#foreach ($cnf in $cnfFiles)
	#{
		#$package = split-path $(Split-path $(Split-Path $cnf -Parent) -Parent) -leaf
	
		#change_CNF $_env $package $((Split-Path $cnf -Parent) + "\") 
	#}
}

$regex = [regex] "\\(\w+?)\\config\\"
$wsPath = "C:\Projects.Web\wM\WMSourceControl\Config"

foreach ($key in $envCnfList.Keys)
{
	$packagesDirInfo = "" 
	
	if (!(Test-Path $($wsPath + "\" + $key)))
	{
		$temp = new-item -path $wsPath -name $key -type directory
		$packagesDirInfo = new-item -path $temp.FullName -name "Packages" -type directory
	}
	
	if ($packagesDirInfo.FullName)
	{
		foreach ($cnf in $envCnfList[$key])
		{
			$results = $regex.Match($cnf)
			log $("CNF: " + $cnf)
			
			$pDirInfo = new-item -path $packagesDirInfo.FullName -name $results.Groups[1].Value -type directory
			$cDirInfo = new-item -path $pDirInfo.FullName -name "Config" -type directory
			Copy-Item -path $cnf -Dest $cDirInfo.FullName
			
		}
	}
	else
	{
		Error $("No Package Directory Info")
	}
}

