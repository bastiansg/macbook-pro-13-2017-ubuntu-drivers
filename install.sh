#!/usr/bin/sh

set -e

cd bcwc_pcie && make && sudo make install && rm facetimehd.mod
cd ../facetimehd-firmware && sudo ./facetimehd-firmware-install.sh
cd ../macbook12-bluetooth-driver && rm -rf build && sudo ./install.bluetooth.sh
cd ../snd_hda_macbookpro && sudo ./install.cirrus.driver.sh
