#!/usr/bin/env -S pwsh.exe -ExecutionPolicy Bypass

param($credential, $username, $password, $comment)

Import-Module -Name TUN.CredentialManager

New-StoredCredential -Target "$credential" -UserName "$username" -Password "$password" -Comment "$comment" -Persist LocalMachine

write-host "$password"
