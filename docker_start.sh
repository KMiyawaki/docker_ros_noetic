#!/bin/bash
function main(){
    local -r WS="/home/${USER}/catkin_ws"
    if [ ! -e ${WS} ]; then
        mkdir -p ${WS}/src
        echo "Making ${WS}/src"
    fi
    docker-compose up -d
}

main "$@"
