#!/bin/bash
function main(){
    local -r WS="${HOME}/catkin_ws"
    if [ ! -e ${WS} ]; then
        mkdir -p ${WS}/src
        echo "Making ${WS}/src"
    fi
    local -r GROUP=`id -gn`
    local SUB_GROUPS=`groups|sed "s/${GROUP}//g"|sed "s/^ *\| *$//g"|sed "s/ /,/g"`

    echo "USER=${USER}" > .env
    echo "UID=${UID}" >> .env
    echo "GID=`id -g`" >> .env
    echo "HOME=${HOME}" >> .env
    docker-compose up -d
}

main "$@"
