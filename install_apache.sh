#!/bin/bash

sudo apt-get update -y
sudo apt-get install -y apache2
echo "Hello from Terraform Apache Server" | sudo tee /var/www/html/index.html
sudo systemctl enable apache2
sudo systemctl start apache2

