#!/bin/bash

# Update packages
sudo apt-get update

# Install Apache and PHP
sudo apt-get install -y apache2 php libapache2-mod-php

# Restart Apache to make sure PHP module is enabled
sudo service apache2 restart

echo "<?php
    echo 'Hello, Real World!';
?>" > /var/www/html/index.php

rm /var/www/html/index.html