#!/bin/bash

# Check wether Ubuntu or fedora 
if [ -f /etc/os-release ]; then
    . /etc/os-release
    OS=$ID
else
    echo "Cannot determine the operating system."
    exit 1
fi

# Install fprintd and libfprint
if [ "$OS" = "ubuntu" ]; then
    echo "Ubuntu detected."
    # Build dependencies.
    sudo apt update
    sudo apt install build-essential meson \
    ninja-build pkg-config git \
    libglib2.0-dev libgusb-dev libnss3-dev libgudev-1.0-dev \
    libpixman-1-dev libgirepository1.0-dev fprintd \
    cmake libssl-dev systemd-dev git
elif [ "$OS" = "fedora" ]; then
    sudo dnf install fprintd libfprint
else
    echo "Unsupported operating system: $OS"
    exit 1
fi

# Get the branch.
git clone -b nb2033-support https://gitlab.freedesktop.org/Kernel-Error/libfprint.git
cd libfprint

# Configure the build
meson setup builddir --prefix=/usr/local -Ddoc=false -Dgtk-examples=false

# Build and install
ninja -C builddir
sudo ninja -C builddir install
sudo ldconfig

