function Get-PPNtlmLogonSuccess {
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
        [object[]]$AdaMembers
    )

    #requires -Version 5

    begin {
    }

    process {
        $AdaMembers | ForEach-Object {
            $filter = @"
                *[EventData
                    [Data
                        [@Name='AuthenticationPackageName']
                        and
                        (Data='NTLM')
                    ]
                    [Data[@Name='TargetUserName']='$($_.Name)']
                ]
                [System
                    [EventID=4624]
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
    }
}
