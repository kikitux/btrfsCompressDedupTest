#!/bin/bash

[ -f  /vagrant/proxy.env ] && source /vagrant/proxy.env

#install btrfs-tools if not present
which rsync || {
  apt-get install -y rsync
}

which duperemove || {
    add-apt-repository ppa:lordgaav/duperemove <<EOF
EOF
    apt-get update
    apt-get install -y duperemove
}

for disk in /dev/sd[a-z]; do
  d=${disk#/dev/}
  [ ${d} == "sda" ] && continue
  [ ${d} == "sdb" ] && continue
  rsync -PavzHl /mnt/sdb/ /mnt/${d}/
done

#/mnt/sdc is deduped
duperemove --hashfile=/root/.duperemove /mnt/sdd

df -Ph
