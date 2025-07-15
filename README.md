# 📊 Beginner DevOps Project: Basic System Monitoring with Netdata

## 🎯 Project Goal
Learn the fundamentals of system monitoring by setting up and customizing **Netdata**, a real-time performance and health monitoring tool.

You’ll:
- Install Netdata on a Linux (Ubuntu) server (AWS EC2)
- Monitor key system metrics
- Customize the dashboard
- Create alerts
- Automate setup with shell scripts

---

## 💡 Prerequisites
- Ubuntu EC2 instance (AWS)
- SSH access to the instance
- Open port **19999** in your AWS security group (Netdata’s default port)

---

## 🔧 Step-by-Step Setup

### ✅ Step 1: Launch EC2 Instance (Ubuntu)
- Instance type: t2.micro (Free Tier)
- AMI: Ubuntu Server 22.04/24.04 LTS
- Security Group Inbound Rules:
  - `22` – SSH
  - `19999` – Netdata Dashboard

SSH into your server:
```bash
ssh -i ~/Downloads/private-key.pem ubuntu@<EC2_PUBLIC_IP>
✅ Step 2: Install Netdata
Run the following command:

bash
Copy
Edit
bash <(curl -Ss https://registry.my-netdata.io/kickstart-static64.sh)
This installs Netdata (static build), starts the agent, and enables it as a service.

✅ Step 3: Access Dashboard
Visit:

cpp
Copy
Edit
http://<EC2_PUBLIC_IP>:19999
You’ll see a real-time monitoring dashboard for:

CPU Usage

Memory

Disk I/O

Network traffic

System health indicators

✅ Step 4: Customize the Dashboard
You can customize Netdata charts using config files.

Example: Hide a chart or change a label

bash
Copy
Edit
sudo nano /etc/netdata/netdata.conf
Look for sections like:

ini
Copy
Edit
[plugin:proc]
    enabled = yes
Restart Netdata:

bash
Copy
Edit
sudo /opt/netdata/bin/netdatacli reload-health
✅ Step 5: Add an Alert (e.g., CPU > 80%)
Navigate to:

bash
Copy
Edit
cd /opt/netdata/etc/netdata/health.d/
Create a new alert file:

bash
Copy
Edit
sudo nano custom_cpu_usage.conf
Paste this example:

ini
Copy
Edit
alarm: high_cpu_usage
on: system.cpu
lookup: average -1m unaligned of user + system
units: %
every: 10s
warn: $this > 80
crit: $this > 90
info: CPU usage is too high.
to: sysadmin
Reload Netdata config:

bash
Copy
Edit
sudo /opt/netdata/bin/netdatacli reload-health
🤖 Step 6: Automation Scripts
🔧 setup.sh
bash
Copy
Edit
#!/bin/bash

# Install Netdata
bash <(curl -Ss https://registry.my-netdata.io/kickstart-static64.sh)

# Open port 19999 if using ufw
# sudo ufw allow 19999
🔧 test_dashboard.sh
bash
Copy
Edit
#!/bin/bash

# Generate CPU Load
echo "Generating CPU load for 60 seconds..."
stress --cpu 2 --timeout 60

# You may need to install stress
# sudo apt update && sudo apt install -y stress
🔧 cleanup.sh
bash
Copy
Edit
#!/bin/bash

echo "Stopping and removing Netdata..."
sudo pkill netdata
sudo rm -rf /opt/netdata
Make them executable:

bash
Copy
Edit
chmod +x setup.sh test_dashboard.sh cleanup.sh




<img width="1440" height="900" alt="Screenshot 2025-07-15 at 6 28 19 PM" src="https://github.com/user-attachments/assets/811b2b05-ecff-4995-9cf7-cb22260855c6" />
