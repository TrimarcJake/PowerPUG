function Get-PPDCNtlmLogon {
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
            Write-PPHost -Type Info -Message "Gathering NTLM logon events from $($_.Name)."
            Invoke-Command -ComputerName $_ {
                $NtlmFilter = @"
                    *[EventData
                        [Data[@Name='AuthenticationPackageName']
                        and (Data='NTLM')]
                    ]
                    [System
                        [(EventID=4624)]
                    ]
"@
                $Query = [System.Diagnostics.Eventing.Reader.EventLogQuery]::New('Security', 'LogName', $NtlmFilter)
                $Reader = [System.Diagnostics.Eventing.Reader.EventLogReader]::New($Query) 
                try {
                    while ($true) {
                        $NtlmEvent = $Reader.ReadEvent()
                        $Message = $NtlmEvent.FormatDescription()
                        $NtlmEvent | Add-Member -NotePropertyName Message -NotePropertyValue $Message -Force
                        $NtlmEvent
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
