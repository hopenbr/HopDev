param ($string = $(throw 'The string to be encrypted or decrypted is required'), 
	   $salt = $(throw 'The key salt to use to derive the key is required'),
	   $pass = $(throw 'The password to derive the key for is required'),
	   [string] $init = $("Harleysville PowerPlatform"),
       [switch] $encrypt,
	   [switch] $decrypt)
	
#need to make the string into byte arrays
$salt = [Text.Encoding]::UTF8.GetBytes($salt)
$pass = [Text.Encoding]::UTF8.GetBytes($pass)

##NOTE:
#Hopefully the above salt and pass are taken from a secure place like the 
#registry this way they can be used again fpr the decrypt, 
#if the pass, salt or init are lost the encryption can never be decrypted 

if($encrypt)
{
	$r = new-Object System.Security.Cryptography.RijndaelManaged  # use Rijndael symmetric key encryption
	$r.Key = (new-Object Security.Cryptography.PasswordDeriveBytes $pass, $salt, "SHA1", 5).GetBytes(32) #256/8
	$r.IV = (new-Object Security.Cryptography.SHA1Managed).ComputeHash( [Text.Encoding]::UTF8.GetBytes($init) )[0..15]
	$c = $r.CreateEncryptor()    # Set the key and initialisation vector to 128-bytes each of (1..16)
	$ms = new-Object IO.MemoryStream
	$cs = new-Object Security.Cryptography.CryptoStream $ms,$c,"Write" # Target data stream, transformation, and mode
	$sw = new-Object IO.StreamWriter $cs
	$sw.Write($String)       # Write the string through the crypto stream into the memory stream
	$sw.Close()
	$cs.Close()
	$ms.Close()
	$r.Clear()
	[byte[]]$result = $ms.ToArray()      # Byte array from the encrypted memory stream
	$encstring = [Convert]::ToBase64String($result)    # Convert to base64 for transport
	
	return $encstring         # The encrypted base64 string representation
}
elseif($decrypt)
{

	$Encrypted = [Convert]::FromBase64String($string)   # Convert the encrypted string to a byte array
	$r = new-Object System.Security.Cryptography.RijndaelManaged  # use Rijndael symmetric key encryption
	$r.Key = (new-Object Security.Cryptography.PasswordDeriveBytes $pass, $salt, "SHA1", 5).GetBytes(32) #256/8
	$r.IV = (new-Object Security.Cryptography.SHA1Managed).ComputeHash( [Text.Encoding]::UTF8.GetBytes($init) )[0..15]
	$d = $r.CreateDecryptor()    # Set the key and initialisation vector to 128-bytes each of (1..16)
	
	$ms = new-Object IO.MemoryStream @(,$Encrypted)    # Create a memorystream from a single-element name/value pair hash table of the byte array
	$cs = new-Object Security.Cryptography.CryptoStream $ms,$d,"Read" # Target data stream, transformation, and mode
	$sr = new-Object IO.StreamReader $cs     # Read the string through the crypto stream from the encrypted memory stream
    $rt = $sr.ReadToEnd()    # Write the unencrypted string
	$sr.Close()
	$cs.Close()
	$ms.Close()
	$r.Clear()
	
	return $rt
}
else
{
	throw "Error: No encryption switch passed in`nUsage New-Encryption [string][string] [string] (string) [-encrypt|-decrypt]" 
}