#!/bin/bash
echo "========== SYSTEM HEALTH REPORT ==========="
date

echo
echo "=========== USER =============="
whoami

echo
echo "========== DISK USAGE ==========="
df -h

echo
echo "============ MEMORY ========="
free -h

echo
echo "=========== IP ADDRESS ============"
ip addr

echo
echo "============ RUNNING PROCESS ========="
ps aux | head 
