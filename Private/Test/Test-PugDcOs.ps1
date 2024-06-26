function Test-PugDcOs {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory, ValueFromPipeline)]
        [object]$PugDc
    )

    #requires -Version 5

    $DcOsWithPugArray = @(
        'Windows Server 2025 Standard',
        'Windows Server 2025 Datacenter',
        'Windows Server 2022 Standard',
        'Windows Server 2022 Datacenter',
        'Windows Server 2019 Standard',
        'Windows Server 2019 Datacenter',
        'Windows Server 2016 Standard',
        'Windows Server 2016 Datacenter',
        'Windows Server 2012 R2 Standard',
        'Windows Server 2012 R2 Datacenter'
    )

    if ($DcOsWithPugArray -contains $PugDc.OSVersion.ToString()) {
        $true
    } else {
        $false
    }
}
