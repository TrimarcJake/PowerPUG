function Get-PPUserNtlmLogon {
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
        [object[]]$User
    )

    #requires -Version 5

    begin {
        Write-Verbose "Starting $($MyInvocation.MyCommand) on $env:COMPUTERNAME..."
     }

    process {
        Write-Verbose "Processing $($MyInvocation.MyCommand) on $env:COMPUTERNAME..."
        $User | ForEach-Object {
            $filter = @"
                *[EventData
                    [Data
                        [@Name='AuthenticationPackageName']
                        and
                        (Data='NTLM')
                    ]
                    [Data[@Name='TargetUserName']='$($_.SamAccountName)']
                ]
                [System
                    [(EventID=4624 or EventID=4625)]
                ]
"@
            Write-Host "Checking Security log for NTLM logons from $($_.Name)`: "
            try {
                Get-WinEvent -FilterXPath $filter -LogName Security -ErrorAction Stop |
                    Select-Object -First 1
            } catch {
            }
        }
    }

    end {
        Write-Verbose "Finishing $($MyInvocation.MyCommand) on $env:COMPUTERNAME..."    }
}
