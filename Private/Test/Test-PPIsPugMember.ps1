function Test-PPIsPugMember {
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
        [Parameter(Mandatory, ValueFromPipeline)]
        [object[]]$Users,
        [object[]]$PugMembers
    )

    #requires -Version 5

    begin {
        if ($null -eq $PugMembers) {
            $PugMembers = Get-PPPugSid | Expand-PPGroupMembership
        } 
    }

    process {
        $Users | ForEach-Object {
            if ($PugMembers -contains $_) {
                Write-Output $true
            } else {
                Write-Output $false
            }
        }
    }

    end {
    }
}
