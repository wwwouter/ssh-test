sudo docker ps -a | tail -n +2 | awk '{print $1}' | xargs sudo docker kill
sudo docker ps -a | tail -n +2 | awk '{print $1}' | xargs sudo docker rm
echo "---"
export MASTER_ID=$(sudo docker run -p 29015:29015 -d mies/rethinkdb rethinkdb --bind all)
export MASTER_IP=$(sudo docker inspect $MASTER_ID | grep IPAddress | cut -d '"' -f 4)
echo $MASTER_ID
export MASTER_PORT=$(sudo docker port $MASTER_ID 29015)
echo $MASTER_PORT
export SLAVE_FIRST_ID=$(sudo docker run -p 29015 -d mies/rethinkdb rethinkdb --join $MASTER_IP:$MASTER_PORT --bind all)
echo $SLAVE_FIRST_ID
export SLAVE_FIRST_PORT=$(sudo docker port $SLAVE_FIRST_ID 29015)
echo $SLAVE_FIRST_PORT
export SLAVE_SECOND_ID=$(sudo docker run -p 29015 -d mies/rethinkdb rethinkdb --join $MASTER_IP:$MASTER_PORT --bind all)
echo $SLAVE_SECOND_ID
