param(
    [string] $_local = $(throw 'Local path for the workspace is required'),
    [string] $_server = $(throw 'Server path for workspace required'),
    [string] $_label = $("")
)

Add-PSSnapIn Harleysville.Deployment.SnapIn -ea silentlycontinue
[string] $_ws 

if ($_label.Length -gt 0)
{
	$_ws = Get-FromTFVC $_local $_server $_label
}
else
{
	$_ws = Get-FromTFVC $_local $_server 
}

return $_ws


