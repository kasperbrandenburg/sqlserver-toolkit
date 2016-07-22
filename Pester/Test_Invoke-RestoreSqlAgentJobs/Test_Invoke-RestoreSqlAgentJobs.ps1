function Test_Invoke-RestoreSqlAgentJobs {
    Param
    (
        $ParentFolder
    )

    $TestName = $MyInvocation.MyCommand.Name
    [XML]$PesterConfig = Get-Content "Pester-Configuration.xml"
    
    $ServerInstance = $PesterConfig.Pester.Tests.$testname.ServerInstance

    # Counting the jobs to restore, used later for comparisson
    $Jobs = Get-ChildItem "$ParentFolder\Jobs\*.sql"
    
    # Import module (must be in path) and run test
    Import-Module sqlserver-toolkit -Force
    Invoke-RestoreSqlAgentJobs -ServerInstance "$ServerInstance" -BackupFolder "$ParentFolder\Jobs\"

    # Query to test if we actually created the same number of jobs, as we had backup files.
    $Query = "SELECT job_id FROM msdb.dbo.sysjobs WHERE name LIKE 'Pester_%'"
    $Result = Invoke-Sqlcmd -ServerInstance $ServerInstance -Database "msdb" -Query $Query

    
    # Cleanup restored jobs
    Foreach ($Job in $Result) {
        $Query = "EXEC sp_delete_job @job_id='"+($Job.job_id)+"'"
        Invoke-Sqlcmd -ServerInstance $ServerInstance -Database "msdb" -Query "$Query"

        Write-Information "Deleted $Job from $ServerInstance"
    }

    
    # Validation
    if ($Jobs.Count -eq $Result.Count ) { return $true }


}
