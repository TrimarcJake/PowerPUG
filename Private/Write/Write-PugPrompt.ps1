function Write-PugPrompt {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory,Position=0)]
        [ValidateSet('Information','Remediation','Both','Neither')]
        $Type
    )

    #requires -Version 5

    process {
        $Prompt = switch($Type) {
            'Information' {
                @{
                    Letter = 'I'
                    ForTo = 'for'
                    Words = 'more information'
                    Continue = ', or press any other key to continue'
                }
            }
            'Remediation' {
                @{
                    Letter = 'R'
                    ForTo = 'for'
                    Words = 'remediation guidance'
                    Continue = ', or press any other key to continue'
                }
            }
            'Both' {
                @{
                    Letter = 'I or R'
                    ForTo = 'for'
                    Words = 'more information & remediation guidance'
                    Continue = ', or press any other key to continue'
                }
            }
            'Neither' {
                @{
                    Letter = 'R'
                    ForTo = 'to'
                    Words = 'restart the process'
                    Continue = ', or press any other key to continue'
                }
            }
        }

        Write-Host 'Press ' -NoNewline
        Write-Host "$($Prompt.Letter) " -ForegroundColor Blue -NoNewline
        Read-Host "$($Prompt.ForTo) $($Prompt.Words)$($Prompt.Continue)"
    }
}
