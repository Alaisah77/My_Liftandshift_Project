#!/bin/bash

# Update the system packages
sudo apt update -y
sudo apt upgrade -y

# Install Java (Tomcat requires Java)
sudo apt install -y default-jdk

# Verify Java installation
java -version

# Create a user for Tomcat
sudo useradd -m -U -d /opt/tomcat -s /bin/false tomcat

# Download the latest version of Tomcat (Adjust version as necessary)
cd /tmp
wget https://downloads.apache.org/tomcat/tomcat-10/v10.1.0/bin/apache-tomcat-10.1.0.tar.gz

# Extract Tomcat
sudo mkdir /opt/tomcat
sudo tar -xvzf apache-tomcat-10.1.0.tar.gz -C /opt/tomcat --strip-components=1

# Set permissions for the Tomcat directory
sudo chown -R tomcat: /opt/tomcat
sudo chmod -R 755 /opt/tomcat

# Create a systemd service file for Tomcat
sudo tee /etc/systemd/system/tomcat.service > /dev/null <<EOL
[Unit]
Description=Apache Tomcat Web Application Container
After=network.target

[Service]
Type=forking

User=tomcat
Group=tomcat

Environment="JAVA_HOME=/usr/lib/jvm/java-11-openjdk-amd64"
Environment="CATALINA_PID=/opt/tomcat/temp/tomcat.pid"
Environment="CATALINA_HOME=/opt/tomcat"
Environment="CATALINA_BASE=/opt/tomcat"
Environment="CATALINA_OPTS=-Xms512M -Xmx1024M -server -XX:+UseParallelGC"
Environment="JAVA_OPTS=-Djava.awt.headless=true -Djava.security.egd=file:/dev/./urandom"

ExecStart=/opt/tomcat/bin/startup.sh
ExecStop=/opt/tomcat/bin/shutdown.sh

Restart=on-failure

[Install]
WantedBy=multi-user.target
EOL

# Reload systemd to apply the changes
sudo systemctl daemon-reload

# Start and enable Tomcat
sudo systemctl start tomcat
sudo systemctl enable tomcat

# Verify Tomcat status
sudo systemctl status tomcat

# Open firewall ports (if firewall is enabled)
# Uncomment the following lines if needed
# sudo ufw allow 8080/tcp
# sudo ufw reload

echo "Tomcat installation and setup is complete."
echo "You can access Tomcat via: http://your_server_ip:8080"

