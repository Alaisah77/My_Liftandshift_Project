#!/bin/bash

# Update the system packages
sudo yum update -y

# Install Erlang (RabbitMQ dependency)
sudo amazon-linux-extras install epel -y
sudo yum install erlang -y

# Download RabbitMQ signing key and enable RabbitMQ repo
sudo rpm --import https://packagecloud.io/rabbitmq/rabbitmq-server/gpgkey
sudo curl -o /etc/yum.repos.d/rabbitmq.repo https://packagecloud.io/rabbitmq/rabbitmq-server/rpm/el/7/x86_64/rabbitmq-server.repo

# Install RabbitMQ
sudo yum install rabbitmq-server -y

# Start the RabbitMQ service
sudo systemctl start rabbitmq-server

# Enable RabbitMQ to start on boot
sudo systemctl enable rabbitmq-server

# Check the status of RabbitMQ service
sudo systemctl status rabbitmq-server

# Enable the RabbitMQ management plugin (optional but recommended for UI access)
sudo rabbitmq-plugins enable rabbitmq_management

# Open RabbitMQ default ports in firewall (if firewall is enabled)
# RabbitMQ port 5672 and management UI port 15672
# Uncomment the following lines if you are using firewalld
# sudo firewall-cmd --permanent --add-port=5672/tcp
# sudo firewall-cmd --permanent --add-port=15672/tcp
# sudo firewall-cmd --reload

# Create a RabbitMQ admin user (replace 'admin' and 'password' with your own credentials)
sudo rabbitmqctl add_user admin password
sudo rabbitmqctl set_user_tags admin administrator
sudo rabbitmqctl set_permissions -p / admin ".*" ".*" ".*"

# Verify RabbitMQ is running and management UI is accessible on port 15672
netstat -plunt | grep beam

echo "RabbitMQ installation and setup is complete. Access the management UI at http://<server-ip>:15672/"

