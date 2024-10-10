function Invoke-PowerPUG {
    [CmdletBinding()]
    param (
        # TODO accept ForestFQDN as string
        # [Parameter(ValueFromPipeline)]
        # [string]$ForestFQDN,
        # [System.Management.Automation.PSCredential]$Credential
    )

    #region show logo
    Show-PPLogo -Version (Get-Date -Format yyyy.M.d)
    #endregion show logo

    if (Test-PPIsDC) {
        if (Test-PPIsElevated) {
        } else {
            $Executable = if ($Host.Name -eq 'Windows PowerShell ISE Host') {
                'powershell_ise.exe'
            } elseif ( ($Host.Name -eq 'ConsoleHost') -and ($Host.Version.Major -gt 6) ) {
                'pwsh.exe'
            } else {
                'powershell.exe'
            }
    
            throw "When run on a DC, this script must be run in an elevated prompt. Please re-open $Executable using `"Run as Administrator`" and start this script again."
        }
    }

    $Environment = Get-PPEnvironment
    Test-PPEnvironment -Environment $Environment

    Show-PPOutro
}