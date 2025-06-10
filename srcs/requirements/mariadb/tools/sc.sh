#!/bin/bash

chown -R mysql:mysql /var/lib/mysql

mysql_install_db --user=mysql --datadir=/var/lib/mysql >> /dev/null
/usr/bin/mysqld_safe --datadir=/var/lib/mysql &

while true; do
    if /usr/bin/mysqladmin ping --silent; then
        echo "MySQL is online"
        break
    fi
    sleep 1
done

mysql -u root -p${SQL_ROOT_PASSWORD} <<EOSQL
ALTER USER 'root'@'localhost' IDENTIFIED BY '${SQL_ROOT_PASSWORD}';
EOSQL

if [ -n "$SQL_DATABASE" ]; then
    echo "Checking if $SQL_DATABASE already exists"
    mysql -u root -e "CREATE DATABASE IF NOT EXISTS $SQL_DATABASE;"
    if [ -n "$SQL_USER" ] && [ -n "$SQL_PASSWORD" ]; then
        echo "Checking if $SQL_USER already exists..."
        mysql -u root -e "CREATE USER IF NOT EXISTS \`${SQL_USER}\`@'%' IDENTIFIED BY '${SQL_PASSWORD}';"
        echo "Granting privileges to $SQL_USER on $SQL_DATABASE"
        mysql -u root -e "GRANT ALL PRIVILEGES ON \`${SQL_DATABASE}\`.* TO '${SQL_USER}'@'%' IDENTIFIED BY '${SQL_PASSWORD}';"
        echo "Flushing privileges..."
        mysql -u root -e "FLUSH PRIVILEGES;"
    fi
fi

wait