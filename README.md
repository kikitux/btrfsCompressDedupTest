# btrfsCompressDedupTest
btrfsCompressDedupTest

# copying 700MB random file

```bash
# to bare, no compression
root@butter:/dev/shm# time cp randon.file.img /mnt/sdc

real    0m1.875s
user    0m0.017s
sys     0m0.445s

# to zlib
root@butter:/dev/shm# time cp randon.file.img /mnt/sde

real    0m3.213s
user    0m0.000s
sys     0m0.444s

# to lzo
root@butter:/dev/shm# time cp randon.file.img /mnt/sdf

real    0m1.221s
user    0m0.000s
sys     0m0.420s

root@butter:/dev/shm#

```

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




