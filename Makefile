devices:
	diskutil list

esxi.img.dmg:
	hdiutil convert -format UDRW -o $(IMAGE_FILE).img $(IMAGE_FILE)

vmware: esxi.img.dmg
	# Format USB device as a bootable MS-DOS volume
	diskutil unmountDisk /dev/disk$(DISK)
	diskutil eraseDisk MS-DOS ESXI MBR /dev/disk$(DISK)
	# Mount USB device to add syslinux.cfg
	mkdir -p source
	mkdir -p target
	hdiutil mount $(IMAGE_FILE) -mountpoint ./source
	cp -r source/ /Volumes/ESXI/
	cp syslinux.cfg /Volumes/ESXI/
	hdiutil eject ./source
	diskutil unmountDisk /dev/disk$(DISK)
	diskutil eject /dev/disk$(DISK)
