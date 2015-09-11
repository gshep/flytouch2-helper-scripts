#!/bin/bash

grep imap /proc/kallsyms |sed 's|\([0-9a-fA-F]\+\) [dDtTbBrR] \(.\+\)|\2|gi' |while read FUNCTION;
do
    DATA=$(grep -A 1 $FUNCTION /proc/kallsyms |sed 's|\([0-9a-fA-F]\+\) [dDtTbBrR] \(.\+\)|\1|gi')
    START_OFFSET=$(echo -n $DATA |cut -d ' ' -f1)
    END_OFFSET=$(echo -n $DATA |cut -d ' ' -f2)

    echo $FUNCTION' - '$(( 0x$END_OFFSET - 0x$START_OFFSET ))
done
