@{
    AliasesToExport      = @()
    Author               = 'Jake Hildreth'
    CmdletsToExport      = @()
    CompanyName          = ''
    CompatiblePSEditions = @('Desktop', 'Core')
    Copyright            = '(c) 2023 - 2024 Jake Hildreth. All rights reserved.'
    Description          = 'PowerPUG helps AD Admins use the Protected Users Group safely.'
    FunctionsToExport    = 'Invoke-PowerPUG'
    GUID                 = '3f8afba8-e266-4a4b-9f09-b2d7ab35eba9'
    ModuleVersion        = '2024.10.6'
    PowerShellVersion    = '5.1'
    PrivateData          = @{
        PSData = @{
            ExternalModuleDependencies = @('Microsoft.PowerShell.Archive', 'Microsoft.PowerShell.Diagnostics', 'Microsoft.PowerShell.Management', 'Microsoft.PowerShell.Security', 'Microsoft.PowerShell.Utility', 'Microsoft.WSMan.Management')
            Tags                       = @('Windows', 'MacOS', 'Linux')
        }
    }
    RequiredModules      = @('Microsoft.PowerShell.Archive', 'Microsoft.PowerShell.Diagnostics', 'Microsoft.PowerShell.Management', 'Microsoft.PowerShell.Security', 'Microsoft.PowerShell.Utility', 'Microsoft.WSMan.Management')
    RootModule           = 'PowerPUG.psm1'
}