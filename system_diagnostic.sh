#!/bin/bash

# System Diagnostic Tool
# Generates comprehensive system report and packages it

TIMESTAMP=$(date +"%Y%m%d_%H%M%S")
REPORT_DIR="system_diagnostic_$TIMESTAMP"
REPORT_FILE="$REPORT_DIR/system_report.txt"
ZIP_FILE="system_diagnostic_$TIMESTAMP.zip"

echo "🔍 System Diagnostic Tool Starting..."
echo "📅 Timestamp: $TIMESTAMP"
echo

# Create report directory
mkdir -p "$REPORT_DIR"

# Start generating report
{
    echo "=== SYSTEM DIAGNOSTIC REPORT ==="
    echo "Generated: $(date)"
    echo "Hostname: $(hostname)"
    echo "User: $(whoami)"
    echo "Working Directory: $(pwd)"
    echo
    echo "=== FILE SYSTEM ANALYSIS ==="
    echo "Files in current directory (immediate): $(ls -A 2>/dev/null | wc -l)"
    echo "Total files in current directory tree: $(find . -mindepth 1 2>/dev/null | wc -l)"
    echo "System-wide file count: $(find / -type f 2>/dev/null | wc -l) files"
    echo "Current directory contents:"
    ls -la
    echo
    echo "=== PROCESSES & RESOURCES ==="
    echo "Active processes: $(ls /proc/[0-9]* 2>/dev/null | wc -l)"
    echo "System load: $(cat /proc/loadavg 2>/dev/null || echo 'N/A')"
    echo "Total memory: $(free -m | grep "Mem:" | awk '{print $2}' 2>/dev/null) MB"
    echo "Memory usage:"
    free -h | grep "Mem:"
    echo
    echo "=== FILESYSTEMS ==="
    echo "Mounted filesystems: $(df -h | tail -n +2 | wc -l)"
    echo "Filesystem details:"
    df -h
    echo
    echo "=== NETWORK STATUS ==="
    echo "Listening ports: $(ss -tuln 2>/dev/null | grep LISTEN | wc -l || echo 'Unable to check')"
    echo "Network connections:"
    ss -tuln 2>/dev/null || echo "ss command not available"
    echo
    echo "=== ENVIRONMENT INFO ==="
    echo "Shell: $SHELL"
    echo "PATH: $PATH"
    echo "Current directory permissions:"
    ls -ld .
    echo
    echo "=== TOP LARGE FILES IN WORKSPACE ==="
    find . -type f -exec du -h {} + 2>/dev/null | sort -hr | head -10 || echo "No files found"
    echo
    echo "=== RECENT SYSTEM LOGS (if available) ==="
    if [ -d "/var/log" ]; then
        echo "Recent system log entries:"
        tail -n 5 /var/log/syslog 2>/dev/null || tail -n 5 /var/log/messages 2>/dev/null || echo "Logs not accessible"
    else
        echo "/var/log directory not accessible"
    fi
    echo
    echo "=== END OF REPORT ==="
    
} > "$REPORT_FILE"

# Add detailed file listing to report
{
    echo
    echo "=== COMPLETE FILE INVENTORY ==="
    echo "Recursive file listing from workspace:"
    find . -type f -exec ls -la {} \; 2>/dev/null | head -50
} >> "$REPORT_FILE"

# Create additional files
echo "System report generated at $TIMESTAMP" > "$REPORT_DIR/meta.txt"
echo "Files: $(find . -type f | wc -l)" >> "$REPORT_DIR/meta.txt"
echo "Directories: $(find . -type d | wc -l)" >> "$REPORT_DIR/meta.txt"

# Create summary JSON for programmatic access
{
    echo "{"
    echo "  \"timestamp\": \"$TIMESTAMP\","
    echo "  \"immediate_files\": $(ls -A 2>/dev/null | wc -l),"
    echo "  \"total_files\": $(find . -mindepth 1 2>/dev/null | wc -l),"
    echo "  \"system_files\": $(find / -type f 2>/dev/null | wc -l),"
    echo "  \"processes\": $(ls /proc/[0-9]* 2>/dev/null | wc -l),"
    echo "  \"memory_mb\": $(free -m | grep "Mem:" | awk '{print $2}' 2>/dev/null),"
    echo "  \"filesystem_count\": $(df -h | tail -n +2 | wc -l),"
    echo "  \"load_avg\": \"$(cat /proc/loadavg 2>/dev/null | cut -d' ' -f1)\","
    echo "  \"workspace_path\": \"$(pwd)\","
    echo "  \"user\": \"$(whoami)\""
    echo "}"
} > "$REPORT_DIR/summary.json"

echo "📊 Report generated: $REPORT_FILE"
echo "📋 Summary created: $REPORT_DIR/summary.json"
echo "📦 Meta info: $REPORT_DIR/meta.txt"

# Create zip file
zip -r "$ZIP_FILE" "$REPORT_DIR" >/dev/null 2>&1

echo
echo "✅ DIAGNOSTIC COMPLETE!"
echo "📁 Report directory: $REPORT_DIR"
echo "📦 Zip file: $ZIP_FILE"
echo "📏 Zip file size: $(du -h "$ZIP_FILE" | cut -f1)"

# Display final summary
echo
echo "=== QUICK SUMMARY ==="
cat "$REPORT_DIR/summary.json"

# Clean up the directory but keep the zip
rm -rf "$REPORT_DIR"

echo
echo "🎯 All data packaged in: $ZIP_FILE"
echo "🔄 Cleaned up temporary files"