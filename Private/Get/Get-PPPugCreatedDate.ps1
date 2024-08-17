function Get-PPPugCreatedDate {
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
        [object]$Domains
    )

    #requires -Version 5

    begin {
        Add-Type -AssemblyName 'System.DirectoryServices.AccountManagement'
        if ($null -eq $Domains) {
            $Domains = Get-PPDomain
        }
    }

    process {
        $Domains | ForEach-Object {
            $PugSid = $_ | Get-PPPugSid
            $PrincipalContext = [System.DirectoryServices.AccountManagement.PrincipalContext]::New('Domain',$_.Name)
            $GroupPrincipal = [System.DirectoryServices.AccountManagement.GroupPrincipal]::FindByIdentity($PrincipalContext,$PugSid)
            $GroupPrincipal.GetUnderlyingObject().Properties["whenCreated"]
        }
    }

    end {
    }
}
