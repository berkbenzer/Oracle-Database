/etc/yum.repos.d]# grubby --default-kernel
/boot/vmlinuz-3.10.0-862.14.4.el7.x86_64
[root@istsl75mgr2t:/etc/yum.repos.d]# grubby --args="transparent_hugepage=never" --update-kernel /boot/vmlinuz-3.10.0-862.14.4.el7.x86_64
[root@istsl75mgr2t:/etc/yum.repos.d]# grubby --info /boot/vmlinuz-3.10.0-862.14.4.el7.x86_64 
index=0
kernel=/boot/vmlinuz-3.10.0-862.14.4.el7.x86_64
args="ro crashkernel=auto rd.lvm.lv=vg_root/lv_root rd.lvm.lv=vg_root/lv_swap rhgb quiet audit=1 LANG=en_US.UTF-8 transparent_hugepage=never"
root=/dev/mapper/vg_root-lv_root
initrd=/boot/initramfs-3.10.0-862.14.4.el7.x86_64.img
title=Red Hat Enterprise Linux Server (3.10.0-862.14.4.el7.x86_64) 7.5 (Maipo)
[root@istsl75mgr2t:/etc/yum.repos.d]# 


##reboot the machine
