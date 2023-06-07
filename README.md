# LearningSecretManagement

Secret Management Module is an engine to securely store secret information in different vaults. It works with different vault modules such as:

- SecretStore Module (Microsoft)
- KeePass Module
- LastPass Module
- AzKeyvault Module (Microsoft)
- More....

The module knows the syntax and language for the different vaults. Your code shouldn't need to change to utilize a different vault, you use a consistent set of CmdLets regardless of the target vault.

Vault modules have to support the Microsoft SecretManagement Module.

You need at least two modules to work with the secret management:

- Microsoft SecretManagement Module
- Vault Module


## Microsoft's SecretStore Module

Some basic info:

- Vault stored locally on your machine
- User specific - One vault per User across all instances/versions of PowerShell
- Microsoft are working on an AllUser scope for SecretStore module

## Where are secrets stored

They are stored in C:\Users\\<username\>\AppData\Local\Microsoft\PowerShell\SecretManagement

Interesting files in this location:

- \secretvaultregistry\vaultinfo - Contains high level information about the different vaults you have access to#
- \localstore - stores the encrypted information/secrets per user

It is possible to share vaults between users but it is not how the module was designed to be used.

## SecretStore Vault (Microsoft)

[Getting Started with the SecretStore Module](https://learn.microsoft.com/en-us/powershell/utility-modules/secretmanagement/get-started/using-secretstore?view=ps-modules)

- Vault is tied to the context of the user and the machine it was created on
- Cannot be shared or easily moved to another machine
- Can create multiple vaults under the same profile
- For automation consider
    - Set Authentication to None, this turns off the requirements to provide a password
    - Set Interaction to None, Prevents scripts from hanging if password is turned back on
        - (Interaction = none) + (Password = Required) = Error Thrown which will stop script
- Security is by securing service account with strong password and monitoring logins made by this account and this machine
- When retrieving a secret using an automated script, specify the vault parameter, don't assume the vault is set as the default

```powershell-interactive
    Set-SecretStoreConfiguration -Authentication None -Interaction None
```

- As SecretStore Module is tied to user and computer no additional `VaultParameters` are required to set up the vault

```powershell-interactive
    Register-SecretVault -ModuleName Microsoft.PowerShell.SecretStore -Name SQLHealthCheck
```
