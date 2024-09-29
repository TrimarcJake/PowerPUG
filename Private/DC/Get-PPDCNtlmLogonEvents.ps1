function Get-PPDCNtlmLogons {
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
        Write-Verbose "Starting $($MyInvocation.MyCommand) on $env:COMPUTERNAME..."
        if ($null -eq $DC) {
            $DC = Get-PPDC
        }
    }

    process {
        $DC | ForEach-Object {
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
                $Query = [System.Diagnostics.Eventing.Reader.EventLogQuery]::New('Security','LogName',$NtlmFilter)
                $Reader = [System.Diagnostics.Eventing.Reader.EventLogReader]::New($Query) 
                try {
                    while ($true) {
                        $Event = $Reader.ReadEvent()
                        $Message = $Event.FormatDescription()
                        $Event | Add-Member -NotePropertyName Message -NotePropertyValue $Message -Force
                        $Event
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
