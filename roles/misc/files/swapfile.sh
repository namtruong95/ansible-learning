#!/bin/bash

if [ ! -z $(swapon -s) ]; then
  exit 0
fi

dd if=/dev/zero of=/swapfile count=4096 bs=1MiB
chmod 600 /swapfile
mkswap /swapfile
swapon /swapfile
sed '$ a /swapfile   swap    swap    sw  0   0' /etc/fstab
