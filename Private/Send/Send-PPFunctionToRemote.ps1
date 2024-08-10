function Test-PPDcOs {
    [CmdletBinding()]
    param (
        [Parameter(ValueFromPipeline)]
        [object]$PPDcs
    )

    #requires -Version 5

    begin {
        if ($null -eq $PPDcs) {
            $PPDcs = Get-PPDc
        }
    }

    process {
    }
    
    end {
    }
}
