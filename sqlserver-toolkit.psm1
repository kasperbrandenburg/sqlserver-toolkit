$here = Split-Path -Parent $MyInvocation.MyCommand.Path

. $here\Functions\SQL-Agent\Invoke-BackupSqlAgentJobs.ps1
. $here\Functions\SQL-Agent\Invoke-RestoreSqlAgentJobs.ps1

$functionsToExport = @(
    'Invoke-BackupSqlAgentJobs',
    'Invoke-RestoreSqlAgentJobs'
)

Export-ModuleMember -Function $functionsToExport