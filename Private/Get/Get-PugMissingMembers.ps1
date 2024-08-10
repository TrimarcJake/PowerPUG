function Get-PugMissingMembers {
    [CmdletBinding()]
    param (
        [Parameter(ValueFromPipeline)]
        [object]$PugDomains
    )

    begin {
        if ($null -eq $PugDomains) {
            $PugDomains = Get-PugDomain
        }
    }

    process {
        $PugDomains | ForEach-Object {
            # $domain = $_
            $PugGroupMembership = $_ | Get-PugPugGroupSid | Expand-PugGroupMembership | Sort-Object -Unique
            $AdaGroupMembership = $_ | Get-PugAdaGroupSid | Expand-PugGroupMembership | Sort-Object -Unique

            $NotInPug = $AdaGroupMembership | Where-Object { $PugGroupMembership -notcontains $_ } 

            $NotInPug | ForEach-Object {
                Write-Output $_
            }
        }
    }

    end {

    }
}
