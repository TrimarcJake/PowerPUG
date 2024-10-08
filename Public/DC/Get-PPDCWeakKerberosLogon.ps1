function Get-PPDCWeakKerberosLogon {
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
        [ValidateNotNullOrEmpty()]
        [object[]]$DC
    )

    #requires -Version 5

    begin {
        Write-Verbose "[$(Get-Date -Format 'yyyy-MM-dd hh:mm:ss')] Starting $($MyInvocation.MyCommand) on $env:COMPUTERNAME..."
        if ($null -eq $DC) {
            $DC = Get-PPDC
        }
    }

    process {
        $DC | ForEach-Object {
            Write-PPHost -Type Info -Message "Gathering Weak Kerberos usage events from $($_.Name)."
            Invoke-Command -ComputerName $_ {
                $KerberosFilter = @"
                    *[EventData
                        [Data[@Name='TicketEncryptionType']!='0x12']
                        [Data[@Name='TicketEncryptionType']!='0x11']
                        [Data[@Name='TicketEncryptionType']!='0xFFFFFFFF']
                    ]
                    [System
                        [(EventID=4768)]
                    ]
"@
                $Query = [System.Diagnostics.Eventing.Reader.EventLogQuery]::New('Security', 'LogName', $KerberosFilter)
                $Reader = [System.Diagnostics.Eventing.Reader.EventLogReader]::New($Query) 
                try {
                    while ($true) {
                        $KerberosEvent = $Reader.ReadEvent()
                        $Message = $KerberosEvent.FormatDescription()
                        $KerberosEvent | Add-Member -NotePropertyName Message -NotePropertyValue $Message -Force
                        $KerberosEvent
                    }
                } catch {
                    Out-Null
                }
            }
        }
    }

    end {
    }
}
