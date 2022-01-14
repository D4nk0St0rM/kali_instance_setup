#### kali instance setup
Spinning up new instances of Kali

##### Manual Steps

- Change password
```
passwd kali
```

- sudo visudo
```
sudo visudo / theUSER ALL=(ALL) NOPASSWD:ALL
```
- password less privesc
```
sudo apt-get install -y -y kali-grant-root && sudo dpkg-reconfigure kali-grant-root
```
- Settings Manager / Power Manager
    - Display All Power Management = Never



