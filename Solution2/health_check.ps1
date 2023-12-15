# Define the list of API endpoints to check
$apiEndpoints = @(
    "PVWA",
    "SessionManagement",
    "CPM",
    "PTA",
    "AAM Credential Providers"
)

# Base URL for the APIs
$baseUrl = "https://<IIS_Server_Ip>/api/ComponentsMonitoringDetails/"

# Teams Incoming Webhook URL From teams
$teamsWebhookUrl = "https://outlook.office.com/webhook/YOUR_WEBHOOK_URL_HERE"

# Function to send alert to Teams channel
function Send-TeamsAlert {
    param (
        [string]$message
    )

    $payload = @{
        "@type" = "MessageCard"
        "@context" = "http://schema.org/extensions"
        "themeColor" = "EA4300"
        "title" = "CyberArk Alert"
        "text" = $message
    } | ConvertTo-Json

    Invoke-RestMethod -Uri $teamsWebhookUrl -Method Post -Body $payload -ContentType 'application/json'
}

# Function to send email alert
# Email Format can be improved 
function Send-EmailAlert {
    param (
        [string]$subject,
        [string]$body
    )

    $smtpServer = "your_smtp_server"
    $smtpFrom = "your_email@example.com"
    $smtpTo = "team1@example.com", "team2@example.com"
    
    $message = New-Object Net.Mail.MailMessage($smtpFrom, $smtpTo)
    $message.Subject = $subject
    $message.Body = $body
    $smtp = New-Object Net.Mail.SmtpClient($smtpServer)
    $smtp.Send($message)
}

try {
    # Iterate over each API endpoint
    foreach ($endpoint in $apiEndpoints) {
        $apiUrl = $baseUrl + $endpoint

        # Invoke API request
        $response = Invoke-RestMethod -Uri $apiUrl -Method Get

        # Check for issues in the API response (modify as needed)
        if ($response -eq $null) {
            $subject = "CyberArk API Issue - Null Response for $endpoint"
            $body = "The API response is null for $endpoint. Please check the CyberArk components."
            Send-EmailAlert -subject $subject -body $body

            # Send alert to Teams channel
            $teamsMessage = "The API response is null for $endpoint. Please check the [CyberArk components]($apiUrl)."
            Send-TeamsAlert -message $teamsMessage
        } elseif ($response.Status -ne "OK") {
            $subject = "CyberArk API Issue - Status is not OK for $endpoint"
            $body = "The API response status is $($response.Status) for $endpoint. Please check the CyberArk components."
            Send-EmailAlert -subject $subject -body $body

            # Send alert to Teams channel
            $teamsMessage = "The API response status is $($response.Status) for $endpoint. Please check the [CyberArk components]($apiUrl)."
            Send-TeamsAlert -message $teamsMessage
        } else {
            # No issues detected for this endpoint
            Write-Host "CyberArk components for $endpoint are healthy."
        }
    }
} catch {
    # Handle any exceptions
    $subject = "CyberArk API Issue - Exception"
    $body = "An exception occurred while checking the CyberArk components. Exception details: $($_.Exception.Message)"
    Send-EmailAlert -subject $subject -body $body

    # Send alert to Teams channel
    $teamsMessage = "An exception occurred while checking the CyberArk components. Exception details: $($_.Exception.Message)"
    Send-TeamsAlert -message $teamsMessage
}
