#!/bin/sh
sudo apt-get update -y
sudo apt-get install wget -y
wget https://releases.wikimedia.org/mediawiki/1.36/mediawiki-1.36.1.tar.gz
sudo systemctl restart apache2
sudo tar -zxpvf mediawiki-1.36.1.tar.gz
sudo mkdir -p /var/www
sudo mkdir -p /var/www/html
sudo mkdir -p /var/www/html/mediawiki
sudo mv mediawiki-1.36.1 /var/www/html/mediawiki
sudo chown -R www-data:www-data /var/www/html/mediawiki
sudo chmod -R 777 /var/www/html/mediawiki
#sudo a2ensite /etc/apache2/sites-available/mediawiki.conf
#sudo a2enmod rewrite
sudo systemctl restart apache2
sudo apt install php-intl -y
sudo apt-get install -y php-mbstring
sudo apt-get install -y php-xml
