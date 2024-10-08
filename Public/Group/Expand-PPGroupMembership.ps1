function Expand-PPGroupMembership {
    <#
        .SYNOPSIS

        .DESCRIPTION

        .PARAMETER Parameter

        .INPUTS

        .OUTPUTS

        .EXAMPLE

        .LINK
    #>
    # TODO Update to handle users with non-standard PGID
    [CmdletBinding()]
    param (
        [Parameter(Mandatory, ValueFromPipeline)]
        [ValidateNotNullOrEmpty()]
        [object[]]$Sid
    )

    #requires -Version 5

    begin {
        Write-Verbose "[$(Get-Date -Format 'yyyy-MM-dd hh:mm:ss')] Starting $($MyInvocation.MyCommand) on $env:COMPUTERNAME..."
        Add-Type -AssemblyName 'System.DirectoryServices.AccountManagement'
    }

    process {
        Write-Verbose "[$(Get-Date -Format 'yyyy-MM-dd hh:mm:ss')] Processing $($MyInvocation.MyCommand) on $env:COMPUTERNAME..."
        Write-Output $Sid -PipelineVariable groupsid | ForEach-Object {
            $PrincipalContext = [System.DirectoryServices.AccountManagement.PrincipalContext]::New('Domain', $groupsid.Domain)
            $GroupPrincipal = [System.DirectoryServices.AccountManagement.GroupPrincipal]::FindByIdentity($PrincipalContext, $groupsid.Value)
            try {
                $GroupPrincipal.GetMembers($true) | ForEach-Object {
                    $_ | Add-Member -NotePropertyName Domain -NotePropertyValue $groupsid.Domain -Force
                    Write-Output $_
                }
            } catch {
                Write-PPHost -Type Warning -Message "Group SID $($groupsid.Value) does not exist in $($groupsid.Domain)."
            }
        }
    }

    end {
        Write-Verbose "[$(Get-Date -Format 'yyyy-MM-dd hh:mm:ss')] Finishing $($MyInvocation.MyCommand) on $env:COMPUTERNAME..."    
    }
}