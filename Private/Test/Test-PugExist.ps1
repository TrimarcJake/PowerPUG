function Test-PUGExist {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory, ValueFromPipeline)]
        [object]$PugDomains
    )

    #requires -Version 5

    begin {
    }

    process {
        $PugDomains | ForEach-Object {
            
        }
    }

    end {
    }
}
