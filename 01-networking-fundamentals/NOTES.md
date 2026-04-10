# 01 — Networking Fundamentals

## OSI Model

| Layer | Name | Protocol Examples |
|-------|------|-------------------|
| 7 | Application | HTTP, DNS, SMTP, FTP |
| 6 | Presentation | TLS/SSL, JPEG |
| 5 | Session | NetBIOS, RPC |
| 4 | Transport | TCP, UDP |
| 3 | Network | IP, ICMP, ARP |
| 2 | Data Link | Ethernet, MAC |
| 1 | Physical | Cables, Signals |

## TCP vs UDP

| Feature | TCP | UDP |
|---------|-----|-----|
| Connection | 3-way handshake | Connectionless |
| Reliable | Yes | No |
| Speed | Slower | Faster |
| Use case | HTTP, SSH, FTP | DNS, VoIP, streaming |

## TCP 3-Way Handshake

```
Client → SYN     → Server
Client ← SYN-ACK ← Server
Client → ACK     → Server
```

## Common Ports

| Port | Service |
|------|---------|
| 21 | FTP |
| 22 | SSH |
| 23 | Telnet |
| 25 | SMTP |
| 53 | DNS |
| 80 | HTTP |
| 110 | POP3 |
| 143 | IMAP |
| 443 | HTTPS |
| 445 | SMB |
| 3306 | MySQL |
| 3389 | RDP |
| 8080 | HTTP Alt |

## Subnetting Quick Reference

```
/24  → 255.255.255.0   → 254 hosts
/25  → 255.255.255.128 → 126 hosts
/26  → 255.255.255.192 → 62 hosts
/28  → 255.255.255.240 → 14 hosts
/30  → 255.255.255.252 → 2 hosts
```

## Nmap Basics

```bash
nmap -sV -sC -oN scan.txt TARGET          # version + default scripts
nmap -p- --min-rate 5000 TARGET           # all ports fast
nmap -sU -p 53,161 TARGET                 # UDP scan
nmap -A TARGET                            # aggressive scan
nmap -sn 192.168.1.0/24                   # host discovery
```

## Wireshark Filters

```
tcp.port == 80
http.request.method == "POST"
ip.addr == 192.168.1.1
dns
tcp.flags.syn == 1 && tcp.flags.ack == 0
```

## DNS Enumeration

```bash
nslookup target.com
dig target.com ANY
dig axfr @ns1.target.com target.com      # zone transfer
host -t mx target.com
dnsenum target.com
```

## Practice Labs

- [ ] TryHackMe: "Pre-Security" → Networking section
- [ ] TryHackMe: "Wireshark: The Basics"
- [ ] TryHackMe: "Nmap"
