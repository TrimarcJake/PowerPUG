function Get-PPForestAdminGroupSid {
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
        $RootDomainSid = Get-PPDomainSid -Domain $Forest.RootDomain
        @("$RootDomainSid-518", "$RootDomainSid-519") | ForEach-Object {
            $AdaGroupSid = [System.Security.Principal.SecurityIdentifier]::New($_)
            $AdaGroupSid | Add-Member -NotePropertyName Domain -NotePropertyValue $Forest.RootDomain -Force
            Write-Output $AdaGroupSid
        }
    }

    end {
        Write-Verbose "[$(Get-Date -Format 'yyyy-MM-dd hh:mm:ss')] Finishing $($MyInvocation.MyCommand) on $env:COMPUTERNAME..."    
    }
}
