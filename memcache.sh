#!/bin/bash

# Update the system packages
sudo yum update -y

# Install Memcached
sudo yum install memcached -y

# Install libmemcached (for command-line utilities)
sudo yum install libmemcached -y

# Start Memcached service
sudo systemctl start memcached

# Enable Memcached to start on boot
sudo systemctl enable memcached

# Check the status of Memcached service
sudo systemctl status memcached

# Open Memcached default port (11211) in firewall (if firewall is enabled)
# Uncomment the following lines if you are using firewalld
# sudo firewall-cmd --permanent --add-port=11211/tcp
# sudo firewall-cmd --reload

# Verify Memcached is running and listening on the default port
netstat -plunt | grep memcached

# Optional: Adjust Memcached memory and connection limits by editing the configuration file
# Default settings are: 64MB of memory and 1024 connections
# You can modify the values in the OPTIONS line, e.g.:
# sudo sed -i 's/OPTIONS=""/OPTIONS="-m 128 -c 1024"/' /etc/sysconfig/memcached

# Restart Memcached to apply any changes
# sudo systemctl restart memcached

echo "Memcached installation and setup is complete."

