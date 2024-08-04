@{
    AliasesToExport      = @()
    Author               = 'Jake Hildreth'
    CmdletsToExport      = @()
CompanyName              = ''
    CompatiblePSEditions = @('Desktop', 'Core')
    Copyright            = '(c) 2023 - 2024 Jake Hildreth. All rights reserved.'
    Description          = 'PowerPUG helps AD Admins use the Protected Users Group safely.'
    FunctionsToExport    = 'Invoke-PowerPUG'
    GUID                 = '3f8afba8-e266-4a4b-9f09-b2d7ab35eba9'
    ModuleVersion        = '0.0.1.1'
    PowerShellVersion    = '5.1'
    PrivateData          = @{
        PSData = @{
            Tags = @('Windows', 'MacOS', 'Linux')
        }
    }
    RequiredModules      = @(@{
            Guid          = 'eefcb906-b326-4e99-9f54-8b4bb6ef3c6d'
            ModuleName    = 'Microsoft.PowerShell.Management'
            ModuleVersion = '3.1.0.0'
        }, @{
            Guid          = '1da87e53-152b-403e-98dc-74d7b4d63d59'
            ModuleName    = 'Microsoft.PowerShell.Utility'
            ModuleVersion = '3.1.0.0'
        })
    RootModule           = 'PowerPUG.psm1'
}