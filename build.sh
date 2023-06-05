#!/bin/bash

echo "Installing libnl3-dev"

apt install libssl-dev libnl-3-dev


echo "Fixing configuration files"
cp hostap/hostapd/defconfig hostap/hostapd/.config
sed -i 's/^#CONFIG_IEEE80211R=y$/CONFIG_IEEE80211R=y/g' hostap/hostapd/.config
echo "CFLAGS += -I/usr/include/libnl3" >> hostap/hostapd/.config

echo "Apply Patch"
patch source: 'patchPMKID.patch', target: "hostap/src/ap/wpa_auth.c"

echo "Building.."
make -C hostap/hostapd
