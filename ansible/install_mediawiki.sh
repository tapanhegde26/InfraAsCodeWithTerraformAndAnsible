#!/bin/bash
HOSTNAME=`hostnamectl`
echo $HOSTNAME
operatingSystem=`awk -F 'Operating System:|LTS Kernel:' '{print $2}' <<< "$HOSTNAME"`
echo $operatingSystem
mediawikisetup(){
  cd /tmp/
  wget https://releases.wikimedia.org/mediawiki/1.36/mediawiki-1.36.1.tar.gz
  tar -xvzf /tmp/mediawiki-*.tar.gz
  sudo mkdir /var/lib/mediawiki
  sudo mv mediawiki-*/* /var/lib/mediawiki
  sudo ln -s /var/lib/mediawiki /var/www/html/mediawiki
  }
if [[ $operatingSystem == *"Ubuntu"* ]]; then
  echo "****** Linux Operating system is 'ubuntu' ******"
  sudo apt-get update -y
  sudo apt-get install wget -y
  #cd /tmp/
  #wget https://releases.wikimedia.org/mediawiki/1.36/mediawiki-1.36.1.tar.gz
  #tar -xvzf /tmp/mediawiki-*.tar.gz
  #sudo mkdir /var/lib/mediawiki
  #sudo mv mediawiki-*/* /var/lib/mediawiki
  #sudo ln -s /var/lib/mediawiki /var/www/html/mediawiki
  mediawikisetup
  sudo phpenmod mbstring
  sudo phpenmod xml
  sudo systemctl restart apache2.service

elif [[ $operatingSystem == *"Red Hat"* ]]; then
  echo "****** Linux Operating system is 'Redhat' ******"
  sudo yum install wget -y
  #cd /tmp/
  #wget https://releases.wikimedia.org/mediawiki/1.36/mediawiki-1.36.1.tar.gz
  #tar -xvzf /tmp/mediawiki-*.tar.gz
  #sudo mkdir /var/lib/mediawiki
  #sudo mv mediawiki-*/* /var/lib/mediawiki
  #sudo ln -s /var/lib/mediawiki /var/www/html/mediawiki
  mediawikisetup
  sudo restorecon -FR /var/www/html/mediawiki/
  sudo dnf install php-intl -y
elif [[ $operatingSystem == *"kali"* ]]; then
  echo "****** Linux Operating system is 'Kali' ******"
fi
