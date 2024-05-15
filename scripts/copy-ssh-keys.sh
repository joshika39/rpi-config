#!/bin/bash

# This script copies the SSH keys to the target machine
# Usage: ./copy-ssh-keys.sh <target_ips> <username> <password> <ssh_key_path>

# Check if the number of arguments is less than 4
if [ $# -lt 4 ]; then
    echo "Usage: ./copy-ssh-keys.sh <target_ips> <username> <password> <ssh_key_path> [--force]"
    exit 1
fi

# Extract the arguments
target_ips=$1
username=$2
password=$3
ssh_key_path=$4
force=${5:-" "}

IFS=',' read -r -a target_ips_array <<< "$target_ips"

for target_ip in "${target_ips_array[@]}"
do
    ssh-copy-id -i $ssh_key_path $force $username@$target_ip
done
