#!/bin/bash

### ==== VARIABEL SETUP ====
FOLDER_NAME="dbo_25"
DB_NAME="dbo_2_db_baru_db"
DB_USER="DBOmkt25"
DB_PASS="DBO2025okebaiknotedgas"
DB_HOST="localhost"  # ganti kalau pake RDS
WP_URL="https://wordpress.org/latest.tar.gz"

echo "Tak pernah ucap hello, pergi kau melambai," 

### ==== DOWNLOAD & EXTRACT ====
cd /var/www/html || exit
wget $WP_URL -O latest.tar.gz
tar -xzf latest.tar.gz
mv wordpress "$FOLDER_NAME"
rm latest.tar.gz

### ==== SETUP DATABASE ====
echo "hawimau 🐅 hawimau 🐅 hawimau 🐅 DB"
mysql -u root -p <<MYSQL_EOF
CREATE DATABASE $DB_NAME;
CREATE USER '$DB_USER'@'%' IDENTIFIED BY '$DB_PASS';
GRANT ALL PRIVILEGES ON $DB_NAME.* TO '$DB_USER'@'%';
FLUSH PRIVILEGES;
MYSQL_EOF

### ==== KONFIGURASI wp-config.php ====
cd "$FOLDER_NAME" || exit
cp wp-config-sample.php wp-config.php

sed -i "s/database_name_here/$DB_NAME/" wp-config.php
sed -i "s/username_here/$DB_USER/" wp-config.php
sed -i "s/password_here/$DB_PASS/" wp-config.php
sed -i "s/localhost/$DB_HOST/" wp-config.php

### ==== IZIN FILE ====
chown -R www-data:www-data /var/www/html/$FOLDER_NAME
chmod -R 755 /var/www/html/$FOLDER_NAME
echo "Tak pernah hancur hati, otaknya bersepai"
echo "✅ DONE! hawimau 🐅 hawimau 🐅 hawimau 🐅  mlaya: http://beta.dbo.id/$FOLDER_NAME/"
