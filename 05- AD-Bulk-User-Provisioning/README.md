# Bulk Active Directory User Creation with PowerShell

In this lab, I automated the creation of two Active Directory user accounts (it could be way more at the enterprise level but it's easy to scale up if needed, this is just a demonstration of the fundamental) by importing a CSV file into PowerShell.

**Environment:** Windows Server VM · Active Directory · `benDomain.local`

**Target OU:** USA → Users → All employees

### 1. Check existing users

I checked the **All employees** OU to confirm that Mike Brown and Sarah Jones were not already present.

![OU before user creation](screenshots/01-%20Before%20user%20Creation.png)

### 2. Create the CSV file

I used a PowerShell here-string to store the user information in $Users, then saved it as a CSV file.

```
$Users = @"
Name,Username,Groups
Mike Brown,MikeBrown,SG-Finance
Sarah Jones,SarahJones,SG-HR
"@

$Users | Set-Content -Path "C:\ADUsers.csv"
```

![File Created](screenshots/02-%20Creating%20the%20file.png)

### 3. Import the CSV and create the accounts

I used `Import-Csv` and `ForEach-Object` to process each row and create an enabled account in the target OU.

```
Import-Csv "C:\ADUsers.csv" | ForEach-Object {
    New-ADUser -Name $_.Name -SamAccountName $_.Username -Path "OU=All employees,OU=Users,OU=USA,DC=benDomain,DC=local" -AccountPassword (Read-Host "Enter Pass" AsSecureString) -Enabled $true -ChangePasswordAtLogon $false -ErrorAction Stop
}
```

The `Groups` column stores sample group information; this script only creates the accounts.

![Users Created and Added to the OU](screenshots/03-%20Users%20Created.png)

### Outcome

Created Mike Brown and Sarah Jones in Active Directory using one script, practicing **CSV handling, variables, loops, secure password input, and AD account administration**.

> This lab uses a shared password with no forced password change. Production onboarding should use unique temporary passwords and require a change at first sign-in.
>