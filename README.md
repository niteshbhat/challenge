# challenge
 jgroupconsulting challenge 

## Challenge Solutions:
**Solution 1:**
Produce a PowerShell and a Python script that would automatically retrieve an account in a specific safe and provide all the metadata from CyberArk.

**Solution 2:**
Produce a script that provides the help status of all the components of a CyberArk.

**Solution 3:**
Provide an example of an automated process of your choosing related to CyberArk.

# CyberArk API User Access Management Script

In a production-type environment, additional security measures are implemented to ensure the safe storage of CyberArk API user access. The approach involves storing the API user access in a safe as an account and setting policies to restrict access only to specific machines. Access to this information is granted using a service account with a password access approach. Below is a script demonstrating these practices.

## Token Generation for the Challenge 

```powershell
Add-Type –AssemblyName System.Web

$cred = Get-Credential –Message "Please enter the credentials for logging into CyberArk host cyberarkhost.com" –UserName $env:UserName

$AUTH_URI = "https://cyberarkhost.com/PasswordVault/API/auth/LDAP/Logon"
$Headers = @{
    'accept'='application/json';
    'content-type'='application/json'
}
$body = @{
    username = "$($cred.UserName)"
    password= "$($cred.GetNetworkCredential().password)"
}

$CyberBody = $body | ConvertTo-Json
$token = Invoke-RestMethod –Method Post –Uri $AUTH_URI –Body $CyberBody –Headers $Headers
