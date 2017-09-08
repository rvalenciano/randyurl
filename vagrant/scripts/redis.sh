cd /tmp
curl -O http://download.redis.io/redis-stable.tar.gz
tar xzvf redis-stable.tar.gz
cd redis-stable
make
make test
sudo make install
sudo mkdir /etc/redis
sudo rm -f /etc/redis/redis.conf
sudo cp /tmp/redis-stable/redis.conf /etc/redis
sudo cp -u /vagrant/scripts/redis.conf /etc/redis/redis.conf
sudo cp -u /vagrant/scripts/redis.service /etc/systemd/system/redis.service
sudo adduser --system --group --no-create-home redis
sudo mkdir /var/lib/redis
sudo chown redis:redis /var/lib/redis
sudo chmod 770 /var/lib/redis
sudo systemctl start redis
sudo systemctl status redis
echo config set stop-writes-on-bgsave-error no | redis-cli
