# Automatic Password Management for Windows IIS Application Pools

## Overview:
Automatic password management is supported for Windows IIS Application Pools on both IPv4 and IPv6. This capability extends to the following platforms:

- IIS 10.0 with "IIS 6 management compatibility" role service

**Note:** The Windows IIS Application Pools plugin does not change values in an application pool located on the local machine where the CyberArk Central Policy Manager (CPM) runs.

## Requirements:
To utilize the IIS Application Pool plugin, ensure the following prerequisites are met:

1. **Windows Script Host:** Cscript version 5.6 or higher must be installed on the CPM machine. By default, Windows 2012 includes this Script Host, and the latest version can be downloaded from the [Microsoft website](https://www.microsoft.com).
2. **Enable Windows Script Host:** Open the Registry editor and navigate to `HKEY_USERS/.DEFAULT/Software/Microsoft/`. Under Microsoft, locate the Windows Script Host key. If absent, add this key. Under Windows Script Host, ensure the Settings key exists. If not, add this key.

## Communication:
The plugin uses the following ports to connect to the remote machine:

- 135
- 445

## Flow Diagram
<img width="138" alt="image" src="https://github.com/niteshbhat/challenge/assets/7299171/58b63d2f-ed24-4ea2-98dc-1cc694ee1914">

