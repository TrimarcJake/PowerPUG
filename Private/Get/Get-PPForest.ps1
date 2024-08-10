function Get-PPForest {
    # TODO Accept other forests in -ForestFQDN parameter
    [CmdletBinding()]
    param(
    )

    #requires -Version 5

    begin {
    }

    process {
        $PugForest = [System.DirectoryServices.ActiveDirectory.Forest]::GetCurrentForest()
        Write-Output $PugForest
    }

    end {
    } 
}