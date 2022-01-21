#### boot into recovery mode as root to make umount /home easier
This is carried out on a LVM encrpyted and home only as seperated partition
Miscalculated the sizing on implimentation

##check syntax of partitions
```
df -Th
```
### unmount home
```
umount /home
```

### check for errors and resize

```
e2fsck -f /dev/mapper/USER--vg-home
resize2fs /dev/mapper/USER--vg-home 50G
```

### reduce LVM
```
lvreduce -L 50G /dev/mapper/USER--vg-home
```

### extend root utilsing all free space
```
lvextend -l +100%FREE /dev/mapper/USER--vg-root
resize2fs /dev/mapper/USER--vg-root
```

### remount home
```
mount /home
```

#### final check
```
df -Th
```

### reeeeeebooot
```
systemctl reboot
```

