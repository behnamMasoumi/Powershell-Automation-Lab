# Get-SystemInfo.ps1
# Collects general Windows system information for IT troubleshooting.
# Output is intentionally sanitized for safe use in a public GitHub repository.

Write-Host "========================================"
Write-Host "       SYSTEM INFORMATION REPORT"
Write-Host "========================================"
Write-Host ""

# -----------------------------
# OPERATING SYSTEM
# -----------------------------

$os = Get-CimInstance Win32_OperatingSystem

Write-Host "OPERATING SYSTEM"
Write-Host "----------------------------------------"
Write-Host "OS                : $($os.Caption)"
Write-Host "Version           : $($os.Version)"
Write-Host "Build             : $($os.BuildNumber)"
Write-Host "Architecture      : $($os.OSArchitecture)"
Write-Host ""

# -----------------------------
# HARDWARE
# -----------------------------

$computer = Get-CimInstance Win32_ComputerSystem
$cpu = Get-CimInstance Win32_Processor

$ramGB = [math]::Round($computer.TotalPhysicalMemory / 1GB, 2)

Write-Host "HARDWARE"
Write-Host "----------------------------------------"
Write-Host "CPU               : $($cpu.Name)"
Write-Host "Cores             : $($cpu.NumberOfCores)"
Write-Host "Logical Processors: $($cpu.NumberOfLogicalProcessors)"
Write-Host "RAM               : $ramGB GB"
Write-Host ""

# -----------------------------
# STORAGE
# -----------------------------

$disk = Get-CimInstance Win32_LogicalDisk -Filter "DeviceID='C:'"

$totalGB = [math]::Round($disk.Size / 1GB, 2)
$freeGB = [math]::Round($disk.FreeSpace / 1GB, 2)
$usedGB = [math]::Round(($disk.Size - $disk.FreeSpace) / 1GB, 2)
$freePercent = [math]::Round(($disk.FreeSpace / $disk.Size) * 100, 1)

Write-Host "STORAGE"
Write-Host "----------------------------------------"
Write-Host "System Drive Total: $totalGB GB"
Write-Host "Free Space        : $freeGB GB"
Write-Host "Used Space        : $usedGB GB"
Write-Host "Free Space        : $freePercent%"
Write-Host ""

# -----------------------------
# NETWORK STATUS
# -----------------------------

$networkAdapters = Get-NetAdapter |
    Where-Object { $_.Status -eq "Up" }

Write-Host "NETWORK"
Write-Host "----------------------------------------"

if ($networkAdapters) {
    Write-Host "Active Adapters   : $($networkAdapters.Count)"
    Write-Host "Connectivity      : Active"
}
else {
    Write-Host "Active Adapters   : 0"
    Write-Host "Connectivity      : No active adapter"
}

Write-Host ""

# -----------------------------
# SYSTEM UPTIME
# -----------------------------

$lastBoot = $os.LastBootUpTime
$uptime = (Get-Date) - $lastBoot

Write-Host "SYSTEM HEALTH"
Write-Host "----------------------------------------"
Write-Host "Last Boot         : $lastBoot"
Write-Host "System Uptime     : $($uptime.Days) Days $($uptime.Hours) Hours $($uptime.Minutes) Minutes"
Write-Host ""

Write-Host "========================================"
Write-Host "          REPORT COMPLETE"
Write-Host "========================================"