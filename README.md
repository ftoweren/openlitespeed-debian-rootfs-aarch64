# Openlitespeed on Debian Trixie-rootfs (AARCH64) | php84 | port 80

_general info:_

- Openlitespeed-1.9.2 in latest version (2026-08) with PHP 8.4.24
- Openlitespeed-1.8.4 on Debian Trixie rootfs essential + apt (linux/aarch64)
- Expose http 80 (8880:80), https 443 (8843:443), admin https 7080 (8870:7080)
- Built and tested on ARM64 device (ZTE B860H v.2) with Armbian Community v25.11 running
```
https://github.com/armbian/community/releases/download/25.11.0-trunk.472/Armbian_community_25.11.0-trunk.472_Aml-s9xx-box_trixie_current_6.12.57_minimal.img.xz
```

---

## Quick Start

### Pull Image
```bash
docker pull ftoweren/openlitespeed-debian-rootfs-x86_64:latest
```
```bash
docker pull ftoweren/openlitespeed-debian-rootfs-aarch64:2025-12
```
### Run Container

With Custom Ports/Your prefered Ports:
```bash
docker run -itd -p 8880:80 -p 8843:443 \
  -p 8870:7080 --name \
  ols-debian-rootfs \
  --restart always \
  ftoweren/openlitespeed-debian-rootfs-aarch64:latest
```
With Volume & Custom Ports/Your prefered Ports:
```bash
docker run -itd -p 8880:80 -p 8843:443 \
  -p 8870:7080 --name \
  ols-debian-rootfs \
  --restart always \
  -v openlitespeed_data:/var/lsws-www
  ftoweren/openlitespeed-debian-rootfs-aarch64:latest
```

### Post-Installation Management
Change OpenLiteSpeed Admin Password:

_current/latest version: admin/erMlh9T6KhKF4AMj_
```bash
docker exec -it ols-debian-rootfs /usr/local/lsws/admin/misc/admpass.sh
```
Change Container Root Password (if needed):
```bash
docker exec -it ols-debian-rootfs passwd
```
---

## Build from Source

### 1.  Generate Custom Minimal Debian Trixie RootFS
To build the exact base rootfs tarball used in this setup (build rootfs using mmdebstrap):
```bash
mmdebstrap --varian=essential --include=apt --include=passwd --include=openssl \
  --include=ca-certificates --include=procps --include=curl --include=wget \
  --aptopt='Apt::Install-Recommends "false"' --dpkgopt="path-exclude=/usr/share/doc/*" \
  --dpkgopt="path-include=/usr/share/doc/*/copyright" --dpkgopt="path-exclude=/usr/share/man/*" \
  --dpkgopt="path-exclude=/usr/share/groff/*"  --dpkgopt="path-exclude=/usr/share/info/*" \
  --dpkgopt="path-exclude=/usr/share/lintian/*" --dpkgopt="path-exclude=/usr/share/locale/*" \
  --dpkgopt="path-exclude=/usr/share/i18n/*" --dpkgopt="path-exclude=/usr/lib/debug/*" \
trixie debian-rootfs-essential-apt-trixie-aarch64.tar.gz
```

### 2.  Build Docker Image
```bash
docker build --no-cache -f path/Dockerfile -t image_name:tag .
```
