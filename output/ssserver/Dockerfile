# ssserver

FROM alpine

RUN apk add --update py-pip \
 && pip install shadowsocks \
 && rm -rf /var/cache/apk/* \
 && echo '#!/bin/sh -e'  > /etc/rc.local \
 && echo '# rc.local'   >> /etc/rc.local \
 && echo 'ssserver -p 443 -k ABCabc123 -m rc4-md5 --user nobody' >> /etc/rc.local \
 && echo 'exit 0' >> /etc/rc.local \
 && chmod +x /etc/rc.local

CMD ["/etc/rc.local"]

