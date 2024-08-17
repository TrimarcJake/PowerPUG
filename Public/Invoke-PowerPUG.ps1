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
    
    $Forest = Get-PPForest
    $Domains = Get-PPDomain
    $Dc = Get-PPDc
}