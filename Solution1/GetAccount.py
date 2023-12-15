import requests

def get_account_id_details(subdomain, account_id, token):
    # Construct the API URL
    api_url = f"https://{subdomain}.privilegecloud.cyberark.com/PasswordVault/API/Accounts/{account_id}/"

    try:
        # Set up headers with authentication token
        headers = {
            'Authorization': f'Bearer {token}'
        }

        # Invoke the API and retrieve the result
        response = requests.get(api_url, headers=headers)
        response.raise_for_status()  # Raise an error for bad responses (4xx or 5xx)

        # Display the result
        result = response.json()
        print(result)
    except requests.exceptions.RequestException as e:
        print(f"Error retrieving account details: {e}")

# Example usage
token = "YOUR_ACCESS_TOKEN"  # Replace with your actual access token
account_id = "123456"        # Replace with the actual account ID
subdomain = "your-subdomain"  # Replace with your actual subdomain

# Call the function to get account details
get_account_id_details(subdomain, account_id, token)
