function Test-PugExist {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory, ValueFromPipeline)]
        [object]$PugDomainSid
    )

    #requires -Version 5

    begin {
    }

    process {
        $PugDomainSid | ForEach-Object {
            
        }
    }

    end {
    }
}
