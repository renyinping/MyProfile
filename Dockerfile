FROM ubuntu:12.04

RUN apt-get update \
 && apt-get install -y \
        lib32z1 lib32ncurses5 lib32bz2-1.0 lib32stdc++6 \
        build-essential ccache bison flex automake intltool libncurses5-dev libssl-dev \
        unzip git subversion mercurial gawk bash bash-completion vim sudo openssh-server \
    \
 && locale-gen zh_CN.UTF-8 en_US.UTF-8 \
 && echo 'LANG="zh_CN.UTF-8"'     >> /etc/environment \
 && echo 'LANGUAGE="en_US.UTF-8"' >> /etc/environment \
    \
 && useradd -m -s /bin/bash ubuntu \
 && echo 'ubuntu:ubuntu' | chpasswd \
 && echo 'ubuntu ALL=NOPASSWD: ALL' > /etc/sudoers.d/ubuntu \
 && chmod 440 /etc/sudoers.d/ubuntu \
    \
 && mkdir /var/run/sshd \
 && echo 'ClientAliveInterval 30' >> /etc/ssh/sshd_config \
 && echo 'ClientAliveCountMax 6'  >> /etc/ssh/sshd_config \
 && sed -i 's/^Port 22$/Port 443/g' /etc/ssh/sshd_config \
    \
 && echo '#!/bin/sh -e'  > /etc/rc.local \
 && echo '# rc.local'   >> /etc/rc.local \
 && echo '/usr/sbin/sshd -D' >> /etc/rc.local \
 && echo 'exit 0'       >> /etc/rc.local \
 && chmod +x /etc/rc.local

CMD ["/etc/rc.local"]

