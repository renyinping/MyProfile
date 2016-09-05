# /bin/bash

# 安装64位系统兼容32位应用包和开发工具包
function my_install_x86_64
{
	sudo apt-get install -y lib32z1 lib32ncurses5 lib32bz2-1.0 lib32stdc++6 \
		build-essential ccache bison flex automake intltool libncurses5-dev \
		unzip git
}

# 解包zip
# UNPACK_DIR 必须是完整目录路径
function my_unpack_zip
{
	DL_URL=$2
	UNPACK_DIR=$1
	DL_FILE=${DL_URL##*/};
	
	mkdir -p ${UNPACK_DIR%/*};
	pushd ${UNPACK_DIR%/*};
	if [ ! -d "${UNPACK_DIR}" ]; then
		if [ ! -f "${DL_FILE}" ]; then
			wget -O ${DL_FILE} ${DL_URL};
		fi;
		unzip -q ${DL_FILE};
		rm -rf ${DL_FILE};
	fi;
	popd;
}

# 解包tgz
# UNPACK_DIR 必须是完整目录路径
function my_unpack_tgz
{
	DL_URL=$2
	UNPACK_DIR=$1
	DL_FILE=${DL_URL##*/};
	
	mkdir -p ${UNPACK_DIR%/*};
	pushd ${UNPACK_DIR%/*};
	if [ ! -d "${UNPACK_DIR}" ]; then
		if [ ! -f "${DL_FILE}" ]; then
			wget -O ${DL_FILE} ${DL_URL};
		fi;
		tar -zxf ${DL_FILE};
		rm -rf ${DL_FILE};
	fi;
	popd;
}

# 安装jdk8
function my_jdk8
{
	DL_URL=http://download.oracle.com/otn-pub/java/jdk/8u101-b13/jdk-8u101-linux-x64.tar.gz
	DL_FILE=${DL_URL##*/}
	UNPACK_DIR=${HOME}/oracle/jdk1.8.0_101
	
	export JDK_HOME=${UNPACK_DIR}
	export JAVA_HOME=${JDK_HOME}
	export PATH=${JAVA_HOME}/bin:${PATH}
	
	mkdir -p ${UNPACK_DIR%/*};
	pushd ${UNPACK_DIR%/*};
	if [ ! -d "${UNPACK_DIR}" ]; then
		if [ ! -f "${DL_FILE}" ]; then
			wget --header "Cookie: oraclelicense=accept" -c --no-check-certificate ${DL_URL};
		fi;
		tar -zxf ${DL_FILE};
		rm -rf ${DL_FILE};
	fi;
	popd;
}

# 安装gradle
function my_gradle
{
	VERSION=3.0
	DL_URL=https://services.gradle.org/distributions/gradle-${VERSION}-bin.zip
	DL_FILE=${DL_URL##*/}
	UNPACK_DIR=${HOME}/gradle/gradle-${VERSION}
	
	export GRADLE_HOME=${UNPACK_DIR}
	export PATH=${GRADLE_HOME}/bin:${PATH}
	
	my_unpack_zip "${UNPACK_DIR}" "${DL_URL}";
}

# 安装android-sdk
function my_android_sdk
{
	VERSION=r24.4.1
	DL_URL=https://dl.google.com/android/android-sdk_${VERSION}-linux.tgz
	DL_FILE=${DL_URL##*/}
	UNPACK_DIR=${HOME}/android/android-sdk-linux
	
	export ANDROID_HOME=${UNPACK_DIR}
	export PATH=${ANDROID_HOME}/tools:${ANDROID_HOME}/platform-tools:${PATH}
	
	my_unpack_tgz "${UNPACK_DIR}" "${DL_URL}";
}

# 更新android-sdk
function my_android_sdk_update
{
	echo "y" | android update sdk --filter tools,platform-tools,build-tools-24.0.1,android-24,extra-google-m2repository --no-ui -a;
	echo "y" | android update sdk --filter extra-android-m2repository --no-ui -a;
}

# 安装android-ndk
function my_android_ndk
{
	VERSION=r12b
	DL_URL=https://dl.google.com/android/repository/android-ndk-${VERSION}-linux-x86_64.zip
	DL_FILE=${DL_URL##*/}
	UNPACK_DIR=${HOME}/android/android-ndk-${VERSION}
	
	export ANDROID_NDK_HOME=${UNPACK_DIR}
	export PATH=${ANDROID_NDK_HOME}:${PATH}
	
	my_unpack_zip "${UNPACK_DIR}" "${DL_URL}";
}

# 安装golang
function my_golang
{
	VERSION=1.7
	DL_URL=https://storage.googleapis.com/golang/go${VERSION}.linux-amd64.tar.gz
	DL_FILE=${DL_URL##*/}
	UNPACK_DIR=${HOME}/go/go
	
	export GOPATH=${UNPACK_DIR%/*}work
	export GOROOT=${UNPACK_DIR}
	export GOROOT_BOOTSTRAP=${GOROOT}
	export PATH=${GOROOT}/bin:${PATH}
	
	my_unpack_tgz "${UNPACK_DIR}" "${DL_URL}";
}

# 安装sbt
function my_sbt
{
	VERSION=
	DL_URL=https://raw.githubusercontent.com/paulp/sbt-extras/master/sbt
	DL_FILE=${DL_URL##*/}
	UNPACK_DIR=${HOME}/sbt
	
	export SBTPATH=${UNPACK_DIR}
	export PATH=${SBTPATH}:${PATH}
	
	mkdir -p ${SBTPATH}
	wget -O ${SBTPATH}/sbt ${DL_URL}
	chmod a+x ${SBTPATH}/sbt
}

