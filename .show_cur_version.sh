#!/bin/bash

set -x

wget -O- http://download.proxmox.com/debian/pbs/dists/bookworm/pbs-no-subscription/binary-amd64/Packages | grep proxmox-backup-server | grep '\.deb' | sort -n | tail -n1
