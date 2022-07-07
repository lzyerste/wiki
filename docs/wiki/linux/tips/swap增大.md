---
title: swap增大
---

# 增大swap

[How to increase swap space?](https://askubuntu.com/questions/178712/how-to-increase-swap-space)

默认文件为/swapfile

## Resize Swap to 8GB

```
# Turn swap off
# This moves stuff in swap to the main memory and might take several minutes
sudo swapoff -a

# Create an empty swapfile
# Note that "1G" is basically just the unit and count is an integer.
# Together, they define the size. In this case 8GB.
sudo dd if=/dev/zero of=/swapfile bs=1G count=8
# Set the correct permissions
sudo chmod 0600 /swapfile

sudo mkswap /swapfile  # Set up a Linux swap area
sudo swapon /swapfile  # Turn the swap on
```

## Check if it worked

```
grep Swap /proc/meminfo
```