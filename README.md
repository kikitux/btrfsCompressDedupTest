# btrfsCompressDedupTest
btrfsCompressDedupTest

# Some tests

sdb Source

sdc Bare, no dedup, no compression

sdd Dedup

sde Compression zlib

sdf Compression lzo


## copying 700MB random file

```bash
root@butter:/vagrant/scripts# dd if=/dev/urandom of=/dev/shm/random.file bs=1M count=2
2+0 records in
2+0 records out
2097152 bytes (2.1 MB) copied, 0.180227 s, 11.6 MB/s
root@butter:/vagrant/scripts# time dd if=/dev/shm/random.file of=/mnt/sdc/random.file oflag=direct
4096+0 records in
4096+0 records out
2097152 bytes (2.1 MB) copied, 1.50688 s, 1.4 MB/s

real    0m1.509s
user    0m0.005s
sys     0m0.278s
root@butter:/vagrant/scripts# time dd if=/dev/shm/random.file of=/mnt/sde/random.file oflag=direct
4096+0 records in
4096+0 records out
2097152 bytes (2.1 MB) copied, 1.93564 s, 1.1 MB/s

real    0m1.940s
user    0m0.000s
sys     0m0.337s
root@butter:/vagrant/scripts# time dd if=/dev/shm/random.file of=/mnt/sdf/random.file oflag=direct
4096+0 records in
4096+0 records out
2097152 bytes (2.1 MB) copied, 2.02141 s, 1.0 MB/s

real    0m2.026s
user    0m0.005s
sys     0m0.316s
root@butter:/vagrant/scripts#

root@butter:/vagrant/scripts# md5sum /dev/shm/random.file /mnt/sdc/random.file /mnt/sde/random.file /mnt/sdf/random.file
9b2bd8c6d4b529a7f197e5669255ecef  /dev/shm/random.file
9b2bd8c6d4b529a7f197e5669255ecef  /mnt/sdc/random.file
9b2bd8c6d4b529a7f197e5669255ecef  /mnt/sde/random.file
9b2bd8c6d4b529a7f197e5669255ecef  /mnt/sdf/random.file
root@butter:/vagrant/scripts#


```

## rsync of sample files. Source was /etc and /usr of ubuntu

For dedup we did `cp /usr/bin /<destinationN>` 4 times.

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
