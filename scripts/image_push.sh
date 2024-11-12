#!/bin/bash

usage() {
    echo     "Usage: $0 source_image dest_image"
    echo     "example: $0   "
}

if [ $1 == "--help" ] || [ $1 == "-h" ]; then
    usage
    exit 1
fi
source=$1
dest=$2

if [[ $source == *"/"* ]]; then
	source_registry=$(echo $source | cut -d'/' -f1)
	source_image_name=$(echo $source | cut -d'/' -f2 | cut -d':' -f1)
	source_image_tag=$(echo $source | cut -d'/' -f2 | awk -F: '{if (NF > 1) print $NF}')
	source_image_full="${source_registry}/${source_image_name}"
else
	source_registry=""
	source_image_name=$(echo $source | awk -F':' '{print $1}')
	source_image_tag=$(echo $source | awk -F':' '{print $2}')
	source_image_full="${source_image_name}"
fi

if [[ $dest == *"/"* ]]; then
	dest_registry=$(echo $dest | cut -d'/' -f1)
	dest_image_name=$(echo $dest | cut -d'/' -f2 | cut -d':' -f1)
	dest_image_tag=$(echo $dest | cut -d'/' -f2 | awk -F: '{if (NF > 1) print $NF}')
	dest_image_full="${dest_registry}/${dest_image_name}"
else
	dest_registry=""
	dest_image_name=$(echo $dest | awk -F':' '{print $1}')
	dest_image_tag=$(echo $dest | awk -F':' '{print $2}')
	dest_image_full="${dest_image_name}"
fi

if [ -z $dest_image_tag ]; then
	dest_image_tag="latest"
fi

if [ -z $source_image_tag ]; then
	source_image_tag="latest"
fi

ansible-playbook -i /home/sinagh79/ansible/inventory.yml /home/sinagh79/ansible/playbooks/new.yml \
    -e "source_registry=$source_registry" \
    -e "source_image_tag=$source_image_tag" \
    -e "source_image_full=$source_image_full" \
    -e "dest_registry=$dest_registry" \
    -e "dest_image_tag=$dest_image_tag" \
    -e "dest_image_full=$dest_image_full"

