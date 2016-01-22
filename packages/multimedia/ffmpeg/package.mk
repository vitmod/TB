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

PKG_NAME="ffmpeg"
PKG_VERSION="2.8.5-Jarvis-rc1"
PKG_LICENSE="LGPLv2.1+"
PKG_SITE="https://ffmpeg.org"
PKG_URL="https://github.com/xbmc/FFmpeg/archive/${PKG_VERSION}.tar.gz"
PKG_SOURCE_DIR="FFmpeg-${PKG_VERSION}"
PKG_DEPENDS_TARGET="toolchain yasm:host zlib bzip2 libvorbis"
PKG_SHORTDESC="FFmpeg is a complete, cross-platform solution to record, convert and stream audio and video."

case "$TARGET_ARCH" in
  arm)
      FFMPEG_TABLES="--enable-hardcoded-tables"
  ;;
  x86_64)
      FFMPEG_TABLES="--disable-hardcoded-tables"
  ;;
esac

case "$TARGET_FPU" in
  neon*)
      FFMPEG_FPU="--enable-neon"
  ;;
  *)
      FFMPEG_FPU=""
  ;;
esac

pre_configure_target() {
  cd $ROOT/$PKG_BUILD
  rm -rf .$TARGET_NAME
}

configure_target() {
  ./configure --prefix=/usr \
              --cpu=$TARGET_CPU \
              --arch=$TARGET_ARCH \
              --enable-cross-compile \
              --cross-prefix=$TARGET_PREFIX \
              --sysroot=$SYSROOT_PREFIX \
              --sysinclude="$SYSROOT_PREFIX/usr/include" \
              --target-os="linux" \
              --extra-version="$PKG_VERSION" \
              --nm="$NM" \
              --ar="$AR" \
              --as="$CC" \
              --cc="$CC" \
              --ld="$CC" \
              --host-cc="$HOST_CC" \
              --host-cflags="$HOST_CFLAGS" \
              --host-ldflags="$HOST_LDFLAGS" \
              --host-libs="-lm" \
              --extra-cflags="$CFLAGS" \
              --extra-ldflags="$LDFLAGS -fPIC" \
              --extra-libs="" \
              --extra-version="" \
              --build-suffix="" \
              --enable-static \
              --disable-shared \
              --enable-gpl \
              --disable-version3 \
              --disable-nonfree \
              --disable-logging \
              --disable-doc \
              --disable-debug --enable-stripping \
              --enable-pic \
              --pkg-config="$ROOT/$TOOLCHAIN/bin/pkg-config" \
              --enable-optimizations \
              --disable-extra-warnings \
              --disable-ffprobe \
              --disable-ffplay \
              --disable-ffserver \
              --disable-ffmpeg \
              --disable-avdevice \
              --enable-avcodec \
              --enable-avformat \
              --enable-swscale \
              --enable-postproc \
              --enable-avfilter \
              --disable-devices \
              --enable-pthreads \
              --disable-w32threads \
              --disable-x11grab \
              --enable-network \
              --disable-gnutls --disable-openssl \
              --disable-gray \
              --enable-swscale-alpha \
              --disable-small \
              --enable-dct \
              --enable-fft \
              --enable-mdct \
              --enable-rdft \
              --disable-crystalhd \
              --disable-vaapi \
              --disable-vdpau \
              --disable-dxva2 \
              --enable-runtime-cpudetect \
              $FFMPEG_TABLES \
              --disable-memalign-hack \
              --disable-encoders \
              --enable-encoder=ac3 \
              --enable-encoder=aac \
              --enable-encoder=wmav2 \
              --enable-encoder=mjpeg \
              --enable-encoder=png \
              --disable-decoder=mpeg_xvmc \
              --enable-hwaccels \
              --disable-muxers \
              --enable-muxer=spdif \
              --enable-muxer=adts \
              --enable-muxer=asf \
              --enable-muxer=ipod \
              --enable-muxer=mpegts \
              --enable-demuxers \
              --enable-parsers \
              --enable-bsfs \
              --enable-protocol=http \
              --disable-indevs \
              --disable-outdevs \
              --enable-filters \
              --disable-avisynth \
              --enable-bzlib \
              --disable-frei0r \
              --disable-libopencore-amrnb \
              --disable-libopencore-amrwb \
              --disable-libopencv \
              --disable-libdc1394 \
              --disable-libdcadec \
              --disable-libfaac \
              --disable-libfreetype \
              --disable-libgsm \
              --disable-libmp3lame \
              --disable-libnut \
              --disable-libopenjpeg \
              --disable-librtmp \
              --disable-libschroedinger \
              --disable-libspeex \
              --disable-libtheora \
              --disable-libvo-aacenc \
              --disable-libvo-amrwbenc \
              --enable-libvorbis --enable-muxer=ogg \
              --disable-libvpx \
              --disable-libx264 \
              --disable-libxavs \
              --disable-libxvid \
              --enable-zlib \
              --enable-asm \
              --disable-altivec \
              $FFMPEG_FPU \
              --enable-yasm \
              --disable-symver
}
