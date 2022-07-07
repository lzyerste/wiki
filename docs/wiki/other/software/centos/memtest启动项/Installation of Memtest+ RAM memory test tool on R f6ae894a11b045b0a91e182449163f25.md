---
title: Installation_of_Memtest+_RAM_memory_test_tool_on_R_f6ae894a11b045b0a91e182449163f25
---

# Installation of Memtest+ RAM memory test tool on Redhat 7 Linux - LinuxConfig.org

[https://linuxconfig.org/installation-of-memtest-ram-memory-test-tool-on-redhat-7-linux](https://linuxconfig.org/installation-of-memtest-ram-memory-test-tool-on-redhat-7-linux)

Installation of Memtest+ RAM memory test tool on Redhat 7 Linux Memtest is a quite handy tool when troubleshooting hardware problem and specifically problems related to Random Access Memory (RAM). After installation the memtest+ tool will become available among other boot options. To install `memtest+` on RHEL 7 Linux server execute the following [linux command](https://linuxconfig.org/linux-commands):

```
# yum install memtest86+
...
Running transaction
  Installing : memtest86+-4.20-12.el7.x86_64      1/1 
  Verifying  : memtest86+-4.20-12.el7.x86_64      1/1 

Installed:
  memtest86+.x86_64 0:4.20-12.el7

```

Next, we will configure memtest86:

```
# memtest-setup 
grub2 detected, installing template...
grub 2 template installed.
Do not forget to regenerate your grub.cfg by:
  # grub2-mkconfig -o /boot/grub2/grub.cfg
Setup complete.

```

As a last step and as per the above setup instructions above we execute:

```
# grub2-mkconfig -o /boot/grub2/grub.cfg
...
Found memtest image: /boot/elf-memtest86+-4.20
done

```

This will update GRUB boot options to include Memtest+ tool. Next time you will reboot your RHEL 7 server GRUB will provide you with Memtest+ boot menu option: