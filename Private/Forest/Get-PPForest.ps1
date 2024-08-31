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
        Write-Verbose "Starting $($MyInvocation.MyCommand) on $env:COMPUTERNAME..."
     }

    process {
        Write-Verbose "Processing $($MyInvocation.MyCommand) on $env:COMPUTERNAME..."
        $Forest = [System.DirectoryServices.ActiveDirectory.Forest]::GetCurrentForest()
        Write-Output $Forest
    }

    end {
        Write-Verbose "Finishing $($MyInvocation.MyCommand) on $env:COMPUTERNAME..."    } 
}