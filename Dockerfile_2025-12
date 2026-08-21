FROM scratch
ADD variant-essential+apt/debian-rootfs-essential-apt-trixie-aarch64.tar.gz /
#comment below if not using volume
VOLUME /var/lsws-www
#OLS with php 8.3.28
RUN wget -O - https://repo.litespeed.sh⁠ | bash
RUN apt install openlitespeed -y
#uncomment below to upgrade to php 8.4. (8.4.15, now 2025/12/13 14:23:46)
#RUN apt install lsphp84 lsphp84-common lsphp84-mysql lsphp84-redis lsphp84-imagick -y
#RUN sed -i 's_lsphp83/bin/lsphp_lsphp84/bin/lsphp_g' /usr/local/lsws/conf/httpd_config.conf
RUN sed -i 's_Example/_/var/lsws-www/_g' /usr/local/lsws/conf/httpd_config.conf
RUN sed -i 's_conf/vhosts//var/lsws-www/vhconf.conf_conf/vhosts/Example/vhconf.conf_g' /usr/local/lsws/conf/httpd_config.conf
RUN	sed -i 's/8088/80/g' /usr/local/lsws/conf/httpd_config.conf && 
apt autoremove -y && rm -rf /var/lib/apt/lists/* 
/var/cache/apt/archives/.deb /var/tmp/ /tmp/*
#comment below if not using VOLUME
RUN mv /usr/local/lsws/Example/* /var/lsws-www/ && chown -R lsadm:lsadm /var/lsws-www/*
EXPOSE 80 443 7080
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
