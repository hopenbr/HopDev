#invoke-NewwMBuildPackage

#this script will invoke the new-wMBuildPackage script from the 
#HPP WebApp
#It is simple just takes the global variables set by HPP WebApp 
#and uses those as parameters

#Global varibales set:
#HPP => path to HPP
#packName => New wM package name
#projType => the wM project type (CL, PL, Common)
#confName => the Package config file name 
#webUser => the user logged in

cd $HPP

return $(.\BuildScripts\New-wMBuildPackage.ps1 $packName $projType $confName)
