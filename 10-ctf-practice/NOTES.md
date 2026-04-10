# 10 — CTF Practice Log

## Platforms

| Platform | Focus | Link |
|----------|-------|------|
| PicoCTF | Beginners | https://picoctf.org |
| CTFtime | All events | https://ctftime.org |
| HackTheBox CTF | All categories | https://ctf.hackthebox.com |
| TryHackMe CTF | Guided | https://tryhackme.com |
| pwn.college | Pwn/Rev | https://pwn.college |

---

## Solved Challenges

| Date | CTF | Challenge | Category | Difficulty | Flag |
|------|-----|-----------|----------|------------|------|
| — | — | — | — | — | — |

---

## Writeups

> Add writeup links or inline writeups here as challenges are solved.
> Follow the template from [CTF Notes repo](https://github.com/Chetan-Biranje/ctf-notes-and-solves).

---

## Quick Reference by Category

### Web
- Check source, cookies, headers first
- Try SQLi, XSS on every input
- Check robots.txt, /.git/, /backup/
- Decode JWT, look for parameter tampering

### Crypto
- Identify cipher type first (CyberChef Magic)
- Check for RSA with small e or known n factorizations
- XOR with repeating key → frequency analysis

### Forensics
- `file`, `strings`, `binwalk`, `exiftool` on every file
- Check for steganography: `steghide`, `zsteg`, spectrogram
- Memory: Volatility; PCAP: Wireshark

### Pwn
- `checksec` first
- Find offset with cyclic
- Check for ret2win, ret2libc, format string

### Rev
- `strings`, `ltrace`, `strace` before decompiler
- Ghidra: find main, look for strcmp/memcmp
- Dynamic: GDB + pwndbg
