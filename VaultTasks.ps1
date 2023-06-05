throw "F8 to run selection! Not Ctrl+F5 or F5"

#region - keyboard shortcuts
# Fold all regions: Ctrl + K Ctrl+0
# Unfold all regions: Ctrl + K Ctrl+J
#endregion

#region - Secret Management Module Cmdlets

# Most of the command used will be in the SecretManagement Module
Get-Command -Module Microsoft.PowerShell.SecretManagement

# Work less with the CmdLets stored in the Vault modules
Get-Command -Module Microsoft.PowerShell.SecretStore

#endregion

#region - setting up first vault

# Create vault
Register-SecretVault -Name DemoVault -ModuleName Microsoft.PowerShell.SecretStore -DefaultVault -AllowClobber

# View the vault
Get-Secret

# A vault password is not required when creating the vault initially.
# Initially Vault is just an XML placeholder until first interact with the vault

#endregion

#region - View vault configuration

#If you haven't set a password at this point you will be prompted.
Get-SecretStoreConfiguration

#Change the default timeout value from 15 min to 30 min
Set-SecretStoreConfiguration -PasswordTimeout 1800

# default 900 seconds / 15 minutes
#endregion

#region - Secret Management Tasks

# Add a secret
# Secure Strings aren't stored in PowerShell history file
Set-Secret -Name MyTextString -Secret "This is just some text"
Set-Secret -Name MyAPIKey -Secret "1ba821f1-bd27-429f-b7b3-4de3b2502027"

# Retrieve a Secret
Get-Secret MyTextString #Returns this as a System.Security.SecureString

# Save secret to a variable
$a = Get-Secret MyTextString

# Store a PSCredential Object as a secret
Set-Secret -Name AdminAsCred -Secret (Get-Credential)

# Remove a secret
Remove-Secret MyAPIKey -Vault VaultDemo

#endregion

#region - make sure you enter the right data

# Secret Management does not do validation on credential information entered
# Ensure you don't enter a bad password
Set-Secret CredWithBadPassword (Get-Credential domain\aperson)

# Attempt to connect with credential with bad password
Enter-PSSession DC01 -Credential (Get-Secret CredWithBadPassword)

(Get-Secret CredWithBadPassword).Password | ConvertFrom-SecureString -AsPlainText

#endregion

#region - use multiple secrets in code

New-PSSession DC01 -Credential (Get-Secret -Name CredMKAdmin -Vault VaultDemo)
New-PSSession EXCH01 -Credential (Get-Secret -Name CredMParker -Vault VaultDemo)
$s = Get-PSSession

Invoke-Command $s {Write-Output "$(whoami) on $(hostname)"}

#endregion

#region - Change user creds when admin privilege needed

# Get AD Info - no admin privileges required
Get-ADUser salexander -Properties Manager

# Change AD Info - - requires admin privileges
Set-ADUser salexander -Manager aperson -Credential (Get-Secret MyAdminAccount)
Set-ADUser salexander -Manager $null -Credential (Get-Secret MyAdminAccount)

#endregion
