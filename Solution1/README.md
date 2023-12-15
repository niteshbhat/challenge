# Get-safeIDDetails PowerShell Function

## Overview

The `Get-safeIDDetails` PowerShell function is designed to retrieve account details from the CyberArk Privilege Cloud using a specified safe ID, subdomain, and authentication token.

## Table of Contents

- [Usage](#usage)
- [Parameters](#parameters)
- [API Endpoint](#api-endpoint)


## Usage

```powershell
# Example usage
$token = "YOUR_ACCESS_TOKEN"  # Replace with your actual access token
$safeID = "123456"          # Replace with the actual account ID
$subdomain = "your-subdomain"  # Replace with your actual subdomain

# Call the function to get account details
Get-safeIDDetails -subdomain $subdomain -safetID $safeID -token $token
