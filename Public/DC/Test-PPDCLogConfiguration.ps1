function Test-PPDCLogConfiguration {
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
        [ValidateNotNullOrEmpty()]
        [object[]]$Configuration
    )

    #requires -Version 5

    begin {
        Write-Verbose "[$(Get-Date -Format 'yyyy-MM-dd hh:mm:ss')] Starting $($MyInvocation.MyCommand) on $env:COMPUTERNAME..."
    }

    process {
        Write-Verbose "[$(Get-Date -Format 'yyyy-MM-dd hh:mm:ss')] Processing $($MyInvocation.MyCommand) on $env:COMPUTERNAME..."
        $Configuration | ForEach-Object {
            if ( ($_.'Policy Target' -eq 'System') -and ($_.Category -eq 'Logon/Logoff') -and 
                ($_.Subcategory -eq 'Logon') -and ($_.'Inclusion Setting' -eq 'Success and Failure')
            ) {
                Write-Output $true
            } elseif ( ($_.'Policy Target' -eq 'System') -and ($_.Category -eq 'Logon/Logoff') -and 
                ($_.Subcategory -eq 'Logon') -and ($_.'Inclusion Setting' -ne 'Success and Failure')
            ) {
                Write-Output $false
            }
        }
    }

    end {
        Write-Verbose "[$(Get-Date -Format 'yyyy-MM-dd hh:mm:ss')] Finishing $($MyInvocation.MyCommand) on $env:COMPUTERNAME..."
    }
}
