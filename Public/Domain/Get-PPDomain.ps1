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
        [ValidateNotNullOrEmpty()]
        [object]$Forest
    )

    #requires -Version 5

    begin {
        Write-Verbose "[$(Get-Date -Format 'yyyy-MM-dd hh:mm:ss')] Starting $($MyInvocation.MyCommand) on $env:COMPUTERNAME..."
        if ($null -eq $Forest) {
            $Forest = Get-PPForest
        }
    }

    process {
        Write-Verbose "[$(Get-Date -Format 'yyyy-MM-dd hh:mm:ss')] Processing $($MyInvocation.MyCommand) on $env:COMPUTERNAME..." 
        $Forest.Domains | ForEach-Object {
            if ( $_.Forest -and ($null -ne $_.DomainControllers) -and ($_.DomainControllers -ne '')) {
                Write-Output $_
            } else {
                Write-PPHost -Type Warning -Message "$($_.Name) is not reachable. PowerPUG! will not attempt to analyze it for PUG readiness."
            }
        }
    }

    end {
        Write-Verbose "[$(Get-Date -Format 'yyyy-MM-dd hh:mm:ss')] Finishing $($MyInvocation.MyCommand) on $env:COMPUTERNAME..."    
    }
}
