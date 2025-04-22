#!/usr/bin/bash

build_linux () {

    cd src/pcgrand
    ./build-lib.sh

    if [ -f "libpcgrand.so" ]; then

        cd ../..

        odin build src -out:app -extra-linker-flags:"-L./src/pcgrand -lpcgrand"

        if [ -f "app" ]; then

            mkdir -p output
            cp app output
            rm app

            cp src/pcgrand/libpcgrand.so output

        fi
    
    fi

}

build_windows () {

    cd src/pcgrand
    ./build-lib.sh

    if [ -f "libpcgrand.a" ]; then

        cd ../..

        odin build src -out:app.exe -extra-linker-flags:"-L.\\src\\pcgrand -lpcgrand"

        if [ -f "app.exe" ]; then

            mkdir -p output
            cp app.exe output
            rm app.exe

            cp src/pcgrand/pcgrand.dll output
            
        fi

    fi

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