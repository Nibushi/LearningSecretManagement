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



#endregion
