function Test-PugDomain {
    [CmdletBinding()]
    param (
        [Parameter(ValueFromPipeline)]
        [object]$PugDomains
    )

    #requires -Version 5

    begin {
        if ($null -eq $PugDomains) {
            $PugDomains = Get-PugDomain
        }
    }
    
    process {
        $PugDomains | ForEach-Object {
            $PugLevel = $false
            if ($_.DomainModeLevel -ge 6) {
                $PugLevel = $true 
            }

            $Return = [PSCustomObject]@{
                Name     = $_.Name
                PugLevel = $PugLevel
            }
            
            Write-Output $Return
        }
    }

    end {}
}
