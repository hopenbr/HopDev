#The Send-Email script will send an email to an email address
#PARAMETERS:
#0: recipient (full email address ie name@harleysvillegroup.com)
#1: The subject of message
#2: Body of message

param(
	[string] $recipient = $(throw 'recipient address is required'),
	[string] $subject = $(throw 'message subject is required'),
	[string] $body = $(throw 'message body is required')
)

begin
{
	write-output "Sending Email to $recipient"
}
process
{
	
	$sender = "SRM@harleysvillegroup.com"                                                         
	$server = "172.20.2.15"  
	$regex = [regex] "<[\w\s].+>"
	$msg 
	if ($recipient.Contains(";"))
	{
		$msg = new-object System.Net.Mail.MailMessage
		$msg.from = $sender
		
		foreach ($rec in $recipient.split(";"))
		{
			$msg.to.add($rec)
		}
		
		
		$msg.Body = $body
		$msg.Subject = $subject
		
	}
	else
	{                                                        
		$msg = new-object System.Net.Mail.MailMessage $sender, $recipient, $subject, $body
	}
	
	if ($regex.match($body).Success)
	{
		$msg.IsBodyHtml = $true
		
		$body = ($body -replace "`n", "<br>")
	}
	
	#$attachment = new-object System.Net.Mail.Attachment $file                         
	#$msg.Attachments.Add($attachment)                                                 
	$client = new-object System.Net.Mail.SmtpClient $server                           
	$client.Credentials = [System.Net.CredentialCache]::DefaultNetworkCredentials     
	$client.Send($msg)    
}