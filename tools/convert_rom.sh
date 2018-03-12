#!/bin/sh
cp "$1" rom.gb

maybe_upercase="${1%.*}"_rom.h
lower="$(echo ${maybe_upercase} | awk '{print tolower($0)}')"
xxd -i rom.gb | sed 's/unsigned/unsigned const/g' > "${lower}"

rm rom.gb

