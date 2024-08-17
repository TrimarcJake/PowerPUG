function Test-PPForest {
    <#
        .SYNOPSIS

        .DESCRIPTION

        .PARAMETER Parameter

        .INPUTS

        .OUTPUTS

        .EXAMPLE

        .LINK
    #>
    [CmdletBinding()]
    param (
        [Parameter(ValueFromPipeline)]
        [object]$Forest
    )

    #requires -Version 5

    begin {
        if ($null -eq $Forest) {
            $Forest = Get-PPForest
        }
    }
    
    process {
        $Forest | ForEach-Object {
            $FFL = $false
            if ($_.ForestModeLevel -ge 6) {
                $FFL = $true 
            }

            $Return = [PSCustomObject]@{
                Name  = $_.Name
                Value = $FFL
            }
            
            Write-Output $Return
        }
    }

    end {}
}
