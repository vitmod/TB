################################################################################
#      This file is part of OpenELEC - http://www.openelec.tv
#      Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)
#
#  OpenELEC is free software: you can redistribute it and/or modify
#  it under the terms of the GNU General Public License as published by
#  the Free Software Foundation, either version 2 of the License, or
#  (at your option) any later version.
#
#  OpenELEC is distributed in the hope that it will be useful,
#  but WITHOUT ANY WARRANTY; without even the implied warranty of
#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#  GNU General Public License for more details.
#
#  You should have received a copy of the GNU General Public License
#  along with OpenELEC.  If not, see <http://www.gnu.org/licenses/>.
################################################################################

PKG_NAME="systemd"
PKG_VERSION="229"
PKG_SITE="http://www.freedesktop.org/wiki/Software/systemd"
PKG_URL="https://github.com/systemd/systemd/archive/v$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain libcap kmod util-linux"
PKG_SHORTDESC="systemd: a system and session manager"

PKG_AUTORECONF="yes"

PKG_CONFIGURE_OPTS_TARGET="ac_cv_func_malloc_0_nonnull=yes \
                           ac_cv_have_decl_IFLA_BOND_AD_INFO=no \
                           ac_cv_have_decl_IFLA_BRPORT_UNICAST_FLOOD=no \
                           ac_cv_path_MOUNT_PATH="/bin/mount"
                           ac_cv_path_UMOUNT_PATH="/bin/umount"
                           KMOD=/usr/bin/kmod \
                           --disable-nls \
                           --disable-dbus \
                           --disable-utmp \
                           --disable-compat-libs \
                           --disable-coverage \
                           --enable-kmod \
                           --disable-xkbcommon \
                           --enable-blkid \
                           --disable-seccomp \
                           --disable-ima \
                           --disable-selinux \
                           --disable-apparmor \
                           --disable-xz \
                           --disable-zlib \
                           --disable-bzip2 \
                           --disable-lz4 \
                           --disable-pam \
                           --disable-acl \
                           --disable-smack \
                           --disable-gcrypt \
                           --disable-audit \
                           --disable-elfutils \
                           --disable-libcryptsetup \
                           --disable-qrencode \
                           --disable-gnutls \
                           --disable-microhttpd \
                           --disable-libcurl \
                           --disable-libidn \
                           --disable-libiptc \
                           --disable-binfmt \
                           --disable-vconsole \
                           --disable-bootchart \
                           --disable-quotacheck \
                           --enable-tmpfiles \
                           --disable-sysusers \
                           --disable-firstboot \
                           --disable-randomseed \
                           --disable-backlight \
                           --disable-rfkill \
                           --enable-logind \
                           --disable-machined \
                           --disable-importd \
                           --disable-hostnamed \
                           --disable-timedated \
                           --enable-timesyncd \
                           --disable-localed \
                           --disable-coredump \
                           --disable-polkit \
                           --enable-resolved \
                           --enable-networkd \
                           --disable-efi \
                           --disable-gnuefi \
                           --disable-kdbus \
                           --disable-myhostname \
                           --enable-hwdb \
                           --disable-manpages \
                           --disable-hibernate \
                           --disable-ldconfig \
                           --enable-split-usr \
                           --disable-tests \
                           --with-debug-tty=/dev/tty3 \
                           --with-sysvinit-path= \
                           --with-sysvrcnd-path= \
                           --with-tty-gid=5 \
                           --with-dbuspolicydir=/etc/dbus-1/system.d \
                           --with-dbussessionservicedir=/usr/share/dbus-1/services \
                           --with-dbussystemservicedir=/usr/share/dbus-1/system-services \
                           --with-dbusinterfacedir=/usr/share/dbus-1/interfaces \
                           --with-rootprefix=/usr \
                           --with-rootlibdir=/lib"

pre_build_target() {
  # broken autoreconf
  ( cd $PKG_BUILD
    intltoolize --force
  )
}

post_makeinstall_target() {
  # remove unneeded stuff
  rm -rf $INSTALL/etc/systemd/system
  rm -rf $INSTALL/etc/xdg
  rm -rf $INSTALL/etc/X11
  rm  -f $INSTALL/usr/bin/kernel-install
  rm -rf $INSTALL/usr/lib/kernel
  rm -rf $INSTALL/usr/lib/rpm
  rm -rf $INSTALL/usr/lib/systemd/catalog
  rm -rf $INSTALL/usr/lib/systemd/system-generators
  rm -rf $INSTALL/usr/lib/systemd/system-preset
  rm -rf $INSTALL/usr/lib/systemd/user
  rm -rf $INSTALL/usr/lib/systemd/user-generators
  rm -rf $INSTALL/usr/lib/tmpfiles.d/etc.conf
  rm -rf $INSTALL/usr/lib/tmpfiles.d/home.conf
  rm -rf $INSTALL/usr/lib/tmpfiles.d/systemd-nspawn.conf
  rm -rf $INSTALL/usr/lib/tmpfiles.d/x11.conf
  rm -rf $INSTALL/usr/share/factory

  # clean up hwdb
  rm -f $INSTALL/usr/lib/udev/hwdb.d/20-OUI.hwdb
  rm -f $INSTALL/usr/lib/udev/hwdb.d/20-acpi-vendor.hwdb
  rm -f $INSTALL/usr/lib/udev/hwdb.d/20-bluetooth-vendor-product.hwdb
  rm -f $INSTALL/usr/lib/udev/hwdb.d/20-net-ifname.hwdb
  rm -f $INSTALL/usr/lib/udev/hwdb.d/20-sdio-classes.hwdb
  rm -f $INSTALL/usr/lib/udev/hwdb.d/20-sdio-vendor-model.hwdb

  # remove Network adaper renaming rule, this is confusing
  rm -rf $INSTALL/usr/lib/udev/rules.d/80-net-setup-link.rules

  # remove getty units, we dont want a console
  rm -rf $INSTALL/usr/lib/systemd/system/autovt@.service
  rm -rf $INSTALL/usr/lib/systemd/system/console-getty.service
  rm -rf $INSTALL/usr/lib/systemd/system/console-shell.service
  rm -rf $INSTALL/usr/lib/systemd/system/container-getty@.service
  rm -rf $INSTALL/usr/lib/systemd/system/getty.target
  rm -rf $INSTALL/usr/lib/systemd/system/getty@.service
  rm -rf $INSTALL/usr/lib/systemd/system/serial-getty@.service
  rm -rf $INSTALL/usr/lib/systemd/system/*.target.wants/getty.target

  # remove other notused or nonsense stuff (our /etc is ro)
  rm -rf $INSTALL/usr/lib/systemd/systemd-update-done
  rm -rf $INSTALL/usr/lib/systemd/system/systemd-update-done.service
  rm -rf $INSTALL/usr/lib/systemd/system/*.target.wants/systemd-update-done.service

  # remove nspawn
  rm -rf $INSTALL/usr/bin/systemd-nspawn
  rm -rf $INSTALL/usr/lib/systemd/system/systemd-nspawn@.service

  # meh nss_resolve
  rm -rf $INSTALL/usr/lib/libnss_resolve*

  # tune journald.conf
  sed -i -e "s,^.*Compress=.*$,Compress=no,g" \
         -e "s,^.*SplitMode=.*$,SplitMode=none,g" \
         -e "s,^.*MaxRetentionSec=.*$,MaxRetentionSec=1day,g" \
         -e "s,^.*RuntimeMaxUse=.*$,RuntimeMaxUse=2M,g" \
         -e "s,^.*RuntimeMaxFileSize=.*$,RuntimeMaxFileSize=512K,g" \
         -e "s,^.*SystemMaxUse=.*$,SystemMaxUse=10M,g" \
         $INSTALL/etc/systemd/journald.conf

  # tune timesyncd.conf
  sed -i -e "s,^#NTP=.*$,NTP=0.pool.ntp.org 1.pool.ntp.org 2.pool.ntp.org 3.pool.ntp.org,g" \
         $INSTALL/etc/systemd/timesyncd.conf

  # tune resolved.conf
  sed -i -e "s,^#LLMNR=.*$,LLMNR=no,g" \
         $INSTALL/etc/systemd/resolved.conf

  # provide 'halt', 'shutdown', 'reboot' & co.
  mkdir -p $INSTALL/usr/sbin
  for i in halt poweroff reboot shutdown ; do
    ln -sf /usr/bin/systemctl $INSTALL/usr/sbin/$i
  done

  # strip
  debug_strip $INSTALL/usr

  # defaults
  mkdir -p $INSTALL/usr/config
  cp -PR $PKG_DIR/config/* $INSTALL/usr/config

  ln -sf /run/systemd/resolve/resolv.conf $INSTALL/etc/resolv.conf

  rm -rf $INSTALL/etc/udev/hwdb.d
  ln -sf /storage/.config/hwdb.d $INSTALL/etc/udev/hwdb.d
  rm -rf $INSTALL/etc/udev/rules.d
  ln -sf /storage/.config/udev.rules.d $INSTALL/etc/udev/rules.d
  rm -rf $INSTALL/etc/systemd/network
  ln -sf /storage/.config/network $INSTALL/etc/systemd/network
}

post_install() {
  add_group systemd-journal 190

  add_group systemd-network 193
  add_user systemd-network x 193 193 "systemd-network" "/" "/bin/sh"
  add_group systemd-timesync 194
  add_user systemd-timesync x 194 194 "systemd-timesync" "/" "/bin/sh"
  add_group systemd-resolve 195
  add_user systemd-resolve x 195 195 "systemd-resolve" "/" "/bin/sh"

  add_group audio 63
  add_group cdrom 11
  add_group dialout 18
  add_group disk 6
  add_group floppy 19
  add_group kmem 9
  add_group lp 7
  add_group tape 33
  add_group tty 5
  add_group video 39
  add_group utmp 22
  add_group input 199

  enable_service systemd-timesyncd.service
  enable_service systemd-networkd.service
  enable_service systemd-resolved.service
  enable_service debug-shell.service
}
