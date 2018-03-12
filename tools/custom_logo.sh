#!/bin/sh

maybe_upercase="${1%.*}"
lower="$(echo ${maybe_upercase} | awk '{print tolower($0)}')"

./make_logo.py "$1" "${lower}".bin
cp "${lower}".bin logo.bin
xxd -i logo.bin > "${lower}"_logo.h
rm logo.bin

