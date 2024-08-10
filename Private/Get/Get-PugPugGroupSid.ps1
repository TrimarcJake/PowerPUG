function Get-PugPugGroupSid {
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
            $DomainName = $_.Name
            $DomainSid = $_ | Get-PugDomainSid
            @("$DomainSid-525") | ForEach-Object {
                $Return = [PSCustomObject]@{
                    Type        = 'PUG'
                    Domain      = $DomainName
                    GroupSid    = $_
                }
    
                Write-Output $Return
            }
        }
    }

    end {
    }
}
