function Test-PPDomain {
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
        [object]$Domains
    )

    #requires -Version 5

    begin {
        if ($null -eq $Domains) {
            $Domains = Get-PPDomain
        }
    }
    
    process {
        $Domains | ForEach-Object {
            $Level = $false
            if ($_.DomainModeLevel -ge 6) {
                $Level = $true 
            }

            $Return = [PSCustomObject]@{
                Name  = $_.Name
                Value = $Level
            }
            
            Write-Output $Return
        }
    }

    end {}
}
