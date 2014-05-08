
CC=arm-none-eabi-gcc
LD=arm-none-eabi-ld

CCFLAGS=-march=armv6
LDFLAGS=-N -Ttext=0x10000

all: test.s
	$(CC) $(CCFLAGS) -o kernel.o -c test.s
	$(LD) $(LDFLAGS) -o kernel.elf kernel.o

clean:
	rm *.o *.elf

run:
	qemu-system-arm -M versatilepb -cpu arm1176 -nographic -kernel kernel.elf
