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
    sudo apt install -y build-essential meson \
    ninja-build pkg-config git \
    libglib2.0-dev libgusb-dev libnss3-dev libgudev-1.0-dev \
    libpixman-1-dev libgirepository1.0-dev fprintd \
    cmake libssl-dev systemd-dev git
elif [ "$OS" = "fedora" ]; then
    echo "Fedora detected."
    # Build is done inside container.
    sudo dnf group install -y "development-tools"
    sudo dnf install -y \
        meson ninja-build systemd-devel cmake \
        libgusb-devel cairo-devel gobject-introspection-devel \
        libgudev-devel gcc-c++ openssl-devel
else
    echo "Unsupported operating system: $OS"
    exit 1
fi

# Obtain the source code of libfprint.so with NB-2033-U patch.
git clone -b nb2033-support https://gitlab.freedesktop.org/Kernel-Error/libfprint.git
cd libfprint || exit 1

# Configure the build the libfprint.so

# Build fprintd
meson setup builddir --prefix=/usr/local -Ddoc=false -Dgtk-examples=false
ninja -C builddir

# Install the build artifact.
sudo ninja -C builddir install

# Fedora only. Move the library to the appropriate Fedora directory.
# Where nb2033u is the name of sensor.
if [ "$OS" = "fedora" ]; then
    sudo cp /usr/local/lib64/libfprint-2.so.2.0.0 /usr/lib64/libfprint-2.so.2.0.0.nb2033u
fi

# Update the library link
sudo ldconfig

# Back to the original directory.
cd - || exit 1

