################################################################################
#  This program is free software: you can redistribute it and/or modify
#  it under the terms of the GNU General Public License as published by
#  the Free Software Foundation, either version 2 of the License, or
#  (at your option) any later version.
#
#  This program is distributed in the hope that it will be useful,
#  but WITHOUT ANY WARRANTY; without even the implied warranty of
#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#  GNU General Public License for more details.
#
#  You should have received a copy of the GNU General Public License
#  along with this program.  If not, see <http://www.gnu.org/licenses/>.
################################################################################

PKG_NAME="openssh"
PKG_VERSION="7.2p2"
PKG_SITE="http://www.openssh.com/"
PKG_URL="http://ftp.openssh.com/pub/OpenBSD/OpenSSH/portable/$PKG_NAME-$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain zlib libressl"
PKG_SHORTDESC="openssh: An open re-implementation of the SSH package"

PKG_AUTORECONF="yes"

PKG_CONFIGURE_OPTS_TARGET="ac_cv_path_PERL= \
                           --sysconfdir=/etc/ssh \
                           --libexecdir=/usr/lib/openssh \
                           --disable-strip \
                           --disable-lastlog \
                           --with-sandbox=no \
                           --disable-utmp \
                           --disable-utmpx \
                           --disable-wtmp \
                           --disable-wtmpx \
                           --without-rpath \
                           --with-ssl-engine \
                           --disable-pututline \
                           --disable-pututxline \
                           --disable-etc-default-login \
                           --with-keydir=/storage/.cache/ssh \
                           --without-pam"

pre_configure_target() {
  export LD="$TARGET_CC"
  export LDFLAGS="$TARGET_CFLAGS $TARGET_LDFLAGS"
}

post_makeinstall_target() {
  rm -rf $INSTALL/usr/lib/openssh/ssh-keysign
  rm -rf $INSTALL/usr/lib/openssh/ssh-pkcs11-helper
  rm -rf $INSTALL/usr/bin/ssh-add
  rm -rf $INSTALL/usr/bin/ssh-agent
  rm -rf $INSTALL/usr/bin/ssh-keyscan

  sed -i $INSTALL/etc/ssh/sshd_config \
      -e "s|^#PermitRootLogin.*|PermitRootLogin yes|g" \
      -e "s|^#PermitEmptyPasswords.*|PermitEmptyPasswords yes|g"
}

post_install() {
  add_user sshd "*" 101 65534 "/var/empty/sshd" "/bin/sh"

  enable_service sshd.service
}
