cd E:\Harleysville.Projects
$dir = get-childitem | where-object {$_.Mode -match "d"}
Foreach ($d in $dir) 
{
     $drop = $d.get_Fullname() + "\drops"
     get-childitem $drop | where-object {$_.Name -match "CI_20"} | remove-item -force -recurse
}
