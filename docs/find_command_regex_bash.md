```
find /usr/lib/systemd/system -type f -regextype posix-basic -regex '.*\(/mesos.*\|/marathon.*\|/haproxy.*\)$' -exec bash -c 'systemctl status "$(basename "$0")"' {} \;
```
