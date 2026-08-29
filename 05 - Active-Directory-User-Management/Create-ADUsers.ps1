$users = Import-Csv ".\users.csv"

foreach ($user in $users) {
    Write-Host "Username: $($user.Username)"
    Write-Host "Name: $($user.FirstName) $($user.LastName)"
    Write-Host "Department: $($user.Department)"
    Write-Host "--------------------------------"
}