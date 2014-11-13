#!/bin/sh

echo "Starting developer workstation environment ...."
echo "Starting developer workstation environment" > workstation.log

cd ./mongodb
./start_image >> ../workstation.log 2>&1 &

cd ../mysql
./start_image >> ../workstation.log 2>&1 &

cd ../redis
./start_image >> ../workstation.log 2>&1 &

sleep 5
sudo docker ps | tail -3 | cut -f1 -d" " > containers.id
for i in `cat containers.id`
do
  sudo docker inspect $i | grep -i "image.*backend" > /tmp/docker.image
  sudo docker inspect $i | grep -i IPAddress         > /tmp/docker.ip
  echo "Container\t$i\t`cat /tmp/docker.image`\t`cat /tmp/docker.ip`"
done

