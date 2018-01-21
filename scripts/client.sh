#!/bin/bash

REGISTRY=10.11.53.33:$1

# Autorise docker à se connecter sans certificat valide
sudo echo "{ \"insecure-registries\" : [\"$REGISTRY\"]}" > /etc/docker/daemon.json

# Restart docker
sudo service docker restart
