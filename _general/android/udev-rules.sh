#!/bin/bash

# cd into adb directory if setup

# Clone this repository
git clone https://github.com/M0Rf30/android-udev-rules.git
cd android-udev-rules
    
# Copy rules file
sudo cp -v 51-android.rules /etc/udev/rules.d/51-android.rules
    
# OR create a sym-link to the rules file - choose this option if you'd like to
# update your udev rules using git.
sudo ln -sf "$PWD"/51-android.rules /etc/udev/rules.d/51-android.rules
    
# Change file permissions
sudo chmod a+r /etc/udev/rules.d/51-android.rules
    
# Add the adbusers group if it's doesn't already exist
sudo cp android-udev.conf /usr/lib/sysusers.d/
sudo systemd-sysusers

# Add your user to the adbusers group
sudo gpasswd -a $(whoami) adbusers
    
# Restart UDEV
sudo udevadm control --reload-rules
sudo systemctl restart systemd-udevd.service
   
# Restart the ADB server (back to Debian again)
adb kill-server
    
# Replug your Android device and verify that USB debugging is enabled in
# developer options
adb devices
             
