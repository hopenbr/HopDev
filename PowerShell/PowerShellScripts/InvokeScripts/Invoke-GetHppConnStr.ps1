#invoke-GetHppConnStr 

#this script will invoke the get-HppConnectionString script
#It is designed to be called from the HPP WebApp 
#therefore all the params will be declared globally via the Web App 

cd $hpp
return $(.\Get-HppConnectionString.ps1 $hppRegPath $serName $dbName)