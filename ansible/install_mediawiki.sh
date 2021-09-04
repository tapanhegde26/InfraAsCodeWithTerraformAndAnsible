#!/bin/bash
sudo yum install wget -y
sudo wget https://releases.wikimedia.org/mediawiki/1.36/mediawiki-1.36.1.tar.gz
sudo tar -zxpvf *.tar.gz
sudo mkdir /var/www/html/mediawiki
sudo mv mediawiki-* /var/www/html/mediawiki/
sudo chown -R apache:apache /var/www/html/mediawiki/
sudo chmod 755 /var/www/html/mediawiki/
sudo restorecon -FR /var/www/html/mediawiki/
sudo dnf install php-intl -y

