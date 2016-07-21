# sqlserver-toolkit
This script library is a work-in-progress set of generic scripts, to use for SQL Server.
It will contain everything from performance counter collection to SQL Agent job copy functions.
It probably only testet on the latest version of SQL Server, so test before you implement.

Support on this is limited, i'll do what i can, and when i can.

## SQL Server Agent Backup/Restore
Using this module you can perform SQL Agent job Backup/Restore.
This is usefull, if you need to copy jobs onto other servers, like QA and Test servers.
It should not be a substitute for proper database backups.

Look in the Example.ps1 file for more information.

### Index maintenance and database backup
If you are looking for at good index maintence scripts, goto https://ola.hallengren.com/

### SQL Server health check
The team at BrentOzar is doing a lot of good with their first-aid kit,
check it out: https://www.brentozar.com/first-aid/

### Diagnostic Information Queries
Glen Berry maintenaces a great set of dianostics queries on his WP blog
https://sqlserverperformance.wordpress.com/
