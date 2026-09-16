#!/usr/bin/env -S pwsh.exe -ExecutionPolicy Bypass

param($credential)

Import-Module -Name CredentialManager

$entry = Get-StoredCredential -Target "$credential"

if ($null -eq $entry) {
  Write-Error "Credential '$credential' not found in Windows Credential Manager"
  exit 1
}

$passwordBinary = [System.Runtime.InteropServices.Marshal]::SecureStringToBSTR($entry.Password)

$password = [System.Runtime.InteropServices.Marshal]::PtrToStringAuto($passwordBinary)

write-host "$password"
