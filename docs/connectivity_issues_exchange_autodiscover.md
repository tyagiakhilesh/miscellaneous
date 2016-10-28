### Autodiscover url was not found

So I was trying to connect to exchange 2013, and while I was testing connection, I was not able to pass the autodiscover url point.

Ultimately what I had to do was. I had to make an MX record in my DNS that points to my mail server (FQDN), host that resolve it.
And had to create a CNAME record, that shall resolve my autodiscover.mydoamin.com URL to the host where mail server is running or to DNS.
