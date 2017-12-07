#!/bin/bash

#
# Map Apple keyboard as if it were a proper keyboard
#

hid_apple_status=$(dkms status hid-apple)
if [[ -n "${hid_apple_status}" ]]; then
    echo "Info: hid-apple kernel module already patched."
    exit 0
fi

git clone https://github.com/free5lot/hid-apple-patched.git
cd hid-apple-patched
sudo dkms add .
sudo dkms build hid-apple/1.0
sudo dkms build install hid-apple/1.0

cat << EOF | sudo tee /etc/modprobe.d/hid_apple.conf
options hid_apple fnmode=2
options hid_apple swap_fn_leftctrl=1
options hid_apple swap_opt_cmd=1
options hid_apple rightalt_as_right_ctrl=1
options hid_apple ejectcd_as_delete=1
EOF

sudo update-initramfs -u
