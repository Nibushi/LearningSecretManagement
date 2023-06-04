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
