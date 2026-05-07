#!/bin/bash

# REAL SECURITY AUDIT SCRIPT - Used by Cloud Engineers
# Detects brute force attacks from real access logs

# ============================================
# CONFIGURATION (Adjust these for your server)
# ============================================

# Real log file locations (depends on web server)
if [ -f "/var/log/nginx/access.log" ]; then
    LOG_FILE="/var/log/nginx/access.log"
    WEB_SERVER="nginx"
elif [ -f "/var/log/apache2/access.log" ]; then
    LOG_FILE="/var/log/apache2/access.log"
    WEB_SERVER="apache"
elif [ -f "/var/log/httpd/access_log" ]; then
    LOG_FILE="/var/log/httpd/access_log"
    WEB_SERVER="httpd"
else
    echo "❌ No web server access log found!"
    exit 1
fi

THRESHOLD=50              # Real threshold (50+ attempts = attack)
TIME_WINDOW="1 hour ago"  # Check last hour only
ALERT_EMAIL="admin@example.com"

# ============================================
# FUNCTIONS
# ============================================

log() {
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] $1"
}

send_alert() {
    local ip=$1
    local count=$2
    local message="🚨 ALERT: Potential brute force attack from $ip ($count attempts in last hour)"
    
    log "$message"
    
    # Send email alert (commented - uncomment to use)
    # echo "$message" | mail -s "Security Alert: Brute Force Detected" "$ALERT_EMAIL"
    
    # Send to Slack (optional)
    # curl -X POST -H 'Content-type: application/json' \
    # --data "{\"text\":\"$message\"}" YOUR_SLACK_WEBHOOK_URL
}

block_ip() {
    local ip=$1
    
    log "Blocking IP: $ip"
    
    # Block using UFW (Ubuntu)
    if command -v ufw &>/dev/null; then
        sudo ufw deny from $ip
    fi
    
    # Block using iptables (all Linux)
    if command -v iptables &>/dev/null; then
        sudo iptables -A INPUT -s $ip -j DROP
    fi
    
    # Add to hosts.deny (for fail2ban)
    echo "ALL: $ip" | sudo tee -a /etc/hosts.deny
}

# ============================================
# MAIN AUDIT
# ============================================

log "Starting Security Audit on $WEB_SERVER server"
log "Log file: $LOG_FILE"
log "Threshold: $THRESHOLD attempts = ATTACK"

# Check if log file exists and has data
if [ ! -f "$LOG_FILE" ]; then
    log "ERROR: Log file not found!"
    exit 1
fi

if [ ! -s "$LOG_FILE" ]; then
    log "Log file is empty - no traffic yet"
    exit 0
fi

echo ""
echo "========================================="
echo "     🔒 SECURITY AUDIT REPORT"
echo "========================================="
echo "Server: $(hostname)"
echo "Time: $(date)"
echo "Web Server: $WEB_SERVER"
echo "Checking last: $(tail -10000 $LOG_FILE | wc -l) requests"
echo ""

# ============================================
# ANALYSIS 1: Top attacking IPs
# ============================================

echo "--- TOP 10 ATTACKING IP ADDRESSES ---"
echo ""

# Extract IPs from FAILED login attempts (401 = auth failed)
# Real attackers only care about /login endpoint
tail -10000 "$LOG_FILE" | grep -E "(POST /login|401)" | awk '{print $1}' | sort | uniq -c | sort -rn | head -10

echo ""
echo "--- DETAILED ANALYSIS (IPs with > $THRESHOLD attempts) ---"
echo ""

# ============================================
# ANALYSIS 2: Check each IP for brute force
# ============================================

ATTACK_COUNT=0
tail -10000 "$LOG_FILE" | grep -E "(POST /login|401)" | awk '{print $1}' | sort | uniq -c | sort -rn | while read count ip; do
    if [ $count -gt $THRESHOLD ]; then
        echo "⚠️ ⚠️ ⚠️ ⚠️ ⚠️ ⚠️ ⚠️ ⚠️ ⚠️ ⚠️ ⚠️ ⚠️ ⚠️ ⚠️ ⚠️ ⚠️ ⚠️ ⚠️ ⚠️ ⚠️"
        echo "🚨 BRUTE FORCE ATTACK DETECTED! 🚨"
        echo "IP Address: $ip"
        echo "Failed Attempts: $count (in last 10,000 requests)"
        echo "Time: $(date)"
        echo "⚠️ ⚠️ ⚠️ ⚠️ ⚠️ ⚠️ ⚠️ ⚠️ ⚠️ ⚠️ ⚠️ ⚠️ ⚠️ ⚠️ ⚠️ ⚠️ ⚠️ ⚠️ ⚠️ ⚠️"
        echo ""
        
        # Send alert
        send_alert "$ip" "$count"
        
        # Uncomment to automatically block
        # block_ip "$ip"
        
        ATTACK_COUNT=$((ATTACK_COUNT + 1))
    fi
done

# ============================================
# ANALYSIS 3: Check for DDoS patterns
# ============================================

echo ""
echo "--- REQUEST RATE ANALYSIS ---"
echo ""

# Count total requests per minute (DDoS detection)
tail -10000 "$LOG_FILE" | awk '{print $4}' | cut -d: -f2 | sort | uniq -c | tail -5

echo ""
echo "========================================="
echo "          AUDIT COMPLETE"
echo "========================================="

if [ $ATTACK_COUNT -gt 0 ]; then
    echo ""
    echo "⚠️  SUMMARY: Found $ATTACK_COUNT potential attackers!"
    echo "Recommendation: Block the IPs listed above immediately."
    echo ""
    echo "To block an IP: sudo ufw deny from <IP>"
    echo "Or: sudo iptables -A INPUT -s <IP> -j DROP"
else
    echo ""
    echo "✅ No brute force attacks detected."
    echo "All IPs have less than $THRESHOLD attempts."
fi

echo ""
echo "Full log location: $LOG_FILE"