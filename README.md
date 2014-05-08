Compile/link with:
==================
	arm-none-eabi-gcc -march=armv6 -o kernel.o -c test.s
	arm-none-eabi-ld -N -Ttext=0x10000 -o kernel.elf kernel.o

Run with:
=========
	qemu-system-arm -M versatilepb -cpu arm1176 -nographic -kernel kernel.elf

kill QEMU with <C-a> x
