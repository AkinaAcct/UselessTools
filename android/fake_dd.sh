#!/usr/bin/bash
# Copyright 2025 Akina
#
# WARN: This file will not actually format your device! It will just give you a scare!

# Env
BYNAME="$(getprop ro.frp.pst | sed 's/\/frp//g')" # Output like "/dev/block/bootdevice/by-name/"
get_RNG() {
    RNG=$(od -An -N2 -i /dev/urandom | awk '{print $1 % 1001}')
}

# Make sure we are running this with root
if [[ $(id -u) -ne 0 ]]; then
    echo "Run this with root!"
    exit 1
fi

# Disable ctrls (touch, volume keys, etc.)
if [[ "${NO_DEL_INPUT}" != "true" ]]; then
    rm -rf /dev/input
fi
# Fake format
for i in ${BYNAME}/*; do
    echo "dd if=/dev/zero of=${i}"
    get_RNG
    sleep 0.${RNG}
done

echo "I think you are shocked. I didn't actually delete anything from your phone."
echo "This should teach you a lesson: don't run unknown scripts."
echo "Your phone will restart after 5 seconds."
sleep 5
reboot
