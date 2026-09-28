# Linux System Health Monitor

## About This Project

This is my beginner Linux system administration project built using CentOS Stream 9.

I created a Bash script that automatically checks basic information about my Linux system.

The purpose of this project was not only to build the script, but also to practise Linux commands, Bash scripting, permissions, networking, SSH, Git, GitHub, VirtualBox networking, port forwarding, and troubleshooting.

---

# Project Structure

```text
linux-system-health-monitor/
├── monitor.sh
└── README.md
```

`monitor.sh` contains the Bash automation script.

`README.md` contains my project documentation and learning notes.

---

# 1. Creating the Project Directory

I created a directory for the project:

```bash
mkdir linux_monitor
```

Then entered the directory:

```bash
cd linux_monitor
```

Check the current directory:

```bash
pwd
```

List files:

```bash
ls
```

Detailed file information:

```bash
ls -l
```

---

# 2. Creating the Bash Script

I created the script:

```bash
cat > monitor.sh
```

Then added:

```bash
#!/bin/bash

echo "===== SYSTEM HEALTH REPORT ====="
date

echo
echo "===== USER ====="
whoami

echo
echo "===== DISK USAGE ====="
df -h

echo
echo "===== MEMORY ====="
free -h

echo
echo "===== IP ADDRESS ====="
ip addr

echo
echo "===== RUNNING PROCESSES ====="
ps aux | head
```

I used:

```text
Ctrl + D
```

to finish writing the file.

---

# 3. Understanding the Shebang

```bash
#!/bin/bash
```

`#!` is called the **shebang**.

It tells Linux which interpreter should execute the script.

```text
/bin/bash
```

means use the Bash program located at `/bin/bash`.

Simple meaning:

```text
#!/bin/bash = Run this script using Bash
```

---

# 4. Making the Script Executable

I checked the permissions:

```bash
ls -l monitor.sh
```

Then made the script executable:

```bash
chmod +x monitor.sh
```

`chmod` changes file permissions.

`+x` adds execute permission.

---

# 5. Running the Script

I ran the script using:

```bash
./monitor.sh
```

`.` means the current directory.

Therefore:

```text
./monitor.sh
```

means:

```text
Run monitor.sh from the current directory.
```

---

# 6. Commands Used by the Script

## date

```bash
date
```

Displays the current date and time.

---

## whoami

```bash
whoami
```

Displays the current logged-in user.

---

## df -h

```bash
df -h
```

Displays disk usage.

`df` = disk filesystem information.

`-h` = human-readable format.

---

## free -h

```bash
free -h
```

Displays RAM and memory usage.

`-h` makes the output easier to read.

---

## ip addr

```bash
ip addr
```

Displays network interfaces and IP addresses.

This command helped me find the IP address of my CentOS virtual machine.

---

## ps aux

```bash
ps aux
```

Displays running processes.

My script uses:

```bash
ps aux | head
```

`head` displays only the first few lines.

---

# 7. Learning Linux Pipes

The pipe symbol is:

```text
|
```

A pipe sends the output of one command into another command.

Example:

```bash
ps aux | head
```

Flow:

```text
ps aux
   |
   v
 head
   |
   v
first few processes
```

---

# 8. Output Redirection

I learned how to redirect command output into files.

## Overwrite a file

```bash
date > record.log
```

`>` writes output into the file and replaces existing content.

---

## Append to a file

```bash
date >> record.log
```

`>>` adds output to the end of the existing file.

---

## Save the system report

```bash
./monitor.sh > system_report.log
```

Append another report:

```bash
./monitor.sh >> system_report.log
```

---

# 9. Standard Output and Error Output

Linux uses:

```text
1 = stdout = normal output
2 = stderr = error output
```

Example:

```bash
df -h 2>&1
```

`2>&1` means:

```text
Send stderr (2) to the same destination as stdout (1).
```

---

# 10. Using tee

I learned how to display output on the terminal while also saving it into a file.

```bash
./monitor.sh | tee system_report.log
```

Flow:

```text
monitor.sh
     |
     v
    tee
   /   \
  v     v
screen  system_report.log
```

Append instead of overwrite:

```bash
./monitor.sh | tee -a system_report.log
```

---

# 11. Troubleshooting

During this project I encountered:

```text
Text file busy
```

I learned to investigate which process was using the file:

```bash
fuser monitor.sh
```

I could also use:

```bash
fuser -v monitor.sh
```

I learned that Linux troubleshooting normally follows this process:

```text
Problem
   ↓
Read the error
   ↓
Gather information
   ↓
Find the cause
   ↓
Apply a fix
   ↓
Test again
```

Useful troubleshooting commands I practised:

```bash
pwd
ls
ls -l
cat monitor.sh
fuser monitor.sh
bash monitor.sh
bash -x monitor.sh
```

`bash -x` is useful for debugging a Bash script:

```bash
bash -x monitor.sh
```

It shows commands as Bash executes them.

---

# 12. SSH Remote Access

I configured SSH so I could control my CentOS virtual machine from Windows PowerShell.

I checked the SSH service using:

```bash
sudo systemctl status sshd
```

The important result was:

```text
Active: active (running)
```

I enabled and started SSH using:

```bash
sudo systemctl enable --now sshd
```

---

# 13. VirtualBox Networking

My CentOS virtual machine was using VirtualBox NAT networking.

The CentOS VM had an address similar to:

```text
10.0.2.15
```

I found it using:

```bash
ip addr
```

Because VirtualBox NAT does not normally allow the Windows host to directly SSH to the guest using this address, I configured port forwarding.

---

# 14. VirtualBox SSH Port Forwarding

I configured:

```text
Name:       SSH
Protocol:   TCP
Host IP:    127.0.0.1
Host Port:  2222
Guest IP:   10.0.2.15
Guest Port: 22
```

The connection works like this:

```text
Windows
127.0.0.1:2222
       |
       v
VirtualBox NAT
       |
       v
CentOS VM
10.0.2.15:22
       |
       v
SSH Server
```

---

# 15. Connecting with SSH

From Windows PowerShell I connected using:

```powershell
ssh -p 2222 tonyluu29@127.0.0.1
```

After entering my CentOS password, I could remotely control the Linux VM from Windows PowerShell.

This taught me how SSH is used for remote Linux administration.

---

# 16. Learning Git

I installed/configured Git and configured my identity:

```bash
git config --global user.name "Tony Luu"
```

```bash
git config --global user.email "MY_GITHUB_EMAIL"
```

I can check the configuration using:

```bash
git config --list
```

---

# 17. Creating the Git Repository

Inside my project directory:

```bash
git init
```

This created a local Git repository.

I renamed the branch to `main`:

```bash
git branch -M main
```

Check Git status:

```bash
git status
```

---

# 18. Adding the Project to Git

I added the Bash script:

```bash
git add monitor.sh
```

Then checked:

```bash
git status
```

I created my first commit:

```bash
git commit -m "Add Linux system health monitor"
```

A commit represents a saved version of my project.

---

# 19. Connecting Git to GitHub

I created a GitHub repository named:

```text
linux-system-health-monitor
```

Then connected my local repository to GitHub:

```bash
git remote add origin https://github.com/USERNAME/linux-system-health-monitor.git
```

Check the remote:

```bash
git remote -v
```

---

# 20. Uploading the Project to GitHub

I pushed the project using:

```bash
git push -u origin main
```

After the first push, future updates can normally be uploaded using:

```bash
git push
```

---

# 21. Updating My Project in the Future

When I change `monitor.sh` or `README.md`, my basic Git workflow is:

```bash
git status
git add .
git commit -m "Describe my changes"
git push
```

The workflow is:

```text
Edit files
   ↓
git status
   ↓
git add
   ↓
git commit
   ↓
git push
   ↓
GitHub
```

---

# Skills Practised

Through this project I practised:

- Linux command-line usage
- Linux filesystem navigation
- Bash scripting
- File permissions
- Shell script execution
- Standard output and standard error
- Output redirection
- Pipes
- `tee`
- Disk monitoring
- Memory monitoring
- Process monitoring
- Linux networking
- SSH
- Linux services with `systemctl`
- VirtualBox
- NAT networking
- Port forwarding
- Linux troubleshooting
- Git
- GitHub
- Remote Linux administration

---

# What I Learned

This project helped me understand how individual Linux concepts work together.

I started with basic commands such as:

```bash
date
df -h
free -h
ip addr
whoami
```

Then I combined those commands into a Bash script.

I made the script executable, ran it, saved its output into log files, troubleshot errors, remotely connected to my Linux VM using SSH, configured VirtualBox networking, and finally used Git and GitHub to publish the project.

The biggest lesson from this project was that Linux administration is not only about memorising commands. It is about understanding how to combine commands to troubleshoot problems and automate repetitive tasks.

---

# Future Improvements

I plan to improve this project by learning how to add:

- CPU usage monitoring
- Disk usage warnings
- Network connectivity tests
- Service monitoring
- Automatic timestamps
- Better log files
- Bash variables
- `if` statements
- loops
- functions
- scheduled execution using `cron`
- alerts when disk or memory usage becomes too high

---

# Author

Tony Luu

Learning Linux, networking, system administration and cloud infrastructure.
