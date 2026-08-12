# OpenLiteSpeed on Debian Trixie RootFS (ARM64 / AArch64)

_general info:_

An ultra-lightweight, high-performance OpenLiteSpeed (1.8.4) Docker image built from scratch using a custom Debian Trixie (Testing) `mmdebstrap` rootfs. Optimized for ARM64 edge devices, Single Board Computers (SBCs), and low-resource environments.
- Openlitespeed-1.8.4 on Debian Trixie rootfs essential + apt (linux/aarch64)
- Expose http 80 (8880:80), https 443 (8843:443), admin https 7080 (8870:7080)
- Built and tested on ARM64 device (ZTE B860H v.2) with Armbian Community v25.11 running:
```
https://github.com/armbian/community/releases/download/25.11.0-trunk.472/Armbian_community_25.11.0-trunk.472_Aml-s9xx-box_trixie_current_6.12.57_minimal.img.xz
```
---

## Quick Start

### Pull Image
```bash
docker pull ftoweren/openlitespeed-debian-rootfs-aarch64:latest
```

### Run Container (With Persistent Volume & Custom Ports)
```bash
docker run -itd \
  -p 8880:80 \
  -p 8843:443 \
  -p 8870:7080 \
  --name ols-debian-rootfs \
  --restart always \
  -v openlitespeed_data:/var/lsws-www \
  ftoweren/openlitespeed-debian-rootfs-aarch64:latest
```

### Post-Installation Management
Change OpenLiteSpeed Admin Password:
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
```
mmdebstrap --variant=essential --include=apt,passwd,openssl,ca-certificates,procps,curl,wget \
  --aptopt='Apt::Install-Recommends "false"' \
  --dpkgopt="path-exclude=/usr/share/doc/*" \
  --dpkgopt="path-include=/usr/share/doc/*/copyright" \
  --dpkgopt="path-exclude=/usr/share/man/*" \
  --dpkgopt="path-exclude=/usr/share/groff/*" \
  --dpkgopt="path-exclude=/usr/share/info/*" \
  --dpkgopt="path-exclude=/usr/share/lintian/*" \
  --dpkgopt="path-exclude=/usr/share/locale/*" \
  --dpkgopt="path-exclude=/usr/share/i18n/*" \
  --dpkgopt="path-exclude=/usr/lib/debug/*" \
  trixie debian-rootfs-essential-apt-trixie-aarch64.tar.gz
```

### 2.  Build Docker Image
```
docker build --no-cache -f path/Dockerfile -t openlitespeed-debian-rootfs-aarch64:latest .
```
