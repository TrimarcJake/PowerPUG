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
        [object]$Dc
    )

    #requires -Version 5

    begin {
        if ($null -eq $Dc) {
            $Dc = Get-PPDc
        }
    }

    process {
    }
    
    end {
    }
}
