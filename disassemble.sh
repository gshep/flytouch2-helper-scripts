#!/bin/sh

FILE_PATH="$1"
if [ -z "$FILE_PATH" ]; then
    echo "Please specify path to a file."
    exit 1
fi

ADDRESS=`echo "$FILE_PATH" |cut -d - -f 1`
if [ -z "$ADDRESS" ]; then
    echo "Can't determine an address of a function: the first part of a file name must be the address."
    exit 2
fi

echo -n "Working directory: "
pwd

# toolchain
INFOTM_TC=${INFOTM_TC:-../toolchain_infotm_1.2.2/bin/arm-infotm-linux-gnueabi-}

OUTPUT_FILE_PATH="${FILE_PATH}.elf"

${INFOTM_TC}objcopy --change-addresses=$ADDRESS -I binary -O elf32-littlearm -B arm "$FILE_PATH" "$OUTPUT_FILE_PATH"

${INFOTM_TC}objcopy --set-section-flags .data=code "$OUTPUT_FILE_PATH"

${INFOTM_TC}objdump -D "$OUTPUT_FILE_PATH" > "${FILE_PATH}.listing"
