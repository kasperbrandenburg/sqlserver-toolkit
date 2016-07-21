function Test_Invoke-BackupSqlAgentJobs {
    
    $TestName = $MyInvocation.MyCommand.Name
    [XML]$PesterConfig = Get-Content "Pester-Configuration.xml"
    
    $ServerInstance = $PesterConfig.Pester.Tests.$testname.ServerInstance
    $TestFolder = $PesterConfig.Pester.RootFolder+"\"+$PesterConfig.Pester.ProjectName+"\"+$TestName
    
    # Creating test folder structure if missing
    If( -not(Test-Path $TestFolder) ) { New-Item -ItemType Folder -Path $TestFolder }

    # Clean out old test data before run
    Remove-Item $TestFolder\*.sql -Force -Verbose

    # Import module (must be in path) and run test
    Import-Module sqlserver-toolkit -Force
	Invoke-BackupSqlAgentJobs -ServerInstance "$ServerInstance" -BackupFolder "$TestFolder"
}
