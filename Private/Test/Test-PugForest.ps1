function Test-PugForest {
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
        $PugForest | ForEach-Object {
            $PugFFL = $false
            if ($_.ForestModeLevel -ge 6) {
                $PugFFL = $true 
            }

            $Return = [PSCustomObject]@{
                Name     = $_.Name
                PugFFL = $PugFFL
            }
            
            Write-Output $Return
        }
    }

    end {}
}
