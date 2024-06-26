function Get-PugDomain {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory, ValueFromPipeline)]
        [object]$PugForest
    )

    #requires -Version 5

    $PugDomains = @()
    $PugDomains += $PugForest | Select-Object -ExpandProperty Domains

    $PugDomains
}
