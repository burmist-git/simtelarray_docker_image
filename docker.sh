#!/bin/bash

function docker_build_sh {
    time docker build -f Dockerfile -t simtelarray $PWD
}

function printHelp {
    echo " --> ERROR in input arguments"
    echo " -h    : print help"
    echo " -b    : create docker image"
    echo " --li  : list images"
    echo " --lc  : list containers"
}

if [ $# -eq 0 ]; then
    printHelp
else
    if [ "$1" = "-h" ]; then
	printHelp
    elif [ "$1" = "-b" ]; then
	docker_build_sh
    elif [ "$1" = "--li" ]; then
	docker images
    elif [ "$1" = "--li" ]; then
	docker images
    elif [ "$1" = "--lc" ]; then
	echo " " 
	echo "active" 
	docker ps
	echo " " 
	echo "all"
	docker ps -a
    else
        printHelp
    fi
fi
