> We need to install nfs-utils on both nfs server and any of its client machines.

```
yum -y install nfs-utils
# On server
systemctl enable nfs-server
systemctl start nfs-server

```

> Expose the shared directories on the server side, add below entry in `/etc/exports` file.
```
/usr/share/nginx/html/config	<nfs-client>(ro,sync,no_root_squash,no_subtree_check)
```
After editing the above file, run
```
 exportfs -a
```

> Accessing the files on the client

Before mounting actually, make sure that server is actually exposing the directories:
```
showmount -e blr-dev-vm-1.hpeswlab.net
```

```
mount -t nfs <nfs-server>:/usr/share/nginx/html/config /tmp/config
```

### Troubleshooting

I got 
```
mount.nfs: access denied by server while mounting blr-dev-vm-1.hpeswlab.net:/usr/share/nginx/html/config
```
while trying to mount config directory on client side. I fonund this relevant error in `/var/log/messages`
```
 08:32:28 blr-dev-vm-1 rpc.mountd[2831]: refused mount request from 16.103.38.61 for /usr/share/nginx/html/config (/usr/share/nginx/html/config): unmatched host
```

Reason for above error is: the hostname being used in `/etc/exports` file is the hostname of client actually, from where you want to 
access the files.

### To mount at boot
add this to /etc/fstab
```
blr-dev-vm-1.hpeswlab.net:/usr/share/nginx/html/config /usr/share/nginx/html/config nfs rw,sync,hard,intr  0     0
```
