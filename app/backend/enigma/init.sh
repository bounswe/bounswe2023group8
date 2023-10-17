#!/bin/bash

# shellcheck disable=SC2046
export $(xargs <.env)

# initialize mysql/init.sql
mkdir -p mysql
mkdir -p mysql/clean
echo "CREATE USER '$MYSQL_USER'@'%' IDENTIFIED BY '$MYSQL_PASSWORD';" > mysql/clean/init.sql
echo "GRANT ALL PRIVILEGES ON $MYSQL_DATABASE.* TO '$MYSQL_USER'@'%';" >> mysql/clean/init.sql
echo "FLUSH PRIVILEGES;" >> mysql/clean/init.sql
