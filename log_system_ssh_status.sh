#!/bin/bash

# Log file path
LOG_FILE="/home/pi/scripts/system_ssh_log.txt"

# Get system date and time
echo "Log Time: $(date)" >> "$LOG_FILE"

# Log system load and memory usage
echo "System Load and Memory:" >> "$LOG_FILE"
uptime >> "$LOG_FILE"
free -h >> "$LOG_FILE"

# Check if SSH service is active
echo "SSH Service Status:" >> "$LOG_FILE"
systemctl status ssh | grep "Active" >> "$LOG_FILE"

# Log the last few lines of the SSH auth log for any authentication attempts
echo "SSH Authentication Attempts:" >> "$LOG_FILE"
tail -n 10 /var/log/auth.log | grep "sshd" >> "$LOG_FILE"

# Log temperature
echo "CPU Temperature:" >> "$LOG_FILE"
vcgencmd measure_temp >> "$LOG_FILE"

# Add a separator for readability
echo "----------------------------------------" >> "$LOG_FILE"

# Print message indicating logging was successful
echo "System status logged to $LOG_FILE"

# Log trimming
MAX_SIZE=50000 # Maximum file size in bytes (50KB in this example)
if [ $(stat -c%s "$LOG_FILE") -ge $MAX_SIZE ]; then
    tail -n 1000 "$LOG_FILE" > "$LOG_FILE.tmp" && mv "$LOG_FILE.tmp" "$LOG_FILE"
    echo "Log file trimmed."
fi
