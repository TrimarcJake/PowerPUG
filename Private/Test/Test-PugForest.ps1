function Test-PUGForest {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory, ValueFromPipeline)]
        [object]$PUGForest
    )

    #requires -Version 5

    if ($PUGForest.ForestModeLevel -lt 6) {
        $false
    } else {
        $true
    }
}
