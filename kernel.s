

.super:
	.ascii "In supervisor mode\012\000"
.user:
	.ascii "In user mode\012\000"

.text
.global _start
_start:
	ldr sp, =0x07FFFFFF
	bl main

.type main, %function
main:
	ldr r0, .superptr
	bl bwputs
	bl switch


.type switch, %function
switch:
	mov ip, sp
	msr CPSR_c, #0xDF
	mov sp, ip
	msr CPSR_c, #0xD3
	mov r0, #0x10
	msr SPSR, r0
	ldr lr, =first
	movs pc, lr


.type first, %function
first:
	ldr r0, .userptr
	bl bwputs
.end:
	b .end

.type bwputs, %function
bwputs:
	ldr r2, .serial
	b .start
.loop:
	strb r3, [r2]
	add r0, r0, #1
.start:
	ldrb r3, [r0]
	cmp r3,#0
	bne .loop
	bx lr


.superptr:
	.word .super
.userptr:
	.word .user
.serial: .word 0x101F1000



