function Test-PugDcOs {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory, ValueFromPipeline)]
        [object]$PugDcs
    )

    #requires -Version 5

    begin {
        $DcOsWithPugArray = @(
            'Windows Server 2025 Standard',
            'Windows Server 2025 Datacenter',
            'Windows Server 2022 Standard',
            'Windows Server 2022 Datacenter',
            'Windows Server 2019 Standard',
            'Windows Server 2019 Datacenter',
            'Windows Server 2016 Standard',
            'Windows Server 2016 Datacenter',
            'Windows Server 2012 R2 Standard',
            'Windows Server 2012 R2 Datacenter'
        )
    }

    process {
        $PugDcs | ForEach-Object {
            $PugOs = $false
            if ($DcOsWithPugArray -contains $_.OSVersion.ToString()) {
                $PugOs = $true
            } 

            $Return = [PSCustomObject]@{
                Name      = $_.Name
                OSVersion = $_.OSVersion
                PugOs     = $PugOs
            }
        }

        Write-Output $Return
    }
    
    end {
    }
}
