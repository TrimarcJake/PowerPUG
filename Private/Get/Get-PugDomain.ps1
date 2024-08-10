function Get-PugDomain {
    [CmdletBinding()]
    param (
        [Parameter(ValueFromPipeline)]
        [object]$PugForest
    )

    #requires -Version 5

    begin {
        if ($null -eq $PugForest) {
            $PugForest = Get-PugForest
        }
    }

    process {
        $PugForest.Domains | ForEach-Object {
            Write-Output $_
        }
    }

    end {
    }
}
