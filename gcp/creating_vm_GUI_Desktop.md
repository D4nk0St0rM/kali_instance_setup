#### create ubuntu virtual machine

#### set up GUI desktop access

```
sudo apt-get -y update 
sudo apt-get install gnome-core -y
sudo apt-get install vnc4server -y
vncserver
### enterpassword
sudo apt install xfce4 xfce4-goodies
sudo nano ~/.vnc/xstartup
###add to end
exec /usr/bin/startxfce4 &
## add tag to vm 'vncserver'
## add firewall rule tcp:5901 with target tag vncserver

```

#### Install VNCViewer
```
https://www.realvnc.com/en/connect/download/viewer/
https://chrome.google.com/webstore/detail/vnc%C2%AE-viewer-for-google-ch/iabmpiboiopbgfabjmgeedhcmjenhbla?hl=en

```

#### Connect with VNCViewer
```
IPADDRESS:5901
```


