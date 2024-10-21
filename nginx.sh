#!/bin/bash

# Update the system packages
sudo apt update -y
sudo apt upgrade -y

# Install Nginx
sudo apt install -y nginx

# Start the Nginx service
sudo systemctl start nginx

# Enable Nginx to start on boot
sudo systemctl enable nginx

# Check the status of Nginx service
sudo systemctl status nginx

# Open the HTTP (port 80) and HTTPS (port 443) ports in the firewall (if UFW is enabled)
sudo ufw allow 'Nginx Full'

# Verify Nginx is running by checking if it is listening on port 80
sudo netstat -tulnp | grep nginx

# Optional: Test Nginx configuration to ensure there are no errors
sudo nginx -t

# Optional: Restart Nginx to apply any changes
sudo systemctl restart nginx

# Display the public IP address of the server
echo "Nginx is installed and running. You can access it via: http://$(curl -s ifconfig.me)"

echo "Nginx installation and

