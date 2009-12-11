#Compare-folders 
#compares the contents of two folders recursively 
#
#returns: collection of diff objects 

param([System.IO.DirectoryInfo] $source = $(throw 'The source directory is required'),
      [System.IO.DirectoryInfo] $target = $(throw 'The target directory is required'),
	  [string] $searchPattern = $("*"),
	  [bool] $recursive = $($true))


#Diff object 

function create-Diff ([System.IO.FileInfo] $sf, [System.IO.FileInfo] $tf, [string] $type)
{
	$diff = New-Object Object
	
	$diff | Add-Member -MemberType NoteProperty -Name "Type" -Value $type
	
	$diff | Add-Member -MemberType NoteProperty -Name "Source" -Value $sf
	
	$diff | Add-Member -MemberType NoteProperty -Name "Target" -Value $tf
	
	return $diff
	
}

Add-PSSnapIn Harleysville.Deployment.SnapIn -ea silentlycontinue

$searchOption = [System.IO.SearchOption]::AllDirectories

if (!$recursive)
{
	$searchOption = [System.IO.SearchOption]::TopDirectoryOnly
}

foreach($file in $source.Getfiles($searchPattern, $searchOption))
{
	
	$targetFile = New-Object -TypeName System.IO.FileInfo -ArgumentList $($file.FullName -replace $($source.FullName -replace "\\", "\\"), $target.FullName)
	#get the target file
	
	if($targetFile.Exists)
	{
		if (!$(Compare-Files $file.FullName $targetFile.FullName))
		{
			write-output $(create-Diff $file $targetFile "Different")
		}
		
	}
	else
	{
		write-output $(create-Diff $file $targetFile "Orphan")
	}
}


