function Test-PPDcOs {
    [CmdletBinding()]
    param (
        [Parameter(ValueFromPipeline)]
        [object]$PugDcs
    )

    #requires -Version 5

    begin {
        if ($null -eq $PugDcs) {
            $PugDcs = Get-PPDc
        }
    }

    process {
    }
    
    end {
    }
}
