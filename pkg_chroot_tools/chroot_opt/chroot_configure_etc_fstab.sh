
cat > /etc/fstab << "EOF"
# Begin /etc/fstab

# file system  mount-point  type     options             dump  fsck
#                                                              order

UUID=<UUID3>     /             ext4    defaults            1     1
UUID=<UUID1>     /boot         ext4    defaults             1     1
UUID=<UUID2>     swap          swap    pri=1               0     0

proc           /proc        proc     nosuid,noexec,nodev 0     0
sysfs          /sys         sysfs    nosuid,noexec,nodev 0     0
devpts         /dev/pts     devpts   gid=5,mode=620      0     0
tmpfs          /run         tmpfs    defaults            0     0
devtmpfs       /dev         devtmpfs mode=0755,nosuid    0     0
tmpfs          /dev/shm     tmpfs    nosuid,nodev        0     0



# End /etc/fstab
EOF

echo "============================"
blkid
echo "============================"

cat /etc/fstab
echo "<UUID1~3> should be replaced by the uuid shown in command blkid"
