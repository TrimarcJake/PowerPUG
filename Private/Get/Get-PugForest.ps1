function Get-PugForest {
    [CmdletBinding()]
    param(
    )

    #requires -Version 5

    begin {
    }

    process {
        $PugForest = [System.DirectoryServices.ActiveDirectory.Forest]::GetCurrentForest()
    }

    end {
        $PugForest
    } 
}