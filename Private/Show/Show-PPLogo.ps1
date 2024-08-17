function Show-PPLogo {
    <#
        .SYNOPSIS

        .DESCRIPTION

        .PARAMETER Parameter

        .INPUTS

        .OUTPUTS

        .EXAMPLE

        .LINK
    #>
    param(
        [string]$Version
    )

   $OutputEncoding = [Console]::OutputEncoding = [Text.UTF8Encoding]::UTF8
   Write-Host "PowerPUG! v<ModuleVersion>" -ForegroundColor Magenta
}