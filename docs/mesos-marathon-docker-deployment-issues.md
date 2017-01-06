I have observed a lot of problems during deployment. Two of the main reasons I have seen *zookeeper znodes* and *orphan process* in the system.

This is how the system looks like when it just boots up. This is one of the snapshot of just a clean system - process that have 
init as parent.

> ## Orphan process problem

Below is the command that shall give you the process with parent as 1. And just below is the snapshot of a system that has just booted up. If you are facing deployment problems, you can double check using below command if something fishy is going on.

*top* command is also very helpfull here. As orphan process' normally consume lot of memory. (This is good link from where I picked this up.)[http://linuxg.net/what-are-zombie-and-orphan-processes-and-how-to-kill-them/]
##### ps -elf | awk '{if ($5 == 1){print $4" "$5" "$15}}'

```
532 1 /usr/lib/systemd/systemd-journald
553 1 /usr/sbin/lvmetad
566 1 /usr/lib/systemd/systemd-udevd
659 1 /sbin/auditd
681 1 /usr/sbin/NetworkManager
682 1 /usr/sbin/rsyslogd
683 1 /usr/lib/systemd/systemd-logind
684 1 /usr/bin/vmtoolsd
688 1 /usr/sbin/irqbalance
689 1 /bin/dbus-daemon
697 1 /usr/sbin/crond
711 1 /usr/sbin/wpa_supplicant
713 1 /usr/lib/polkit-1/polkitd
925 1 /usr/sbin/haproxy-systemd-wrapper
926 1 /usr/bin/python
927 1 java
929 1 /usr/sbin/mesos-master
932 1 dockerd
933 1 java
935 1 /usr/sbin/sshd
1141 1 /sbin/agetty
1308 1 /usr/pgsql-9.4/bin/postgres
1755 1 /usr/libexec/postfix/master
1792 1 nginx:
2576 1 /usr/sbin/mesos-slave
```
> ### Remedy for orphan process

This is what you can do. Kill all process whose pid is > 1
```
kill -9 -1
```
*NOTE: Above command is very nearly equivalent to rebooting your system. I advise you not do it, unless you are really sure what are you doing.*

Then you shall need to make sure that all services come back. These are the services that we need. If anything fails to come back, don't worry. You just need to manually start them.

These are the services that we need 
* mesos-master
* mesos-slave
* docker
* marathon
* docker
* haproxy
* crond
* postgres
* nginx

Use this command to find out the status
```
find /usr/lib/systemd/system -type f -regextype posix-basic -regex '.*\(/mesos.*\|/marathon.*\|/haproxy.*\|/docker.*\|/crond.*\|/nginx.*\|/postgres.*\)$' -exec bash -c 'systemctl status "$(basename "$0")" | grep -C 3 Active' {} \;
```
> ## Docker devicemapper problem

At one instance I saw that when the script ran `rm -rf /var/lib/docker` it got devicemapper busy issue. And because of which docker could not recover from above kill -9 -1 thing.

Reason is device is mounted. You need to find the mounted device and umount it.

> ## Healthcheck problem

Often I have seen that even though the node came up fine, but healthcheck was failing. I could see in the logs. Just to make sure that mesos/marathon doesn't kill my job even though it is saying its not healthy you can set *"maxConsecutiveFailures"* property in healthCheck configuration as 0. 

I have seen that if I do as above, then eventually node turns up healthy.
