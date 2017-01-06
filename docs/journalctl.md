journalctl may be used to query the contents of the systemd(1) journal as written by systemd-journald.service(8).

If one or more match arguments are passed, the output is filtered accordingly. A match is in the format "FIELD=VALUE", e.g.  "_SYSTEMD_UNIT=httpd.service"

`
# -xe cause it to show from the last entries.
journalctl -xe _SYSTEMD_UNIT=haproxy.service 
`

-f, --follow
           Show only the most recent journal entries, and continuously print new entries as they are appended to the journal.

man 7 systemd.journal-fields
