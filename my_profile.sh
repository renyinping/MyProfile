# /bin/bash

# 安装64位系统兼容32位应用包和开发工具包
function my_install_x86_64
{
	sudo apt-get install -y lib32z1 lib32ncurses5 lib32bz2-1.0 lib32stdc++6 \
		build-essential ccache bison flex automake intltool libncurses5-dev \
		unzip git
}

# 解包zip
function my_unpack_zip
{
	DL_URL=$3
	DL_FILE=$2
	UNPACK_DIR=$1
	
	if [ ! -d "${PWD}/${UNPACK_DIR}" ]; then
		if [ ! -f "${PWD}/${DL_FILE}" ]; then
			wget ${DL_URL};
		fi;
		unzip -q ${DL_FILE};
		rm -rf ${DL_FILE};
	fi;
}

# 解包tgz
function my_unpack_tgz
{
	DL_URL=$3
	DL_FILE=$2
	UNPACK_DIR=$1
	
	if [ ! -d "${PWD}/${UNPACK_DIR}" ]; then
		if [ ! -f "${PWD}/${DL_FILE}" ]; then
			wget ${DL_URL};
		fi;
		tar -zxf ${DL_FILE};
		rm -rf ${DL_FILE};
	fi;
}

# 安装jdk8
function my_jdk8
{
	DL_URL=http://download.oracle.com/otn-pub/java/jdk/8u101-b13/jdk-8u101-linux-x64.tar.gz
	DL_FILE=${DL_URL##*/}
	UNPACK_DIR=jdk1.8.0_101
	export JDK_HOME=${PWD}/${UNPACK_DIR}
	export JAVA_HOME=${JDK_HOME}
	export PATH=${JAVA_HOME}/bin:${PATH}
	
	if [ ! -d "${PWD}/${UNPACK_DIR}" ]; then
		if [ ! -f "${PWD}/${DL_FILE}" ]; then
			wget --header "Cookie: oraclelicense=accept" -c --no-check-certificate ${DL_URL};
		fi;
		tar -zxf ${DL_FILE};
		rm -rf ${DL_FILE};
	fi;
}

# 安装gradle
function my_gradle
{
	VERSION=3.0
	DL_URL=https://services.gradle.org/distributions/gradle-${VERSION}-bin.zip
	DL_FILE=${DL_URL##*/}
	UNPACK_DIR=gradle-${VERSION}
	export GRADLE_HOME=${PWD}/${UNPACK_DIR}
	export PATH=${GRADLE_HOME}/bin:${PATH}
	
	my_unpack_zip ${UNPACK_DIR} ${DL_FILE} ${DL_URL};
}

# 安装android-sdk
function my_android_sdk
{
	VERSION=r24.4.1
	DL_URL=https://dl.google.com/android/android-sdk_${VERSION}-linux.tgz
	DL_FILE=${DL_URL##*/}
	UNPACK_DIR=android-sdk-linux
	export ANDROID_HOME=${PWD}/${UNPACK_DIR}
	export PATH=${ANDROID_HOME}/tools:${ANDROID_HOME}/platform-tools:${PATH}
	
	my_unpack_tgz ${UNPACK_DIR} ${DL_FILE} ${DL_URL};
		
	echo "y" | android update sdk --filter tools,platform-tools,build-tools-24.0.1,android-24,extra-google-m2repository --no-ui -a;
	echo "y" | android update sdk --filter extra-android-m2repository --no-ui -a;
}

# 安装android-ndk
function my_android_ndk
{
	VERSION=r12b
	DL_URL=https://dl.google.com/android/repository/android-ndk-${VERSION}-linux-x86_64.zip
	DL_FILE=${DL_URL##*/}
	UNPACK_DIR=android-ndk-${VERSION}
	export ANDROID_NDK_HOME=${PWD}/${UNPACK_DIR}
	
	my_unpack_zip ${UNPACK_DIR} ${DL_FILE} ${DL_URL};
}

# 安装golang
function my_golang
{
	VERSION=1.7
	DL_URL=https://storage.googleapis.com/golang/go${VERSION}.linux-amd64.tar.gz
	DL_FILE=${DL_URL##*/}
	UNPACK_DIR=go
	export GOROOT=${PWD}/${UNPACK_DIR}
	export GOPATH=${PWD}/${UNPACK_DIR}work
	export GOROOT_BOOTSTRAP=${GOROOT}
	export PATH=${GOROOT}/bin:${PATH}
	
	my_unpack_tgz ${UNPACK_DIR} ${DL_FILE} ${DL_URL};
}

# 安装sbt
function my_sbt
{
	VERSION=
	DL_URL=https://raw.githubusercontent.com/paulp/sbt-extras/master/sbt
	DL_FILE=${DL_URL##*/}
	UNPACK_DIR=sbt
	export SBTPATH=${PWD}/${UNPACK_DIR}
	export PATH=${SBTPATH}:${PATH}
	
	mkdir -p ${SBTPATH}
	wget -O ${SBTPATH}/sbt ${DL_URL}
	chmod a+x ${SBTPATH}/sbt
}

