

.text
.global _start
_start:
	ldr sp, =0x07FFFFFF
	bl main

.type main,%function
main:
	b main
