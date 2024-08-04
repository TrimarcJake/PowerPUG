function Show-PUGLogo {
    param(
        [string]$Version
    )

   $OutputEncoding = [Console]::OutputEncoding = [Text.UTF8Encoding]::UTF8
   Write-Host "PowerPUG! v$Version" -ForegroundColor Magenta
}