function Test-PPDcOs {
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
        [object]$Dcs
    )

    #requires -Version 5

    begin {
        if ($null -eq $Dcs) {
            $Dcs = Get-PPDc
        }
    }

    process {
    }
    
    end {
    }
}
