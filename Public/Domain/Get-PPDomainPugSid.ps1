function Get-PPDomainPugSid {
    <#
        .SYNOPSIS

        .DESCRIPTION

        .PARAMETER Parameter

        .INPUTS

        .OUTPUTS

        .EXAMPLE

        .LINK
    #>
    param (
        [Parameter(Mandatory, ValueFromPipeline)]
        [ValidateNotNullOrEmpty()]
        [object]$Domain
    )

    #requires -Version 5

    begin {
        Write-Verbose "[$(Get-Date -Format 'yyyy-MM-dd hh:mm:ss')] Starting $($MyInvocation.MyCommand) on $env:COMPUTERNAME..."
        if ($null -eq $Domain) {
            $Domain = Get-PPDomain
        }
    }

    process {
        Write-Verbose "[$(Get-Date -Format 'yyyy-MM-dd hh:mm:ss')] Processing $($MyInvocation.MyCommand) on $env:COMPUTERNAME..."
        Write-Output $Domain -PipelineVariable loopdomain | ForEach-Object {
            if (-not $Domain.Sid) {
                $DomainSid = Get-PPDomainSid -Domain $_
            } else {
                $DomainSid = $Domain.Sid
            }
            @("$DomainSid-525") | ForEach-Object {
                $GroupSid = [System.Security.Principal.SecurityIdentifier]::New($_)
                $GroupSid | Add-Member -NotePropertyName Domain -NotePropertyValue $loopdomain -Force
                Write-Output $GroupSid
            }
        }
    }

    end {
        Write-Verbose "[$(Get-Date -Format 'yyyy-MM-dd hh:mm:ss')] Finishing $($MyInvocation.MyCommand) on $env:COMPUTERNAME..."    
    }
}
