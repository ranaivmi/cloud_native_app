#!/bin/bash

# Script to run the CNA as docker services on swarm

# Start vizualizer on port 8080
docker ps | grep visualizer
if [ $? -ne 0]
then
    docker run -it -d -p 8080:8080 -e HOST=$(docker-machine ls | head -2 | grep -v NAME | awk '{print $5}' | sed 's#tcp://##' | sed 's#:2376##') \
        -e PORT=8080 -v /var/run/docker.sock:/var/run/docker.sock --name visualizer  manomarks/visualizer
fi

# Check if the overlay network is available
docker network list | grep cnalan
if [ $? -ne 0 ]
then
    docker network create --driver overlay cnalan
fi

docker service create --name rabbit --publish 15672:15672 \
    --env RABBITMQ_DEFAULT_USER=stackrabbit \
    --env  RABBITMQ_DEFAULT_PASS=password \
    --network cnalan rabbitmq:3-management

docker service create --name redis --network cnalan redis

docker service create --name mariadb --network cnalan \
    --env MYSQL_ROOT_PASSWORD=toto \
    --env MYSQL_DATABASE=prestashop \
    --env MYSQL_USER=prestashop \
    --env MYSQL_PASSWORD=prestashop1234 mariadb  # need to manage dump

docker service create --name web --network cnalan --publish 80:80 \
    uggla/cloudnativeapp_web

docker service create --name i --network cnalan \
    uggla/cloudnativeapp_i

docker service create --name s --network cnalan \
    uggla/cloudnativeapp_s

docker service create --name b --network cnalan \
    uggla/cloudnativeapp_b

docker service create --name p --network cnalan \
    uggla/cloudnativeapp_p

docker service create --name w --network cnalan \
    uggla/cloudnativeapp_w

docker service create --name w1 --network cnalan \
    uggla/cloudnativeapp_w1

docker service create --name w2 --network cnalan \
    --env W2_APIKEY=blakey \
    --env W2_TO=machin@bidule.com \
    --env W2_DOMAIN=domain \
    uggla/cloudnativeapp_w2

