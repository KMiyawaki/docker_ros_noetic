#!/bin/bash
function main(){
    docker stop ros1_noetic_user_${USER}
}

main "$@"
