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
        [object]$PPDcs
    )

    #requires -Version 5

    begin {
        if ($null -eq $PPDcs) {
            $PPDcs = Get-PPDc
        }
    }

    process {
    }
    
    end {
    }
}
