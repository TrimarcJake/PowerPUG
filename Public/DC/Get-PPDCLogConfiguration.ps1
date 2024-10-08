function Get-PPDCLogConfiguration {
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
        Write-Verbose "[$(Get-Date -Format 'yyyy-MM-dd hh:mm:ss')] Processing $($MyInvocation.MyCommand) on $env:COMPUTERNAME..."
        Write-Output $DC -PipelineVariable domaincontroller | ForEach-Object {
            try {
                $Session = New-PSSession -ComputerName $domaincontroller -ErrorAction Stop
                Send-PPFunctionToRemote -FunctionName Get-PPDCAuditPolicy -Session $Session
                Write-PPHost -Type Info -Message "Checking if $($_.Name) has Logon Auditing enabled."
                Invoke-Command -Session $Session -ScriptBlock { Get-PPDCAuditPolicy }
            } catch {
            }
        }
    }

    end {
        Write-Verbose "[$(Get-Date -Format 'yyyy-MM-dd hh:mm:ss')] Finishing $($MyInvocation.MyCommand) on $env:COMPUTERNAME..."
    }
}