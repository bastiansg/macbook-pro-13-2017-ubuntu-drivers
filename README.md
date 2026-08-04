# macbook-pro-13-2017-ubuntu-drivers


### This repository provides a comprehensive installation script for setting up all necessary drivers to run Ubuntu 26.04 on the `MacBook Pro (13-inch, 2017)`, specifically for the board model `B4831CEBD52A0C4C`.

### Ubuntu 26.04 support

Ubuntu 26.04 with kernel 7 uses three maintained forks:

- [`bcwc_pcie`](https://github.com/bastiansg/bcwc_pcie): updates the FaceTimeHD driver for kernel 7 API changes.
- [`macbook12-bluetooth-driver`](https://github.com/bastiansg/macbook12-bluetooth-driver): prevents kernel source downloads from hanging during installation.
- [`snd_hda_macbookpro`](https://github.com/bastiansg/snd_hda_macbookpro): fixes the DKMS module path used by kernel 6.17 and newer.

The FaceTimeHD module has been verified to build on kernel `7.0.0-15-generic`.


### Clone the Repository
This project uses Git submodules, so you need to clone it recursively:

```bash
git clone --recursive https://github.com/bastiansg/macbook-pro-13-2017-ubuntu-drivers.git
```

If you already cloned the repository before the `bcwc_pcie` fork change, update the submodules:

```bash
git pull
git submodule sync --recursive
git submodule update --init --recursive
```

### Requirements

Before running the installation script, ensure that the package `linux-source` is installed. This package provides the necessary kernel sources for building certain drivers. In some cases, the package might not be available directly from the package manager, and you will need to download it manually:

1. Check Your Kernel Version:

    Open a terminal and run:
    ```bash
    uname -a
    ```
    Use the output to identify your current kernel version.

2. Download the package:
    Go to https://archive.ubuntu.com/ubuntu/pool/main/l/linux/ and download the appropriate .deb file for your kernel version.

3. Install the Package:
    Open a terminal and run:
    ```bash
    sudo dpkg -i linux-source-[PACKAGE_VERSION].deb
    ```


### Installation script:

To install all the required drivers, run the following command:
```bash
sudo ./install.sh
```

### Features

This installation script ensures proper functionality of the following components:

    - Audio: Enables sound output.
    - Camera: Allows usage of the built-in camera.
    - Microphone: Enables audio input via the built-in microphone.
    - Bluetooth: Supports Bluetooth connectivity.
