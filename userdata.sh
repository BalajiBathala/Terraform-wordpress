#!/bin/bash
# Install Apache and start the service
sudo yum update -y
sudo yum install -y httpd
sudo systemctl start httpd
sudo systemctl enable httpd

# Install MySQL client
sudo yum install -y mysql

# Install PHP and required extensions
sudo amazon-linux-extras enable php7.2
sudo yum install -y php php-mysqlnd

# Download and configure WordPress
cd /var/www/html
sudo wget https://wordpress.org/latest.zip
sudo yum install -y unzip
sudo unzip latest.zip
sudo mv wordpress/* .
sudo rm -rf wordpress latest.zip
sudo mv wp-config-sample.php wp-config.php

# Configure wp-config.php
sudo sed -i "s/database_name_here/wordpress/" wp-config.php
sudo sed -i "s/username_here/balaji/" wp-config.php
sudo sed -i "s/password_here/balajibalu/" wp-config.php
sudo sed -i "s/localhost/wordpress.cfm4i0ssctrk.us-east-2.rds.amazonaws.com/" wp-config.php

# File permissions
sudo chown -R apache:apache /var/www/html
sudo chmod -R 755 /var/www/html

# Restart Apache to apply changes
sudo systemctl restart httpd

