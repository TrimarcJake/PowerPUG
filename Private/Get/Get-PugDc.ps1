function Get-PugDc {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory, ValueFromPipeline)]
        [object]$PugDomains
    )

    #requires -Version 5

    begin {
    }

    process {
        $PugDomains.Name | ForEach-Object -PipelineVariable domain {
            $DirectoryContext = [System.DirectoryServices.ActiveDirectory.DirectoryContext]::New(0,$_)
            [System.DirectoryServices.ActiveDirectory.DomainController]::FindAll($DirectoryContext) | ForEach-Object {
                Write-Output $_
            }
        }
    }

    end {
    }
}
