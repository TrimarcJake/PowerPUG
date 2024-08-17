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
    # TODO this feels hacky
    [CmdletBinding()]
    param (
        [Parameter(ValueFromPipeline)]
        [object]$Domains
    )

    #requires -Version 5

    begin {
        if ($null -eq $Domains) {
            $Domains = Get-PPDomain
        }
    }

    process {
        $Domains | ForEach-Object {
            $DomainKrbtgtSid = [System.Security.Principal.NTAccount]::New($_,'krbtgt').Translate([System.Security.Principal.SecurityIdentifier]).Value 
            $DomainSid = [System.Security.Principal.SecurityIdentifier]::New($DomainKrbtgtSid.Substring(0,$DomainKrbtgtSid.length-4))
            Write-Output $DomainSid
        }
    }

    end {
    }
}
