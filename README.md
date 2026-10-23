# PowerShell Administration Labs

PowerShell scripts and labs I built to practice Windows troubleshooting, Active Directory administration, and reporting.

## Featured Project: AD User Access Report

Retrieves an Active Directory user's account status, password information, OU location, and group memberships.

- Accepts a username as a parameter
- Returns a structured report using `[PSCustomObject]`
- Reports directory lookup errors using `try/catch`
- Supports CSV export through the PowerShell pipeline
- Includes screenshots of successful queries, nonexistent-user handling, and CSV verification

[View the script and project documentation](03-AD-User-Access-Report)

## Projects

| Project | Description |
| --- | --- |
| [AD User Access Report](03-AD-User-Access-Report) | Collects account details and group memberships for help desk investigations. |
| [System Information Collector](01%20-%20System%20Information%20Collector) | Displays Windows version, CPU, memory, disk usage, active network adapters, and uptime. |
| [Service Monitoring](02%20-%20Service%20Monitoring) | Checks the status of selected Windows services and reports services that cannot be found. |
| [Windows Health Check](04%20-%20Windows-Health-Check) | Displays disk space, service status, firewall profile settings, uptime, and an ICMP reachability test. |
| [Bulk AD User Provisioning](05-%20AD-Bulk-User-Provisioning) | Documents creating AD accounts in a specified OU using CSV input and a PowerShell loop. |

## Running the Scripts

Open a project folder and review its script and README before running it.

The Windows diagnostic scripts query the local computer. Active Directory projects require the `ActiveDirectory` PowerShell module, connectivity to the domain, and appropriate permissions.

The user access report returns an object that can be displayed or exported:

```powershell
.\Get-UserAccessReport.ps1 -Username "MasonKol"
```

```powershell
.\Get-UserAccessReport.ps1 -Username "MasonKol" |
    Export-Csv -Path ".\MasonKol-AccessReport.csv" -NoTypeInformation
```

Run these examples from the folder containing `Get-UserAccessReport.ps1`.

## Skills Practiced

- Windows system queries with CIM
- Service and firewall status checks
- Active Directory user and group queries
- Variables, arrays, loops, and parameters
- Filtering, property selection, and sorting
- Structured output with `[PSCustomObject]`
- Error handling with `try/catch`
- CSV import and export

## Lab Notes

The Active Directory projects were developed in a Windows Server VM using test accounts. System information and health checks provide diagnostic observations rather than a complete assessment of a computer's health.

Each project folder contains its own documentation. Screenshots are included where configuration and test results were captured.