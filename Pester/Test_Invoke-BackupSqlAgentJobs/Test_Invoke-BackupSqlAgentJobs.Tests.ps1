$here = Split-Path -Parent $MyInvocation.MyCommand.Path
$sut = (Split-Path -Leaf $MyInvocation.MyCommand.Path).Replace(".Tests.", ".")
. "$here\$sut"

# Load Pester config file
[XML]$PesterConfig = Get-Content "Pester-Configuration.xml"

Describe "Test_Invoke-BackupSqlAgentJobs" {
    It "Performs backup of SQL Agent jobs" {

        $TestName = "Test_Invoke-BackupSqlAgentJobs"
        $ServerInstance = $PesterConfig.Pester.Tests.$testname.ServerInstance
        $TestFolder = $PesterConfig.Pester.RootFolder+"\"+$PesterConfig.Pester.ProjectName+"\"+$TestName


        Test_Invoke-BackupSqlAgentJobs
        (Get-ChildItem $TestFolder\*.sql).Count | Should BeGreaterThan 0
    }
}
