function Get-PPDomainSid {
    <#
        .SYNOPSIS

        .DESCRIPTION

        .PARAMETER Parameter

        .INPUTS

        .OUTPUTS

        .EXAMPLE

        .LINK
    #>
    # TODO this is hacky. Replace krbtgt SID with the PDCe SID instead.
    [CmdletBinding()]
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
        $Domain | Where-Object { $_.Forest -and $_.DomainControllers } | ForEach-Object {
            $DomainKrbtgtSid = [System.Security.Principal.NTAccount]::New($_.Name, 'krbtgt').Translate([System.Security.Principal.SecurityIdentifier]).Value 
            $DomainSid = [System.Security.Principal.SecurityIdentifier]::New($DomainKrbtgtSid.Substring(0, $DomainKrbtgtSid.length - 4))
            $DomainSid | Add-Member -NotePropertyName Domain -NotePropertyValue $_ -Force
            Write-Output $DomainSid
        }
    }

    end {
        Write-Verbose "[$(Get-Date -Format 'yyyy-MM-dd hh:mm:ss')] Finishing $($MyInvocation.MyCommand) on $env:COMPUTERNAME..."    
    }
}
