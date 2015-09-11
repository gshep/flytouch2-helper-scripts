# flytouch2-helper-scripts
Helper scripts to build a custom kernel for Flytouch2/Superpad III tablet.

Here are the short desription. For more details check the scripts source code.

1. dot-config - the Linux kernel config file for the tablet;
1. my\_build.sh - script helps to build custom kernel with
    initramfs. Set the following environment variables:
    * INFOTM\_TC - path to the toolchain;
    * INITRD\_PATH - path to the directory contains the hierarchy
        of the initramfs;
    * MKIMAGE\_PATH - path to the mkimage utility from U-Boot.
    and run it to start compilation. Useful command:

    `$ ( time my_build.sh ) |& tee \`date +%M%H\_%F\`-build-log.txt`
1. constants\_instead\_of\_macros.diff - this is a modification
    of the kernel to use constants instead of macros;
1. disassemble.sh - the script converts raw machine code to source
    code in assembler language. The script takes only one argument -
    path to a file with machine code. First part of a file name
    must be in the following format: '0xXXXXXXXX-' - it is used
    as base address in 'objcopy' command. The script creates
    two files: 'file path'.elf and 'file path'.listing.
    An environment varialbe 'INFOTM_TC' is used to get a path
    to a toolchain.
    For the details check this great article - https://code.google.com/p/milestone-overclock/wiki/Disassembly;
1. determine\_size\_of\_functions.sh - the script is intended to
    be executed on the tablet directly. It searches all functions
    with the substring 'imap' in the /proc/kallsyms and
    calculates their sizes in bytes.

# Links
Here https://drive.google.com/open?id=0Bw5iSiWPdccTdC1sVEdkUkFYZ2M
you can find the original toolchain I've downloaded from ftp://zenithink.com/dyliao/.
Also there are located config and patch for the kernel 3.4.x from
http://rtck.org/zt180/patches/.

The important post about the tablet - http://www.slatedroid.com/topic/20377-open-source-project/.
Big thanks to yuray for the great work!
