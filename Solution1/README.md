# Get-AccountIDDetails PowerShell Function

## Overview

The `Get-AccountIDDetails` PowerShell function is designed to retrieve account details from the CyberArk Privilege Cloud using a specified account ID, subdomain, and authentication token.

## Table of Contents

- [Usage](#usage)
- [Parameters](#parameters)
- [API Endpoint](#api-endpoint)


## Usage

```powershell
# Example usage
$token = "YOUR_ACCESS_TOKEN"  # Replace with your actual access token
$accountID = "123456"          # Replace with the actual account ID
$subdomain = "your-subdomain"  # Replace with your actual subdomain

# Call the function to get account details
Get-AccountIDDetails -subdomain $subdomain -accountID $accountID -token $token
