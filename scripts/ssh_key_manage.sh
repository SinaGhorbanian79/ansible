#!/bin/bash

usage() {
    echo     "Usage: $0 inventory"
    echo     "example: $0 /etc/ansible/inventory.yml"
}

if [ $# -eq 0 ]; then
	usage
	exit
fi

if [ $1 == "--help" ] || [ $1 == "-h" ]; then
    usage
    exit 1
fi

inventory=$1
echo "Current directory: $(pwd)"
 ansible-playbook -i $inventory playbooks/ssh_key_manager.yml