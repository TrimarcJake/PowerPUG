function Write-This {
    <#
        .SYNOPSIS

        .DESCRIPTION

        .PARAMETER Parameter

        .INPUTS

        .OUTPUTS

        .EXAMPLE

        .LINK
    #>
    # Write a string of text to the host and a log file simultaneously.
    [CmdletBinding()]
    [Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingWriteHost', '', Justification = 'Support using Write-Host and colors for interactive scripts.')]
    [OutputType([string])]
        param (
            # The message to display and/or write to a log
            [Parameter(Mandatory, Position = 0)]
            [string]
            $LogText,

            # Type of output to send
            [Parameter(Position = 1)]
            [ValidateSet('Both','HostOnly','LogOnly')]
            [string]
            $Output = 'Both'
        )

    switch ($Output) {
        Both {
            Write-Host "$LogText"
            [void]$LogStringBuilder.AppendLine($LogText)
        }
        HostOnly {
            Write-Host "$LogText"
        }
        LogOnly {
            [void]$LogStringBuilder.AppendLine($LogText)
        }
    } # end switch Output
} # end function Write-This