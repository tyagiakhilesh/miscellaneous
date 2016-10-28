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

## Second Problem: Enabling the SQL auth mode for the db

* Make sure you enable the sa login account first. By default its disabled.
* Once that is done, simply right click the instance (after logging into it through windows auth mode), Got to security. Check SQL server and Window .. Ok.
* Done.

## Login failed for user while trying to connect to MSSQL
This [link](https://support.microsoft.com/en-us/kb/555332)
```
Login failed for user '<user_name>'. (Microsoft SQL Server, Error: 18456)
```
SO I recently changed the domain of this machine (it was different when I installed the SQLSERVR) and the same is the reason for above.
```
Scenario 3: The login may use Windows Authentication but the login is an unrecognized Windows principal

An unrecognized Windows principal means that Windows can't verify the login. This might be because the Windows login is from an untrusted domain. To resolve this issue, verify that you are logged in to the correct domain.
```
