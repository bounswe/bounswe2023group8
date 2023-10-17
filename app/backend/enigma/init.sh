#!/bin/bash

# shellcheck disable=SC2046
export $(xargs <.env)

# initialize mysql/init.sql
mkdir mysql
echo "CREATE USER '$MYSQL_USER'@'%' IDENTIFIED BY '$MYSQL_PASSWORD';" > mysql/init.sql
echo "GRANT ALL PRIVILEGES ON $MYSQL_DATABASE.* TO '$MYSQL_USER'@'%';" >> mysql/init.sql
echo "FLUSH PRIVILEGES;" >> mysql/init.sql
