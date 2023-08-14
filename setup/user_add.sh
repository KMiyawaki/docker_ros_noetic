#!/bin/bash

function main(){
    local -r SCRIPT=$(basename $0)
    local -r MIN_ARG=4
    if [ $# -lt "${MIN_ARG}" ]; then
        echo "usage: ${SCRIPT} USER_NAME GROUP_NAME USER_ID GROUP_ID" 1>&2
        return 0
    fi
    local -r USER_NAME=${1}
    local -r GROUP_NAME=${2}
    local -r USER_ID=${3}
    local -r GROUP_ID=${4}
    local -r PASSWORD=${USER_NAME}
    local -r ROS_VER=${5}
    
    echo "${USER_ID} ${GROUP_NAME}"
    groupadd -g ${GROUP_ID} ${GROUP_NAME}
    useradd -m -s /bin/bash -u ${USER_ID} -g ${GROUP_ID} -G sudo ${USER_NAME}
    echo ${USER_NAME}:${PASSWORD} | chpasswd
    echo "${USER_NAME}   ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers
    
    cd /home/${USER_NAME}
    sudo -u ${USER_NAME} git clone -b develop https://github.com/KMiyawaki/setup_robot_programming.git
    cd /home/${USER_NAME}/setup_robot_programming
    sudo -u ${USER_NAME} ./setup_emacs.sh
    sudo -u ${USER_NAME} ./install_vscode_extension_from_file.sh ms-iot vscode-ros 0.9.4
    sudo -u ${USER_NAME} ./install_vscode_extension_from_file.sh ms-python python 2023.13.11881007
    sudo -u ${USER_NAME} ./install_vscode_extension_from_file.sh ms-vscode cpptools 1.16.3
    sudo -u ${USER_NAME} ./${ROS_VER}/init_workspace.sh -p # Add python samples
}

main "$@"
