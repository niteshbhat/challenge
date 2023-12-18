# PowerShell Script for CyberArk Integration

## Module Installation

```powershell
# Check if psPAS module is installed, if not, install it
if (-not (Get-Module -Name psPAS -ListAvailable)) {
    Install-Module -Name psPAS -RequiredVersion 6.0.30 -Force -ErrorAction Stop
}

# Check if IdentityCommand module is installed, if not, install it
if (-not (Get-Module -Name IdentityCommand -ListAvailable)) {
    Install-Module -Name IdentityCommand -Force -ErrorAction Stop
}

```
# Import the modules
```
Import-Module -Name psPAS -ErrorAction Stop
Import-Module -Name IdentityCommand -ErrorAction Stop

try {
    # Get credentials
    $cred = Get-Credential -UserName "niteshbhat@jgroupconsulting.com.au" -Message 'Please enter the password'

    # New Session has been activated
    try {
        New-PASSession -IdentityTenantURL 'https://aba4130.id.cyberark.cloud' -PrivilegeCloudURL 'https://jgroup.privilegecloud.cyberark.cloud' -Credential $Cred -IdentityUser
    } catch {
        Write-Host "An error occurred: $_"
        # Add additional error handling or logging as needed
    }

    if ($(Get-PASLoggedOnUser).UserName -eq "niteshbhat@jgroupconsulting.com.au") {
        write-host "Code to execute if the condition is true (successful login)"
    } else {
        write-host "Unable to login into the session"
    }

    # Q1 What is the domain_admin01 password under password Nitesh_API_Testing?
    Write-host "#Q1 What is the domain_admin01 password under password Nitesh_API_Testing?"
    $account = Get-PASAccount -SafeName "Nitesh_API_Testing" -Search "domain_admin01" -ErrorAction Stop
    $accountID = $($($account).ID)
    $accountPassword= Get-PASAccountPassword -AccountID $accountID -Reason "Thanks for the challenge" -ErrorAction Stop
    write-host "Reason is retrieve the password 'Thanks for the challenge' and Username: $($accountPassword).UserName & Password: $($accountPassword).Password"

    # Q2 What are all the safes you have access to?
    Write-host "#Q2 What are all the safes you have access to?"
    # Get the list of PASafe objects
    $passafes = Get-PASSafe

    # Initialize an empty string to store concatenated descriptions
    $descriptions = ""

    # Iterate through each PASafe object
    foreach ($safe in $passafes) {
        # Concatenate the descriptions with a ","
        $descriptions += $safe.Description + ","
    }

    # Remove the trailing ","
    $descriptions = $descriptions.TrimEnd(',')

    # Output the result
    Write-Host "We have $($passafes.Count) and their descriptions are $descriptions"

    # Q3 Add an account into the CTF safe you have access to and provide the details for reference
    write-host "#Q3 Add an account into the CTF safe you have access to and provide the details for reference"
    # Convert plain text password to secure string
    $securePassword = ConvertTo-SecureString -String "Secret1337$" -AsPlainText -Force

    # Add account to a safe
    Add-PASAccount -SecretType Password -Secret $securePassword -SafeName "Nitesh_CTF_Safe" -PlatformID "WinServerLocal" -Username "niteshbhat" -Address "bigserver.com" -ErrorAction Stop
    Write-Output "Account added successfully."

} catch {
    # Handle errors
    Write-Error "Error: $_"
    # Log or perform additional actions as needed
} finally {
    # Close PASSession which has been closed
    Close-PASSession
}
```

##  output 
```
<img width="530" alt="image" src="https://github.com/niteshbhat/challenge/assets/7299171/38b94772-19c2-44c0-ad7f-8f898cb6a3bf">
```
