function Get-PPDomain {
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
        $Forest.Domains | ForEach-Object {
            Write-Output $_
        }
    }

    end {
    }
}
