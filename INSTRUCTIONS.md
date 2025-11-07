# INSTRUCTIONS.md - Complete Capabilities and Code Templates

**Document Version:** 1.0  
**Created:** 2025-11-07 09:24:46  
**Environment:** Kubernetes Container Sandbox  
**Repository:** https://github.com/sheikh-who/minimind  

## Table of Contents

1. [Environment Capabilities Overview](#environment-capabilities-overview)
2. [Core System Capabilities](#core-system-capabilities)
3. [Development Capabilities](#development-capabilities)
4. [Analysis Capabilities](#analysis-capabilities)
5. [Network and Connectivity](#network-and-connectivity)
6. [File Management](#file-management)
7. [Code Block Templates](#code-block-templates)
8. [Automation Scripts](#automation-scripts)
9. [Monitoring and Diagnostics](#monitoring-and-diagnostics)
10. [Best Practices](#best-practices)

---

## Environment Capabilities Overview

### What This Environment Provides

This sandbox environment is a **high-performance containerized development platform** with the following capabilities:

- **Massive Storage:** 1.0P capacity (39TB used, 4% utilization)
- **High Performance:** Intel Xeon Platinum 8369B (16 cores, 30GB RAM)
- **Full Development:** Complete programming environment
- **Version Control:** Git integration with GitHub
- **Network Access:** Internet connectivity for development
- **Security:** Multi-layer isolation and access control
- **Stability:** 7+ weeks of stable operation
- **Analysis Tools:** Comprehensive system monitoring and documentation

### Why These Capabilities Matter

- **Unlimited Storage:** Handle large datasets and projects
- **High Performance:** Run complex computations and analyses
- **Development Ready:** Full programming language support
- **Version Control:** Track changes and collaborate
- **Reliability:** Stable environment for long-term projects
- **Security:** Safe isolation for experimentation
- **Documentation:** Automated reporting and analysis

---

## Core System Capabilities

### System Information
```bash
# Get comprehensive system information
uname -a

# Check hostname
hostname

# Check uptime
uptime

# Check current user
whoami

# Check current directory
pwd
```

### Hardware Information
```bash
# CPU information
lscpu

# Number of processors
nproc

# Memory information
free -h

# Detailed memory info
cat /proc/meminfo

# Storage information
df -h

# CPU information
cat /proc/cpuinfo
```

### Process Management
```bash
# List all processes
ps aux

# Count processes
ps aux | wc -l

# Top processes by CPU
ps aux --sort=-%cpu | head -10

# Top processes by memory
ps aux --sort=-%mem | head -10

# Check system load
uptime
```

---

## Development Capabilities

### Programming Languages

#### Python
```python
# Python development templates
#!/usr/bin/env python3
"""
Python Script Template
"""

import os
import sys
import json
from datetime import datetime

def main():
    """Main function"""
    print("Python script template")
    print(f"Current time: {datetime.now()}")
    print(f"Working directory: {os.getcwd()}")
    print(f"Python version: {sys.version}")

if __name__ == "__main__":
    main()
```

#### JavaScript/Node.js
```javascript
// JavaScript/Node.js template
#!/usr/bin/env node

const os = require('os');
const fs = require('fs');
const http = require('http');

function main() {
    console.log('JavaScript/Node.js template');
    console.log(`Platform: ${os.platform()}`);
    console.log(`Architecture: ${os.arch()}`);
    console.log(`Memory: ${Math.round(os.totalmem() / 1024 / 1024 / 1024)}GB`);
}

if (require.main === module) {
    main();
}

module.exports = { main };
```

#### Shell Scripting
```bash
#!/bin/bash

# Shell script template
set -euo pipefail

SCRIPT_NAME=$(basename "$0")
LOG_FILE="/tmp/${SCRIPT_NAME}.log"

# Logging function
log() {
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] $1" | tee -a "$LOG_FILE"
}

# Main script
main() {
    log "Starting ${SCRIPT_NAME}"
    log "Working directory: $(pwd)"
    log "User: $(whoami)"
    log "Environment setup complete"
}

# Execute main function
main "$@"
```

### Package Management

#### Python Package Installation
```bash
# Install packages using pip
pip install requests
pip install pandas
pip install numpy
pip install matplotlib

# Install with requirements.txt
pip install -r requirements.txt

# Create requirements.txt
pip freeze > requirements.txt
```

#### Node.js Package Management
```bash
# Initialize Node.js project
npm init -y

# Install packages
npm install express
npm install axios
npm install dotenv

# Install development dependencies
npm install --save-dev nodemon
npm install --save-dev jest

# Install globally
npm install -g nodemon
```

#### System Package Management
```bash
# Update package list
apt update

# Install packages
apt install -y curl
apt install -y wget
apt install -y git
apt install -y tree

# Clean up
apt autoremove
apt autoclean
```

---

## Analysis Capabilities

### System Analysis Scripts

#### Comprehensive System Scan
```bash
#!/bin/bash

# System Analysis Template
ANALYSIS_DIR="/workspace/analysis"
TIMESTAMP=$(date +%Y%m%d_%H%M%S)

# Create analysis directory
mkdir -p "$ANALYSIS_DIR"

# System information collection
collect_system_info() {
    local output_file="$ANALYSIS_DIR/system_info_${TIMESTAMP}.txt"
    
    echo "# System Information Report" > "$output_file"
    echo "Generated: $(date)" >> "$output_file"
    echo "" >> "$output_file"
    
    echo "## Basic Information" >> "$output_file"
    echo "- Hostname: $(hostname)" >> "$output_file"
    echo "- OS: $(uname -a)" >> "$output_file"
    echo "- Uptime: $(uptime -p)" >> "$output_file"
    echo "" >> "$output_file"
    
    echo "## Hardware" >> "$output_file"
    echo "- CPU: $(nproc) cores" >> "$output_file"
    echo "- Memory: $(free -h | awk '/^Mem/ {print $2}')" >> "$output_file"
    echo "" >> "$output_file"
    
    echo "## Storage" >> "$output_file"
    df -h >> "$output_file"
    echo "" >> "$output_file"
    
    echo "## Process Count" >> "$output_file"
    echo "- Total processes: $(ps aux | wc -l)" >> "$output_file"
}

# File system analysis
analyze_filesystem() {
    local output_file="$ANALYSIS_DIR/filesystem_${TIMESTAMP}.txt"
    
    echo "# Filesystem Analysis" > "$output_file"
    echo "Generated: $(date)" >> "$output_file"
    echo "" >> "$output_file"
    
    echo "## Workspace Structure" >> "$output_file"
    find /workspace -type f | head -20 >> "$output_file"
    echo "" >> "$output_file"
    
    echo "## File Count by Type" >> "$output_file"
    find /workspace -type f -name "*.sh" | wc -l >> "$output_file"
    find /workspace -type f -name "*.md" | wc -l >> "$output_file"
    find /workspace -type f -name "*.py" | wc -l >> "$output_file"
}

# Execute analysis
collect_system_info
analyze_filesystem

echo "Analysis complete. Results in: $ANALYSIS_DIR"
```

### Data Analysis Templates

#### Python Data Analysis
```python
#!/usr/bin/env python3

import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
import json
import os
from datetime import datetime

def setup_matplotlib():
    """Setup matplotlib for non-interactive mode"""
    import warnings
    warnings.filterwarnings('default')
    plt.switch_backend("Agg")
    plt.style.use("seaborn-v0_8")
    plt.rcParams["font.sans-serif"] = ["Arial", "DejaVu Sans"]
    plt.rcParams["axes.unicode_minus"] = False

def analyze_system_data():
    """Analyze system data and create visualizations"""
    setup_matplotlib()
    
    # Create sample data
    data = {
        'timestamp': pd.date_range('2025-01-01', periods=100, freq='1H'),
        'cpu_usage': np.random.normal(30, 10, 100),
        'memory_usage': np.random.normal(60, 15, 100),
        'storage_usage': np.random.normal(40, 5, 100)
    }
    
    df = pd.DataFrame(data)
    
    # Create visualization
    fig, axes = plt.subplots(2, 2, figsize=(12, 8))
    fig.suptitle('System Performance Analysis')
    
    # CPU usage
    axes[0, 0].plot(df['timestamp'], df['cpu_usage'])
    axes[0, 0].set_title('CPU Usage (%)')
    axes[0, 0].tick_params(axis='x', rotation=45)
    
    # Memory usage
    axes[0, 1].plot(df['timestamp'], df['memory_usage'])
    axes[0, 1].set_title('Memory Usage (%)')
    axes[0, 1].tick_params(axis='x', rotation=45)
    
    # Storage usage
    axes[1, 0].plot(df['timestamp'], df['storage_usage'])
    axes[1, 0].set_title('Storage Usage (%)')
    axes[1, 0].tick_params(axis='x', rotation=45)
    
    # Summary statistics
    axes[1, 1].text(0.1, 0.5, f"""Summary Statistics:
    
CPU Average: {df['cpu_usage'].mean():.1f}%
Memory Average: {df['memory_usage'].mean():.1f}%
Storage Average: {df['storage_usage'].mean():.1f}%

Generated: {datetime.now().strftime('%Y-%m-%d %H:%M:%S')}""")
    axes[1, 1].set_title('Summary')
    axes[1, 1].axis('off')
    
    plt.tight_layout()
    plt.savefig('/workspace/system_analysis.png', dpi=300, bbox_inches='tight')
    plt.close()
    
    # Save data
    df.to_json('/workspace/system_data.json', orient='records', date_format='iso')
    
    return df.describe()

if __name__ == "__main__":
    summary = analyze_system_data()
    print("System analysis complete!")
    print(summary)
```

---

## Network and Connectivity

### Network Analysis Tools

#### Connectivity Testing
```bash
#!/bin/bash

# Network connectivity test script
NETWORK_LOG="/workspace/network_test.log"
TIMESTAMP=$(date +%Y%m%d_%H%M%S)

echo "Network Connectivity Test - $TIMESTAMP" > "$NETWORK_LOG"
echo "=======================================" >> "$NETWORK_LOG"
echo "" >> "$NETWORK_LOG"

# Test internet connectivity
test_internet() {
    echo "Testing Internet Connectivity:" >> "$NETWORK_LOG"
    if ping -c 3 8.8.8.8 > /dev/null 2>&1; then
        echo "✓ Internet access: PASS" >> "$NETWORK_LOG"
    else
        echo "✗ Internet access: FAIL" >> "$NETWORK_LOG"
    fi
    echo "" >> "$NETWORK_LOG"
}

# Test DNS resolution
test_dns() {
    echo "Testing DNS Resolution:" >> "$NETWORK_LOG"
    if nslookup github.com > /dev/null 2>&1; then
        echo "✓ DNS resolution: PASS" >> "$NETWORK_LOG"
    else
        echo "✗ DNS resolution: FAIL" >> "$NETWORK_LOG"
    fi
    echo "" >> "$NETWORK_LOG"
}

# Test GitHub connectivity
test_github() {
    echo "Testing GitHub Connectivity:" >> "$NETWORK_LOG"
    if curl -s --head https://github.com | head -n 1 | grep -q "200 OK"; then
        echo "✓ GitHub access: PASS" >> "$NETWORK_LOG"
    else
        echo "✗ GitHub access: FAIL" >> "$NETWORK_LOG"
    fi
    echo "" >> "$NETWORK_LOG"
}

# Test network interfaces
test_interfaces() {
    echo "Network Interfaces:" >> "$NETWORK_LOG"
    ip addr show | grep -E "^[0-9]+: " >> "$NETWORK_LOG"
    echo "" >> "$NETWORK_LOG"
}

# Execute tests
test_internet
test_dns
test_github
test_interfaces

echo "Network test completed. Results saved to: $NETWORK_LOG"
```

#### API Testing Template
```bash
#!/bin/bash

# API testing template
API_ENDPOINT="${1:-https://api.github.com}"
OUTPUT_FILE="/workspace/api_test_$(date +%Y%m%d_%H%M%S).json"

echo "Testing API: $API_ENDPOINT" > "$OUTPUT_FILE"

# Test GET request
curl -s -w "\nStatus: %{http_code}\nTime: %{time_total}s\nSize: %{size_download} bytes\n" \
     "$API_ENDPOINT" > "$OUTPUT_FILE.tmp" 2>&1

# Test response
if curl -s "$API_ENDPOINT" | jq . > /dev/null 2>&1; then
    echo "✓ Valid JSON response" >> "$OUTPUT_FILE"
else
    echo "✗ Invalid or no JSON response" >> "$OUTPUT_FILE"
fi

echo "API test completed. Results in: $OUTPUT_FILE"
```

---

## File Management

### File Operations Templates

#### File Backup Script
```bash
#!/bin/bash

# File backup template
BACKUP_DIR="/workspace/backups"
SOURCE_DIR="/workspace"
TIMESTAMP=$(date +%Y%m%d_%H%M%S)

# Create backup directory
mkdir -p "$BACKUP_DIR"

# Create backup archive
create_backup() {
    local backup_name="backup_${TIMESTAMP}.zip"
    local backup_path="$BACKUP_DIR/$backup_name"
    
    echo "Creating backup: $backup_name"
    cd /workspace
    
    # Backup important files
    zip -r "$backup_path" \
        AGENTS.md \
        README.md \
        deep_sandbox_scan/docs/ \
        browser/ \
        external_api/ \
        -x "*.tmp" "*.log" "*.zip" > /dev/null 2>&1
    
    if [ -f "$backup_path" ]; then
        echo "✓ Backup created: $backup_path ($(du -h "$backup_path" | cut -f1))"
    else
        echo "✗ Backup failed"
        return 1
    fi
}

# Verify backup
verify_backup() {
    local backup_path="$1"
    echo "Verifying backup: $backup_path"
    
    if unzip -t "$backup_path" > /dev/null 2>&1; then
        echo "✓ Backup integrity: PASS"
    else
        echo "✗ Backup integrity: FAIL"
        return 1
    fi
}

# Main backup process
main() {
    create_backup
    verify_backup "$BACKUP_DIR/backup_${TIMESTAMP}.zip"
    echo "Backup process completed"
}

main "$@"
```

#### File Analysis Script
```bash
#!/bin/bash

# File analysis template
ANALYSIS_DIR="/workspace/file_analysis"
TIMESTAMP=$(date +%Y%m%d_%H%M%S)

mkdir -p "$ANALYSIS_DIR"

# Analyze file types
analyze_file_types() {
    echo "## File Type Analysis" > "$ANALYSIS_DIR/file_types_${TIMESTAMP}.txt"
    echo "Generated: $(date)" >> "$ANALYSIS_DIR/file_types_${TIMESTAMP}.txt"
    echo "" >> "$ANALYSIS_DIR/file_types_${TIMESTAMP}.txt"
    
    for ext in sh md py js json txt zip; do
        count=$(find /workspace -name "*.${ext}" | wc -l)
        if [ $count -gt 0 ]; then
            echo "*.${ext}: $count files" >> "$ANALYSIS_DIR/file_types_${TIMESTAMP}.txt"
        fi
    done
}

# Analyze file sizes
analyze_file_sizes() {
    echo "## Large Files Analysis" > "$ANALYSIS_DIR/large_files_${TIMESTAMP}.txt"
    echo "Generated: $(date)" >> "$ANALYSIS_DIR/large_files_${TIMESTAMP}.txt"
    echo "" >> "$ANALYSIS_DIR/large_files_${TIMESTAMP}.txt"
    
    find /workspace -type f -size +1M -exec ls -lh {} \; | sort -k5 -hr >> "$ANALYSIS_DIR/large_files_${TIMESTAMP}.txt"
}

# Count files and directories
count_resources() {
    echo "## Resource Counts" > "$ANALYSIS_DIR/counts_${TIMESTAMP}.txt"
    echo "Generated: $(date)" >> "$ANALYSIS_DIR/counts_${TIMESTAMP}.txt"
    echo "" >> "$ANALYSIS_DIR/counts_${TIMESTAMP}.txt"
    
    echo "Total files: $(find /workspace -type f | wc -l)" >> "$ANALYSIS_DIR/counts_${TIMESTAMP}.txt"
    echo "Total directories: $(find /workspace -type d | wc -l)" >> "$ANALYSIS_DIR/counts_${TIMESTAMP}.txt"
    echo "Executable files: $(find /workspace -type f -executable | wc -l)" >> "$ANALYSIS_DIR/counts_${TIMESTAMP}.txt"
}

# Execute analysis
analyze_file_types
analyze_file_sizes
count_resources

echo "File analysis completed. Results in: $ANALYSIS_DIR"
```

---

## Code Block Templates

### Database Operations

#### SQLite Database Template
```python
#!/usr/bin/env python3

import sqlite3
import json
from datetime import datetime

class DatabaseManager:
    def __init__(self, db_path="/workspace/data.db"):
        self.db_path = db_path
        self.init_database()
    
    def init_database(self):
        """Initialize database with sample tables"""
        conn = sqlite3.connect(self.db_path)
        cursor = conn.cursor()
        
        # Create system metrics table
        cursor.execute('''
            CREATE TABLE IF NOT EXISTS system_metrics (
                id INTEGER PRIMARY KEY AUTOINCREMENT,
                timestamp TEXT,
                cpu_usage REAL,
                memory_usage REAL,
                storage_usage REAL
            )
        ''')
        
        # Create file tracking table
        cursor.execute('''
            CREATE TABLE IF NOT EXISTS file_tracking (
                id INTEGER PRIMARY KEY AUTOINCREMENT,
                filepath TEXT,
                size INTEGER,
                modified_time TEXT,
                file_type TEXT
            )
        ''')
        
        conn.commit()
        conn.close()
    
    def insert_system_metrics(self, cpu, memory, storage):
        """Insert system metrics into database"""
        conn = sqlite3.connect(self.db_path)
        cursor = conn.cursor()
        
        cursor.execute('''
            INSERT INTO system_metrics (timestamp, cpu_usage, memory_usage, storage_usage)
            VALUES (?, ?, ?, ?)
        ''', (datetime.now().isoformat(), cpu, memory, storage))
        
        conn.commit()
        conn.close()
    
    def get_latest_metrics(self, limit=10):
        """Get latest system metrics"""
        conn = sqlite3.connect(self.db_path)
        cursor = conn.cursor()
        
        cursor.execute('''
            SELECT timestamp, cpu_usage, memory_usage, storage_usage
            FROM system_metrics
            ORDER BY timestamp DESC
            LIMIT ?
        ''', (limit,))
        
        results = cursor.fetchall()
        conn.close()
        return results

# Usage example
if __name__ == "__main__":
    db = DatabaseManager()
    db.insert_system_metrics(30.5, 60.2, 45.8)
    
    metrics = db.get_latest_metrics(5)
    print("Latest system metrics:")
    for metric in metrics:
        print(f"Time: {metric[0]}, CPU: {metric[1]}%, Memory: {metric[2]}%, Storage: {metric[3]}%")
```

### Web Server Template

#### Simple HTTP Server
```python
#!/usr/bin/env python3

import http.server
import socketserver
import json
import os
from datetime import datetime

class APIHandler(http.server.SimpleHTTPRequestHandler):
    def do_GET(self):
        """Handle GET requests"""
        if self.path == '/api/status':
            self.send_response(200)
            self.send_header('Content-type', 'application/json')
            self.end_headers()
            
            status = {
                'status': 'running',
                'timestamp': datetime.now().isoformat(),
                'workspace': '/workspace',
                'user': os.environ.get('USER', 'unknown'),
                'hostname': os.environ.get('HOSTNAME', 'unknown')
            }
            
            self.wfile.write(json.dumps(status, indent=2).encode())
        else:
            super().do_GET()
    
    def do_POST(self):
        """Handle POST requests"""
        if self.path == '/api/test':
            content_length = int(self.headers['Content-Length'])
            post_data = self.rfile.read(content_length)
            
            self.send_response(200)
            self.send_header('Content-type', 'application/json')
            self.end_headers()
            
            response = {
                'status': 'success',
                'received_data': post_data.decode('utf-8'),
                'timestamp': datetime.now().isoformat()
            }
            
            self.wfile.write(json.dumps(response, indent=2).encode())
        else:
            self.send_error(404)

def start_server(port=8080):
    """Start the HTTP server"""
    with socketserver.TCPServer(("", port), APIHandler) as httpd:
        print(f"Server running on port {port}")
        print("Available endpoints:")
        print("  GET  /api/status    - System status")
        print("  POST /api/test      - Test endpoint")
        httpd.serve_forever()

if __name__ == "__main__":
    start_server()
```

### Configuration Management

#### YAML Configuration Template
```yaml
# config.yaml
system:
  name: "sandbox_environment"
  version: "1.0"
  environment: "development"
  
database:
  type: "sqlite"
  path: "/workspace/data.db"
  backup_interval: 3600  # seconds
  
monitoring:
  enabled: true
  metrics_interval: 60   # seconds
  retention_days: 30
  
network:
  timeout: 30            # seconds
  retry_attempts: 3
  user_agent: "SandboxAgent/1.0"
  
security:
  require_auth: false
  max_file_size: "100MB"
  allowed_extensions:
    - ".sh"
    - ".py"
    - ".js"
    - ".md"
    - ".json"
    - ".yaml"
```

#### JSON Configuration Template
```json
{
  "system": {
    "name": "sandbox_environment",
    "version": "1.0",
    "environment": "development",
    "created": "2025-11-07T09:24:46Z"
  },
  "features": {
    "version_control": true,
    "file_monitoring": true,
    "system_analysis": true,
    "backup_automation": true,
    "network_testing": true
  },
  "limits": {
    "max_file_size": "100MB",
    "max_processes": 1000,
    "memory_limit": "30GB",
    "storage_limit": "1.0P"
  },
  "notifications": {
    "email": false,
    "webhook": false,
    "log_level": "INFO"
  }
}
```

---

## Automation Scripts

### System Health Monitor
```bash
#!/bin/bash

# System health monitoring script
MONITOR_LOG="/workspace/health_monitor.log"
ALERT_THRESHOLD_CPU=80
ALERT_THRESHOLD_MEMORY=85

# Monitor function
monitor_system() {
    local timestamp=$(date '+%Y-%m-%d %H:%M:%S')
    local cpu_usage=$(top -bn1 | grep "Cpu(s)" | awk '{print $2}' | sed 's/%us,//')
    local memory_usage=$(free | grep Mem | awk '{printf("%.1f", $3/$2 * 100.0)}')
    
    echo "[$timestamp] CPU: ${cpu_usage}%, Memory: ${memory_usage}%" >> "$MONITOR_LOG"
    
    # Check for alerts
    if (( $(echo "$cpu_usage > $ALERT_THRESHOLD_CPU" | bc -l) )); then
        echo "[$timestamp] ALERT: High CPU usage: ${cpu_usage}%" >> "$MONITOR_LOG"
    fi
    
    if (( $(echo "$memory_usage > $ALERT_THRESHOLD_MEMORY" | bc -l) )); then
        echo "[$timestamp] ALERT: High memory usage: ${memory_usage}%" >> "$MONITOR_LOG"
    fi
}

# Run monitoring
while true; do
    monitor_system
    sleep 60  # Monitor every minute
done
```

### Automated Backup Scheduler
```bash
#!/bin/bash

# Automated backup scheduler
BACKUP_DIR="/workspace/automated_backups"
SCHEDULE_FILE="/workspace/backup_schedule.json"
RETENTION_DAYS=7

# Check if backup is due
check_backup_schedule() {
    if [ ! -f "$SCHEDULE_FILE" ]; then
        echo "No schedule file found. Creating default schedule..."
        cat > "$SCHEDULE_FILE" << EOF
{
  "last_backup": "1970-01-01T00:00:00Z",
  "frequency": "daily",
  "enabled": true
}
EOF
    fi
}

# Run backup if scheduled
run_backup_if_due() {
    local last_backup=$(jq -r '.last_backup' "$SCHEDULE_FILE")
    local frequency=$(jq -r '.frequency' "$SCHEDULE_FILE")
    local enabled=$(jq -r '.enabled' "$SCHEDULE_FILE")
    
    if [ "$enabled" = "true" ]; then
        current_time=$(date -u +%s)
        last_backup_time=$(date -d "$last_backup" +%s 2>/dev/null || echo "0")
        
        case $frequency in
            "daily")
                threshold=$((24 * 60 * 60))  # 24 hours
                ;;
            "weekly")
                threshold=$((7 * 24 * 60 * 60))  # 7 days
                ;;
            *)
                threshold=$((24 * 60 * 60))  # default daily
                ;;
        esac
        
        if [ $((current_time - last_backup_time)) -gt $threshold ]; then
            echo "Running scheduled backup..."
            run_automated_backup
            update_schedule
        fi
    fi
}

# Run backup
run_automated_backup() {
    local timestamp=$(date +%Y%m%d_%H%M%S)
    local backup_name="auto_backup_${timestamp}.zip"
    local backup_path="$BACKUP_DIR/$backup_name"
    
    mkdir -p "$BACKUP_DIR"
    
    cd /workspace
    zip -r "$backup_path" \
        AGENTS.md \
        README.md \
        deep_sandbox_scan/docs/ \
        -x "*.tmp" "*.log" > /dev/null 2>&1
    
    if [ -f "$backup_path" ]; then
        echo "Automated backup created: $backup_name"
        return 0
    else
        echo "Automated backup failed"
        return 1
    fi
}

# Update schedule
update_schedule() {
    local current_time=$(date -u +%Y-%m-%dT%H:%M:%SZ)
    jq ".last_backup = \"$current_time\"" "$SCHEDULE_FILE" > "$SCHEDULE_FILE.tmp"
    mv "$SCHEDULE_FILE.tmp" "$SCHEDULE_FILE"
}

# Main execution
main() {
    check_backup_schedule
    run_backup_if_due
    
    # Clean old backups
    find "$BACKUP_DIR" -name "auto_backup_*.zip" -mtime +$RETENTION_DAYS -delete
}

main "$@"
```

---

## Monitoring and Diagnostics

### Performance Monitoring
```python
#!/usr/bin/env python3

import psutil
import time
import json
from datetime import datetime

class SystemMonitor:
    def __init__(self, output_file="/workspace/system_metrics.json"):
        self.output_file = output_file
        self.metrics = []
    
    def collect_metrics(self):
        """Collect system metrics"""
        timestamp = datetime.now().isoformat()
        
        # CPU metrics
        cpu_percent = psutil.cpu_percent(interval=1)
        cpu_count = psutil.cpu_count()
        
        # Memory metrics
        memory = psutil.virtual_memory()
        swap = psutil.swap_memory()
        
        # Disk metrics
        disk = psutil.disk_usage('/')
        disk_io = psutil.disk_io_counters()
        
        # Network metrics
        net_io = psutil.net_io_counters()
        
        # Process metrics
        process_count = len(psutil.pids())
        
        metrics = {
            'timestamp': timestamp,
            'cpu': {
                'percent': cpu_percent,
                'count': cpu_count
            },
            'memory': {
                'total': memory.total,
                'available': memory.available,
                'percent': memory.percent,
                'used': memory.used
            },
            'disk': {
                'total': disk.total,
                'used': disk.used,
                'free': disk.free,
                'percent': (disk.used / disk.total) * 100
            },
            'network': {
                'bytes_sent': net_io.bytes_sent,
                'bytes_recv': net_io.bytes_recv,
                'packets_sent': net_io.packets_sent,
                'packets_recv': net_io.packets_recv
            },
            'processes': {
                'count': process_count
            }
        }
        
        self.metrics.append(metrics)
        return metrics
    
    def save_metrics(self):
        """Save metrics to file"""
        with open(self.output_file, 'w') as f:
            json.dump(self.metrics, f, indent=2)
    
    def get_current_status(self):
        """Get current system status summary"""
        metrics = self.collect_metrics()
        
        status = {
            'status': 'healthy',
            'timestamp': metrics['timestamp'],
            'cpu_usage': f"{metrics['cpu']['percent']:.1f}%",
            'memory_usage': f"{metrics['memory']['percent']:.1f}%",
            'disk_usage': f"{metrics['disk']['percent']:.1f}%",
            'process_count': metrics['processes']['count']
        }
        
        # Check for issues
        if metrics['cpu']['percent'] > 80:
            status['status'] = 'warning'
            status['issue'] = 'High CPU usage'
        
        if metrics['memory']['percent'] > 85:
            status['status'] = 'warning'
            status['issue'] = 'High memory usage'
        
        if metrics['disk']['percent'] > 90:
            status['status'] = 'critical'
            status['issue'] = 'High disk usage'
        
        return status

# Usage example
if __name__ == "__main__":
    monitor = SystemMonitor()
    
    # Get current status
    status = monitor.get_current_status()
    print(f"System Status: {json.dumps(status, indent=2)}")
    
    # Monitor for a period
    for i in range(5):
        monitor.collect_metrics()
        time.sleep(60)  # Monitor for 5 minutes
    
    monitor.save_metrics()
    print("Monitoring complete. Metrics saved.")
```

---

## Best Practices

### Code Quality Standards

#### Shell Script Standards
```bash
#!/bin/bash

# Shell script best practices template
set -euo pipefail  # Exit on error, undefined vars, pipe failures

# Constants
readonly SCRIPT_NAME="$(basename "$0")"
readonly LOG_DIR="/var/log/${SCRIPT_NAME%.*}"
readonly CONFIG_FILE="/etc/${SCRIPT_NAME%.*}.conf"

# Functions
log() {
    local level="$1"
    shift
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] [$level] $*" | tee -a "$LOG_DIR/${SCRIPT_NAME%.*}.log"
}

error() {
    log "ERROR" "$@"
    exit 1
}

warn() {
    log "WARN" "$@"
}

info() {
    log "INFO" "$@"
}

# Main function
main() {
    info "Starting ${SCRIPT_NAME}"
    
    # Validate input
    if [ $# -eq 0 ]; then
        error "Usage: ${SCRIPT_NAME} <argument>"
    fi
    
    # Main logic here
    info "Processing argument: $1"
    
    info "${SCRIPT_NAME} completed successfully"
}

# Execute with error handling
main "$@" || error "Script failed with exit code $?"
```

#### Python Code Standards
```python
#!/usr/bin/env python3
"""
Python script template with best practices
"""

import os
import sys
import logging
import argparse
from pathlib import Path
from typing import Optional, List

# Configuration
LOG_LEVEL = os.getenv('LOG_LEVEL', 'INFO')
LOG_FORMAT = '%(asctime)s - %(name)s - %(levelname)s - %(message)s'

# Setup logging
logging.basicConfig(
    level=getattr(logging, LOG_LEVEL),
    format=LOG_FORMAT,
    handlers=[
        logging.FileHandler('/tmp/script.log'),
        logging.StreamHandler(sys.stdout)
    ]
)
logger = logging.getLogger(__name__)

class ScriptClass:
    """Main script class with best practices"""
    
    def __init__(self, config_file: Optional[str] = None):
        self.config_file = config_file
        self.config = self._load_config()
        logger.info("Script initialized")
    
    def _load_config(self) -> dict:
        """Load configuration from file"""
        if self.config_file and Path(self.config_file).exists():
            import json
            with open(self.config_file) as f:
                return json.load(f)
        return {}
    
    def process_data(self, data: List[str]) -> dict:
        """Process data with error handling"""
        try:
            result = {
                'input_count': len(data),
                'processed': 0,
                'errors': []
            }
            
            for item in data:
                try:
                    # Process each item
                    processed_item = item.strip()
                    if processed_item:
                        result['processed'] += 1
                except Exception as e:
                    result['errors'].append(str(e))
                    logger.error(f"Error processing item: {item}, error: {e}")
            
            return result
        
        except Exception as e:
            logger.error(f"Critical error in process_data: {e}")
            raise
    
    def run(self, args) -> int:
        """Main execution method"""
        try:
            logger.info("Starting script execution")
            
            # Process arguments
            data = args.input if hasattr(args, 'input') else []
            result = self.process_data(data)
            
            logger.info(f"Processing complete: {result}")
            return 0
        
        except Exception as e:
            logger.error(f"Script execution failed: {e}")
            return 1

def main() -> int:
    """Main entry point with argument parsing"""
    parser = argparse.ArgumentParser(
        description='Script description',
        formatter_class=argparse.RawDescriptionHelpFormatter,
        epilog='Example: python script.py --input "data1,data2"'
    )
    parser.add_argument(
        '--input',
        type=str,
        help='Input data to process'
    )
    parser.add_argument(
        '--config',
        type=str,
        help='Configuration file path'
    )
    parser.add_argument(
        '--verbose', '-v',
        action='store_true',
        help='Verbose output'
    )
    
    args = parser.parse_args()
    
    if args.verbose:
        global LOG_LEVEL
        LOG_LEVEL = 'DEBUG'
        logging.getLogger().setLevel(logging.DEBUG)
    
    # Create and run script
    script = ScriptClass(config_file=args.config)
    return script.run(args)

if __name__ == '__main__':
    sys.exit(main())
```

### Security Guidelines

#### Input Validation
```python
#!/usr/bin/env python3

import re
import os
import sys
from pathlib import Path

def validate_filename(filename: str) -> bool:
    """Validate filename for security"""
    if not filename:
        return False
    
    # Check for path traversal
    if '..' in filename or filename.startswith('/'):
        return False
    
    # Check for dangerous characters
    if re.search(r'[<>:"/\\|?*]', filename):
        return False
    
    # Check length
    if len(filename) > 255:
        return False
    
    return True

def safe_path_join(base_dir: str, filename: str) -> Path:
    """Safely join paths and validate"""
    base_path = Path(base_dir).resolve()
    
    if not validate_filename(filename):
        raise ValueError(f"Invalid filename: {filename}")
    
    # Create full path
    full_path = (base_path / filename).resolve()
    
    # Ensure path is within base directory
    if not str(full_path).startswith(str(base_path)):
        raise ValueError(f"Path traversal attempt: {filename}")
    
    return full_path

def safe_command_execution(command: List[str]) -> bool:
    """Safely execute commands"""
    allowed_commands = ['ls', 'cat', 'grep', 'find']
    
    if not command or command[0] not in allowed_commands:
        logger.error(f"Command not allowed: {command}")
        return False
    
    # Additional validation for arguments
    for arg in command[1:]:
        if re.search(r'[;&|`$()<>]', arg):
            logger.error(f"Dangerous characters in argument: {arg}")
            return False
    
    return True

# Usage example
try:
    # Safe file operation
    safe_file = safe_path_join("/workspace", "test_file.txt")
    
    # Safe command execution
    if safe_command_execution(["ls", "-la"]):
        print("Safe to execute command")
    
except ValueError as e:
    print(f"Security validation failed: {e}")
    sys.exit(1)
```

---

## Usage Instructions

### Getting Started

1. **Read the Environment Overview** - Understand capabilities
2. **Choose Your Development Path** - Select appropriate templates
3. **Set Up Your Workspace** - Create project directories
4. **Use Version Control** - Commit changes regularly
5. **Follow Best Practices** - Maintain code quality

### Code Block Usage

- **Templates are ready-to-use** - Copy, modify, and execute
- **Security included** - Input validation and safe practices
- **Error handling** - Comprehensive error management
- **Logging built-in** - Track execution and debug issues
- **Configuration support** - Flexible configuration options

### Customization

- **Modify paths** - Update to match your project structure
- **Adjust parameters** - Tune for your specific needs
- **Add features** - Extend templates with additional functionality
- **Integrate tools** - Combine with existing development tools

### Best Practices

- **Always validate input** - Prevent security issues
- **Handle errors gracefully** - Provide meaningful error messages
- **Log important events** - Enable debugging and monitoring
- **Test thoroughly** - Validate all code before deployment
- **Document changes** - Keep documentation current

---

**This instructions.md provides comprehensive templates and guidelines for effective development in the sandbox environment. All code blocks are ready to use and can be customized for specific project needs.**