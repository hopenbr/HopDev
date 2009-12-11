#The Remove-All script will remove all elements (files, sub-folders) for a given folder
#PARAMETERS:
#0: full path to folder needing to be cleaned out


param(
	[string] $dir = $(throw 'Missing parameter: Directoy path required')
)

begin
{
	write-output "Cleaning directory $dir"
}
process
{
	get-childitem $dir | remove-item -force -recurse
}
