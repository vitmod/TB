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

PKG_NAME="ffmpeg"
PKG_VERSION="3.0.2"
PKG_SITE="https://ffmpeg.org"
PKG_URL="http://ffmpeg.org/releases/${PKG_NAME}-${PKG_VERSION}.tar.bz2"
PKG_DEPENDS_TARGET="toolchain zlib bzip2"
PKG_SHORTDESC="FFmpeg is a complete, cross-platform solution to record, convert and stream audio and video."

case "$TARGET_FPU" in
  neon*)
      FFMPEG_FPU="--enable-neon"
  ;;
esac

configure_target() {
  ../configure --prefix=/usr \
              --arch=$TARGET_ARCH \
              --cpu=$TARGET_CPU \
              --cross-prefix=$TARGET_PREFIX \
              --enable-cross-compile \
              --sysroot=$SYSROOT_PREFIX \
              --sysinclude="$SYSROOT_PREFIX/usr/include" \
              --target-os="linux" \
              --pkg-config="/usr/bin/pkg-config" \
              --extra-cflags="$CFLAGS" \
              --build-suffix="" \
              --enable-pic \
              --disable-logging \
              --enable-gpl \
              --disable-version3 \
              --disable-nonfree \
              --enable-static \
              --disable-shared \
              --disable-small \
              --enable-runtime-cpudetect \
              --disable-gray \
              --enable-swscale-alpha \
              --disable-ffmpeg \
              --disable-ffplay \
              --disable-ffprobe \
              --disable-ffserver \
              --disable-doc \
              --disable-htmlpages \
              --disable-manpages \
              --disable-podpages \
              --disable-txtpages \
              --disable-avdevice \
              --enable-avcodec \
              --enable-avformat \
              --enable-swresample \
              --enable-swscale \
              --enable-postproc \
              --enable-avfilter \
              --enable-pthreads \
              --disable-w32threads \
              --enable-network \
              --enable-mdct \
              --enable-rdft \
              --enable-fft \
              --disable-d3d11va \
              --disable-dxva2 \
              --disable-vaapi \
              --disable-vda \
              --disable-vdpau \
              --disable-encoders \
              --enable-encoder=aac,ac3,mjpeg,png,wmav2 \
              --disable-decoder=mpeg_xvmc \
              --disable-muxers \
              --enable-muxer=adts,asf,ipod,mpegts,ogg,spdif \
              --disable-indevs \
              --disable-outdevs \
              --disable-devices \
              --enable-bzlib \
              --disable-gnutls \
              --disable-libvorbis \
              --disable-openssl \
              --enable-zlib \
              --disable-symver \
              --disable-memalign-hack \
              --enable-asm \
              --disable-altivec \
              --disable-yasm \
              --disable-debug \
              --enable-optimizations \
              --disable-extra-warnings \
              --enable-stripping \
              $FFMPEG_FPU
}
