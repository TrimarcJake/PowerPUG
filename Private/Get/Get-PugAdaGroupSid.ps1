function Get-PugAdaGroupSid {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory, ValueFromPipeline)]
        [object]$PugDomains
    )

    #requires -Version 5

    begin {
        $RootDomainSid = (Get-PugForest).RootDomain | Get-PugDomainSid
        @("$RootDomainSid-518","$RootDomainSid-519") | ForEach-Object {
            $Return = [PSCustomObject]@{
                Type        = 'Forest'
                Domain      = (Get-PugForest).RootDomain.Name
                GroupSid    = $_
            }

            Write-Output $Return
        }
    }

    process {
        $PugDomains | ForEach-Object {
            $DomainName = $_.Name
            $DomainSid = $_ | Get-PugDomainSid
            @('S-1-5-32-544',"$DomainSid-512") | ForEach-Object {
                $Return = [PSCustomObject]@{
                    Type        = 'Domain'
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
