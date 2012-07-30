#!/sbin/ext/busybox sh

#/sbin/ext/busybox sh /sbin/boot/busybox.sh
/sbin/ext/busybox sh /sbin/boot/postea-root.sh

read sync < /data/sync_fifo
rm /data/sync_fifo
