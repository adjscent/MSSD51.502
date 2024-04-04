#!/bin/bash

# Update packages
sudo apt-get update

# Install Apache and PHP
sudo apt-get install -y net-tools apache2 php libapache2-mod-php

# Restart Apache to make sure PHP module is enabled
sudo service apache2 restart

echo "<?php
    echo 'Hello, Fake World!';
?>" > /var/www/html/index.php

rm /var/www/html/index.html


ifconfig ens37 128.199.102.112/24