function Invoke-PowerPUG {
    [CmdletBinding()]
    param (
        [Parameter(ValueFromPipeline)]
        [string]$ForestFQDN,
        [System.Management.Automation.PSCredential]$Credential
    )

    #region pretty stuff
    Show-PPLogo -Version (Get-Date -Format yyyy.M.d)
    #endregion

    # TODO accept ForestFQDN as string

    #region get environmental info
    
    $PPForest = Get-PPForest
    $PPDomains = Get-PPDomain
    $PPDc = Get-PPDc
}