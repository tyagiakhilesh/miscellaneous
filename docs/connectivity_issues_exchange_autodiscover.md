### Autodiscover url was not found

So I was trying to connect to exchange 2013, and while I was testing connection, I was not able to pass the autodiscover url point.

Ultimately what I had to do was. I had to make an MX record in my DNS that points to my mail server (FQDN), host that resolve it.
And had to create a CNAME record, that shall resolve my autodiscover.mydoamin.com URL to the host where mail server is running or to DNS.


#### Issue with DNS Prefix thing
I came today and found out that my autodiscover thing was still not working. I went ahead to my network adapter. Went to IPv4 properties. General->Advanced->DNS.

Here I saw that Append these DNS suffix (in order) was radio buttonned and it has a value other then the domain into which my machine is. I changed that to Append primary and connection specific DNS suffixes and checked Append parent suffix of primary DNS sufix. Restarted the machine. I could see that my autodiscover was working alright again.

#### Real key to solve the issue

In reality the main problem is resolving the path to autodiscover.mydomain.com. Use nslookup to find out if the paths being tried for discovering the service are indeed reachable or not. Which paths are being probed actually, can be found out via: microsoft connectivity tools : [here this link](https://testconnectivity.microsoft.com)
