echo "update root password"
mysql -e "UPDATE mysql.user SET Password = PASSWORD('$MARIADB_ROOT_PASSWORD') WHERE User = 'root'"

echo "kill the anonymous users"
mysql -e "DROP USER ''@'localhost'"
mysql -e "DROP USER ''@'$(hostname)'"

echo "kill off the demo database"
mysql -e "DROP DATABASE test"

# echo "create $MARIADB_DATABASE"
# mysql -e "create database $MARIADB_DATABASE"
# mysql -e "create user '$MARIADB_USER'@'%' identified by '$MARIADB_USER_PASSWORD'"
# mysql -e "grant all privileges on $MARIADB_DATABASE.* to $MARIADB_USER@'%'"

echo "make our changes take effect"
mysql -e "FLUSH PRIVILEGES"