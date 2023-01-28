#!/bin/bash

########################################################## functions
container_running() {
    containerCount=$(echo ${ROOTPWD} | sudo -S docker ps -a | grep $1 | grep -v "grep" | wc -l)
    if [ "$containerCount" != 0 ]; then
        echo "please remove container $1 and try again"
        return 1
    fi

    return 0
}

build_image() {
    echo ${ROOTPWD} | sudo -S docker build -t "$1" .

    if [ $? -eq 0 ]; then
        echo build docker image "$1" successfully
    else
        echo build docker image "$1" fail
        exit 1
    fi

}

# configure docker run cmd every time you want to run
run_container() {
    echo ${ROOTPWD} | sudo -S docker run -dp 82:80 --restart=always --name "$1" "$2"
}
########################################################## functions

########################################################## vars
# running sudo needs root password
ROOTPWD="wc123456"
# name image going to build
IMAGE_NAME="frontend"
CONTAINER_NAME="frontend"

########################################################## vars

build_image "$IMAGE_NAME"

# test if containers already exists

RT=0

container_running "$IMAGE_NAME"

RT=$(($RT || $?))

if [ $RT -eq 1 ]; then
    echo exit with 1
    exit 1
fi

run_container $IMAGE_NAME $CONTAINER_NAME

echo exit with 0
