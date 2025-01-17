# /bin/bash

. my_profile.sh


# 安装openwrt-imagebuilder
function my_openwrt_img_wndr3700v4_15051
{
	VERSION=15.05.1
	DL_URL=https://downloads.openwrt.org/chaos_calmer/15.05.1/ar71xx/nand/OpenWrt-ImageBuilder-15.05.1-ar71xx-nand.Linux-x86_64.tar.bz2
	DL_FILE=${DL_URL##*/}
	UNPACK_DIR=${HOME}/wndr3700v4/OpenWrt-ImageBuilder-15.05.1-ar71xx-nand.Linux-x86_64
	
	my_unpack_tar_bz2 "${UNPACK_DIR}" "${DL_URL}";
	
	pushd ${UNPACK_DIR};
	
	# 完整使用 128M flash
	OLD='wndr4300_mtdlayout=mtdparts=ar934x-nfc:256k(u-boot)ro,256k(u-boot-env)ro,256k(caldata),512k(pot),2048k(language),512k(config),3072k(traffic_meter),2048k(kernel),23552k(ubi),25600k@0x6c0000(firmware),256k(caldata_backup),-(reserved)'
	NEW='wndr4300_mtdlayout=mtdparts=ar934x-nfc:256k(u-boot)ro,256k(u-boot-env)ro,256k(caldata),512k(pot),2048k(language),512k(config),3072k(traffic_meter),2048k(kernel),121856k(ubi),123904k@0x6c0000(firmware),256k(caldata_backup),-(reserved)'
	EDIT_FILE="${UNPACK_DIR}/target/linux/ar71xx/image/Makefile"
	sed -i "s/${OLD}/${NEW}/g" ${EDIT_FILE};
	
	# 编译选项
	LUCI='luci luci-i18n-base-zh-cn luci-i18n-firewall-zh-cn'
	USB='kmod-usb-storage kmod-usb-storage-extras kmod-scsi-core block-mount usbutils blkid fdisk e2fsprogs hdparm kmod-fs-ext4'
	SMB='luci-app-samba luci-i18n-samba-zh-cn'
	FAT32='kmod-fs-vfat kmod-nls-cp437 kmod-nls-iso8859-1'
	NTFS='kmod-fs-ntfs'
	BT='luci-app-transmission luci-i18n-transmission-zh-cn transmission-web'
	XXNET='bash ca-certificates python-base pyopenssl gevent libevent2 libevent2-core libevent2-extra libevent2-openssl libevent2-pthreads python-greenlet'
	OUTPUT=output/wndr3700v4/15.05.1
	case $1 in
		bt)
			OUTPUT=${OUTPUT}/bt
			make image PROFILE=WNDR4300 PACKAGES="${LUCI} ${USB} ${SMB} ${FAT32} ${NTFS} ${BT}";
			;;
		usb)
			OUTPUT=${OUTPUT}/usb
			make image PROFILE=WNDR4300 PACKAGES="${LUCI} ${USB} ${SMB} ${FAT32} ${NTFS}";
			;;
		xxnet)
			OUTPUT=${OUTPUT}/xxnet
			cp ${OUTPUT}/packages/* ${UNPACK_DIR}/packages/;
			make image PROFILE=WNDR4300 PACKAGES="${LUCI} ${XXNET}";
			;;
		*)
			OUTPUT=${OUTPUT}
			make image PROFILE=WNDR4300 PACKAGES="${LUCI}";
			;;
	esac;

	popd;
	mkdir -p ${OUTPUT};
	mv ${UNPACK_DIR}/bin/ar71xx/*-wndr3700v4-* ${OUTPUT}/
}

# 安装openwrt-sdk
function my_openwrt_sdk_wndr3700v4_15051
{
	VERSION=15.05.1
	DL_URL=https://downloads.openwrt.org/chaos_calmer/15.05.1/ar71xx/nand/OpenWrt-SDK-15.05.1-ar71xx-nand_gcc-4.8-linaro_uClibc-0.9.33.2.Linux-x86_64.tar.bz2
	DL_FILE=${DL_URL##*/}
	UNPACK_DIR=${HOME}/wndr3700v4/OpenWrt-SDK-15.05.1-ar71xx-nand_gcc-4.8-linaro_uClibc-0.9.33.2.Linux-x86_64
	
	my_unpack_tar_bz2 "${UNPACK_DIR}" "${DL_URL}";
}

# 编译
function my_openwrt_compile_wndr3700v4_15051
{
	UNPACK_DIR=${HOME}/wndr3700v4/OpenWrt-SDK-15.05.1-ar71xx-nand_gcc-4.8-linaro_uClibc-0.9.33.2.Linux-x86_64
	
	ln -s src/openwrt/packages/gevent0.13.8/ ${UNPACK_DIR}/package/gevent
	ln -s src/openwrt/packages/greenlet/     ${UNPACK_DIR}/package/greenlet
	ln -s src/openwrt/packages/libevent2/    ${UNPACK_DIR}/package/libevent
	
	pushd ${UNPACK_DIR};
		./script/feeds update -a
		./script/feeds install python-base
		make package/gevent/compile
		make package/libevent/compile
	popd;
	
	mv ${UNPACK_DIR}/bin/ar71xx/packages/base/gevent_**         output/wndr3700v4/15.05.1/xxnet/
	mv ${UNPACK_DIR}/bin/ar71xx/packages/base/python-greenlet_* output/wndr3700v4/15.05.1/xxnet/
	mv ${UNPACK_DIR}/bin/ar71xx/packages/base/libevent2*        output/wndr3700v4/15.05.1/xxnet/
}
	

