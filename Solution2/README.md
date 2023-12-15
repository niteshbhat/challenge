# CyberArk API Health Check

## Overview

This PowerShell script performs health checks on various CyberArk API endpoints to ensure the smooth operation of CyberArk components. It includes functionality to send alerts to Teams channels and emails in case of issues detected in the API responses.

## Table of Contents

- [API Endpoints](#api-endpoints)
- [Configuration](#configuration)
- [Alerting](#alerting)
- [Usage](#usage)

## API Endpoints

The script checks the health of the following CyberArk API endpoints:

- PVWA (Password Vault Web Access)
- SessionManagement
- CPM (Central Policy Manager)
- PTA (Privileged Threat Analytics)
- AAM Credential Providers

## Configuration

Before running the script, make sure to configure the following variables:

- **$baseUrl (String):** The base URL for the CyberArk API endpoints.

- **$teamsWebhookUrl (String):** Teams Incoming Webhook URL for sending alerts.

- **$smtpServer (String):** SMTP server for sending email alerts.

- **$smtpFrom (String):** Sender's email address.

- **$smtpTo (Array):** Array of recipient email addresses.

## Alerting

The script includes two functions for sending alerts:

1. **Send-TeamsAlert:** Sends an alert to a Teams channel using an Incoming Webhook.

2. **Send-EmailAlert:** Sends an email alert using SMTP. You may want to enhance the email format for your specific needs.

## Usage

```powershell
# Example configuration
$baseUrl = "https://<IIS_Server_Ip>/api/ComponentsMonitoringDetails/"
$teamsWebhookUrl = "https://outlook.office.com/webhook/YOUR_WEBHOOK_URL_HERE"
$smtpServer = "your_smtp_server"
$smtpFrom = "your_email@example.com"
$smtpTo = "team1@example.com", "team2@example.com"


