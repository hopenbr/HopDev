
begin{}

process
{
 
 $size= gci $_ -recurse -force | 
 ? { $_.GetType() -like 'System.IO.DirectoryInfo'} | 
 % {$_.GetFiles() } | 
 Measure-Object -Property Length -Sum |
 Measure-Object -Property Sum -Sum

  $size2 = (Get-item .).GetFiles() | 
  Measure-Object -Property Length -Sum

  [System.Math]::Round(($size.Sum + $size2.Sum) / 
    (1024 * 1024)).ToString() + "MB"
}

end{}