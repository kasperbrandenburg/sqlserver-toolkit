# Load the module
Import-Module .\sqlserver-toolkit.psd1 -Force

# Perform the backup af jobs to files on disk
Invoke-BackupSqlAgentJobs -ServerInstance "localhost\sql201201" -BackupFolder "C:\Temp\SQL_Backups"

# Load the files from disk, and restore into a SQL Server.
Invoke-RestoreSqlAgentJobs -ServerInstance "localhost\sql201201" -BackupFolder "C:\Temp\SQL_Backups"