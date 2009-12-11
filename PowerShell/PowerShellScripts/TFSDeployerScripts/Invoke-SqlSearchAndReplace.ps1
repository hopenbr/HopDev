##SQL Script and Replace 
#this script will search all of the sql scripts a use the SearchandReplace.xml
#to replace all values found 

param([string] $path2scriptsFolder = $(throw 'Full UNC path to Scripts folder is required'),
	  $deployer = $(throw 'The SRM TFS Deployer object is required'))


#SearchAndReplace hierachy 
# The SRM xml is the highest in the order meaning it can be override by all others
#next we will look at the Pre-Deployment area of the Database area 
#and lastly the EnvConfig DB area 

#Searches can be override by lower xml   

function add-ToSearchAndReplaceHash ([hashtable] $srh, [xml] $srx)
{
	foreach ($search in $srx.Searches.Search)
	{
		if ($srh.containsKey($($search.searchfor)))
		{
			$srh[$($search.searchfor)] = $($search.replacewith)
		}
		else
		{
			$srh.add($($search.searchfor), $($search.replacewith))
		}
	}
	
	return $srh
	
}

####MAIN###

##Create SearchAndReplace hash 

$deployer.logger.log("Preparing for SQL scripts Search and Replace", "info")

[string] $srmSrSeverPath = $($deployer.Config.Deployment.ServerPaths.DBSearchAndReplace) + "/" + $($deployer.RegionName.ShortName) + "/"  + "SearchAndReplace.xml"

[string] $srmSearchAndReplace = $($deployer.Config.Deployment.TempLocation + "searchAndReplace.xml")

$deployer.Tfs.VCS.DownloadFile($srmSrSeverPath, $srmSearchAndReplace)

[string] $deploymentSearchAndReplace = Join-Path $path2scriptsFolder "Pre-Deployment\SearchAndReplace.xml"

[string] $regionSearchAndReplace = Join-Path $deployer.BuildData.DropLocation $("Env.Config\" + $($deployer.RegionName.FullName) + "\DB\SearchAndReplace.xml")

[hashtable] $srXml = @{}
[hashtable] $searchAndReplacements = @{}

$srXml.Add(1, $srmSearchAndReplace)
$srXml.Add(2, $deploymentSearchAndReplace)
$srXml.Add(3, $regionSearchAndReplace)

#this ensures that SearchAndReplace hash is updated in the correct order 
for ($i = 1; $i -le 3; $i++)
{	
	if (Test-Path $srXml[$i])
	{
		$deployer.logger.log("$srXml[$i] added to Search and replace" , "debug")
		
		[xml] $xml = [xml] (gc $srXml[$i])
		
		$searchAndReplacements = add-ToSearchAndReplaceHash $searchAndReplacements $xml
	}
}

#call search and replace on correct areas in schema 
[string] $schemaFunction = Join-Path $path2scriptsFolder "Schema\Functions\*.sql"
[string] $schemaSP = Join-Path $path2scriptsFolder "Schema\Stored Procedures\*.sql"
[string] $schemaViews = Join-Path $path2scriptsFolder "Schema\Views\*.sql"

[array] $files = @()

if ($(Test-Path $schemaFunction))
{
	$deployer.logger.log("Running Search and replace on $schemaFunction" , "debug")
	$files += Get-ChildItem $schemaFunction -recurse 
}

if ($(Test-Path $schemaSP))
{
	$deployer.logger.log("Running Search and replace on $schemaSP" , "debug")
	$files += Get-ChildItem $schemaSP -recurse 
}

if ($(Test-Path $schemaViews))
{
	$deployer.logger.log("Running Search and replace on $schemaViews" , "debug")
	$files += Get-ChildItem $schemaViews -recurse 
}

if ($files.count -gt 0)
{
	$deployer.logger.log("Search and replace will scan $($files.Count) elements" , "debug")
	$files | .\Invoke-SearchAndReplace.ps1 $searchAndReplacements
}
else
{
	$deployer.logger.log("No elements will be scanned for search and replace" , "warning")
}

$deployer.logger.log("Search and replace Complete", "info")