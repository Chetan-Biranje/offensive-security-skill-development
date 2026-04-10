#!/bin/bash
# recon.sh — Quick target recon script
# Usage: bash recon.sh <TARGET_IP>

TARGET=$1
OUTPUT_DIR="./recon_$TARGET"

if [ -z "$TARGET" ]; then
    echo "Usage: $0 <target_ip>"
    exit 1
fi

mkdir -p "$OUTPUT_DIR"
echo "[*] Starting recon on $TARGET"
echo "[*] Output → $OUTPUT_DIR"

echo "[*] Quick Nmap scan..."
nmap -sV -sC --open -oN "$OUTPUT_DIR/nmap_quick.txt" "$TARGET"

echo "[*] Full port scan..."
nmap -p- --min-rate 5000 -T4 -oN "$OUTPUT_DIR/nmap_full.txt" "$TARGET"

echo "[*] Running vuln scripts on found ports..."
PORTS=$(grep "^[0-9]" "$OUTPUT_DIR/nmap_quick.txt" | cut -d/ -f1 | tr '\n' ',' | sed 's/,$//')
nmap -p "$PORTS" --script vuln -oN "$OUTPUT_DIR/nmap_vuln.txt" "$TARGET"

# Web check
if grep -q "80\|443\|8080\|8443" "$OUTPUT_DIR/nmap_quick.txt"; then
    echo "[*] Web service detected, running gobuster..."
    gobuster dir -u "http://$TARGET" -w /usr/share/wordlists/dirbuster/directory-list-2.3-medium.txt \
        -o "$OUTPUT_DIR/gobuster.txt" -t 50 2>/dev/null
fi

# SMB check
if grep -q "445\|139" "$OUTPUT_DIR/nmap_quick.txt"; then
    echo "[*] SMB detected, running enum4linux..."
    enum4linux -a "$TARGET" > "$OUTPUT_DIR/enum4linux.txt" 2>/dev/null
fi

echo "[+] Recon complete. Results in $OUTPUT_DIR/"
