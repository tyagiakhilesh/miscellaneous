Over and over, I keep circling back to problem of setting up MSSQL properly.

Starting from this link [here](http://stackoverflow.com/questions/18060667/why-am-i-getting-cannot-connect-to-server-a-network-related-or-instance-speci)
* First: Allowing remote connections to database. (Enable TCP/IP protocol for your instance)
* Check the browser service etc. (Though they really don't make a difference. But So what!! I am paranoid!)
* One big issue. In SQL Server Configuration Manager, I see that my SQL Server Service, was showing Log On As NT AUTHORITY\NetworkService. This
is when I was facing
```
TITLE: Connect to Server ------------------------------  Cannot connect to SHAREDDEV-2\MSSQLSERVER.  ------------------------------ ADDITIONAL INFORMATION:  A network-related or instance-specific error occurred while establishing a connection to SQL Server. The server was not found or was not accessible. Verify that the instance name is correct and that SQL Server is configured to allow remote connections. (provider: SQL Network Interfaces, error: 25 - Connection string is not valid) (Microsoft SQL Server, Error: 87)  For help, click: http://go.microsoft.com/fwlink?ProdName=Microsoft%20SQL%20Server&EvtSrc=MSSQLServer&EvtID=87&LinkId=20476  ------------------------------  The parameter is incorrect  ------------------------------ BUTTONS:  OK ------------------------------
```
Once I changed that to AUTHORITY\NETWORK SERVICE, then I could do away with that error. Though, again this probably was not the root cause 
of the error.
* Finally I checked, on what port was MSSQLServer was running. Found out that it was using dynamic port. 1433 was missing. SO added that, then 
VOILA!!
