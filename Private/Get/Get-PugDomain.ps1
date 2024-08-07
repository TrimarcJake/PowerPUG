function Get-PugDomain {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory, ValueFromPipeline)]
        [object]$PugForest
    )

    #requires -Version 5

    begin {
    }

    process {
        $PugForest.Domains | ForEach-Object {
            Write-Output $_
        }
    }

    end {
    }
}
