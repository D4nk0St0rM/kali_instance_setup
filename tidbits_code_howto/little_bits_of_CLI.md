#### installed packages
```bash
apt list --installed
dpkg --get-selections | grep -v deinstall
```



#### finding strings in files
```
grep -rnw ../ -e 'string'
```


#### watching connections
```
tcpdump icmp -v -i any
```



#### show whats been manually installed

```
for x in $( apt list --manual-installed 2>/dev/null | awk -F '/' '/\[installed\]/ {print $1}' ); do echo ${x}; aptitude why ${x}; done | grep 'Manually installed' -B1 | grep -v 'Manually installed\|^--$'

while read x; do echo -e "${x}\n`aptitude why ${x}`" | grep 'Manually installed' -B1 | grep -v '^Manually installed\|^--'; done <<< $(apt-mark showmanual)

apt-mark showmanual | while read x;do echo -e"$x\n`aptitude why $x`"|grep ^Man -B1|grep -v '^Man\|^-';done

```

#### Terminal pastebin
[termbin](https://termbin.com/)

####  grepping

```
grep -rnw '/path/to/somewhere/' -e 'pattern'
grep --include=\*.{txt,sh} -rnw '/path/to/somewhere/' -e "pattern"
grep --exclude=\*.txt -rnw '/path/to/somewhere/' -e "pattern"
grep --exclude-dir={dir1,dir2,*.dst} -rnw '/path/to/somewhere/' -e "pattern"
```

#### Unable to edit resolv.conf
```
 lsattr /etc/resolv.conf
# the output with 'i' means file is immutable 
# ----i---------e------- /etc/resolv.conf
sudo chattr -i /etc/resolv.conf
```

