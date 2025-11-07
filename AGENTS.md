# AGENTS.md - AI Agent Guide for Sandbox Environment

**Environment:** Kubernetes Container Sandbox  
**Location:** `/workspace`  
**Documentation Version:** 1.0  
**Last Updated:** 2025-11-07 09:21:42  
**Repository:** https://github.com/sheikh-who/minimind  

## Environment Overview

This is a **containerized development environment** running in Kubernetes with:
- **Operating System:** Ubuntu 20.04.6 LTS
- **Architecture:** x86_64 (Intel Xeon Platinum 8369B)
- **Memory:** 30GB (11GB used, 18GB available)
- **Storage:** 1.0P network filesystem (39TB used, 4%)
- **User:** `minimax` (non-root, secure)

## Development Environment Setup

### Workspace Navigation
- **Primary Directory:** `/workspace` (1.0P capacity)
- **Current Working Directory:** Always start commands from `/workspace`
- **Home Directory:** `/home/minimax` (minimal usage)

### Essential Commands
```bash
# Check current location and system info
pwd && whoami && hostname

# Navigate to workspace (this is your main directory)
cd /workspace

# Check workspace structure
ls -la

# Monitor system resources
free -h && df -h /workspace
```

### Available Development Tools
- **Shell:** bash (primary interface)
- **Version Control:** git with GitHub integration
- **Programming:** Python, JavaScript, Shell scripting
- **Package Managers:** pip, npm, apt (as available)
- **Build Tools:** Standard Linux build utilities
- **System Analysis:** Custom diagnostic tools

## Development Workflow

### Version Control (Git + GitHub)
```bash
# Check git status
git status

# Add files to staging
git add .

# Commit changes with descriptive message
git commit -m "[Type] Brief description of changes"

# Push to GitHub (main branch)
git push origin main

# Pull latest changes
git pull origin main
```

### Project Organization
```
/workspace/
├── .git/                     # Version control (100KB)
├── browser/                  # Browser tools (7.9KB)
├── external_api/             # API integrations (46KB)
├── deep_sandbox_scan/        # System analysis & docs
├── [your_project_files]      # Create project directories here
└── README.md                 # Project documentation
```

### Development Best Practices
1. **Always work in `/workspace` directory**
2. **Commit frequently to GitHub with descriptive messages**
3. **Test scripts before deployment**
4. **Update documentation when making changes**
5. **Use meaningful file and directory names**
6. **Monitor system resources during development**

## System Analysis and Documentation

### Available Analysis Tools
```bash
# Run comprehensive system scan
bash /workspace/deep_sandbox_scan/scripts/comprehensive_sandbox_scanner.sh

# Check workspace analysis
bash /workspace/deep_sandbox_scan/scripts/comprehensive_sandbox_scanner.sh

# View generated documentation
ls /workspace/deep_sandbox_scan/docs/

# Check current system status
ps aux | wc -l
free -h
df -h /workspace
```

### Documentation Structure
- **Main Documentation:** `/workspace/deep_sandbox_scan/docs/`
- **System Reference:** `00_complete_system_reference.md`
- **Scan Reports:** `00_scan_summary.md` + 7 detailed analysis reports
- **README Guide:** `README.md` (navigation and usage guide)

### Creating Documentation
When adding new features or making significant changes:
1. Update relevant markdown files in docs/
2. Add code examples and usage instructions
3. Include security considerations
4. Update the main README.md

## File Operations and Management

### File Creation Guidelines
- **Scripts:** Use `.sh` extension, include shebang `#!/bin/bash`
- **Documentation:** Use `.md` extension, follow markdown standards
- **Configuration:** Use `.yaml` or `.json` for structured data
- **Temporary Files:** Use `/tmp` for ephemeral data

### File Permissions
- **Scripts:** Make executable with `chmod +x script_name.sh`
- **Documentation:** Standard read permissions for all users
- **Configuration:** Restrict to appropriate access levels
- **Never use 777 permissions** (security risk)

### Workspace Management
```bash
# Check disk usage
du -sh /workspace/*

# Find large files
find /workspace -type f -size +100M

# Count files
find /workspace -type f | wc -l

# Clean temporary files
find /workspace -name "*.tmp" -delete
find /workspace -name "*.log" -delete
```

## Security and Access Control

### User Context
- **Current User:** `minimax` (non-root)
- **Permissions:** Standard user permissions
- **Security Model:** Container isolation with multi-layer security
- **Access:** Full workspace access, limited system access

### Security Guidelines
1. **Never attempt to gain root access**
2. **Use HTTPS for all external connections**
3. **Keep files in appropriate directories**
4. **Respect container boundaries**
5. **Monitor resource usage**
6. **Use proper file permissions**

### Network and Connectivity
```bash
# Test internet connectivity
ping -c 1 8.8.8.8

# Check network status
ip addr show

# Test GitHub connectivity
curl -I https://github.com

# Check DNS resolution
nslookup github.com
```

## Process and Resource Management

### Running Processes
- **Total Processes:** 398 running processes
- **Process Types:** Container runtime, system services, user applications
- **Resource Usage:** 37% CPU and memory utilization
- **Monitoring:** Standard Linux process tools available

### Process Guidelines
```bash
# Check running processes
ps aux

# Monitor resource usage
top

# Check memory usage
free -h

# Monitor disk I/O
iotop (if available)
```

### Resource Limits
- **Memory:** 30GB total (monitor usage)
- **CPU:** 16 cores (manage intensive tasks)
- **Storage:** 1.0P (plenty of space)
- **Network:** Standard container network limits

## Backup and Recovery

### Version Control Strategy
- **Primary Backup:** GitHub repository (https://github.com/sheikh-who/minimind)
- **Local Archives:** ZIP files for important data
- **Documentation:** Comprehensive system analysis reports
- **Frequency:** Commit after significant changes

### Creating Archives
```bash
# Create project archive
cd /workspace
zip -r project_backup_$(date +%Y%m%d_%H%M%S).zip [your_project_files]/

# Backup important documentation
cd /workspace/deep_sandbox_scan
zip -r docs_backup_$(date +%Y%m%d_%H%M%S).zip docs/

# Check archive contents
unzip -l archive_name.zip
```

### Recovery Procedures
1. **GitHub Recovery:** Clone repository to restore files
2. **Documentation Recovery:** Extract from backup archives
3. **System Recovery:** Re-run system analysis scripts
4. **Project Recovery:** Use version control history

## Testing and Quality Assurance

### Code Testing
```bash
# Test bash scripts
bash -n script_name.sh  # Syntax check
bash script_name.sh     # Execute with testing

# Test Python scripts
python3 -m py_compile script.py  # Syntax check
python3 script.py                 # Execute

# Test JavaScript/Node.js
node -c script.js    # Syntax check
node script.js       # Execute
```

### Quality Guidelines
1. **Test all code before deployment**
2. **Validate syntax with appropriate linters**
3. **Check file permissions after creation**
4. **Test network connectivity for external services**
5. **Verify documentation accuracy**
6. **Monitor resource usage during testing**

## Troubleshooting Common Issues

### Permission Issues
```bash
# Check file permissions
ls -l filename

# Fix script permissions
chmod +x script_name.sh

# Check user and groups
whoami
groups
```

### Network Issues
```bash
# Test connectivity
ping -c 1 google.com

# Check DNS
cat /etc/resolv.conf

# Test specific service
curl -I https://github.com
```

### Storage Issues
```bash
# Check disk space
df -h

# Check directory size
du -sh /workspace/[directory]

# Find large files
find /workspace -type f -size +1G
```

### Process Issues
```bash
# Check process list
ps aux | grep [process_name]

# Kill problematic processes (use with care)
kill -9 [PID]

# Check system load
uptime
```

## Performance Optimization

### Development Efficiency
- **Use short, descriptive names** for files and directories
- **Organize projects in subdirectories** of `/workspace`
- **Leverage the 1.0P storage** for large projects
- **Use Git for version control** instead of file copies
- **Create automated scripts** for repetitive tasks

### Resource Management
- **Monitor memory usage** during intensive operations
- **Clean temporary files** regularly
- **Use efficient file formats** (JSON over XML when possible)
- **Optimize network operations** by batching requests
- **Cache results** when appropriate

## Communication and Collaboration

### Agent-to-Agent Communication
- **Use descriptive commit messages** for change tracking
- **Update documentation** to reflect current state
- **Create test cases** for complex functionality
- **Use consistent coding standards** across projects
- **Document assumptions** and dependencies

### External Communication
- **Use HTTPS** for all external API calls
- **Handle timeouts gracefully** in network operations
- **Implement proper error handling** for failures
- **Log important events** for debugging
- **Respect rate limits** on external services

## Environment-Specific Notes

### Container Characteristics
- **Kubernetes Pod:** Runs in containerized environment
- **Network Storage:** 1.0P network filesystem access
- **Virtual Hardware:** Intel Xeon processor, 30GB RAM
- **Isolated Environment:** Complete container isolation

### Unique Capabilities
- **Massive Storage:** 1.0P workspace capacity
- **High Performance:** Modern processor and ample memory
- **Stable Environment:** 7+ weeks uptime
- **Full Development:** Complete programming environment
- **External Access:** Internet connectivity for development

### Limitations
- **Non-root User:** Cannot modify system-level configurations
- **Container Boundaries:** Cannot access host system directly
- **Network Dependencies:** External services require internet access
- **Resource Limits:** CPU, memory, and network limits apply

## Getting Started Checklist

For new AI agents working in this environment:

- [ ] **Navigate to workspace:** `cd /workspace`
- [ ] **Check system status:** `uname -a && free -h && df -h`
- [ ] **Review project structure:** `ls -la`
- [ ] **Check Git status:** `git status`
- [ ] **Read documentation:** `ls /workspace/deep_sandbox_scan/docs/`
- [ ] **Set up development environment** (if needed)
- [ ] **Test connectivity:** `ping -c 1 8.8.8.8`
- [ ] **Create project directory** (if starting new project)
- [ ] **Commit initial work** to version control

## Emergency Contacts and Resources

### Internal Resources
- **System Documentation:** `/workspace/deep_sandbox_scan/docs/`
- **Diagnostic Tools:** `/workspace/deep_sandbox_scan/scripts/`
- **GitHub Repository:** https://github.com/sheikh-who/minimind
- **System Scan Script:** `comprehensive_sandbox_scanner.sh`

### External Resources
- **Ubuntu 20.04 Documentation:** https://ubuntu.com/server/docs
- **Git Documentation:** https://git-scm.com/docs
- **Bash Scripting Guide:** Standard Linux bash documentation
- **Kubernetes Documentation:** https://kubernetes.io/docs/

---

**Remember:** This environment is designed for **secure, isolated development** with **unlimited storage potential**. Use the available tools, follow best practices, and maintain security boundaries while leveraging the high-performance capabilities for your projects.

**For questions or issues:** Review the comprehensive documentation in `/workspace/deep_sandbox_scan/docs/` or check the system analysis reports for current environment status.