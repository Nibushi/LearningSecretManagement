throw "F8 to run selection! Not Ctrl+F5 or F5"

#region - keyboard shortcuts
# Fold all regions: Ctrl + K Ctrl+0
# Unfold all regions: Ctrl + K Ctrl+J
#endregion

#region - find the modules on the PSGallery
# SecretMgmt Module
Find-Module "Microsoft.PowerShell.SecretManagement" | Select-Object Name, Author, CompanyName, Version | Format-List

# SecretManagement Vaults
Find-Module -tag "SecretManagement" | Select-Object Name, Author, CompanyName, Version |Sort-Object Name
#endregion

#region - Installing Modules
# Need to run PowerShell v5 or higher

# Install Secret Management Module (the engine)
Install-Module -Name Microsoft.PowerShell.SecretManagement -Repository PSGallery

# Install Secret Management Store ( the translator & storage )
Install-Module -Name Microsoft.PowerShell.SecretStore -Repository PSGallery

#endregion
