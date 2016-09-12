# /bin/sh

opkg install wget ca-certificates unzip

UPD_URL='https://github.com/XX-net/XX-Net/raw/master/code/default/update_version.txt'
UPD_FILE=${UPD_URL##*/}
wget -O ${UPD_FILE} ${UPD_URL}

ZIP_URL=`sed -n '/Stable/{n;p}' ${UPD_FILE}`
VERSION=${ZIP_URL##*/}
VERSION=${VERSION%%\ *}
UNPACK_DIR=XX-Net-${VERSION}
wget -O ${VERSION} ${ZIP_URL}
rm -rf ${UNPACK_DIR}
unzip ${VERSION}

LOCAL_DIR=code/${VERSION}/gae_proxy/local
NOARCH_DIR=code/${VERSION}/python27/1.0/lib/noarch
rm -rf   xx-net/${LOCAL_DIR}
rm -rf   xx-net/${NOARCH_DIR}
mkdir -p xx-net/${LOCAL_DIR%/*}
mkdir -p xx-net/${NOARCH_DIR%/*}
mv ${UNPACK_DIR}/code/default/gae_proxy/local         xx-net/${LOCAL_DIR%/*}/
mv ${UNPACK_DIR}/code/default/python27/1.0/lib/noarch xx-net/${NOARCH_DIR%/*}/
echo ${VERSION} > xx-net/code/version.txt

rm -rf ${UPD_FILE}
rm -rf ${VERSION}
rm -rf ${UNPACK_DIR}

echo '
# /bin/sh

TOP_DIR=`dirname $(readlink -f $0)`;
VERSION=`cat ${TOP_DIR}/code/version.txt`;
echo "Version=${VERSION}";

screen -d -m -S xx-net python ${TOP_DIR}/code/${VERSION}/gae_proxy/local/proxy.pyc;
screen -ls;
' > xx-net/start.sh
chmod a+x xx-net/start.sh

