function Get-PugDomainSid {
    # TODO this feels hacky
    [CmdletBinding()]
    param (
        [Parameter(Mandatory, ValueFromPipeline)]
        [object]$PugDomains
    )

    #requires -Version 5

    begin {
    }

    process {
        $PugDomains | ForEach-Object {
            $DomainKrbtgtSid = [System.Security.Principal.NTAccount]::New($_,'krbtgt').Translate([System.Security.Principal.SecurityIdentifier]).Value 
            $DomainKrbtgtSid.Substring(0,$DomainKrbtgtSid.length-4)
        }
    }

    end {
    }
}
