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

    $Environment = Get-PPEnvironment
    Test-PPEnvironment -Environment $Environment
    $DCLogConfiguration = Get-PPDCLogConfiguration -DC $Environment.Dcs
    Test-PPDCLogConfiguration -Configuration $DCLogConfiguration
}