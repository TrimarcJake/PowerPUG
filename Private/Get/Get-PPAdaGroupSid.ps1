function Get-PPAdaGroupSid {
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
        [object]$Domains
    )

    #requires -Version 5

    begin {
        if ($null -eq $Domains) {
            $Domains = Get-PPDomain
        }

        $RootDomainSid = (Get-PPForest).RootDomain | Get-PPDomainSid
        $RootDomainName = (Get-PPForest).RootDomain
        @("$RootDomainSid-518","$RootDomainSid-519") | ForEach-Object {
            $AdaGroupSid = [System.Security.Principal.SecurityIdentifier]::New($_)
            $AdaGroupSid | Add-Member -NotePropertyName Domain -NotePropertyValue $RootDomainName -Force
            Write-Output $AdaGroupSid
        }
    }

    process {
        $Domains | ForEach-Object {
            $DomainName = $_.Name
            $DomainSid = $_ | Get-PPDomainSid
            @('S-1-5-32-544',"$DomainSid-512") | ForEach-Object {
                $AdaGroupSid = [System.Security.Principal.SecurityIdentifier]::New($_)
                $AdaGroupSid | Add-Member -NotePropertyName Domain -NotePropertyValue $DomainName -Force
                Write-Output $AdaGroupSid
            }
        }
    }

    end {
    }
}
