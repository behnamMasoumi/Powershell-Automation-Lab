param(
    [Parameter(Mandatory)]
    [string]$Username
)

Import-Module ActiveDirectory -ErrorAction Stop

try {
    $user = Get-ADUser -Identity $Username `
        -Properties LockedOut, PasswordLastSet, PasswordExpired `
        -ErrorAction Stop

    $groups = Get-ADPrincipalGroupMembership -Identity $Username `
        -ErrorAction Stop |
        Select-Object -ExpandProperty Name

    [PSCustomObject]@{
        Name              = $user.Name
        Username          = $user.SamAccountName
        Enabled           = $user.Enabled
        LockedOut         = $user.LockedOut
        PasswordLastSet   = $user.PasswordLastSet
        PasswordExpired   = $user.PasswordExpired
        DistinguishedName = $user.DistinguishedName
        Groups            = ($groups | Sort-Object) -join "; "
    }
}
catch {
    Write-Error "Could not retrieve the report for '$Username': $($_.Exception.Message)"
}