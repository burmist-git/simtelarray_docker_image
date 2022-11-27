#!/bin/bash

function docker_build_sh {
    time docker build -f Dockerfile -t simtelarray $PWD
}

function simtelarray_build_sif {
    time singularity build simtelarray.sif docker-daemon://simtelarray:latest
}

function singularity_run_simtelarray {
    singularity run -B /home/burmist/home2/work/CTA/corsika_reader_my/tmp/data/:/store/cta/cta03/ simtelarray.sif /run_simtelarray/run_simtelarray.sh -test_sim_telarray
}

function clean {
    rm -rf simple_test_sim_telarray.log
    rm -rf telarray_rand.conf.used*
}

function printHelp {
    echo " --> ERROR in input arguments"
    echo " -h        : print help"
    echo " -b        : create docker image"
    echo " -s        : singularity .sif file"
    echo " -c        : clean"
    echo " -rungamma : singularity run gamma"
    echo " --li      : list images"
    echo " --lc      : list containers"
}

if [ $# -eq 0 ]; then
    printHelp
else
    if [ "$1" = "-h" ]; then
	printHelp
    elif [ "$1" = "-b" ]; then
	docker_build_sh
    elif [ "$1" = "-s" ]; then
	simtelarray_build_sif
    elif [ "$1" = "-rungamma" ]; then
	singularity_run_simtelarray
    elif [ "$1" = "-c" ]; then
	clean
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
