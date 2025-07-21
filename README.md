# macbook-pro-13-2017-ubuntu-drivers


### This repository provides a comprehensive installation script for setting up all necessary drivers to run Ubuntu 24.04.3 seamlessly on the `MacBook Pro (13-inch, 2017)`, specifically for the board model `B4831CEBD52A0C4C`.


### Clone the Repository
This project uses Git submodules, so you need to clone it recursively:

```bash
git clone --recursive https://github.com/bastiansg/macbook-pro-13-2017-ubuntu-drivers.git
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
