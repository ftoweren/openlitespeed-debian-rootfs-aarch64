FROM scratch
ENV DEBIAN_FRONTEND=noninteractive

ADD variant-essential+apt/debian-rootfs-essential-apt-trixie-aarch64.tar.gz /

#uncomment below to update & upgrade
#RUN apt-get update && apt-get upgrade -y

#New OLS (1.9.2 | 2026-08-06) with PHP 8.3 (default)
RUN wget -O - https://repo.litespeed.sh | bash
RUN apt-get install openlitespeed -y
#uncomment below to upgrade to php 8.4. (8.4.24, now 2026/08/21 15:30:22)
RUN apt-get install lsphp84 -y
RUN sed -i 's_lsphp83/bin/lsphp_lsphp84/bin/lsphp_g' /usr/local/lsws/conf/httpd_config.conf

#comment below if not using VOLUME
RUN cp -r /usr/local/lsws/Example/. /var/lsws-www/ && chown -R nobody:nogroup /var/lsws-www
RUN sed -i 's_Example/_/var/lsws-www/_g' /usr/local/lsws/conf/httpd_config.conf
RUN sed -i 's_conf/vhosts//var/lsws-www/vhconf.conf_conf/vhosts/Example/vhconf.conf_g' /usr/local/lsws/conf/httpd_config.conf
RUN	sed -i 's/8088/80/g' /usr/local/lsws/conf/httpd_config.conf

RUN apt-get autoremove -y && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* \
           /var/cache/apt/archives/*.deb \
           /var/tmp/* \
           /tmp/* \
		   /usr/local/lsws/Example/*

EXPOSE 80 443 7080

#comment below if not using volume or your prefered dir
VOLUME /var/lsws-www

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
