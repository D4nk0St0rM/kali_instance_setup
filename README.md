[![Typing SVG](https://readme-typing-svg.herokuapp.com?font=Press+Start&size=30&duration=4000&color=1E0DC6EE&center=true&vCenter=true&multiline=true&width=1200&height=150&lines=D4nk0St0rM;SpReAd+L0vE+%26+ShArE+Kn0wLeDgE;%60I'm+smart+enough+to+know+that+I'm+dumb%60)](https://git.io/typing-svg)
---

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

- Firefox add-ons
    - FoxyProxy Standard
    - Wappalyzer
    - Burp Proxy Toggler by ZishanAdThandar
  




