#!/bin/bash

has_partition=$(lsblk | grep sdc2 | wc -l)

if [ $has_partition -eq 0 ]; then
  echo "The /dev/sdc2 partition does not exist"
  exit 1
fi

is_mounted=$(lsblk | grep sdc2 | grep -o "MOUNTPOINT" | wc -l)

if ! [ $is_mounted -eq 1 ]; then
  echo "Mounting the /dev/sdc2 partition to /mnt"
  sudo mount /dev/sdc2 /mnt
fi

declare -A settings=(
  ["49-eduroam.key.yaml"]="/mnt/etc/netplan/49-eduroam.yaml"
)

for source_file in "${!settings[@]}"; do
  destination_path="${settings[$source_file]}"
  sudo cp "$source_file" "$destination_path"
done

sudo umount /mnt
