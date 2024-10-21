#!/bin/bash

# Update the system packages
sudo yum update -y

# Install MySQL server (MariaDB is the default MySQL-compatible server in Amazon Linux 2)
sudo yum install -y mariadb-server

# Start the MySQL (MariaDB) service
sudo systemctl start mariadb

# Enable MySQL (MariaDB) to start on boot
sudo systemctl enable mariadb

# Secure MySQL installation (you will be prompted to set a root password, remove test databases, etc.)
# You can run this part interactively or modify it for automation
sudo mysql_secure_installation

# Check the status of MySQL (MariaDB) service
sudo systemctl status mariadb

# Install and start firewalld (if it's not already installed)
sudo yum install firewalld -y
sudo systemctl start firewalld
sudo systemctl enable firewalld

# Add the MariaDB port 3306 to the firewall to allow remote access
sudo firewall-cmd --permanent --add-port=3306/tcp

# Reload the firewall to apply changes
sudo firewall-cmd --reload

# Verify that port 3306 is open
sudo firewall-cmd --list-ports

# Verify MySQL is running and listening on the default port (3306)
netstat -plunt | grep mysqld

echo "MySQL (MariaDB) installation and firewall configuration is complete."
echo "You can access the database remotely through port 3306."

