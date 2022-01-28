#!/bin/bash

if test -f "$1"
then
echo "found file fullflash"
else
echo "Error: Not found fullflash file"
echo "Use: converter_rom_4to8_MiB.sh [4MiB_fullflash_file] [uboot_file]"
exit -1
fi

if test -f "$2"
then
echo "found file uboot"
else
echo "Error: Not found u-boot file"
echo "Use: converter_rom_4to8_MiB.sh [4MiB_fullflash_file] [uboot_file]"
exit -1
fi

tr '\0' '\377' < /dev/zero | dd bs=1024 count=8192 of=temp8mbflash.bin
dd if=$2 of=8mb.rom bs=1K count=120
dd if=$1 of=8mb.rom bs=1K count=3906 seek=120 skip=120
dd if=temp8mbflash.bin of=8mb.rom bs=1K count=4160 seek=4032
rm temp8mbflash.bin
dd if=$1  of=8mb.rom bs=1K count=64 seek=8128 skip=4032

echo "Complite. New fullflash file \"8mb.rom\" create."
