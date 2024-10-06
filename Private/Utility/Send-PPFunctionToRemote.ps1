function Send-PPFunctionToRemote {
    <#
        .SYNOPSIS

        .DESCRIPTION

        .PARAMETER Parameter

        .INPUTS

        .OUTPUTS

        .EXAMPLE

        .LINK
        https://matthewjdegarmo.com/powershell/2021/03/31/how-to-import-a-locally-defined-function-into-a-remote-powershell-session.html
    #>
    [CmdletBinding()]
    param (
        [Parameter(Mandatory)]
        [string[]]$FunctionName,
        [Parameter(Mandatory, ValueFromPipeline)]
        [ValidateNotNullOrEmpty()]
        [object[]]$Session
    )

    #requires -Version 5

    begin {
        Write-Verbose "Starting $($MyInvocation.MyCommand) on $env:COMPUTERNAME..."
    }

    process {
        Write-Verbose "Processing $($MyInvocation.MyCommand) on $env:COMPUTERNAME..."
        $FunctionName | Foreach-Object {
            try {
                $Function = Get-Command -Name $_
                if ($Function) {
                    $Definition = @"
$($Function.CommandType) $_ {
$($Function.Definition)
}
"@                  
                    Invoke-Command -Session $Session -ScriptBlock {
                        param($LoadMe)
                        . ([scriptblock]::Create($LoadMe))
                    } -ArgumentList $Definition
                }
            } catch {
                throw $_
            }
        }
    }
    
    end {
        Write-Verbose "Finishing $($MyInvocation.MyCommand) on $env:COMPUTERNAME..."    
    }
}
