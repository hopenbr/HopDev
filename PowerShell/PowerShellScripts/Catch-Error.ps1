#this script will catch errors and email it to the person who kick off process
#this script will be very slim at first, 
#PARAMETERS:
#0: Recipient of email
#1: Build Number
#2: $Error

$subject = "TFS Deploy ERROR: $Args[1]"
$Body = "There was an Error while Deploying in $Args[1]`nERORR: $Args[2]"

.\Send-Email.ps1 $Args[0] $subject $body

