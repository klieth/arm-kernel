

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
	ldr r1, .superptr
	bl bwputs
.send:
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
	ldr r1, .userptr
	bl bwputs
.end:
	b .end

.type bwputs, %function
bwputs:
	ldr r2, .serial
	b .start
.loop:
	add r1, r1, #1
.start:
	ldrb r3, [r1]
	strb r3, [r2]
	cmp r3,#0
	bne .loop
	bx lr


.superptr:
	.word .super
.userptr:
	.word .user
.serial: .word 0x101F1000



