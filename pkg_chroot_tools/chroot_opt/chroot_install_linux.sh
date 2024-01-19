#!/bin/bash

export FILE=linux-6.1.11
export FILE_XZ=${FILE}.tar.xz
export SRC_DIR=/sources
export CHROOT_PKG=${SRC_DIR}/chroot-pkg

mkdir -p $CHROOT_PKG

if [ ! -d ${CHROOT_PKG}/${FILE} ];
then
  tar xvf ${SRC_DIR}/${FILE_XZ} -C ${CHROOT_PKG}/
fi

cd ${CHROOT_PKG}/${FILE}

make mrproper
make menuconfig

# [*] Device Drivers, Generic Driver Options, Maintain a devtmpfs filesystem to mount at /dev
# [*] Device Drivers, Network device support, Ethernet Driver support, AMD PCnet32 PCI support
# [*] Device Drivers, Fusion MPT device support (select the three drivers for SPI, FC, SAS)
# [*] Device Drivers, SCSI device support, SCSI low-level drivers
# [*] File Systems, Ext3 Journaling file system support

# [*] Processor type and features, Build a relocatable kernel
# [*] Processor type and features, Randomize the address of the kernel image
# [ ] General setup, Compile the kernel with warnings as errors
# [ ] General setup, Enable kernel headers through /sys/kernel/kheaders.tar.xz
# [*] General architecture-dependent options, Stack Protector buffer overflow detection
# [*] General architecture-dependent options, Strong Stack Protector
# [*] Device Drivers, Graphics support, Frame buffer Devices, Support for frame buffer devices
# [*] Device Drivers, Graphics support, Console display driver support, Framebuffer Console support
# [ ] Device Drivers, Generic Driver Options, Support for uevent helper
# [*] Device Drivers, Generic Driver Options, Maintain a devtmpfs filesystem to mount at /dev
# [*] Device Drivers, Generic Driver Options, Automount devtmpfs at /dev, after the kernel mounted the rootfs
# [*] Processor type and features, Support x2apic
# [*] Device Drivers, PCI Support
# [*] Device Drivers, PCI Support, Message Signaled Interrupts (MSI and MSI-X)
# [*] Device Drivers, IOMMU Hardware Support
# [*] Device Drivers, IOMMU Hardware Support, Support for Interrupt Remapping



make -j4
make modules_install
cp -iv arch/x86/boot/bzImage /boot/vmlinuz-6.1.11-lfs-11.3
cp -iv System.map /boot/System.map-6.1.11
cp -iv .config /boot/config-6.1.11

install -d /usr/share/doc/linux-6.1.11
cp -r Documentation/* /usr/share/doc/linux-6.1.11

install -v -m755 -d /etc/modprobe.d
cat > /etc/modprobe.d/usb.conf << "EOF"
# Begin /etc/modprobe.d/usb.conf
install ohci_hcd /sbin/modprobe ehci_hcd ; /sbin/modprobe -i ohci_hcd ; true
install uhci_hcd /sbin/modprobe ehci_hcd ; /sbin/modprobe -i uhci_hcd ; true
# End /etc/modprobe.d/usb.conf
EOF
