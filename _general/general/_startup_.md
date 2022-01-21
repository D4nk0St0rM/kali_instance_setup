#### crontab -e
```
SHELL=/bin/bash
@reboot sleep 30 && sudo apt-get update
```

#### local.rc
/etc/rc.local
sudo chmod +x /etc/rc.local
```
#! /bin/bash
//path-to-script
exit 0
```

