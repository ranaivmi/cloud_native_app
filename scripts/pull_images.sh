#!/bin/bash

# Pulling the images on our registry
for i in  web i b p s w w1 w2 db
do
    docker pull 10.11.53.33:5000/cloudnativeapp_$i
    docker tag 10.11.53.33:5000/cloudnativeapp_$i cloudnativeapp_$i
done

