#!/usr/bin/bash

build_linux () {

    gcc -fPIC -c pcgrand.c -o pcgrand.o
    gcc -shared -o libpcgrand.so pcgrand.o

    # To inspect the library: 
    # nm -D libpcgrand.so | grep tc_

}

build_windows () {

    gcc -c pcgrand.c -o pcgrand.o
    gcc -shared -o pcgrand.dll pcgrand.o -Wl,--out-implib,libpcgrand.a

}

os_name=$(uname -s)

case "$os_name" in
  Linux*)
    build_linux
    ;;
  Darwin*)
    echo "Mac is not supported."
    ;;
  CYGWIN* | MINGW*)
    build_windows
    ;;
  *)
    echo "Unknown or unsupported operating system: '$os_name'."
    ;;
esac