#!/bin/sh

# Idempotentally provision users and devices in lava

set -ex

lava-server manage users list | grep -q admin || \
    $(lava-server manage users add --staff --superuser --email admin@example.com --passwd admin admin; \
      lava-server manage tokens add --user admin --secret cuc3w4jaku7qr4ixbsym0jmxx70p0lbtzq47sm2cx57y9yw7oadychyi1mkqkjbtmqexer6mkibdtewyi0xo7shwy6s0dhn1p0nq3jwm01m7yhrl9ajzr97usn1pzgqs)

lava-server manage workers list | grep dispatcher || \
    lava-server manage workers add dispatcher

# Add device types
lava-server manage device-types list | grep -q qemu || \
    lava-server manage device-types add qemu

lava-server manage device-types list | grep -q x86 || \
    lava-server manage device-types add x86

lava-server manage device-types list | grep -q beaglebone-black || \
    lava-server manage device-types add beaglebone-black

lava-server manage device-types list | grep -q bcm2837-rpi-3-b || \
    lava-server manage device-types add bcm2837-rpi-3-b

# Add machines
lava-server manage devices list | grep -q qemu-01 || \
    lava-server manage devices add --device-type qemu --worker dispatcher qemu-01

lava-server manage devices list | grep -q bbb-01 || \
    lava-server manage devices add --device-type beaglebone-black --worker dispatcher bbb-01

lava-server manage devices list | grep -q c2d-01 || \
    lava-server manage devices add --device-type x86 --worker dispatcher c2d-01

lava-server manage devices list | grep -q rpi3-01 || \
    lava-server manage devices add --device-type bcm2837-rpi-3-b --worker dispatcher rpi3-01
