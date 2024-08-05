function Get-PugForest {
    # TODO Accept other forests in -ForestFQDN parameter
    [CmdletBinding()]
    param(
    )

    #requires -Version 5

    begin {
    }

    process {
        [System.DirectoryServices.ActiveDirectory.Forest]::GetCurrentForest()
    }

    end {
    } 
}