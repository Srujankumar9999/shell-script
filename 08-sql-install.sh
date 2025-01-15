#!/bin/bash

# Check if the script is run as root
if [ "$(id -u)" -ne 0 ]; then
    echo "Please run this script as root or use sudo."
    exit 1
fi

# Update the package index
echo "Updating package index..."
apt update -y

# Install prerequisite packages
echo "Installing prerequisites..."
apt install -y wget gnupg

# Add MySQL APT repository
echo "Adding MySQL APT repository..."
wget https://dev.mysql.com/get/mysql-apt-config_0.8.22-1_all.deb -O mysql-apt-config.deb
dpkg -i mysql-apt-config.deb

# Update the package index again after adding MySQL repository
echo "Updating package index after adding MySQL repository..."
apt update -y

# Install MySQL server
echo "Installing MySQL server..."
apt install -y mysql-server

# Start and enable MySQL service
echo "Starting and enabling MySQL service..."
systemctl start mysql
systemctl enable mysql

# Secure MySQL installation
echo "Securing MySQL installation..."
mysql_secure_installation

# Confirm installation
echo "MySQL installation complete."
mysql --version
