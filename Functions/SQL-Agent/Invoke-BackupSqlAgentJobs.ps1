
Function Invoke-BackupSqlAgentJobs
{

    <#
    .Synopsis
        Performs backup of SQL Agent Jobs.
    .DESCRIPTION
        Invoke-BackupSqlAgentJobs can perform backup of SQL Agent files using SMO. The function connects to SQL Server,
        Iterates across jobs and saves all jobs as individual files on disk.
    .PARAMETER ServerInstance
        Name of the SQL Server you are connection to, to perform backup of SQL Agent Jobs. This can be locally or remotely.
        Name could be "localhost", or "localhost\instance" or it could be remotely "Server1.domain.com,1433"
    .PARAMETER BackupFolder
        The folder in which you want to place the backup .sql files. This can be both absolute and relative paths
        UNC should be supported as well.
    .EXAMPLE
        Invoke-BackupSqlAgentJobs -ServerInstance "localhost" -BackupFolder "C:\Temp\SQL_Backups"
    .EXAMPLE
        Invoke-BackupSqlAgentJobs -ServerInstance "localhost\sql201201" -BackupFolder "Temp\SQL_Backups"
    .INPUTS
    .OUTPUTS
    .LINK
        Invoke-RestoreSqlAgentJobs
    #>

    [cmdletbinding()]
    Param
    (
            [parameter(Mandatory=$true, ValueFromPipeline=$false, HelpMessage="SQL Server hostname and or instance name e.g. 'localhost', or 'sqlServer01\instance1'")]
            [Alias("SQLServer", "Hostname", "Computername")]
            [String]$ServerInstance,

            [parameter(Mandatory=$true, ValueFromPipeline=$false, HelpMessage="Folder on filesystem where backups will be placed")]
            [String]$BackupFolder
    )

    Begin 
    {
        [System.Reflection.Assembly]::LoadWithPartialName('Microsoft.SqlServer.Smo') | Out-Null
    }

    Process 
    {
        $Server = New-Object Microsoft.SqlServer.Management.Smo.Server("$ServerInstance")
 
        $Jobs = $Server.Jobserver.Jobs 
        #$Jobs = $Server.Jobserver.Jobs | where-object {$_.category -eq "[your category]"}
 
        if ($Jobs -ne $null)
        {
 
            $ServerInstance = $ServerInstance.Replace("\", "-")
 
            ForEach ( $job in $Jobs )
            {
                $FileName = "$BackupFolder\" + $ServerInstance + "_" + $job.Name + ".sql"
                $job.Script() | Out-File -filepath $FileName
            }
        }
        else
        {
            Write-Output "No Jobs was found on $Server"
        }
    }

    end {}
}