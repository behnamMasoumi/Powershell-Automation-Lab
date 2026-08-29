# WindowsHealthCheck.ps1
# Read-only Windows health assessment.
# This script does not modify system settings or files.

Write-Host "========================================"
Write-Host "        WINDOWS HEALTH CHECK"
Write-Host "========================================"
Write-Host ""

# ----------------------------------------
# SYSTEM DRIVE
# ----------------------------------------

Write-Host "STORAGE"
Write-Host "----------------------------------------"

$disk = Get-CimInstance Win32_LogicalDisk -Filter "DeviceID='C:'"

$freeGB = [math]::Round($disk.FreeSpace / 1GB, 2)
$totalGB = [math]::Round($disk.Size / 1GB, 2)
$freePercent = [math]::Round(($disk.FreeSpace / $disk.Size) * 100, 1)

Write-Host "Total Space       : $totalGB GB"
Write-Host "Free Space        : $freeGB GB"
Write-Host "Free Space        : $freePercent%"

if ($freePercent -lt 15) {
    Write-Host "WARNING: Low disk space."
}
else {
    Write-Host "Disk Status       : OK"
}

Write-Host ""

# ----------------------------------------
# IMPORTANT SERVICES
# ----------------------------------------

Write-Host "WINDOWS SERVICES"
Write-Host "----------------------------------------"

$services = @(
    "wuauserv",
    "WinDefend",
    "Dhcp",
    "Dnscache"
)

foreach ($serviceName in $services) {

    $service = Get-Service -Name $serviceName -ErrorAction SilentlyContinue

    if ($service) {

        if ($service.Status -eq "Running") {
            Write-Host "$($service.DisplayName) : Running"
        }
        else {
            Write-Host "$($service.DisplayName) : $($service.Status)"
        }

    }
    else {
        Write-Host "$serviceName : Not Found"
    }
}

Write-Host ""

# ----------------------------------------
# FIREWALL
# ----------------------------------------

Write-Host "WINDOWS FIREWALL"
Write-Host "----------------------------------------"

$firewallProfiles = Get-NetFirewallProfile

foreach ($profile in $firewallProfiles) {

    if ($profile.Enabled) {
        Write-Host "$($profile.Name) : Enabled"
    }
    else {
        Write-Host "$($profile.Name) : Disabled"
    }
}

Write-Host ""

# ----------------------------------------
# SYSTEM UPTIME
# ----------------------------------------

Write-Host "SYSTEM UPTIME"
Write-Host "----------------------------------------"

$os = Get-CimInstance Win32_OperatingSystem
$uptime = (Get-Date) - $os.LastBootUpTime

Write-Host "Last Boot         : $($os.LastBootUpTime)"
Write-Host "Uptime            : $($uptime.Days) Days $($uptime.Hours) Hours $($uptime.Minutes) Minutes"

Write-Host ""

# ----------------------------------------
# NETWORK CONNECTIVITY
# ----------------------------------------

Write-Host "NETWORK CONNECTIVITY"
Write-Host "----------------------------------------"

$connection = Test-NetConnection -ComputerName "1.1.1.1" -InformationLevel Quiet

if ($connection) {
    Write-Host "Internet Connectivity : Available"
}
else {
    Write-Host "Internet Connectivity : Unavailable"
}

Write-Host ""

# ----------------------------------------
# COMPLETE
# ----------------------------------------

Write-Host "========================================"
Write-Host "          HEALTH CHECK COMPLETE"
Write-Host "========================================"