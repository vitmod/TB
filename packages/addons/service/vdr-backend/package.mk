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

PKG_NAME="vdr-backend"
PKG_VERSION="6.0"
PKG_REV="1"
PKG_LICENSE="GPL"
PKG_SITE="http://www.openelec.tv"
PKG_URL=""
PKG_DEPENDS_TARGET="vdr vdr-plugin-vnsiserver vdr-plugin-dvbapi"
PKG_SECTION="service"
PKG_SHORTDESC="A powerful DVB TV application"
PKG_LONGDESC=""

PKG_IS_ADDON="yes"
PKG_ADDON_NAME="VDR PVR Backend"
PKG_ADDON_TYPE="xbmc.service"
PKG_ADDON_ID="service.vdr"

PKG_DISCLAIMER="this is an unofficial addon. please don't ask for support in openelec forum / irc channel"
PKG_MAINTAINER="Stefan Saraev (seo @ freenode)"

make_target() {
  : # nothing to do here
}

makeinstall_target() {
  : # nothing to do here
}

addon() {
  # set PKG_LONGDESC
  PKG_LONGDESC="Version info:\n"
  for dep in $PKG_DEPENDS_TARGET ; do
    PKG_LONGDESC="$PKG_LONGDESC $dep: $(get_pkg_version $dep)\n"
  done

  VDR_DIR="$(get_build_dir vdr)"
  VDR_PLUGIN_VNSISERVER_DIR="$(get_build_dir vdr-plugin-vnsiserver)"

  mkdir -p $ADDON_BUILD/$PKG_ADDON_ID/config
  touch $ADDON_BUILD/$PKG_ADDON_ID/config/channels.conf
  cp $VDR_DIR/diseqc.conf $ADDON_BUILD/$PKG_ADDON_ID/config
  cp $VDR_DIR/keymacros.conf $ADDON_BUILD/$PKG_ADDON_ID/config
  cp $VDR_DIR/scr.conf $ADDON_BUILD/$PKG_ADDON_ID/config
  cp $VDR_DIR/sources.conf $ADDON_BUILD/$PKG_ADDON_ID/config
  cp $VDR_DIR/svdrphosts.conf $ADDON_BUILD/$PKG_ADDON_ID/config
  echo '0.0.0.0/0' >> $ADDON_BUILD/$PKG_ADDON_ID/config/svdrphosts.conf

  mkdir -p $ADDON_BUILD/$PKG_ADDON_ID/config/plugins

  mkdir -p $ADDON_BUILD/$PKG_ADDON_ID/plugin
  cp -PR $VDR_PLUGIN_VNSISERVER_DIR/libvdr*.so.* $ADDON_BUILD/$PKG_ADDON_ID/plugin
  cp -PR $(get_build_dir vdr-plugin-dvbapi)/libvdr*.so.* $ADDON_BUILD/$PKG_ADDON_ID/plugin

  mkdir -p $ADDON_BUILD/$PKG_ADDON_ID/config/plugins/vnsiserver
  cp -PR $VDR_PLUGIN_VNSISERVER_DIR/vnsiserver/allowed_hosts.conf $ADDON_BUILD/$PKG_ADDON_ID/config/plugins/vnsiserver

  mkdir -p $ADDON_BUILD/$PKG_ADDON_ID/bin
  cp -P $VDR_DIR/vdr $ADDON_BUILD/$PKG_ADDON_ID/bin
}
