function Get-PPDomainPugCreatedDate {
    <#
        .SYNOPSIS

        .DESCRIPTION

        .PARAMETER Parameter

        .INPUTS

        .OUTPUTS

        .EXAMPLE

        .LINK
    #>
    # TODO Investigate changing this to RODC group since it was created w/upgrade to 2008.
    [CmdletBinding()]
    param (
        [Parameter(ValueFromPipeline)]
        [ValidateNotNullOrEmpty()]
        [object]$Domain
    )

    #requires -Version 5

    begin {
        Write-Verbose "[$(Get-Date -Format 'yyyy-MM-dd hh:mm:ss')] Starting $($MyInvocation.MyCommand) on $env:COMPUTERNAME..."
        Add-Type -AssemblyName 'System.DirectoryServices.AccountManagement'
        if ($null -eq $Domain) {
            $Domain = Get-PPDomain
        }
    }

    process {
        Write-Verbose "[$(Get-Date -Format 'yyyy-MM-dd hh:mm:ss')] Processing $($MyInvocation.MyCommand) on $env:COMPUTERNAME..."
        $Domain | Where-Object PugExists | ForEach-Object {
            if (-not $_.PugSid) {
                $PugSid = Get-PPDomainPugSid -Domain $_
            } else {
                $PugSid = $_.PugSid
            }
            $PrincipalContext = [System.DirectoryServices.AccountManagement.PrincipalContext]::New('Domain', $_.Name)
            $GroupPrincipal = [System.DirectoryServices.AccountManagement.GroupPrincipal]::FindByIdentity($PrincipalContext, $PugSid)
            $GroupPrincipal.GetUnderlyingObject().Properties["whenCreated"]
        }
    }

    end {
        Write-Verbose "[$(Get-Date -Format 'yyyy-MM-dd hh:mm:ss')] Finishing $($MyInvocation.MyCommand) on $env:COMPUTERNAME..."    
    }
}
