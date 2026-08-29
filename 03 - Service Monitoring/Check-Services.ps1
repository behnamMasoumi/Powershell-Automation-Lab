Write-Host "========================================"
Write-Host "       WINDOWS SERVICE MONITOR"
Write-Host "========================================"

$services = @(
    "wuauserv",
    "WinDefend",
    "Dhcp",
    "Dnscache",
    "Spooler"
)

foreach ($service in $services) {

    $status = Get-Service -Name $service -ErrorAction SilentlyContinue

    if ($status) {
        Write-Host "$($status.DisplayName) : $($status.Status)"
    }
    else {
        Write-Host "$service : Service not found"
    }
}


Write-Host "========================================"
Write-Host "             CHECK COMPLETE"
Write-Host "========================================"