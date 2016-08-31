A simple filter script to examine RBL blocks/deliveries from a postfix `/var/log/mail.log`.

```shell
tail -n500 -F /var/log/mail.log | perl mailfilter.pl
```
