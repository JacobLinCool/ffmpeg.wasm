#!/bin/bash

set -euo pipefail

CONF_FLAGS=(
  --target-os=none              # disable target specific configs
  --arch=x86_32                 # use x86_32 arch
  --disable-everything                # Disable all features by default
  --enable-cross-compile        # use cross compile configs
  --disable-asm                 # disable asm
  --disable-stripping           # disable stripping as it won't work
  --disable-programs            # disable ffmpeg, ffprobe and ffplay build
  --disable-doc                 # disable doc build
  --disable-debug               # disable debug mode
  --disable-runtime-cpudetect   # disable cpu detection
  --disable-autodetect          # disable env auto detect
  --enable-demuxer=wav                # Enable WAV demuxer
  --enable-muxer=mp3                  # Enable MP3 muxer
  --enable-parser=mp3                 # Enable MP3 parser
  --enable-encoder=libmp3lame         # Enable MP3 encoder
  --enable-decoder=pcm_s16le          # Enable PCM decoder (WAV)
  --enable-protocol=file
  --enable-filter=anull,aformat,aresample,pan
  --disable-avdevice                  # Disable device support
  --disable-swscale                   # Disable video scaling
  --disable-network                   # Disable network support

  # assign toolchains and extra flags
  --nm=emnm
  --ar=emar
  --ranlib=emranlib
  --cc=emcc
  --cxx=em++
  --objcc=emcc
  --dep-cc=emcc
  --extra-cflags="$CFLAGS"
  --extra-cxxflags="$CXXFLAGS"

  # disable thread when FFMPEG_ST is NOT defined
  ${FFMPEG_ST:+ --disable-pthreads --disable-w32threads --disable-os2threads}
)

emconfigure ./configure "${CONF_FLAGS[@]}" $@
emmake make -j
