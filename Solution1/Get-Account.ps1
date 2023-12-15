# Function to retrieve account details by ID
function Get-AccountIDDetails {
    param(
        [string]$subdomain,
        [string]$accountID,
        [string]$token
    )

    # Construct the API URL
    $apiUrl = "https://<subdomain>.privilegecloud.cyberark.com/PasswordVault/API/Accounts/$accountID/"

    try {
        # Set up headers with authentication token
        $headers = @{
            'Authorization' = "Bearer $token"
        }

        # Invoke the API and retrieve the result
        $result = Invoke-RestMethod -Uri $apiUrl -Headers $headers -Method Get

        # Display the result
        $result | Format-List
    }
    catch {
        Write-Error "Error retrieving account details: $_"
    }
}

# Example usage
$token = "YOUR_ACCESS_TOKEN"  # Replace with your actual access token
$accountID = "123456"          # Replace with the actual account ID

# Call the function to get account details
Get-AccountDetails -subdomain $subdomain -accountID $accountID -token $token
