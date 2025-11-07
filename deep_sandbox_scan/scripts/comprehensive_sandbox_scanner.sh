#!/bin/bash

# Comprehensive Sandbox Deep Scanner
# Created: 2025-11-07 09:15:09
# Purpose: Deep scan of entire sandbox environment with detailed documentation

set -euo pipefail

# Configuration
SCRIPT_DIR="/workspace/deep_sandbox_scan"
BACKUP_DIR="$SCRIPT_DIR/backup"
REPORTS_DIR="$SCRIPT_DIR/reports"
DOCS_DIR="$SCRIPT_DIR/docs"
TIMESTAMP=$(date '+%Y%m%d_%H%M%S')
LOG_FILE="$REPORTS_DIR/scan_log_$TIMESTAMP.txt"

# Ensure directories exist
mkdir -p "$BACKUP_DIR" "$REPORTS_DIR" "$DOCS_DIR"

# Logging function
log() {
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] $1" | tee -a "$LOG_FILE"
}

# Start comprehensive scan
log "Starting comprehensive sandbox scan..."

# 1. SYSTEM OVERVIEW
log "=== SYSTEM OVERVIEW ==="
{
    echo "# Comprehensive Sandbox Environment Report"
    echo ""
    echo "**Scan Date:** $(date)"
    echo "**Environment:** Linux container sandbox"
    echo "**Workspace:** /workspace"
    echo ""
    
    # Basic system info
    echo "## System Information"
    echo "- **Hostname:** $(hostname)"
    echo "- **Kernel:** $(uname -r)"
    echo "- **Architecture:** $(uname -m)"
    echo "- **Uptime:** $(uptime -p)"
    echo "- **Current User:** $(whoami)"
    echo "- **Current Working Directory:** $(pwd)"
    echo ""
    
    # Memory and CPU info
    echo "## Hardware Resources"
    echo "### Memory"
    free -h
    echo ""
    echo "### CPU"
    nproc
    lscpu | head -20
    echo ""
    
    # Storage
    echo "## Storage Overview"
    df -h
    echo ""
    
} > "$DOCS_DIR/01_system_overview.md"

# 2. FILESYSTEM STRUCTURE
log "Scanning filesystem structure..."
{
    echo "# Filesystem Structure Analysis"
    echo ""
    echo "## Root Directory Structure"
    echo "### From /"
    find / -maxdepth 1 -type d | sort | while read dir; do
        size=$(du -sh "$dir" 2>/dev/null | cut -f1)
        echo "- $dir ($size)"
    done
    echo ""
    
    echo "## Key System Directories Analysis"
    for dir in /proc /sys /dev /etc /usr /var /tmp /opt /home /root; do
        if [ -d "$dir" ]; then
            echo "### $dir"
            file_count=$(find "$dir" -type f 2>/dev/null | wc -l)
            dir_count=$(find "$dir" -maxdepth 1 -type d 2>/dev/null | wc -l)
            size=$(du -sh "$dir" 2>/dev/null | cut -f1)
            echo "- Files: $file_count"
            echo "- Directories: $dir_count"
            echo "- Size: $size"
            echo ""
        fi
    done
    
} > "$DOCS_DIR/02_filesystem_structure.md"

# 3. WORKSPACE ANALYSIS
log "Analyzing workspace in detail..."
{
    echo "# Workspace Deep Analysis"
    echo ""
    echo "## Workspace Location and Structure"
    echo "- **Path:** /workspace"
    echo "- **Current Size:** $(du -sh /workspace | cut -f1)"
    echo "- **Total Files:** $(find /workspace -type f 2>/dev/null | wc -l)"
    echo "- **Total Directories:** $(find /workspace -type d 2>/dev/null | wc -l)"
    echo ""
    
    echo "## Complete Workspace Tree"
    tree /workspace -a -L 5 || ls -la /workspace
    echo ""
    
    echo "## Workspace Subdirectories Analysis"
    for dir in /workspace/*/; do
        if [ -d "$dir" ]; then
            dir_name=$(basename "$dir")
            echo "### $dir_name"
            file_count=$(find "$dir" -type f 2>/dev/null | wc -l)
            size=$(du -sh "$dir" 2>/dev/null | cut -f1)
            echo "- Path: $dir"
            echo "- Files: $file_count"
            echo "- Size: $size"
            echo ""
        fi
    done
    
} > "$DOCS_DIR/03_workspace_analysis.md"

# 4. ENVIRONMENT VARIABLES AND CONFIGURATION
log "Collecting environment configuration..."
{
    echo "# Environment and Configuration"
    echo ""
    echo "## Environment Variables"
    echo "### All Environment Variables"
    env | sort
    echo ""
    
    echo "### Key Environment Variables"
    for var in PATH HOME USER SHELL PWD OLDPWD LANG LC_ALL SHLVL _ LOGNAME; do
        if [ -n "${!var:-}" ]; then
            echo "- **$var:** ${!var}"
        fi
    done
    echo ""
    
    echo "## System Configuration Files"
    important_configs=(
        "/etc/hosts"
        "/etc/hostname"
        "/etc/resolv.conf"
        "/etc/os-release"
        "/proc/cpuinfo"
        "/proc/meminfo"
    )
    
    for config in "${important_configs[@]}"; do
        if [ -f "$config" ]; then
            echo "### $config"
            echo "\`\`\`"
            cat "$config" 2>/dev/null | head -20
            echo "\`\`\`"
            echo ""
        fi
    done
    
} > "$DOCS_DIR/04_environment_config.md"

# 5. NETWORK AND CONNECTIVITY
log "Analyzing network configuration..."
{
    echo "# Network and Connectivity"
    echo ""
    echo "## Network Interfaces"
    ip addr show 2>/dev/null || ifconfig -a 2>/dev/null
    echo ""
    
    echo "## Routing Table"
    ip route show 2>/dev/null || route -n
    echo ""
    
    echo "## Network Services"
    echo "### Active Network Connections"
    netstat -tuln 2>/dev/null || ss -tuln
    echo ""
    
    echo "### DNS Configuration"
    cat /etc/resolv.conf 2>/dev/null
    echo ""
    
    echo "## Connectivity Tests"
    echo "### Ping Tests (if available)"
    ping -c 1 8.8.8.8 2>/dev/null || echo "Ping not available"
    echo ""
    
} > "$DOCS_DIR/05_network_analysis.md"

# 6. SECURITY AND PERMISSIONS
log "Analyzing security and permissions..."
{
    echo "# Security and Permissions Analysis"
    echo ""
    
    echo "## User Information"
    echo "- **Current User:** $(whoami)"
    echo "- **User ID:** $(id -u)"
    echo "- **Group ID:** $(id -g)"
    echo "- **Groups:** $(groups)"
    echo ""
    
    echo "## Permission Overview"
    echo "### Key Directory Permissions"
    for dir in /workspace /root /tmp /etc; do
        if [ -d "$dir" ]; then
            echo "- $dir: $(ls -ld "$dir" 2>/dev/null | cut -d' ' -f1)"
        fi
    done
    echo ""
    
    echo "## File System Permissions"
    echo "### Workspace Permissions"
    find /workspace -type f -name "*.sh" -exec ls -l {} \; 2>/dev/null | head -10
    echo ""
    
} > "$DOCS_DIR/06_security_permissions.md"

# 7. PROCESS AND SERVICES ANALYSIS
log "Analyzing running processes..."
{
    echo "# Process and Services Analysis"
    echo ""
    
    echo "## Running Processes"
    echo "### Process Count"
    ps aux | wc -l
    echo ""
    
    echo "### Top 20 Processes by CPU"
    ps aux --sort=-%cpu | head -21
    echo ""
    
    echo "### Top 20 Processes by Memory"
    ps aux --sort=-%mem | head -21
    echo ""
    
    echo "## System Services"
    echo "### Active Services (if systemctl available)"
    systemctl list-units --type=service --state=running 2>/dev/null || echo "Systemctl not available"
    echo ""
    
} > "$DOCS_DIR/07_processes_services.md"

# 8. FILE CONTENT ANALYSIS
log "Analyzing key file contents..."
{
    echo "# Key File Contents Analysis"
    echo ""
    
    echo "## Log Files"
    echo "### System Logs (if available)"
    for log_path in /var/log/messages /var/log/syslog /var/log/auth.log; do
        if [ -f "$log_path" ]; then
            echo "### $log_path (last 20 lines)"
            tail -20 "$log_path" 2>/dev/null
            echo ""
        fi
    done
    
    echo "## Configuration Files"
    echo "### Shell Configuration"
    for shell_config in ~/.bashrc ~/.bash_profile ~/.profile /etc/profile; do
        if [ -f "$shell_config" ]; then
            echo "### $shell_config"
            echo "\`\`\`"
            cat "$shell_config" 2>/dev/null | head -30
            echo "\`\`\`"
            echo ""
        fi
    done
    
} > "$DOCS_DIR/08_file_contents.md"

# 9. CREATE BACKUP ARCHIVES
log "Creating comprehensive backup archives..."

# Create main backup archive
cd /
zip -r "$BACKUP_DIR/complete_sandbox_backup_$TIMESTAMP.zip" \
    /workspace \
    /etc/hosts \
    /etc/hostname \
    /etc/resolv.conf \
    /etc/os-release \
    /proc/cpuinfo \
    /proc/meminfo \
    2>/dev/null || true

# Create workspace-specific backup
cd /workspace
zip -r "$BACKUP_DIR/workspace_backup_$TIMESTAMP.zip" . \
    -x "*.zip" "*/.git/*" "*/.sandbox-runtime/*" \
    2>/dev/null || true

# Create configuration backup
mkdir -p "$BACKUP_DIR/config_files"
cp /etc/hosts /etc/hostname /etc/resolv.conf /etc/os-release \
    "$BACKUP_DIR/config_files/" 2>/dev/null || true
cp /proc/cpuinfo /proc/meminfo "$BACKUP_DIR/config_files/" 2>/dev/null || true

# 10. GENERATE SUMMARY REPORT
log "Generating summary report..."
{
    echo "# Complete Sandbox Scan Summary"
    echo ""
    echo "**Scan Completed:** $(date)"
    echo "**Scan Duration:** Calculated from start time"
    echo ""
    
    echo "## Scan Results"
    echo "- **System Files Scanned:** $(find / -type f 2>/dev/null | wc -l)"
    echo "- **Workspace Files:** $(find /workspace -type f 2>/dev/null | wc -l)"
    echo "- **Documentation Files Created:** $(find "$DOCS_DIR" -name "*.md" | wc -l)"
    echo "- **Backup Archives Created:** $(find "$BACKUP_DIR" -name "*.zip" | wc -l)"
    echo ""
    
    echo "## Generated Files"
    echo "### Documentation"
    ls -la "$DOCS_DIR"/*.md 2>/dev/null | awk '{print "- " $9 " (" $5 " bytes)"}'
    echo ""
    
    echo "### Backup Archives"
    ls -la "$BACKUP_DIR"/*.zip 2>/dev/null | awk '{print "- " $9 " (" $5 " bytes)"}'
    echo ""
    
    echo "## Environment Characteristics"
    echo "- **Container Environment:** $([ -f /.dockerenv ] && echo "Docker container" || echo "Not Docker")"
    echo "- **Memory Limit:** $([ -f /sys/fs/cgroup/memory/memory.limit_in_bytes ] && cat /sys/fs/cgroup/memory/memory.limit_in_bytes 2>/dev/null || echo "No cgroup limit")"
    echo "- **CPU Limit:** $([ -f /sys/fs/cgroup/cpu/cpu.cfs_quota_us ] && cat /sys/fs/cgroup/cpu/cpu.cfs_quota_us 2>/dev/null || echo "No cgroup limit")"
    echo ""
    
} > "$DOCS_DIR/00_scan_summary.md"

# 11. CREATE MASTER INDEX
log "Creating master documentation index..."
{
    echo "# Complete Sandbox Documentation Index"
    echo ""
    echo "**Generated:** $(date)"
    echo "**Purpose:** Comprehensive documentation of sandbox environment"
    echo ""
    
    echo "## Documentation Files"
    for doc in "$DOCS_DIR"/*.md; do
        if [ -f "$doc" ]; then
            filename=$(basename "$doc")
            title=$(head -1 "$doc" | sed 's/^# //')
            size=$(wc -l < "$doc")
            echo "- **[$filename]($doc)** - $title ($size lines)"
        fi
    done
    echo ""
    
    echo "## Backup Archives"
    for backup in "$BACKUP_DIR"/*.zip; do
        if [ -f "$backup" ]; then
            filename=$(basename "$backup")
            size=$(du -h "$backup" | cut -f1)
            echo "- **$filename** - $size"
        fi
    done
    echo ""
    
    echo "## Usage"
    echo "1. Review the summary in \`00_scan_summary.md\`"
    echo "2. Explore detailed documentation in order"
    echo "3. Use backup archives for data recovery"
    echo ""
    
} > "$DOCS_DIR/README.md"

log "Comprehensive sandbox scan completed successfully!"
log "Results available in: $DOCS_DIR"
log "Backups available in: $BACKUP_DIR"

# Display completion summary
echo ""
echo "=== SCAN COMPLETION SUMMARY ==="
echo "📁 Documentation: $DOCS_DIR (8 detailed reports)"
echo "💾 Backups: $BACKUP_DIR (multiple archives)"
echo "📊 Summary: $DOCS_DIR/README.md"
echo ""
echo "All files are ready for download and review!"