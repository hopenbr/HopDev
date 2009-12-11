#new-FileSHA1.ps1
#this scripts will take a content SHA and return the hash key 
#reutn can either be a file with same name in same directory with .sha1 extension 
#or just return string key(s) back to pipeline
#
#param ([Parameter(Position=0, mandatory=$true, valuefrompipeline=$true)] [System.IO.FileInfo] $_) 

param ([bool] $output2File = $($false),
	   [bool] $continueOnError = $($false)) 
 
begin 
{
	# Get the alghorthm object 
	$Algo = [System.Security.Cryptography.HashAlgorithm]::Create('SHA1')
}

process
{
	#trap errors if the file stream is still open it needs to be closed
    trap{ if ($streamOpen){$fs.close()}}
	
	#I expect a fileInfo object collection in from pipeline
	[bool] $streamOpen = $false
	
	[System.IO.FileInfo] $file = $_
	
	if ($file.exists)
	{
		#get the file stream 
		[System.IO.FileStream] $fs = [System.IO.File]::OpenRead($file.FullName)
		
		$streamOpen = $true
		
		if ($fs.length -gt 0) 
		{ #ensure file is not empty 
		
			# Now compute hash 
			$Hash = $Algo.ComputeHash($Fs)    
			[string] $Hashstring ="" 
			
			#get the hash Key
			foreach ($byte in $hash) 
			{
				$hashstring += $byte.tostring("x2")
			} 
			
			#check for output type
			if ($output2File)
			{
				#out to file will just create file in same directory with a .sha1 extension
				$output = $(Join-Path $($file.Directory.FullName) $($file.name.remove($($file.name.length - $file.extension.Length))+ ".sha1"))
			
				$hashString | Out-File -FilePath $output
			}
			else
			{
				#add key to pipeline
				Write-Output $hashString
			}
			
		} 
		else 
		{ 
			if (!$continueOnError) 
			{ #some file types cannot be hashed 
				throw $("File {0} can not be hashed" -f $file.FullName)
			}      
		} 
		
		#clean up 
		$fs.close()
		$streamOpen = $false
	}
	else
	{
		if (!$continueOnError) 
		{
			throw $("File {0} does not exist" -f $file.FullName)
		}  
		
	}
}

end{}