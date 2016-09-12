# /bin/bash

. my_profile.sh


# 安装openwrt-imagebuilder
function my_openwrt_img_mi424wr
{
	VERSION=10.03.1
	DL_URL='https://downloads.openwrt.org/backfire/10.03.1/ixp4xx_generic/OpenWrt-ImageBuilder-ixp4xx-for-Linux-i686.tar.bz2'
	DL_FILE=${DL_URL##*/}
	UNPACK_DIR=${HOME}/mi424wr/OpenWrt-ImageBuilder-ixp4xx-for-Linux-i686
	
	my_unpack_tar_bz2 "${UNPACK_DIR}" "${DL_URL}";
	
	mkdir -p ${UNPACK_DIR}/bin/ixp4xx/apex;
	DL_URL='https://downloads.openwrt.org/backfire/10.03.1/ixp4xx_generic/apex/apex-fsg3-armeb.bin'
	DL_FILE=${DL_URL##*/}
	DL_FILE=${UNPACK_DIR}/bin/ixp4xx/apex/${DL_FILE}
	[ ! -f "${DL_FILE}" ] && wget -O "${DL_FILE}" "${DL_URL}"

	DL_URL='https://downloads.openwrt.org/backfire/10.03.1/ixp4xx_generic/apex/apex-nas100d-armeb.bin'
	DL_FILE=${DL_URL##*/}
	DL_FILE=${UNPACK_DIR}/bin/ixp4xx/apex/${DL_FILE}
	[ ! -f "${DL_FILE}" ] && wget -O "${DL_FILE}" "${DL_URL}"

	DL_URL='https://downloads.openwrt.org/backfire/10.03.1/ixp4xx_generic/apex/apex-nslu2-16mb-armeb.bin'
	DL_FILE=${DL_URL##*/}
	DL_FILE=${UNPACK_DIR}/bin/ixp4xx/apex/${DL_FILE}
	[ ! -f "${DL_FILE}" ] && wget -O "${DL_FILE}" "${DL_URL}"

	DL_URL='https://downloads.openwrt.org/backfire/10.03.1/ixp4xx_generic/apex/apex-nslu2-armeb.bin'
	DL_FILE=${DL_URL##*/}
	DL_FILE=${UNPACK_DIR}/bin/ixp4xx/apex/${DL_FILE}
	[ ! -f "${DL_FILE}" ] && wget -O "${DL_FILE}" "${DL_URL}"
	
	pushd ${UNPACK_DIR};
	
	# 编译选项
	LUCI='luci luci-i18n-chinese'
	RT2500='kmod-rt2500-pci'
	OUTPUT=output/mi424wr/10.03.1
	case $1 in
		rt2500)
			OUTPUT=${OUTPUT}/rt2500
			make image PACKAGES="${LUCI} ${RT2500}";
			;;
		*)
			OUTPUT=${OUTPUT}
			make image PACKAGES="${LUCI}";
			;;
	esac;

	popd;
	mkdir -p ${OUTPUT};
	mv ${UNPACK_DIR}/bin/ixp4xx/openwrt-ixp4xx-generic-* ${OUTPUT}/
}

