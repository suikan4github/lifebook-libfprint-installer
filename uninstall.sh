#!/bin/sh

cd libfprint || exit 1
if [ "$OS" = "fedora" ]; then
    sudo rm /usr/lib64/libfprint-2.so.2.0.0.nb2033u
fi
sudo ninja -C builddir uninstall
sudo ldconfig