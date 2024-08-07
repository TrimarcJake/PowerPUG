function Write-PugOutput {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory,Position=0)]
        [ValidateSet('Info','Warning','Success','Error','Code','Prompt','Remediation','Title','Subtitle')]
        $Type,
        [Parameter(Mandatory,Position=1)]
        $Message
    )

    #requires -Version 5
}
