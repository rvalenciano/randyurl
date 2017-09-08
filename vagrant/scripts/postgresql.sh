#!/bin/bash
sudo apt-get update -y  > /dev/null && sudo apt-get upgrade -y > /dev/null
sudo apt-get install postgresql-9.5 postgresql-contrib -y > /dev/null
sudo apt-get install libpq-dev -y > /dev/null
sudo -u postgres psql -c "CREATE USER randyurl_development WITH PASSWORD 'changeme';"
sudo -u postgres createdb randyurl_development
sudo -u postgres psql -c "ALTER DATABASE randyurl_development OWNER TO randyurl_development"
sudo -u postgres psql -c "CREATE USER randyurl_test WITH PASSWORD 'changeme';"
sudo -u postgres createdb randyurl_test
sudo -u postgres psql -c "ALTER DATABASE randyurl_test OWNER TO randyurl_test"
sudo -u postgres psql -c "ALTER USER randyurl_test CREATEDB;"
LINE="host all all 0.0.0.0/0 md5"
FILE=/etc/postgresql/9.5/main/pg_hba.conf
sudo grep -qF "$LINE" "$FILE" || sudo printf "$LINE" >> "$FILE"
LINE="listen_addresses = '*'"
FILE=/etc/postgresql/9.5/main/postgresql.conf
sudo grep -qF "$LINE" "$FILE" || sudo printf "$LINE" >> "$FILE"
sudo /etc/init.d/postgresql restart