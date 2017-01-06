

This mainly involves one major thing, you just need to start your mesos-slave so that it points to mesos-master, that you want. For that, mainly you need to change entry in /etc/mesos/zk file to point to master.

Mesos slave mainly shall be running only docker and slave.

Make sure you disable to firewall on slaves. systemctl stop firewalld

Finally, create /etc/mesos-slave/hostname and /etc/mesos-slave/ip files. They must respectively hold hostname of slave and ip of slave.

------

Another imporatnt thing is, some container don't use URI to load the configurations instead they look for configurations using system path. In that case, if they don't find the configurations, then tasks won't be launched on the slave. So you need to find a mechanism to provide these configurations to these slave machines. Best is mount the config folder from master to these slave machines.

And to share the config files, I need to have an NFS server running on my master so that I can say something like this on my slaves.

### To setup NFS server

[See here](https://github.hpe.com/akhilesh-tyagi/linux_trickery/blob/master/nfs_server.md)
