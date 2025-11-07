# Filesystem Structure Analysis

## Root Directory Structure Analysis

### Primary System Directories
The sandbox environment uses a containerized Linux filesystem with the following key directories:

#### Core System Directories
- `/proc` - Virtual filesystem for process and system information
- `/sys` - Virtual filesystem for hardware device information  
- `/dev` - Device files for hardware devices
- `/etc` - System configuration files
- `/usr` - User programs and libraries
- `/var` - Variable data (logs, caches, temporary files)
- `/tmp` - Temporary files
- `/opt` - Optional/additional software
- `/home` - User home directories
- `/root` - Root user home directory

#### Workspace-Specific Directories
- `/workspace` - Primary working directory (1.0P capacity, 4% used)
- `/workspace/.git` - Git version control
- `/workspace/browser` - Browser-related files
- `/workspace/external_api` - External API integrations

## Detailed Directory Analysis

### Root Directory Permissions and Structure
```
/                       (root directory)
/workspace             (main working directory - 1.0P storage)
/proc                  (virtual filesystem - 39K entries)
/sys                   (system information - 4.5M entries)
/dev                   (device files - 4.4K entries)
/etc                   (configuration - 2.8K entries)
/usr                   (user programs - 1.5M entries)
/var                   (variable data - 2.4K entries)
/tmp                   (temporary files - 2.6K entries)
/opt                   (optional software - 0 files in this container)
/home                  (user homes - 0 files in this container)
/root                  (root home - 18 files)
```

## Workspace Deep Analysis

### Current Workspace Structure
Based on previous analysis, the workspace contains:

- **Total Size:** 39T used out of 1.0P capacity
- **Total Files:** 134,702 system-wide files
- **Workspace Files:** 30 files (from GitHub backup)
- **Key Subdirectories:** 
  - `.git/` - Version control data
  - `browser/` - Browser-related tools
  - `external_api/` - API integrations
  - `deep_sandbox_scan/` - Current scan documentation

### Mount Points and Storage
- **Main Filesystem:** overlay (492G total, 233G used, 50%)
- **Workspace Mount:** alinas-ap-rhh1p1jl15.13bec248f04-ser25.us-east-1.tls.127.0.1.39-qZs8hMwv (1.0P, 39T used)
- **Temporary Storage:** tmpfs (64M to 16G various mounts)

## Filesystem Characteristics

### Container Environment
- **Type:** Kubernetes pod container
- **Hypervisor:** KVM (Intel Xeon Platinum 8369B)
- **Memory:** 30GB total, 11GB used
- **CPU:** 16 cores, Intel Xeon Platinum
- **Uptime:** 7 weeks, 5 days, 19 hours, 1 minute
- **Architecture:** x86_64

### Security and Isolation
- **User:** minimax (non-root)
- **Container:** Isolated filesystem with overlay mounting
- **Cgroup:** Memory and CPU limits applied
- **Network:** Virtual network interface via Kubernetes

This filesystem analysis shows a well-structured container environment with sufficient storage (1.0P workspace capacity) and proper isolation for sandbox operations.