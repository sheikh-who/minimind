#!/bin/bash

# Advanced System Diagnostic Tool with Subdirectory Archives
# Generates comprehensive system report and creates individual archives for each subdirectory

TIMESTAMP=$(date +"%Y%m%d_%H%M%S")
MAIN_REPORT_DIR="system_diagnostic_$TIMESTAMP"
MAIN_ZIP="complete_diagnostic_$TIMESTAMP.zip"

echo "🔍 Advanced System Diagnostic Tool Starting..."
echo "📅 Timestamp: $TIMESTAMP"
echo

# Create main report directory
mkdir -p "$MAIN_REPORT_DIR"

# Generate main system report
{
    echo "=== SYSTEM DIAGNOSTIC REPORT ==="
    echo "Generated: $(date)"
    echo "Hostname: $(hostname)"
    echo "User: $(whoami)"
    echo "Working Directory: $(pwd)"
    echo "Shell: $SHELL"
    echo
    echo "=== SYSTEM OVERVIEW ==="
    echo "Total files in current directory tree: $(find . -mindepth 1 2>/dev/null | wc -l)"
    echo "System-wide file count: $(find / -type f 2>/dev/null | wc -l) files"
    echo "Active processes: $(ls /proc/[0-9]* 2>/dev/null | wc -l)"
    echo "System memory: $(free -m | grep "Mem:" | awk '{print $2}') MB"
    echo "System load: $(cat /proc/loadavg 2>/dev/null | cut -d' ' -f1)"
    echo "Mounted filesystems: $(df -h | tail -n +2 | wc -l)"
    echo
    echo "=== WORKSPACE STRUCTURE ANALYSIS ==="
    echo "Top-level items:"
    ls -la
    echo
    echo "Subdirectories found:"
    find . -type d -maxdepth 1 -not -path '.' | sort
    echo
    echo "=== DIRECTORY BREAKDOWN ==="
    for dir in */; do
        if [ -d "$dir" ]; then
            dir_name=$(basename "$dir")
            file_count=$(find "$dir" -type f 2>/dev/null | wc -l)
            dir_size=$(du -sh "$dir" 2>/dev/null | cut -f1)
            echo "📁 $dir_name: $file_count files, $dir_size"
        fi
    done
    echo
    echo "=== FILESYSTEM STATUS ==="
    df -h
    echo
    echo "=== SYSTEM RESOURCES ==="
    free -h
    echo
    echo "=== NETWORK STATUS ==="
    echo "Listening ports: $(ss -tuln 2>/dev/null | grep LISTEN | wc -l || echo 'Unable to check')"
    echo
    echo "=== LARGE FILES (Top 10) ==="
    find . -type f -exec du -h {} + 2>/dev/null | sort -hr | head -10 || echo "No files found"
    echo
    echo "=== END OF MAIN REPORT ==="
    
} > "$MAIN_REPORT_DIR/main_system_report.txt"

# Get list of subdirectories
SUBDIRS=$(find . -maxdepth 1 -type d -not -path '.' | sed 's|^\./||' | sort)

if [ -n "$SUBDIRS" ]; then
    echo "📦 Creating individual archives for subdirectories..."
    
    # Create individual archives for each subdirectory
    for dir in $SUBDIRS; do
        if [ -d "$dir" ]; then
            echo "  📁 Archiving: $dir"
            zip -r "archive_${dir}_${TIMESTAMP}.zip" "$dir" >/dev/null 2>&1
        fi
    done
else
    echo "ℹ️  No subdirectories found to archive individually"
fi

# Create summary file
{
    echo "=== DIAGNOSTIC SUMMARY ==="
    echo "Timestamp: $TIMESTAMP"
    echo "User: $(whoami)"
    echo "Working Directory: $(pwd)"
    echo
    echo "Workspace Statistics:"
    echo "  - Total items (immediate): $(ls -A 2>/dev/null | wc -l)"
    echo "  - Total files (recursive): $(find . -type f 2>/dev/null | wc -l)"
    echo "  - Total directories: $(find . -type d 2>/dev/null | wc -l)"
    echo "  - System files: $(find / -type f 2>/dev/null | wc -l)"
    echo "  - Active processes: $(ls /proc/[0-9]* 2>/dev/null | wc -l)"
    echo "  - System memory: $(free -m | grep "Mem:" | awk '{print $2}') MB"
    echo
    echo "Subdirectories archived:"
    for dir in $SUBDIRS; do
        if [ -d "$dir" ]; then
            file_count=$(find "$dir" -type f 2>/dev/null | wc -l)
            size=$(du -sh "$dir" 2>/dev/null | cut -f1)
            archive_name="archive_${dir}_${TIMESTAMP}.zip"
            archive_size=$(ls -lh "$archive_name" 2>/dev/null | awk '{print $5}' || echo "N/A")
            echo "  📁 $dir: $file_count files, $size → $archive_name ($archive_size)"
        fi
    done
    echo
    echo "Generated Files:"
    echo "  📄 Main report: $MAIN_REPORT_DIR/main_system_report.txt"
    echo "  📦 Individual subdirectory archives: $(ls archive_*_${TIMESTAMP}.zip 2>/dev/null | wc -l) files"
    echo "  📋 Summary: $MAIN_REPORT_DIR/summary.txt"
    echo
    echo "Total workspace size: $(du -sh . 2>/dev/null | cut -f1)"
    
} > "$MAIN_REPORT_DIR/summary.txt"

# Create JSON summary for programmatic access
{
    echo "{"
    echo "  \"timestamp\": \"$TIMESTAMP\","
    echo "  \"user\": \"$(whoami)\","
    echo "  \"workspace_path\": \"$(pwd)\","
    echo "  \"total_files\": $(find . -type f 2>/dev/null | wc -l),"
    echo "  \"total_directories\": $(find . -type d 2>/dev/null | wc -l),"
    echo "  \"subdirectories\": ["
    
    first=true
    for dir in $SUBDIRS; do
        if [ -d "$dir" ]; then
            if [ "$first" = true ]; then
                first=false
            else
                echo ","
            fi
            file_count=$(find "$dir" -type f 2>/dev/null | wc -l)
            dir_size=$(du -s "$dir" 2>/dev/null | cut -f1)
            echo -n "    {\"name\": \"$dir\", \"files\": $file_count, \"size_kb\": $dir_size}"
        fi
    done
    echo
    echo "  ],"
    echo "  \"system_files\": $(find / -type f 2>/dev/null | wc -l),"
    echo "  \"processes\": $(ls /proc/[0-9]* 2>/dev/null | wc -l),"
    echo "  \"memory_mb\": $(free -m | grep "Mem:" | awk '{print $2}'),"
    echo "  \"load_average\": \"$(cat /proc/loadavg 2>/dev/null | cut -d' ' -f1)\""
    echo "}"
} > "$MAIN_REPORT_DIR/data.json"

# Create master archive with main report
zip -r "$MAIN_ZIP" "$MAIN_REPORT_DIR" >/dev/null 2>&1

echo
echo "✅ ADVANCED DIAGNOSTIC COMPLETE!"
echo
echo "📊 REPORTS CREATED:"
echo "  📄 Main Report: $MAIN_REPORT_DIR/main_system_report.txt"
echo "  📋 Summary: $MAIN_REPORT_DIR/summary.txt"  
echo "  🗃️  Data: $MAIN_REPORT_DIR/data.json"
echo
echo "📦 INDIVIDUAL SUBDIRECTORY ARCHIVES:"
if [ -n "$SUBDIRS" ]; then
    ls -lh archive_*_${TIMESTAMP}.zip 2>/dev/null | awk '{print "  📁 " $9 " (" $5 ")"}'
else
    echo "  ℹ️  No subdirectories to archive"
fi
echo
echo "📦 MASTER ARCHIVE:"
echo "  📦 $MAIN_ZIP ($(ls -lh "$MAIN_ZIP" | awk '{print $5}'))"
echo
echo "=== QUICK SUMMARY ==="
cat "$MAIN_REPORT_DIR/data.json"
echo
echo "🎯 All files ready for download!"
echo "🔄 Total archives created: $(ls archive_*_${TIMESTAMP}.zip 2>/dev/null | wc + 1) files"

# Show final file listing
echo
echo "=== FINAL FILE INVENTORY ==="
ls -la *${TIMESTAMP}* 2>/dev/null