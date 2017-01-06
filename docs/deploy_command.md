#### With storage and idm overridden.
```
bash ./deploy-service.sh  -o marathon-host=Base-CentOS-0-vinod.hpeswlab.net -o vertica-db-hostname=16.103.35.155 \
-o vertica-db-password=nextgen -o vertica-db-username=dbadmin --ssh-host=Base-CentOS-0-vinod.hpeswlab.net --ssh-user=root \
--ssh-password=skyline --config-directory /tmp/aspen -o idm-baseurl=https://a1-dev-hap3052.lab.lynx-connected.com:9012 \
-o storage-api-haproxy-name=a1-dev-mem048.lab.lynx-connected.com -o storage-api-https-service-port=9444
```

#### With Rabbit username and password overriden

```
bash ./deploy-service.sh  -o marathon-host=Base-CentOS-0-vinod.hpeswlab.net -o vertica-db-hostname=16.103.35.155 \
-o vertica-db-password=nextgen -o vertica-db-username=dbadmin --ssh-host=Base-CentOS-0-vinod.hpeswlab.net \
--ssh-user=root --ssh-password=skyline -o idm-baseurl=https://a1-dev-hap3052.lab.lynx-connected.com:9012 \
-o storage-api-haproxy-name=a1-dev-mem048.lab.lynx-connected.com -o storage-api-https-service-port=9444 \
-o rabbit-user=poc_user -o rabbit-password=nextgen;
```

#### With standard exclusions
```
bash ./deploy-service.sh -x "partner,eca,ed,production,ftp,sampledata,external" -o marathon-host=Base-CentOS-0-vinod.hpeswlab.net -o vertica-db-hostname=16.103.35.155 -o vertica-db-password=nextgen -o vertica-db-username=dbadmin --ssh-host=Base-CentOS-0-vinod.hpeswlab.net --ssh-user=root --ssh-password=skyline -o idm-baseurl=https://a1-dev-hap3052.lab.lynx-connected.com:9012 -o storage-api-haproxy-name=a1-dev-mem048.lab.lynx-connected.com  -o storage-api-https-service-port=9444 -o rabbit-user=guest -o rabbit-password=guest 
```
