#!/bin/bash

[ -f  /vagrant/proxy.env ] && source /vagrant/proxy.env

#install btrfs-tools if not present
which btrfs || {
  apt-get install -y btrfs-tools
}

# ZLIB -- slower, higher compression ratio (uses zlib level 3 setting, you can see the zlib level difference between 1 and 6 in zlib sources).
# LZO -- faster compression and decompression than zlib, worse compression ratio, designed to be fast

unset disk
declare -A disk
disk["sdb"]="defaults"                          # source
disk["sdc"]="defaults"                          # bare
disk["sdd"]="defaults"
disk["sde"]="compress-force=zlib,compress=zlib" # zlib
disk["sdf"]="compress-force=lzo,compress=lzo"   # lzo


#check for device
for disk in /dev/sd[a-z]; do
    d=${disk#/dev/}
    [ ${d} == "sda" ] && continue               # skip os disk
    #format if no metadata present
    blkid ${disk}*
    if [ $? -ne 0 ]; then
        mkfs.btrfs -m single -d single ${disk}
        blkid ${disk} 2>&1>/dev/null && echo $(blkid ${disk} -o export | head -n1) /mnt/${d} auto ${disk["${d}"]} 0 0 >> /etc/fstab
        mkdir -p /mnt/${d}
        mount /mnt/${d}
    else
        echo "filesystem metadata found on ${disk}, ignoring"
    fi
done
