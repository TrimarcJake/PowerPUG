function Get-PPWeakKerberosLogon {
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
                    [Data[@Name='TargetUserName']='$($_.Name)']
                    [Data[@Name='TicketEncryptionType']!='0x12']
                    [Data[@Name='TicketEncryptionType']!='0x11']
                ]
                [System
                    [(EventID=4768 or EventID=4769)]
                ]
"@
            Write-Host "Checking for DES/RC4 Kerberos logons for $($_.Name)`: "
            try {
                Get-WinEvent -FilterXPath $filter -LogName Security -ErrorAction Stop |
                    Select-Object -First 1 
            } catch {
            }
            Write-Host
        }
    }

    end {
    }
}
