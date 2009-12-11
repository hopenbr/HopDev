###########
#Validate-XML.ps1 
#This script will validate some xml against an XSD to ensure it is 
#structural sound. 
#
############
param([string] $path2Xml = $(throw 'The full UNC path to the xml is required'),
	  [string] $schemaName = $(throw 'The schema name is required'),
	  [string] $schemaUrl = $(throw 'The schema Url is required'))
	  
trap{return $false}

$settings = New-Object Xml.XmlReaderSettings

$settings.ValidationFlags = [Xml.Schema.XmlSchemaValidationFlags]::ProcessInlineSchema
$settings.ValidationType = [xml.ValidationType]::Schema
#$settings.schemas.add($schemaUrl, $schemaName) | Out-Null
$settings.schemas.add($schemaName, $schemaUrl) | Out-Null

#$settings.Add_validationEventHandler({throw("Xml not valid at line: $($_.exception.LineNumber) position: $($_.exception.LinePosition)")})

$settings.Add_validationEventHandler({$Error.Add("Xml not valid at line: $($_.exception.LineNumber) position: $($_.exception.LinePosition)") | out-null})

$reader = [Xml.XmlReader]::Create($path2Xml, $settings)

$eCount = $Error.Count

while($reader.Read()){}
$reader.Close() | Out-Null

if ($eCount -eq $Error.Count)
{
	return $true
}
else
{
	return $false
}

