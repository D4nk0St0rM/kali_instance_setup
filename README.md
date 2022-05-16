<!-- SVG Typing Animation  -->

[![Typing SVG](https://readme-typing-svg.herokuapp.com?font=Press+Start+2P&color=%231023EE&size=30&duration=3000&center=true&vCenter=true&multiline=true&width=1200&height=150&lines=D4nk0St0rM;SpReAd+L0vE;ShArE+Kn0wLeDgE)](https://git.io/typing-svg)
---

<h2><p align="center">
    `I'm Smart Enough to Know That I'm Dumb`
    </p></h2>

____
#### kali instance setup
Spinning up new instances of Kali, a simple, rough and ready script and config files to help spin up new set up reasonably quickly

I made this for myself, if you find some use here, than thats cool too...

Much bastardisation and ideas taken from https://github.com/g0tmi1k/os-scripts and https://github.com/blacklanternsecurity

There are some manual interventions required, not yet worked out how to shove those in.... but hey, its a time saver nontheless!



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




