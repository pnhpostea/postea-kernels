if /sbin/ext/busybox [ ! -f /system/postea/rooted ];
then
# Remount system RW
    /sbin/ext/busybox mount -o remount,rw /system
    /sbin/ext/busybox mount -t rootfs -o remount,rw rootfs

# ensure /system/xbin exists
    toolbox mkdir /system/xbin
    toolbox chmod 755 /system/xbin

# su
    toolbox rm /system/bin/su
    toolbox rm /system/xbin/su
    toolbox cat /res/misc/su > /system/xbin/su
    toolbox chown 0.0 /system/xbin/su
    toolbox chmod 6755 /system/xbin/su

# Once be enough
    toolbox mkdir /system/postea
    toolbox chmod 755 /system/postea
    echo 1 > /system/postea/rooted

# Remount system RO
    /sbin/ext/busybox mount -t rootfs -o remount,ro rootfs
    /sbin/ext/busybox mount -o remount,ro /system
fi;
