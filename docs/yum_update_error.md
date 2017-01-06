if you ever get this kind of error while running `yum update`
```
Loaded plugins: fastestmirror, langpacks


 One of the configured repositories failed (Unknown),
 and yum doesn't have enough cached data to continue. At this point the only
 safe thing yum can do is fail. There are a few ways to work "fix" this:

     1. Contact the upstream for the repository and get them to fix the problem.

     2. Reconfigure the baseurl/etc. for the repository, to point to a working
        upstream. This is most often useful if you are using a newer
        distribution release than is supported by the repository (and the
        packages for the previous distribution release still work).

     3. Disable the repository, so yum won't use it by default. Yum will then
        just ignore the repository until you permanently enable it again or use
        --enablerepo for temporary usage:

            yum-config-manager --disable <repoid>

     4. Configure the failing repository to be skipped, if it is unavailable.
        Note that yum will try to contact the repo. when it runs most commands,
        so will have to try and fail each time (and thus. yum will be be much
        slower). If it is a very temporary problem though, this is often a nice
        compromise:

            yum-config-manager --save --setopt=<repoid>.skip_if_unavailable=true

Cannot find a valid baseurl for repo: base/7/x86_64 
```

For solution, put proxy information in `/etc/yum.conf` file.
```
proxy=http://proxy.houston.hpecorp.net:8080
```
