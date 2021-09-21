#!/bin/bash
HOSTNAME=`hostnamectl`
echo $HOSTNAME
operatingSystem=`awk -F 'Operating System:|LTS Kernel:' '{print $2}' <<< "$HOSTNAME"`
echo $operatingSystem
if [[ $operatingSystem == *"Ubuntu"* ]]; then
  echo "****** Linux Operating system is 'ubuntu' ******"
  sudo apt-get update -y
  sudo apt-get install wget -y
  wget https://releases.wikimedia.org/mediawiki/1.36/mediawiki-1.36.1.tar.gz
  sudo systemctl restart apache2
  sudo tar -zxpvf mediawiki-1.36.1.tar.gz
  sudo mkdir -p /var/www
  sudo mkdir -p /var/www/html
  sudo mkdir -p /var/www/html/mediawiki
  sudo cp -r  mediawiki-1.36.1 /var/www/html/mediawiki
  sudo chown -R www-data:www-data /var/www/html/mediawiki
  sudo chmod -R 777 /var/www/html/mediawiki
  sudo a2ensite /etc/apache2/sites-available/ec2user.conf
  sudo a2enmod rewrite
  sudo systemctl restart apache2
  sudo apt install php-intl -y
  sudo apt-get install -y php-mbstring
  sudo apt-get install -y php-xml
elif [[ $operatingSystem == *"Red Hat"* ]]; then
  echo "****** Linux Operating system is 'Redhat' ******"
  sudo yum install wget -y
  sudo wget https://releases.wikimedia.org/mediawiki/1.36/mediawiki-1.36.1.tar.gz
  sudo tar -zxpvf *.tar.gz
  sudo mkdir /var/www/html/mediawiki
  sudo mv mediawiki-* /var/www/html/mediawiki/
  sudo chown -R apache:apache /var/www/html/mediawiki/
  sudo chmod 755 /var/www/html/mediawiki/
  sudo restorecon -FR /var/www/html/mediawiki/
  sudo dnf install php-intl -y
elif [[ $operatingSystem == *"kali"* ]]; then
  echo "****** Linux Operating system is 'Kali' ******"
fi
