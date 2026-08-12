# OpenLiteSpeed on Debian Trixie RootFS (ARM64 / AArch64)

An ultra-lightweight, high-performance OpenLiteSpeed (1.8.4) Docker image built from scratch using a custom Debian Trixie (Testing) `mmdebstrap` rootfs. Optimized for ARM64 edge devices, Single Board Computers (SBCs), and low-resource environments.

Tested and validated on **ZTE B860H v2** running **Armbian Community v25.11 (Linux Kernel 6.12)**.

---

## Quick Start

### Pull Image
```bash
docker pull ftoweren/openlitespeed-debian-rootfs-aarch64:latest

---

Run Container (With Persistent Volume & Custom Ports):
docker run -itd \
  -p 8880:80 \
  -p 8843:443 \
  -p 8870:7080 \
  --name ols-debian-rootfs \
  --restart always \
  -v openlitespeed_data:/var/lsws-www \
  ftoweren/openlitespeed-debian-rootfs-aarch64:latest

Post-Installation Management
----------------------------
Change OpenLiteSpeed Admin Password:
docker exec -it ols-debian-rootfs /usr/local/lsws/admin/misc/admpass.sh

Change Container Root Password (if needed):
docker exec -it ols-debian-rootfs passwd

---

How to Build from Source
------------------------

1.  Generate Custom Minimal Debian Trixie RootFS
To build the exact base rootfs tarball used in this setup (build rootfs using mmdebstrap):
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

2.  Build Docker Image
docker build --no-cache -f path/Dockerfile -t openlitespeed-debian-rootfs-aarch64:latest .
