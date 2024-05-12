#!/bin/bash

# Check with lsblk that the /dev/sdc2 partition exists

has_partition=$(lsblk | grep sdc2 | wc -l)

if [ $has_partition -eq 0 ]; then
  echo "The /dev/sdc2 partition does not exist"
  exit 1
fi

# Mount the /dev/sdc2 partition to /mnt
sudo mount /dev/sdc2 /mnt


# Create a list of lists with the settings to copy and the destination path

settings = (
  ("49-eduroam.key.yaml", "/mnt/etc/netplan/49-eduroam.yaml"),
)

# Copy the settings to the destination path

for setting in "${settings[@]}"; do
  sudo cp $setting[0] $setting[1]
done

# Unmount the /dev/sdc2 partition

sudo umount /mnt
