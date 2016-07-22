$here = Split-Path -Parent $MyInvocation.MyCommand.Path
$sut = (Split-Path -Leaf $MyInvocation.MyCommand.Path).Replace(".Tests.", ".")
. "$here\$sut"

# Load Pester config file
[XML]$PesterConfig = Get-Content "Pester-Configuration.xml"

Describe "Test_Invoke-RestoreSqlAgentJobs" {
    It "Testing SQL Agent job restore" {

        # Uses set of SQL Agent scripts from the \Jobs\ folder
        $ServerInstance = $PesterConfig.Pester.Tests.$testname.ServerInstance

        Test_Invoke-RestoreSqlAgentJobs -ParentFolder $here | Should be $true        
    }
}
