

Function Invoke-RestoreSqlAgentJobs
{
    <#
    .Synopsis
       
    .DESCRIPTION
    .PARAMETER InputObject
    .EXAMPLE
    .EXAMPLE
    .INPUTS
    .OUTPUTS
    .LINK
        Invoke-BackupSqlAgentJobs
    #>

    [cmdletbinding()]
    Param
    (
            [parameter(Mandatory=$true, ValueFromPipeline=$false, HelpMessage="SQL Server hostname and or instance name e.g. 'localhost', or 'sqlServer01\instance1'")]
            [Alias("SQLServer", "Hostname", "Computername")]
            [String]$ServerInstance,

            [parameter(Mandatory=$true, ValueFromPipeline=$false, HelpMessage="Folder on filesystem where backups are placed")]
            [String]$BackupFolder
    )
    $Jobs = Get-ChildItem -Path $BackupFolder

    Foreach( $Job in $Jobs )
    {
        [string]$Query = Get-Content $Job.FullName
    
        <#
        DisableVariables needed 
            http://stackoverflow.com/questions/15580003/error-when-inserting-strings-with-with-invoke-sqlcmd-in-powershell
            http://msdn.microsoft.com/en-us/library/cc281720.aspx
        #>
        Invoke-Sqlcmd -ServerInstance "$ServerInstance" -Database "msdb" -Query "$Query" -DisableVariables
    }
}