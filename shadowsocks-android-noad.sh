# /bin/bash

. myprofile.sh
myjdk8;
mygradle;
myandroid_sdk;
myandroid_ndk;
mygolang;
mysbt;

# 定义shadowsocks版本
VERSION=v2.10.8

# shadowsocks-android
git clone https://github.com/shadowsocks/shadowsocks-android.git \
	&& cd shadowsocks-android \
	&& git checkout ${VERSION}


# NoAd
# 方法一：必须先删除·com.google.android.gms.ads.AdActivity·上面的一行
sed -i -e :a -e '$!N;s/.*\n\(.*com.google.android.gms.ads.AdActivity\)/\1/;ta' -e 'P;D' src/main/AndroidManifest.xml \
	&& sed -i '/com.google.android.gms.ads.AdActivity/d' src/main/AndroidManifest.xml \
	&& sed -i '/keyboard|keyboardHidden|orientation|screenLayout|uiMode|screenSize|smallestScreenSize/d' src/main/AndroidManifest.xml

# 方法二：删除·com.google.android.gms.ads.AdActivity·行和下面3行，共删除4行
# sed -i '/com.google.android.gms.ads.AdActivity/,+3d' src/main/AndroidManifest.xml

# build
git submodule update --init
sbt native-build clean android:package-release

