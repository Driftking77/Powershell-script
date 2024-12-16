# Variables
$serverName = "1.2.3.4,14330" # SQL Server instance (e.g., "localhost" or "ServerName\InstanceName")
$databaseName = "DB_Name" # Name of the database to back up
$backupDirectory = "D:\abc" # Directory where the backup will be saved
$backupFileName = "$databaseName-$(Get-Date -Format 'yyyyMMddHHmmss').bak" # Backup file with timestamp
$backupPath = Join-Path $backupDirectory $backupFileName


# SQL Authentication Credentials
$sqlUsername = "qwerty" # SQL username
$sqlPassword = "Qwerty@123456" # SQL password


# Ensure the backup directory exists
if (-not (Test-Path -Path $backupDirectory)) {
    New-Item -ItemType Directory -Path $backupDirectory -Force | Out-Null
}

# Import the SqlServer module
Import-Module -Name SqlServer


# Create the SQL Server SMO object with SQL Authentication
$server = New-Object Microsoft.SqlServer.Management.Smo.Server $serverName
$server.ConnectionContext.LoginSecure = $false  # Use SQL Authentication
$server.ConnectionContext.Login = $sqlUsername
$server.ConnectionContext.Password = $sqlPassword


# Create a Backup object
$backup = New-Object Microsoft.SqlServer.Management.Smo.Backup
$backup.Action = "Database"
$backup.Database = $databaseName
$backup.Devices.AddDevice($backupPath, "File")
$backup.Incremental = $false  # Full backup
$backup.ExpirationDate = (Get-Date).AddDays(30) # Optional: set expiration for the backup
$backup.LogTruncation = [Microsoft.SqlServer.Management.Smo.BackupTruncateLogType]::Truncate


# Perform the backup
try {
    Write-Host "Starting backup of database '$databaseName' to file '$backupPath'..."
    $backup.SqlBackup($server)
    Write-Host "Backup completed successfully to '$backupPath'."
} catch {
    Write-Error "An error occurred during the backup: $_"
}
