function Test-PPPugGroupExists {
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
        [object]$GroupSids
    )

    #requires -Version 5

    begin {
        if ($null -eq $GroupSid) {
            $GroupSids = Get-PPPugGroupSid
        }
        Add-Type -AssemblyName 'System.DirectoryServices.AccountManagement'
    }

    process {
        $GroupSids | ForEach-Object {
            $PrincipalContext = [System.DirectoryServices.AccountManagement.PrincipalContext]::New('Domain',$_.Domain)
            $GroupExists = $false
            try {
                $GroupPrincipal = [System.DirectoryServices.AccountManagement.GroupPrincipal]::FindByIdentity($PrincipalContext,$_.Value)
                $GroupPrincipal.GetMembers() | Out-Null
                $GroupExists = $true
            } catch {
            }

            $Return = [PSCustomObject]@{
                Name  = $_.Domain
                Value = $GroupExists
            }

            Write-Output $Return
        }
    }

    end {
    }
}
