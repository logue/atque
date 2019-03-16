#!/bin/sh

./configure --host=i686-w64-mingw32.static --with-wx-config=i686-w64-mingw32.static-wx-config
make DESTDIR=`pwd`/_install install
i686-w64-mingw32.static-strip ./_install/usr/local/bin/*.exe