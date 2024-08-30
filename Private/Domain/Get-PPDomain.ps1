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
        Write-Verbose "Starting $($MyInvocation.MyCommand) on $env:COMPUTERNAME..."
        if ($null -eq $Forest) {
            $Forest = Get-PPForest
        }
    }

    process {
        Write-Verbose "Starting $($MyInvocation.MyCommand) on $env:COMPUTERNAME..." 
        $Forest.Domains | ForEach-Object {
           if ( $_.Forest -and ($null -ne $_.DomainControllers) -and ($_.DomainControllers -ne '')) {
                Write-Output $_
            } else {
                Write-Warning "$($_.Name) is not reachable. PowerPUG! will not attempt to analyze it for PUG readiness."
            }
        }
    }

    end {
        Write-Verbose "Finishing $($MyInvocation.MyCommand) on $env:COMPUTERNAME..."    }
}
