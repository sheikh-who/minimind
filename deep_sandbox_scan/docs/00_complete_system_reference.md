# Complete Sandbox System Reference Guide

**Document Version:** 1.0  
**Created:** 2025-11-07 09:18:29  
**Environment:** Kubernetes Container Sandbox  
**Author:** MiniMax Agent  

## Table of Contents

1. [System Overview](#system-overview)
2. [Architecture and Design](#architecture-and-design)
3. [How the System Works](#how-the-system-works)
4. [File System Structure](#file-system-structure)
5. [Network and Connectivity](#network-and-connectivity)
6. [Security Model](#security-model)
7. [Development Environment](#development-environment)
8. [Process Management](#process-management)
9. [Backup and Version Control](#backup-and-version-control)
10. [System Commands and Usage](#system-commands-and-usage)
11. [Troubleshooting Guide](#troubleshooting-guide)
12. [Best Practices](#best-practices)

---

## System Overview

### What is this System?
This is a **cloud-based Linux container sandbox environment** running in a Kubernetes cluster, designed for:
- **Development and Testing:** Full development environment with programming tools
- **Data Analysis:** High-capacity storage for data processing (1.0P workspace)
- **System Administration:** Complete system access for administrative tasks
- **Research and Development:** Isolated environment for experimentation

### System Characteristics
- **Environment Type:** Kubernetes Pod Container
- **Operating System:** Ubuntu 20.04.6 LTS (Focal Fossa)
- **Architecture:** x86_64 (64-bit)
- **Primary Storage:** 1.0 Petabyte workspace (4% used)
- **Memory:** 30GB total (11GB used, 18GB available)
- **CPU:** Intel Xeon Platinum 8369B @ 2.70GHz (16 cores, 32 threads)
- **Uptime:** 7 weeks, 5 days, 19 hours, 1 minute

### Why This Architecture?
The system is designed as a **containerized development environment** because:
- **Isolation:** Complete isolation from host system
- **Scalability:** Easy to scale and replicate
- **Security:** Controlled access and resource limits
- **Flexibility:** Customizable development environment
- **Reliability:** High-availability cloud infrastructure

---

## Architecture and Design

### Container Architecture
```
┌─────────────────────────────────────────────────────────────┐
│                    Kubernetes Pod                          │
├─────────────────────────────────────────────────────────────┤
│  ┌─────────────────────────────────────────────────────────┐ │
│  │                Container Runtime                        │ │
│  │  ┌─────────────┐ ┌─────────────┐ ┌─────────────────────┐ │ │
│  │  │   Process   │ │   Network   │ │   File System       │ │ │
│  │  │  Namespace  │ │  Namespace  │ │    Namespace        │ │ │
│  │  └─────────────┘ └─────────────┘ └─────────────────────┘ │ │
│  └─────────────────────────────────────────────────────────┘ │
├─────────────────────────────────────────────────────────────┤
│                Cgroup Resource Limits                       │
│  ┌─────────────┐ ┌─────────────┐ ┌─────────────────────────┐ │
│  │   Memory    │ │     CPU     │ │     I/O Limits          │ │
│  │   30GB      │ │    16Core   │ │   Network Storage       │ │
│  └─────────────┘ └─────────────┘ └─────────────────────────┘ │
└─────────────────────────────────────────────────────────────┘
                          │
                          ▼
┌─────────────────────────────────────────────────────────────┐
│                 Virtual Hardware                            │
│  ┌─────────────┐ ┌─────────────┐ ┌─────────────────────────┐ │
│  │ Virtual     │ │ Network     │ │    Network Storage      │ │
│  │ CPU/RAM     │ │ Interface   │ │      1.0P Capacity      │ │
│  └─────────────┘ └─────────────┘ └─────────────────────────┘ │
└─────────────────────────────────────────────────────────────┘
```

### Key Design Principles

1. **Multi-Layer Isolation:**
   - Process isolation (separate PID namespace)
   - Network isolation (separate network namespace)
   - Filesystem isolation (overlay filesystem with workspace mounting)
   - User isolation (non-root user execution)

2. **Resource Management:**
   - Memory limits via cgroups
   - CPU limits and fair scheduling
   - Storage I/O throttling
   - Network bandwidth management

3. **Security by Design:**
   - Minimal Linux capabilities
   - No privileged access
   - Controlled external access
   - Secure network communication

---

## How the System Works

### Container Lifecycle
1. **Creation:** Kubernetes creates pod with container runtime
2. **Initialization:** Setup process, network, and filesystem namespaces
3. **Resource Assignment:** CPU and memory limits applied via cgroups
4. **Network Setup:** Virtual network interface and DNS configuration
5. **Filesystem Mount:** Overlay filesystem with network storage
6. **Process Start:** Init process starts user environment
7. **Ready State:** Container ready for user interaction

### Filesystem Mechanism
```
┌─────────────────────────────────────────────────────────────┐
│                      Mount Stack                            │
├─────────────────────────────────────────────────────────────┤
│  /workspace (1.0P network storage) ← Our working directory │
├─────────────────────────────────────────────────────────────┤
│  Overlay Layer (container filesystem)                       │
│  ┌─────────────┐ ┌─────────────┐ ┌─────────────────────────┐ │
│  │   Lower     │ │   Upper     │ │    Work Directory       │ │
│  │  (read-only)│ │  (writable) │ │   (internal overlay)    │ │
│  │  base image │ │  changes    │ │    operations           │ │
│  └─────────────┘ └─────────────┘ └─────────────────────────┘ │
├─────────────────────────────────────────────────────────────┤
│  Original Filesystem (Host/Kernel Level)                    │
└─────────────────────────────────────────────────────────────┘
```

**How it works:**
- **Base Layer:** Read-only Ubuntu filesystem
- **Upper Layer:** Writable container-specific changes
- **Workspace Mount:** Network storage mounted at /workspace
- **Unified View:** User sees single coherent filesystem

### Network Communication
```
Container → Virtual Interface → Kubernetes Network → Internet
     ↓              ↓                    ↓              ↓
   Local       Containerd         Pod Network      GitHub/API
   Apps        Network Bridge    Service Mesh     External Services
```

**Network Flow:**
1. **Container Apps** → Write to virtual network interface
2. **Container Runtime** → Bridges to Kubernetes pod network
3. **Kubernetes** → Routes to cluster network
4. **NAT/Proxy** → Internet access for external services
5. **DNS Resolution** → Kubernetes DNS service

### Process Management
```
User Commands → Bash Shell → System Calls → Kernel → Cgroups
     ↓              ↓             ↓          ↓         ↓
   Interactive   Process      Namespace   Process   Resource
   Sessions      Creation     Isolation   Scheduling Limits
```

**Process Isolation:**
- Each process runs in container's PID namespace
- Process trees isolated from host system
- Resource limits enforced by cgroups
- Signal handling and IPC contained within namespace

---

## File System Structure

### Root Directory Analysis
```
/ (root)
├── proc/              - Virtual filesystem for system info
├── sys/               - Virtual filesystem for hardware
├── dev/               - Device files
├── etc/               - System configuration
├── usr/               - User programs and libraries
├── var/               - Variable data (logs, caches)
├── tmp/               - Temporary files
├── opt/               - Optional software (empty)
├── home/              - User directories (minimal)
├── root/              - Root user directory
└── workspace/         - Main working directory (1.0P capacity)
```

### Workspace Organization
```
/workspace/
├── .git/                     - Git version control (100KB)
│   ├── objects/              - Git objects
│   ├── refs/                 - Branch references
│   └── HEAD                  - Current branch pointer
├── browser/                  - Browser tools (7.9KB)
│   └── [browser utilities]   - Browser automation/testing
├── external_api/             - API integrations (46KB)
│   └── [API clients]         - External service connectors
├── deep_sandbox_scan/        - System analysis (growing)
│   ├── scripts/              - Analysis and scan scripts
│   ├── docs/                 - Generated documentation
│   ├── reports/              - Scan logs and reports
│   └── backup/               - Backup archives
├── system_diagnostic.sh      - System diagnostic tool
├── advanced_diagnostic.sh    - Enhanced diagnostic tool
└── README.md                 - Project documentation
```

### File System Logic

**Why This Structure?**
- **.git/**: Version control for all project files
- **browser/**: Dedicated space for browser-related tools
- **external_api/**: Clean separation of API integrations
- **deep_sandbox_scan/**: Current analysis work isolated
- **Diagnostic Scripts**: Self-contained system analysis tools

**Storage Strategy:**
- **Network Storage:** 1.0P capacity for unlimited growth
- **Version Control:** Git tracks all changes and history
- **Modular Design:** Each subdirectory serves specific purpose
- **Documentation:** All analysis and changes documented

---

## Network and Connectivity

### Network Architecture
```
┌─────────────────┐    ┌──────────────────┐    ┌─────────────────┐
│   Container     │    │   Kubernetes     │    │   External      │
│   Application   │    │   Pod Network    │    │   Internet      │
│                 │    │                  │    │                 │
│  ┌───────────┐  │    │  ┌─────────────┐ │    │  ┌───────────┐ │
│  │  Local    │  │    │  │ Virtual     │ │    │  │ GitHub    │ │
│  │  Apps     │  │    │  │ Interface   │ │    │  │ API       │ │
│  └───────────┘  │    │  └─────────────┘ │    │  └───────────┘ │
│       ↓         │    │         ↓        │    │       ↓       │
│  ┌───────────┐  │    │  ┌─────────────┐ │    │  ┌───────────┐ │
│  │ Virtual   │  │    │  │ Pod-to-Pod  │ │    │  │ Package   │ │
│  │ Interface │  │    │  │ Routing     │ │    │  │ Repos     │ │
│  └───────────┘  │    │  └─────────────┘ │    │  └───────────┘ │
└─────────────────┘    └──────────────────┘    └─────────────────┘
```

### Network Services
- **Git Operations:** HTTPS to GitHub (successfully tested)
- **Package Repositories:** APT, pip, npm access
- **External APIs:** Network connectivity for integrations
- **DNS Resolution:** Kubernetes DNS service
- **File Storage:** High-speed network filesystem

### Why This Network Design?
- **Internet Access:** Required for development tools and updates
- **Security:** Controlled access through Kubernetes
- **Performance:** High-speed network storage access
- **Reliability:** Redundant network paths and DNS

---

## Security Model

### Security Layers
```
┌─────────────────────────────────────────────────────────────┐
│                     Security Stack                          │
├─────────────────────────────────────────────────────────────┤
│  Application Security (User-level access control)           │
├─────────────────────────────────────────────────────────────┤
│  Container Security (Namespace isolation)                   │
├─────────────────────────────────────────────────────────────┤
│  Kubernetes Security (Pod policies)                         │
├─────────────────────────────────────────────────────────────┤
│  Infrastructure Security (Virtual hardware isolation)       │
├─────────────────────────────────────────────────────────────┤
│  Cloud Security (Physical hardware isolation)               │
└─────────────────────────────────────────────────────────────┘
```

### Security Mechanisms

1. **User Isolation:**
   - **Non-root User:** minimax (not root)
   - **No Sudo:** No privileged command execution
   - **Controlled Access:** Limited to workspace directory

2. **Process Isolation:**
   - **PID Namespace:** Separate process tree
   - **Cgroup Limits:** Resource constraints
   - **Signal Isolation:** Limited signal propagation

3. **Network Isolation:**
   - **Virtual Network:** Separate from host network
   - **Controlled Access:** Kubernetes network policies
   - **NAT-based Internet:** Controlled external access

4. **Filesystem Isolation:**
   - **Overlay Filesystem:** Isolated filesystem changes
   - **Network Storage:** Separated from host storage
   - **Permission Control:** Standard Unix permissions

### Why This Security Model?
- **Defense in Depth:** Multiple security layers
- **Least Privilege:** Minimal necessary permissions
- **Isolation:** Complete separation from host system
- **Auditing:** Standard Linux audit trails

---

## Development Environment

### Available Tools
- **Shell:** bash with full command-line interface
- **Version Control:** Git with GitHub integration
- **Programming:** Python, JavaScript, Shell scripting
- **Package Managers:** pip, npm, apt (as available)
- **Build Tools:** Standard Linux build utilities
- **System Analysis:** Custom diagnostic and scanning tools

### Development Workflow
1. **Code Development:** Edit files in workspace
2. **Version Control:** Git commit and push changes
3. **Testing:** Execute scripts and analyze results
4. **Documentation:** Generate reports and documentation
5. **Backup:** Automated archive creation

### Why This Environment?
- **Full Development:** Complete programming environment
- **Version Control:** Git tracks all changes
- **High Storage:** 1.0P for large projects
- **Isolation:** Safe testing environment
- **Documentation:** Automated report generation

---

## Process Management

### Process Overview
- **Total Processes:** 398 running processes
- **Process Types:** Container runtime, system services, user applications
- **Resource Usage:** 37% CPU and memory utilization
- **Efficiency:** Well-managed process hierarchy

### Process Categories
1. **Container Runtime:** Kubernetes and containerd processes
2. **System Services:** Network and filesystem services
3. **User Environment:** Shell and development tools
4. **Analysis Tools:** System scanning and diagnostic tools

### How Process Management Works
```
User Command → Shell Process → System Call → Kernel → Cgroup Enforcement
     ↓             ↓             ↓          ↓         ↓
  Interactive   Process       Namespace   Process   Resource
  Execution     Creation      Isolation   Scheduling Limits
```

### Why This Process Model?
- **Efficiency:** Optimal process scheduling
- **Isolation:** Protected from host processes
- **Resource Control:** Fair CPU and memory allocation
- **Security:** Contained process environment

---

## Backup and Version Control

### Version Control System
- **Platform:** Git with GitHub
- **Repository:** https://github.com/sheikh-who/minimind
- **Branch:** main (primary branch)
- **Files Tracked:** All workspace files and documentation

### Backup Strategy
1. **Version Control:** Git tracks all code changes
2. **Automated Archives:** ZIP files for data backup
3. **Documentation:** Complete scan reports
4. **External Storage:** GitHub repository as remote backup

### How Backup Works
```
Local Changes → Git Commit → GitHub Push → Remote Repository
      ↓            ↓            ↓              ↓
  File Edits   Version    Network       GitHub
  Analysis     History    Transfer      Storage
```

### Why This Backup System?
- **Reliability:** Multiple backup locations
- **Version History:** Complete change tracking
- **Remote Access:** GitHub provides remote access
- **Automated:** Scripts handle backup creation

---

## System Commands and Usage

### Basic Navigation
```bash
# Check current directory
pwd

# List files
ls -la

# Navigate to workspace
cd /workspace

# Check system info
uname -a
hostname
```

### Process Management
```bash
# Check running processes
ps aux

# Monitor system resources
top
htop  # if available

# Check memory usage
free -h

# Check CPU information
lscpu
nproc
```

### File System Operations
```bash
# Check disk usage
du -sh /workspace
df -h

# Find files
find /workspace -type f

# Count files
find /workspace -type f | wc -l
```

### Network Operations
```bash
# Check network interfaces
ip addr show

# Test connectivity
ping -c 1 8.8.8.8

# Check DNS
cat /etc/resolv.conf
```

### Version Control
```bash
# Check git status
git status

# Add files to git
git add .

# Commit changes
git commit -m "Update description"

# Push to GitHub
git push origin main
```

### Custom Analysis Tools
```bash
# Run comprehensive system scan
bash /workspace/deep_sandbox_scan/scripts/comprehensive_sandbox_scanner.sh

# Check workspace structure
tree /workspace -a -L 3

# Generate reports
ls /workspace/deep_sandbox_scan/docs/
```

---

## Troubleshooting Guide

### Common Issues

1. **Permission Denied:**
   ```bash
   # Check file permissions
   ls -l filename
   
   # Check user and group
   whoami
   groups
   ```

2. **Network Connectivity:**
   ```bash
   # Test network
   ping -c 1 8.8.8.8
   
   # Check DNS
   nslookup github.com
   
   # Check network status
   ip addr show
   ```

3. **Disk Space:**
   ```bash
   # Check storage usage
   df -h
   
   # Check workspace size
   du -sh /workspace
   ```

4. **Memory Issues:**
   ```bash
   # Check memory usage
   free -h
   
   # Check processes using memory
   ps aux --sort=-%mem | head
   ```

### How to Diagnose Issues
1. **Check System Logs:** Look in /var/log (if available)
2. **Process Monitoring:** Use ps, top, htop
3. **Resource Checking:** Use df, free, du
4. **Network Testing:** Use ping, curl, nslookup
5. **File Permissions:** Use ls, stat, find

### Why This Troubleshooting Approach?
- **Systematic:** Follow logical diagnostic steps
- **Resource-Focused:** Check CPU, memory, disk, network
- **Standard Tools:** Use common Linux utilities
- **Documentation:** Record findings for future reference

---

## Best Practices

### Development Best Practices
1. **Version Control:** Always commit changes to Git
2. **Documentation:** Update README files with changes
3. **Testing:** Test scripts before deployment
4. **Backup:** Create archives for important data
5. **Monitoring:** Regularly check system resources

### Security Best Practices
1. **User Safety:** Run as non-root user (already configured)
2. **Network Safety:** Use HTTPS for external connections
3. **File Safety:** Maintain proper file permissions
4. **Process Safety:** Monitor resource usage
5. **Data Safety:** Regular backups and version control

### Performance Best Practices
1. **Resource Monitoring:** Check CPU and memory usage
2. **Storage Management:** Monitor disk space
3. **Process Management:** Clean up unnecessary processes
4. **Network Optimization:** Use efficient network operations
5. **File Organization:** Maintain clean directory structure

### Why These Best Practices?
- **Reliability:** Ensures stable and reliable operation
- **Security:** Maintains secure environment
- **Performance:** Optimizes resource usage
- **Maintainability:** Keeps environment organized and manageable
- **Documentation:** Ensures knowledge is preserved

---

## Conclusion

This sandbox environment provides a **complete, isolated, and secure development platform** with:

- **High Capacity:** 1.0P storage for unlimited development
- **Full Isolation:** Complete container security and isolation
- **Modern Tools:** Complete development toolchain
- **Version Control:** Git integration with GitHub
- **Documentation:** Comprehensive analysis and reporting
- **Security:** Multi-layer security model
- **Performance:** High-performance hardware and storage

The system is designed for **reliable, secure, and scalable development** with proper isolation, comprehensive documentation, and automated backup capabilities.

---

**Document End**
*This document serves as a complete reference for understanding and using the sandbox environment effectively.*