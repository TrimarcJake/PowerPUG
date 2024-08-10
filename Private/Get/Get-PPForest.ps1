function Get-PPForest {
    # TODO Accept other forests in -ForestFQDN parameter
    [CmdletBinding()]
    param(
    )

    #requires -Version 5

    begin {
    }

    process {
        $PPForest = [System.DirectoryServices.ActiveDirectory.Forest]::GetCurrentForest()
        Write-Output $PPForest
    }

    end {
    } 
}