function Read-PPHost {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory,Position=0)]
        $Message
    )

    #requires -Version 5

    begin {
    }

    process {
        Read-Host -Prompt $(Write-Host "[?] $Message`n> " -ForegroundColor Blue -BackgroundColor DarkGray -NoNewLine)
    }
}
