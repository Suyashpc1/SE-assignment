#!/bin/bash

# Use Windows-style logs and commands safely in Git Bash
MONITOR_LOG="monitor.log"
TEMP_LOG="temp.log"

echo "Checking system logs..."

# Run wevtutil safely with correct quoting
powershell.exe -Command "wevtutil qe System /c:10 /rd:true /f:text" | grep -i "error\|failed\|critical" > "$TEMP_LOG"

if [ -s "$TEMP_LOG" ]; then
    echo "$(date) - Critical errors found" >> "$MONITOR_LOG"
    cat "$TEMP_LOG"
else
    echo "$(date) - No critical errors found" >> "$MONITOR_LOG"
fi

rm -f "$TEMP_LOG"
