#!/bin/sh

# Check wether Ubuntu or fedora 
if [ -f /etc/os-release ]; then
    . /etc/os-release
    OS=$ID
else
    echo "Cannot determine the operating system."
    exit 1
fi

# Get into the source directory.
cd libfprint || exit 1

# Delete the copied library. 
if [ "$OS" = "fedora" ]; then
    sudo rm /usr/lib64/libfprint-2.so.2.0.0.nb2033u
fi

# Uninstall and update the library configuration.
sudo ninja -C builddir uninstall
sudo ldconfig

# Go back to the original directory.
cd - || exit 1
