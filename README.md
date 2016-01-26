# btrfsCompressDedupTest
btrfsCompressDedupTest

# some results

sdb Source
sdc Bare, no dedup, no compression
sdd Dedup
sde Compression zlib
sdf Compression lzo


```bash

root@butter:/vagrant/scripts# mount -t btrfs
/dev/sdb on /mnt/sdb type btrfs (rw)
/dev/sdc on /mnt/sdc type btrfs (rw)
/dev/sdd on /mnt/sdd type btrfs (rw)
/dev/sde on /mnt/sde type btrfs (rw,compress-force=zlib,compress=zlib)
/dev/sdf on /mnt/sdf type btrfs (rw,compress-force=lzo,compress=lzo)


root@butter:/vagrant/scripts# df -Ph /mnt/*/ ; mount -t btrfs
Filesystem      Size  Used Avail Use% Mounted on
/dev/sdb         20G   15G  5.1G  75% /mnt/sdb
/dev/sdc         20G   15G  5.1G  75% /mnt/sdc
/dev/sdd         20G   15G  5.1G  75% /mnt/sdd
/dev/sde         20G  4.2G   16G  21% /mnt/sde
/dev/sdf         20G  6.1G   14G  31% /mnt/sdf

root@butter:/vagrant/scripts#
```




