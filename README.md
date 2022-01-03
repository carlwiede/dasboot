# dasboot
##### A Tiny x86 Bootloader

Requires nasm and qemu.

To compile the code to binary, type
```
nasm -f bin boot.asm -o boot.bin
```

To emulate the bootloader, type
```
qemu-system-x86_64 -fda boot.bin
```

Booty, booty, booty, booty, rockin' everywhere.

###### Courtesy of Joe Bergeron's [Writing a Tiny x86 Bootloader](https://www.joe-bergeron.com/posts/Writing%20a%20Tiny%20x86%20Bootloader/)
