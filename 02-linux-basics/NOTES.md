# 02 — Linux Basics & CLI Mastery

## File System Navigation

```bash
pwd           # current directory
ls -la        # list with hidden files
cd /path      # change directory
find / -name "flag.txt" 2>/dev/null
locate file   # fast search (uses DB)
which python3 # path of binary
```

## File Operations

```bash
cat file.txt
less file.txt
head -20 file.txt
tail -f /var/log/syslog
grep -r "password" /etc/ 2>/dev/null
grep -i "pass" file.txt
cut -d: -f1 /etc/passwd   # first field
awk -F: '{print $1}' /etc/passwd
sort | uniq -c | sort -rn  # count unique
```

## Permissions

```bash
chmod 755 file      # rwxr-xr-x
chmod +x script.sh
chown user:group file
ls -la              # check perms
stat file           # detailed info

# SUID = 4, SGID = 2, Sticky = 1
chmod 4755 binary   # set SUID
```

## Processes

```bash
ps aux
kill -9 PID
jobs / fg / bg
nohup command &     # run after logout
screen / tmux       # persistent sessions
```

## Networking

```bash
ip a
ip route
ss -tulnp
curl -v http://target
wget http://target/file
```

## Bash Scripting Basics

```bash
#!/bin/bash
VAR="hello"
echo $VAR

for i in {1..10}; do echo $i; done

if [ -f "file.txt" ]; then
  echo "exists"
fi

# Read line by line
while IFS= read -r line; do
  echo "$line"
done < file.txt
```

## Useful One-Liners

```bash
# Find all SUID files
find / -perm -4000 2>/dev/null

# Monitor file changes
watch -n 1 ls -la /tmp

# Port scan with bash
for p in {1..1024}; do (echo >/dev/tcp/TARGET/$p) 2>/dev/null && echo "open: $p"; done

# Base64 encode/decode
echo "text" | base64
echo "dGV4dA==" | base64 -d
```

## OverTheWire: Bandit Progress

| Level | Complete |
|-------|----------|
| 0→1 | [ ] |
| 1→2 | [ ] |
| 2→3 | [ ] |
| ... | [ ] |
