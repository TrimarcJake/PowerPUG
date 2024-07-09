function Get-PugForest {
    [CmdletBinding()]
    param(
        [string]$ForestName
    )

    #requires -Version 5

    $PugForest = [System.DirectoryServices.ActiveDirectory.Forest]::GetCurrentForest()

    $PugForest 
}