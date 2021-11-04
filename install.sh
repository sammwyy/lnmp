#!/bin/bash
###########################
#          Nginx          #
###########################
# 1.1 Update the package sources.
sudo apt update
# 1.2 Install or upgrade nginx.
sudo apt install -y nginx
sudo apt upgrade

###########################
#         MariaDB         #
###########################
# 2.1 Install MariaDB Server
sudo apt install -y mariadb-server

###########################
#           PHP           #
###########################
# 3.1 Install FMP (PHP Preprocessor)
sudo apt install -y php-fpm
# 3.2 Install PHP MySQL Addon
sudo apt install -y php-mysql

###########################
#          Setup          #
###########################
# 4.1 Setup Nginx to use PHP
echo "server {"                                            > /etc/nginx/sites-available/default
echo "   listen 80 default_server;"                       >> /etc/nginx/sites-available/default
echo "   listen [::]:80 default_server;"                  >> /etc/nginx/sites-available/default
echo " "                                                  >> /etc/nginx/sites-available/default
echo "   root /var/www/html;"                             >> /etc/nginx/sites-available/default
echo "   index index.php index.html index.htm;"           >> /etc/nginx/sites-available/default
echo " "                                                  >> /etc/nginx/sites-available/default
echo "   location / {"                                    >> /etc/nginx/sites-available/default
echo "       try_files \$uri \$uri/ =404;"                >> /etc/nginx/sites-available/default
echo "   }"                                               >> /etc/nginx/sites-available/default
echo " "                                                  >> /etc/nginx/sites-available/default
echo "   location ~ \\.php\$ {"                           >> /etc/nginx/sites-available/default
echo "       include snippets/fastcgi-php.conf;"          >> /etc/nginx/sites-available/default
echo "       fastcgi_pass unix:/run/php/php7.3-fpm.sock;" >> /etc/nginx/sites-available/default
echo "   }"                                               >> /etc/nginx/sites-available/default
echo " "                                                  >> /etc/nginx/sites-available/default
echo "   location ~ /\\.ht {"                             >> /etc/nginx/sites-available/default
echo "       deny all;"                                   >> /etc/nginx/sites-available/default
echo "   }"                                               >> /etc/nginx/sites-available/default
echo "}"                                                  >> /etc/nginx/sites-available/default
# 4.2 Setup example page
wget https://github.com/sammwyy/lnmp/raw/main/index.php -O /var/www/html/index.php

###########################
#         Restart         #
###########################
sudo systemctl reload nginx
