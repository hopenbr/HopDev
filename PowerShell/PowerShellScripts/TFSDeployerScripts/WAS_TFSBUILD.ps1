# Set-ExecutionPolicy Unrestricted
# Set-ExecutionPolicy Restricted
# ###################################################################################
# ###################################################################################
#
# Powershell deployment script for WebSphere EAR(s) (Enterprise Application Archives)
#
# Note that portions are derived from BAT scripts provided by IBM
#      If at any time those BAT files are updated by IBM, the appropriate changes
#      need to be made in this script...
#      Reason that this was done was that the BAT process makes use of ERRORLEVEL
#      and Powershell uses LastExitCode, and there appears to be no interface if
#      we were to simply have Powershell exec the BAT...
#
#####
#Update 10-16-2008
## function check-sdlc removed
## this subroutine's functionality was pushed out to the config.xml, 
## DeploymentConfig.xml and Deploy-Ear.ps1
## The information is passed in as parameters
##
# 
# ###################################################################################


# ###################################################################################
# Set arguments/parameters
# ###################################################################################
param($SDLC = $(Throw "Exception: missing argument specifying SDLC target"),
	  $hgi_host =  $(Throw "Exception: missing argument specifying Host target"),
      $hgi_port =  $(Throw "Exception: missing argument specifying Port target"),
      $hgi_user =  $(Throw "Exception: missing argument specifying User ID target"),
      $hgi_password =  $(Throw "Exception: missing argument specifying Password target"),
	  $APPN = $(Throw "Exception: missing argument Specifying Application Name" ), 
	  $EARU = $(Throw "Exception: missing argument Specifying EAR (fully qualified UNC path)"))  


# #####################################################################################
# NOTE THAT THE FOLLOWING DERIVED FROM wasadmin.bat     and modified for PowerShell
# #####################################################################################

# #####################################################################################
# NOTE THAT THE FOLLOWING DERIVED FROM setupCmdLine.bat and modified for PowerShell
# #####################################################################################
    $WAS_HOME="E:\WAS\dmgr"
    $JAVA_HOME="E:\WAS\dmgr\java"
    $WAS_CELL="$env:computername"
    $WAS_NODE="$env:computername"

    $ITP_LOC="$WAS_HOME\deploytool\itp"
    $CONFIG_ROOT="$WAS_HOME\config"
    $CLIENTSAS="-Dcom.ibm.CORBA.ConfigURL=file:$WAS_HOME/properties/sas.client.props"
    $CLIENTSOAP="-Dcom.ibm.SOAP.ConfigURL=file:$WAS_HOME/properties/soap.client.props"
    $WAS_EXT_DIRS="$JAVA_HOME\lib;$WAS_HOME\classes;$WAS_HOME\lib;$WAS_HOME\lib\ext;$WAS_HOME\web\help;$ITP_LOC\plugins\com.ibm.etools.ejbdeploy\runtime"
    $WAS_BOOTCLASSPATH="$JAVA_HOME\jre\lib\ext\ibmorb.jar"
    $WAS_CLASSPATH="$WAS_HOME\properties;$WAS_HOME\lib\bootstrap.jar;$WAS_HOME\lib\j2ee.jar;$WAS_HOME\lib\lmproxy.jar;$WAS_HOME\lib\urlprotocols.jar"
    $WAS_PATH="$WAS_HOME\bin;$JAVA_HOME\bin;$JAVA_HOME\jre\bin;$PATH"
    $CLOUDSCAPE_HOME="$WAS_HOME\cloudscape"
# #####################################################################################
# NOTE END OF THAT        DERIVED FROM setupCmdLine.bat and modified for PowerShell
# #####################################################################################
# #####################################################################################
# NOTE THAT THE FOLLOWING DERIVED FROM wasadmin.bat     and modified for PowerShell
# #####################################################################################
$sh_out = &"$JAVA_HOME\bin\java" "$CLIENTSOAP" "$CLIENTSAS" "-Dcom.ibm.ws.scripting.wsadminprops=$WSADMIN_PROPERTIES" "-Dcom.ibm.ws.management.standalone=true" "-Duser.install.root=$USER_INSTALL_ROOT" "-Dwas.install.root=$WAS_HOME" "-Dwas.repository.root=$CONFIG_ROOT" "-Dserver.root=$WAS_HOME" "-Dlocal.cell=$WAS_CELL" "-Dlocal.node=$WAS_NODE" "-Dcom.ibm.itp.location=$WAS_HOME\bin" "-classpath" "$WAS_CLASSPATH;$WAS_HOME\lib\jython.jar" "-Dws.ext.dirs=$WAS_EXT_DIRS" "com.ibm.ws.bootstrap.WSLauncher" "com.ibm.ws.scripting.WasxShell" "-host" "$hgi_host" "-port" "$hgi_port" "-user" "$hgi_user" "-password" "$hgi_password" "-f" "E:\WAS_JACL\HGIC_Deploy_EAR.jacl" "$APPN" $($EARU -replace "\\", "\\")
# #####################################################################################
# NOTE END OF THAT        DERIVED FROM wasadmin.bat     and modified for PowerShell
# #####################################################################################


# ############################################################################################################ #
# NOTE: if LastExitCode is -1, then the deployment script failed because the application to be deployed is new
# ############################################################################################################ #

$LastExitCode
if ($LastExitCode -eq 105) {$sh_out; Throw "An exception occurred in the wsadmin JACL script`n$sh_out"}
if ($LastExitCode -eq -1)  {$sh_out; Throw "Invalid application, as it was not previously deployed manually to $SDLC"}
if ($LastExitCode -ne 0)   {$sh_out; Throw "An unknown exception has occurred`n$sh_out"}

$sh_out