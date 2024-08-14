function Get-PPForest {
    <#
        .SYNOPSIS

        .DESCRIPTION

        .PARAMETER Parameter

        .INPUTS

        .OUTPUTS

        .EXAMPLE

        .LINK
    #>
    # TODO Accept other forests in -ForestFQDN parameter
    [CmdletBinding()]
    param(
    )

    #requires -Version 5

    begin {
    }

    process {
        $PPForest = [System.DirectoryServices.ActiveDirectory.Forest]::GetCurrentForest()
        Write-Output $PPForest
    }

    end {
    } 
}