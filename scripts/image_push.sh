#!/bin/bash

usage() {
    echo     "Usage: $0 source_image dest_image registry_username"
    echo     "example: $0 docker.arvancloud.ir/nginx:latest hub.example.ir/ghorbani-test/nginx:alpine sina-ghorbani"
}

if [ $# -eq 0 ]; then
	usage
	exit
fi

if [ $1 == "--help" ] || [ $1 == "-h" ]; then
    usage
    exit 1
fi

source_image=$1
dest_image=$2
username=$3
read -s -p "Enter registry password: " password

if [[ $source == *"/"* ]]; then
	source_image_tag=$(echo $sourcei_image | awk -F'/' '{last=$NF} END {split(last, parts, ":"); print (length(parts) > 1 ? parts[length(parts)] : "")}')
else
	source_image_tag=$(echo $source_image | awk -F':' '{print $2}')
fi

if [[ $dest == *"/"* ]]; then
	dest_image_tag=$(echo $dest_image | awk -F'/' '{last=$NF} END {split(last, parts, ":"); print (length(parts) > 1 ? parts[length(parts)] : "")}')
else
	dest_image_tag=$(echo $dest_image | awk -F':' '{print $2}')
fi

if [ -z $dest_image_tag ]; then
	dest_image_tag="latest"
fi

if [ -z $source_image_tag ]; then
	source_image_tag="latest"
fi

ansible-playbook -i ./inventory/inventory.yml ./playbooks/image_pull_and_push.yml \
    -e "source_image=$source_image" \
    -e "dest_image=$dest_image" \
	-e "username=$username" \
	-e "password=$password"