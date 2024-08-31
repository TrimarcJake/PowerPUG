function Get-PPEnvironment {
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
    )

    #requires -Version 5

    #region collection and enrichment
    #region collect forest environmental info
    Write-PPHost -Type Info -Message "Collecting Forest Information"
    $Forest = Get-PPForest
    Write-PPHost -Type Info -Message "Enriching Collected Forest Information"
    $Forest | ForEach-Object {
        $PugFFL = Test-PPForestFL -Forest $_
        $_ | Add-Member -NotePropertyName PugFFL -NotePropertyValue $PugFFL -Force
        $ForestAdminGroupSids = Get-PPForestAdminGroupSid -Forest $_
        $_ | Add-Member -NotePropertyName AdminGroupSids -NotePropertyValue $ForestAdminGroupSids -Force
    }
    #endregion collect forest enviromental info
    
    #region collect domain environmental info
    Write-PPHost -Type Info -Message "Collecting Domain Information"
    $Domains = Get-PPDomain -Forest $Forest | Select-Object -Unique
    Write-PPHost -Type Info -Message "Enriching Collected Domain Information"
    $Domains | ForEach-Object {
        $DomainSid = Get-PPDomainSid -Domain $_
        $_ | Add-Member -NotePropertyName Sid -NotePropertyValue $DomainSid -Force
        $PugDFL = Test-PPDomainFL -Domain $_
        $_ | Add-Member -NotePropertyName PugDFL -NotePropertyValue $PugDFL -Force
        $PugSid = Get-PPDomainPugSid -Domain $_
        $_ | Add-Member -NotePropertyName PugSid -NotePropertyValue $PugSid -Force
        $PugExists = Test-PPDomainPugExists -Domain $_
        $_ | Add-Member -NotePropertyName PugExists -NotePropertyValue $PugExists -Force
        $DomainAdminGroupSids = Get-PPDomainAdminGroupSid -Domain $_
        $_ | Add-Member -NotePropertyName AdminGroupSids -NotePropertyValue $DomainAdminGroupSids -Force
    }
    #endregion collect forest environmental info

    #region collect domain controller environmental info
    Write-PPHost -Type Info -Message "Collecting Domain Controller Information"
    $Dcs = Get-PPDc -Domain $Domains | Select-Object -Unique
    Write-PPHost -Type Info -Message "Enriching Collected Domain Controller Information"
    $Dcs | ForEach-Object {
        $PugOS = Test-PPDCOS -DC $_
        $_ | Add-Member -NotePropertyName PugOS -NotePropertyValue $PugOS -Force
        try {
            $AuditingConfiguration = Get-PPDCLogConfiguration -DC $_
            $AuditingEnabled = Test-PPDCLogConfiguration -Configuration $AuditingConfiguration
            $_ | Add-Member -NotePropertyName AuditingEnabled -NotePropertyValue $AuditingEnabled -Force
        } catch {
        }
    }
    #endregion collect domain controller environmental info

    #region expand group membership
    Write-PPHost -Type Info -Message "Collecting Protected User Group Membership"
    $PugMembers = Expand-PPGroupMembership -Sid $Domains.PugSid

    Write-PPHost -Type Info -Message "Collecting Forest AD Admin Group Membership"
    $ForestAdmins = Expand-PPGroupMembership -Sid $Forest.AdminGroupSids | Select-Object -Unique
    Write-PPHost -Type Info -Message "Enriching Collected AD Forest Admin Information"
    $ForestAdmins | ForEach-Object {
        $PugMember = Test-PPUserPugMember -User $_ -PugMembership $PugMembers
        $_ | Add-Member -NotePropertyName PugMember -NotePropertyValue $PugMember -Force
        
        $PasswordOlderThan1Year = Test-PPUserPasswordOlderThan1Year -User $_
        $_ | Add-Member -NotePropertyName PasswordOlderThan1Year -NotePropertyValue $PasswordOlderThan1Year -Force
        $PasswordOlderThanPug = Test-PPUserPasswordOlderThanPug -User $_
        $_ | Add-Member -NotePropertyName PasswordOlderThanPug -NotePropertyValue $PasswordOlderThanPug -Force
    }
    
    Write-PPHost -Type Info -Message "Collecting Domain Admin Group Membership"
    $DomainAdmins = $Domains.AdminGroupSids | Expand-PPGroupMembership -Sid $_ | Select-Object -Unique
    Write-PPHost -Type Info -Message "Enriching Collected Domain Admin Information"
    $DomainAdmins | ForEach-Object {
        $PugMember = Test-PPUserPugMember -User $_ -PugMembership $PugMembers
        $_ | Add-Member -NotePropertyName PugMember -NotePropertyValue $PugMember -Force
        $PasswordOlderThan1Year = Test-PPUserPasswordOlderThan1Year -User $_
        $_ | Add-Member -NotePropertyName PasswordOlderThan1Year -NotePropertyValue $PasswordOlderThan1Year -Force
        $PasswordOlderThanPug = Test-PPUserPasswordOlderThanPug -User $_
        $_ | Add-Member -NotePropertyName PasswordOlderThanPug -NotePropertyValue $PasswordOlderThanPug -Force
    }
    #endregion expand group
    #endregion collection and enrichment

    $Environment = @{
        Forest       = $Forest
        Domains      = $Domains
        Dcs          = $Dcs
        ForestAdmins = $ForestAdmins
        DomainAdmins = $DomainAdmins
    }

    Write-Output $Environment
    Read-Host 'Press Enter to Continue'
}
