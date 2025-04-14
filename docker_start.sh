#!/bin/bash
function main(){
    local -r BASE="ros1_noetic"
    local -r BASE_IMAGE="kmiyawaki20/${BASE}"
    local -r IMAGE_NAME="${BASE_IMAGE}_user_${USER}"
    local -r CONTAINER_NAME="${BASE}_user_${USER}"
    local -r DOCKER_FILE="Dockerfile.useradd"
    local -r GROUP=`id -gn`
    local -r GID=`id -g`
    local -r SUB_GROUPS=`groups|sed "s/${GROUP}//g"|sed "s/^ *\| *$//g"|sed "s/ /,/g"`
    local -r WS="${HOME}/catkin_ws"
    local -r WS_SRC="${WS}/src"
    
    if [ ! -e "${WS}" ]; then
        mkdir -p "${WS_SRC}"
        echo "Making ${WS_SRC}"
    fi

    docker images|grep -q ${IMAGE_NAME}
    if [ $? -eq 1 ]; then
        echo "${IMAGE_NAME} does not exists. "
        echo "OK. Start to build image."
        # --progress=plain does not work for Jetson
        docker build -t "${IMAGE_NAME}" -f "${DOCKER_FILE}" \
            --build-arg BASE="${BASE_IMAGE}" \
            --build-arg USER_NAME="${USER}" \
            --build-arg GROUP_NAME="${GROUP}" \
            --build-arg USER_ID="${UID}" \
            --build-arg GROUP_ID="${GID}" \
            --build-arg ROS_VER="ros1" .
    else
        echo "${IMAGE_NAME} exists. Executing docker-compose up."
    fi
    
    echo "CONTAINER=${CONTAINER_NAME}" > .env
    echo "IMAGE_NAME=${IMAGE_NAME}" >> .env
    echo "USER=${USER}" >> .env
    echo "UID=${UID}" >> .env
    echo "GID=${GID}" >> .env
    echo "HOME=${HOME}" >> .env
    cp ./docker-compose.yml.template ./docker-compose.yml
    sed -i -e "s/<SERVICE>/${CONTAINER_NAME}/" ./docker-compose.yml
    docker-compose -p ${CONTAINER_NAME} up -d
}

main "$@"
