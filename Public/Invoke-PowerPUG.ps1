function Invoke-PowerPUG {
    [CmdletBinding()]
    param (
        # TODO accept ForestFQDN as string
        # [Parameter(ValueFromPipeline)]
        # [string]$ForestFQDN,
        # [System.Management.Automation.PSCredential]$Credential
    )

    #region show logo
    Show-PPLogo -Version (Get-Date -Format yyyy.M.d)
    #endregion show logo

    Get-PPEnvironment | Test-PPEnvironment
    Get-PPDCLogConfiguration | Test-PPDCLogConfiguration
}