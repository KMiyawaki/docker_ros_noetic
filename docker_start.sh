#!/bin/bash
function main(){
    local -r WS="${HOME}/catkin_ws"
    local -r SETUP_SCRIPTS="setup_robot_programming"
    if [ ! -e ${WS} ]; then
        mkdir -p ${WS}/src
        echo "Making ${WS}/src"
    fi
    (
        cd ${HOME}
        if [ ! -e ${SETUP_SCRIPTS} ]; then
            echo "Cloning ${SETUP_SCRIPTS}"
            git clone https://github.com/KMiyawaki/${SETUP_SCRIPTS}.git
        else
            cd ${SETUP_SCRIPTS}
            git pull
        fi
    )

    echo "UID=${UID}" > .env
    echo "GID=`id -g`" >> .env
    echo "HOME=${HOME}" >> .env
    echo "SETUP_SCRIPTS=${SETUP_SCRIPTS}" >> .env
    docker-compose up -d
}

main "$@"
