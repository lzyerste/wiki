---
title: How_to_find_the_driver__module__associated_with_a__e9b1dc5ab7cf4648ac6190c2e74c2958
---

# How to find the driver (module) associated with a device on Linux? - Unix & Linux Stack Exchange

[https://unix.stackexchange.com/questions/97676/how-to-find-the-driver-module-associated-with-a-device-on-linux](https://unix.stackexchange.com/questions/97676/how-to-find-the-driver-module-associated-with-a-device-on-linux)

To get this information from `sysfs` for a device file, first determine the major/minor number by looking at the output of `ls -l`, eg

```
 $ ls -l /dev/sda
 brw-rw---- 1 root disk 8, 0 Apr 17 12:26 /dev/sda

```

The `8, 0` tells us that major number is `8` and the minor is `0`. The `b` at the start of the listing also tells us that it is a block device. Other devices may have a `c` for character device at the start.

If you then look under `/sys/dev`, you will see there are two directories. One called `block` and one called `char`. The no-brainer here is that these are for block and character devices respectively. Each device is then accessible by its major/minor number is this directory. If there is a driver available for the device, it can be found by reading the target of the `driver` link in this or the `device` sub-directory. Eg, for my `/dev/sda` I can simply do:

```
$ readlink /sys/dev/block/8\:0/device/driver
../../../../../../../bus/scsi/drivers/sd

```

This shows that the `sd` driver is used for the device. If you are unsure if the device is a block or character device, in the shell you could simply replace this part with a `*`. This works just as well:

```
$ readlink /sys/dev/*/8\:0/device/driver
../../../../../../../bus/scsi/drivers/sd

```

Block devices can also be accessed directly through their name via either `/sys/block` or `/sys/class/block`. Eg:

```
$ readlink /sys/block/sda/device/driver
../../../../../../../bus/scsi/drivers/sd

```

Note that the existence of various directories in `/sys` may change depending on the kernel configuration. Also not all devices have a `device` subfolder. For example, this is the case for partition device files like `/dev/sda1`. Here you have to access the device for the whole disk (unfortunately there are no `sys` links for this).

A final thing which can be useful to do is to list the drivers for all devices for which they are available. For this you can use globs to select all the directories in which the driver links are present. Eg:

```
$ ls -l /sys/dev/*/*/device/driver && ls -l /sys/dev/*/*/driver 
lrwxrwxrwx 1 root root 0 Apr 17 12:27 /sys/dev/block/11:0/device/driver -> ../../../../../../../bus/scsi/drivers/sr
lrwxrwxrwx 1 root root 0 Apr 17 12:26 /sys/dev/block/8:0/device/driver -> ../../../../../../../bus/scsi/drivers/sd
lrwxrwxrwx 1 root root 0 Apr 17 12:26 /sys/dev/block/8:16/device/driver -> ../../../../../../../bus/scsi/drivers/sd
lrwxrwxrwx 1 root root 0 Apr 17 12:26 /sys/dev/block/8:32/device/driver -> ../../../../../../../../../bus/scsi/drivers/sd
lrwxrwxrwx 1 root root 0 Apr 17 20:38 /sys/dev/char/189:0/driver -> ../../../../bus/usb/drivers/usb
lrwxrwxrwx 1 root root 0 Apr 17 20:38 /sys/dev/char/189:1024/driver -> ../../../../bus/usb/drivers/usb
lrwxrwxrwx 1 root root 0 Apr 17 20:38 /sys/dev/char/189:128/driver -> ../../../../bus/usb/drivers/usb
lrwxrwxrwx 1 root root 0 Apr 17 20:38 /sys/dev/char/189:256/driver -> ../../../../bus/usb/drivers/usb
lrwxrwxrwx 1 root root 0 Apr 17 20:38 /sys/dev/char/189:384/driver -> ../../../../bus/usb/drivers/usb
lrwxrwxrwx 1 root root 0 Apr 17 12:26 /sys/dev/char/189:512/driver -> ../../../../bus/usb/drivers/usb
lrwxrwxrwx 1 root root 0 Apr 17 12:26 /sys/dev/char/189:513/driver -> ../../../../../bus/usb/drivers/usb
lrwxrwxrwx 1 root root 0 Apr 17 12:26 /sys/dev/char/189:514/driver -> ../../../../../bus/usb/drivers/usb
lrwxrwxrwx 1 root root 0 Apr 17 12:26 /sys/dev/char/189:640/driver -> ../../../../bus/usb/drivers/usb
lrwxrwxrwx 1 root root 0 Apr 17 12:26 /sys/dev/char/189:643/driver -> ../../../../../bus/usb/drivers/usb
lrwxrwxrwx 1 root root 0 Apr 17 20:38 /sys/dev/char/189:768/driver -> ../../../../bus/usb/drivers/usb
lrwxrwxrwx 1 root root 0 Apr 17 20:38 /sys/dev/char/189:896/driver -> ../../../../bus/usb/drivers/usb
lrwxrwxrwx 1 root root 0 Apr 17 12:26 /sys/dev/char/21:0/device/driver -> ../../../../../../../bus/scsi/drivers/sd
lrwxrwxrwx 1 root root 0 Apr 17 12:26 /sys/dev/char/21:1/device/driver -> ../../../../../../../bus/scsi/drivers/sd
lrwxrwxrwx 1 root root 0 Apr 17 12:27 /sys/dev/char/21:2/device/driver -> ../../../../../../../bus/scsi/drivers/sr
lrwxrwxrwx 1 root root 0 Apr 17 12:26 /sys/dev/char/21:3/device/driver -> ../../../../../../../../../bus/scsi/drivers/sd
lrwxrwxrwx 1 root root 0 Apr 17 12:26 /sys/dev/char/250:0/device/driver -> ../../../../../../../bus/hid/drivers/hid-generic
lrwxrwxrwx 1 root root 0 Apr 17 12:26 /sys/dev/char/250:1/device/driver -> ../../../../../../../bus/hid/drivers/hid-generic
lrwxrwxrwx 1 root root 0 Apr 17 12:26 /sys/dev/char/250:2/device/driver -> ../../../../../../../bus/hid/drivers/hid-generic
lrwxrwxrwx 1 root root 0 Apr 17 12:26 /sys/dev/char/252:0/device/driver -> ../../../../../../../bus/scsi/drivers/sd
lrwxrwxrwx 1 root root 0 Apr 17 12:26 /sys/dev/char/252:1/device/driver -> ../../../../../../../bus/scsi/drivers/sd
lrwxrwxrwx 1 root root 0 Apr 17 12:27 /sys/dev/char/252:2/device/driver -> ../../../../../../../bus/scsi/drivers/sr
lrwxrwxrwx 1 root root 0 Apr 17 12:26 /sys/dev/char/252:3/device/driver -> ../../../../../../../../../bus/scsi/drivers/sd
lrwxrwxrwx 1 root root 0 Apr 17 19:53 /sys/dev/char/254:0/device/driver -> ../../../bus/pnp/drivers/rtc_cmos
lrwxrwxrwx 1 root root 0 Apr 17 19:53 /sys/dev/char/29:0/device/driver -> ../../../bus/platform/drivers/simple-framebuffer
lrwxrwxrwx 1 root root 0 Apr 17 19:53 /sys/dev/char/4:64/device/driver -> ../../../bus/pnp/drivers/serial
lrwxrwxrwx 1 root root 0 Apr 17 19:53 /sys/dev/char/4:65/device/driver -> ../../../bus/platform/drivers/serial8250
lrwxrwxrwx 1 root root 0 Apr 17 19:53 /sys/dev/char/4:66/device/driver -> ../../../bus/platform/drivers/serial8250
lrwxrwxrwx 1 root root 0 Apr 17 19:53 /sys/dev/char/4:67/device/driver -> ../../../bus/platform/drivers/serial8250
lrwxrwxrwx 1 root root 0 Apr 17 12:26 /sys/dev/char/6:0/device/driver -> ../../../bus/pnp/drivers/parport_pc
lrwxrwxrwx 1 root root 0 Apr 17 12:26 /sys/dev/char/99:0/device/driver -> ../../../bus/pnp/drivers/parport_pc

```

Finally, to diverge from the question a bit, I will add another `/sys` glob trick to get a much broader perspective on which drivers are being used by which devices (though not necessarily those with a device file):

```
find /sys/bus/*/drivers/* -maxdepth 1 -lname '*devices*' -ls

```

### Update

Looking more closely at the output of `udevadm`, it appears to work by finding the canonical `/sys` directory (as you would get if you dereferenced the major/minor directories above), then working its way up the directory tree, printing out any information that it finds. This way you get information about parent devices and any drivers they use as well.

To experiment with this I wrote the script below to walk up the directory tree and display information at each relevant level. `udev` seems to look for readable files at each level, with their names and contents being incorporated in `ATTRS`. Instead of doing this I display the contents of the `uevent` files at each level (seemingly the presence of this defines a distinct level rather than just a subdirectory). I also show the basename of any subsystem links I find and this showing how the device fits in this hierarchy. `udevadm` does not display the same information, so this is a nice complementary tool. The parent device information (eg `PCI` information) is also useful if you want to match the output of other tools like `lshw` to higher level devices.

```
#!/bin/bash

dev=$(readlink -m $1)

# test for block/character device
if [ -b "$dev" ]; then
  mode=block
elif [ -c "$dev" ]; then
  mode=char
else
  echo "$dev is not a device file" >&2
  exit 1
fi

# stat outputs major/minor in hex, convert to decimal
data=( $(stat -c '%t %T' $dev) ) || exit 2
major=$(( 0x${data[0]} ))
minor=$(( 0x${data[1]} ))

echo -e "Given device:     $1"
echo -e "Canonical device: $dev"
echo -e "Major: $major"
echo -e "Minor: $minor\n"

# sometimes nodes have been created for devices that are not present
dir=$(readlink -f /sys/dev/$mode/$major\:$minor)
if ! [ -e "$dir" ]; then
  echo "No /sys entry for $dev" >&2
  exit 3
fi

# walk up the /sys hierarchy one directory at a time
# stop when there are three levels left 
while [ $dir == /*/*/* ]( $dir == /*/*/* ); do

  # it seems the directory is only of interest if there is a 'uevent' file
  if [ -e "$dir/uevent" ]; then
    echo "$dir:"
    echo "  Uevent:"
    sed 's/^/    /' "$dir/uevent"

    # check for subsystem link
    if [ -d "$dir/subsystem" ]; then
        subsystem=$(readlink -f "$dir/subsystem")
        echo -e "\n  Subsystem:\n    ${subsystem##*/}"
    fi

    echo
  fi

  # strip a subdirectory
  dir=${dir%/*}
done

```