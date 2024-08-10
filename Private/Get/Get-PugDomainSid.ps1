function Get-PugDomainSid {
    # TODO this feels hacky
    [CmdletBinding()]
    param (
        [Parameter(ValueFromPipeline)]
        [object]$PugDomains
    )

    #requires -Version 5

    begin {
        if ($null -eq $PugDomains) {
            $PugDomains = Get-PugDomain
        }
    }

    process {
        $PugDomains | ForEach-Object {
            $DomainKrbtgtSid = [System.Security.Principal.NTAccount]::New($_,'krbtgt').Translate([System.Security.Principal.SecurityIdentifier]).Value 
            Write-Output $DomainKrbtgtSid.Substring(0,$DomainKrbtgtSid.length-4)
        }
    }

    end {
    }
}
