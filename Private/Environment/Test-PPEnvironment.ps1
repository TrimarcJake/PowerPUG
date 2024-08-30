function Test-PPEnvironment {
    <#
        .SYNOPSIS

        .DESCRIPTION

        .PARAMETER Paramter

        .INPUTS

        .OUTPUTS

        .EXAMPLE

        .LINK
    #>
    [CmdletBinding()]
    param (
        [Parameter(Mandatory, ValueFromPipeline)]
        [ValidateNotNullOrEmpty()]
        [object]$Environment
    )

    #requires -Version 5

    #region static values
    $FLHashtable = @{
        0  = 'Windows Server 2000'
        1  = 'Windows Server 2003 Interim'
        2  = 'Windows Server 2003'
        3  = 'Windows Server 2008'
        4  = 'Windows Server 2008 R2'
        5  = 'Windows Server 2012'
        6  = 'Windows Server 2012 R2'
        7  = 'Windows Server 2016'
        10 = 'Windows Server 2025'
    }
    #endregion static values

    #region show environmental results
    #region show forest results
    
    Write-PPHost -Type Title -Message 'Forest Functional Level (FFL)'
    Write-PPHost -Type Subtitle -Message @'
If the FFL is Server 2012 R2 or higher, the Protected Users Group exists in all domains in the forest.
    All domains will receive host- and domain controller-level protections.
'@
    Write-PPHost -Type Subtitle -Message @'
If the FFL is Server 2012 or lower, the Protected Users Group may or may not exist in domains in the forest.
    Host and Domain Controller protections may not be consistently applied.
'@
    if ($Environment.Forest.PugFFL) {
        Write-PPHost -Type Success @"
$($Environment.Forest.Name) FFL is $($FLHashtable[$Environment.Forest.ForestModeLevel]).
    The Protected Users Group exists in all domains in the forest.
"@
    } else {
        Write-PPHost -Type Warning @"
$($Environment.Forest.Name) FFL is $($FLHashtable[$Environment.Forest.ForestModeLevel]).
    Domains in this forest can support PUG protections if they:
      - Have a functional level of 2008 or higher.
      - Have a DC running 2012 R2 or newer holding the PDC emulator role.
"@
    }
    Read-Host 'Press Enter to Continue'
    #endregion show forest results

    #region show domain results
    
    if ($Environment.Forest.PugFFL -eq $false) {
        Write-PPHost -Type Title -Message 'Domain Functional Level (FFL)'
        Write-PPHost -Type Subtitle -Message @'
If the DFL is Server 2012 R2 or higher, the Protected Users Group exists in that domain.
    Host- and domain controller-level protections will apply within the domain but may not extend beyond that domain.
'@
        Write-PPHost -Type Subtitle -Message @'
If the DFL is Server 2008-2012, the Protected Users Group *may* exist in that domain.'
    Only host-level protections will apply within the domain but may not extend beyond that domain.
'@
        Write-PPHost -Type Subtitle -Message @'
If the DFL is Server 2008-2012, the Protected Users Group *may* exist in that domain.'
    If the Protected Users Group exists, only host-level protections will apply within the domain.
    Protections may not extend beyond that domain.
'@
        $Environment.Domains | ForEach-Object {
           if ($_.PugExists -and $_.PugDfl) {
                Write-PPHost -Type Success -Message @"
$($_.Name) DFL is $($FLHashtable[$_.DomainModeLevel]).
    The Protected Users group exists in this domain.
    Host- and domain controller-level protections will apply to all intra-domain traffic.
    Only host-level protections will apply to inter-domain traffic with 
    domains running Server 2008-2012.
    No protections will apply to traffic with domains running Server 2003 or lower.
"@
    } elseif ($_.PugExists -and ($_.PugDfl -eq $false) ) {
        Write-PPHost -Type Warning -Message @"
$($_.Name) DFL is $($FLHashtable[$_.DomainModeLevel]).
    The Protected Users group exists in this domain, but the DFL is too low for full protection.
    Host-level protections will apply to all intra-domain traffic and any inter-domain traffic
    with domains running Server 2008-2012 DFL.
    Domain controller-level protections will not apply to any traffic.
    No protections will apply to traffic with domains running Server 2003 or lower.
"@
    } else {
        Write-PPHost -Type Error -Message @"
$($_.Name) DFL is $($FLHashtable[$_.DomainModeLevel])
    The Protected Users group does nto exist in this domain.
    No protections will apply to intra-domain traffic or inter-domain traffic.
"@
            }
        }
    }
    Read-Host 'Press Enter to Continue'
    #endregion show domain results

    #region show DC results
    
    if ($Environment.Forest.PugFFL -eq $false) {
        $Environment.Domains | ForEach-Object {
           if ( ($_.PugDFL -eq $false) -and ($_.PugExists -eq $false) ) {
                Write-PPHost -Type Title -Message "Domain Controller (DC) Operating System (OS): $($_.Name)"
                Write-PPHost -Type Subtitle -Message @'
If the DFL is Server 2008-2012, the Protected Users Group can be created in that domain
    by promoting a Server 2012 R2 DC into the Primary Domain Controller emulator (PDCe) role.
    Host-level protections will apply within the domain but may not extend beyond that domain.
'@
                $Environment.Dcs | ForEach-Object {
                   if ($_.PugOs) {
                        Write-PPHost -Type Success -Message "$($_.Name) is running $($_.OSVersion) and can support the PUG!"
                    } else {
                        Write-PPHost -Type Error -Message "$($_.Name) is running $($_.OSVersion) and cannot support the PUG."
                    }
                }

                Write-PPHost -Type Title -Message "DC Logging Configuration: $($_.Name)"
                Write-PPHost -Type Subtitle -Message 'Proper Audit Logging is required to check for the use of NTLM and weak Kerberos.'
                $Environment.Dcs | ForEach-Object {
                   if ($_.AuditingEnabled) {
                        Write-PPHost -Type Success -Message "$($_.Name) has Logon Auditing properly configured."
                    } else {
                        Write-PPHost -Type Error -Message @"
$($_.Name) does not have Logon Auditing properly configured.
    Please run the following command on $($_.Name):
"@
                        Write-PPHost -Type Code -Message "auditpol /set /subcategory:Logon /success:enable /failure:enable"
                    }
                }
            }
        }
    }
    Read-Host 'Press Enter to Continue'
    #endregion show DC results
    #endregion show environmental results
}
