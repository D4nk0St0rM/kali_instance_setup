<p align="center">
    <b>:panda_face: D4nk0St0rM :panda_face:</b>
</p>
<p align="center">
    <i><b>SpReAd L0vE & ShArE Kn0wLeDgE</b></i>
</p>

____
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
- Settings Manager
    - Power Manager
        - Display All Power Management = Never
    - Keyboard
        - Layout = English UK

- Screenshot
    - add to panel

- Chromium
    - add to panel

- Text Editor
    - remove from panel

- Wallpaper
    - Kali-neon




