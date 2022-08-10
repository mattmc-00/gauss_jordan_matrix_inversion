	.arch armv6
	.eabi_attribute 28, 1
	.eabi_attribute 20, 1
	.eabi_attribute 21, 1
	.eabi_attribute 23, 3
	.eabi_attribute 24, 1
	.eabi_attribute 25, 1
	.eabi_attribute 26, 2
	.eabi_attribute 30, 6
	.eabi_attribute 34, 1
	.eabi_attribute 18, 4
	.file	"gauss.c"
	.text
	.align	2
	.arch armv6
	.syntax unified
	.arm
	.fpu vfp
	.type	fx_mul, %function
fx_mul:
	@ args = 0, pretend = 0, frame = 16
	@ frame_needed = 1, uses_anonymous_args = 0
	@ link register save eliminated.
	push	{r4, r5, r6, r7, fp}
	add	fp, sp, #16
	sub	sp, sp, #20
	str	r0, [fp, #-32]
	str	r1, [fp, #-36]
	ldr	r1, [fp, #-32]
	asr	r0, r1, #31
	mov	r6, r1
	mov	r7, r0
	strd	r6, [fp, #-28]
	ldr	r1, [fp, #-36]
	asr	r0, r1, #31
	mov	r4, r1
	mov	r5, r0
	ldr	r1, [fp, #-24]
	mul	r0, r4, r1
	ldr	r1, [fp, #-28]
	mul	r1, r5, r1
	add	r1, r0, r1
	ldr	r0, [fp, #-28]
	umull	r2, r3, r0, r4
	add	r1, r1, r3
	mov	r3, r1
	strd	r2, [fp, #-28]
	strd	r2, [fp, #-28]
	ldrd	r0, [fp, #-28]
	mov	r2, #0
	mov	r3, #0
	lsr	r2, r0, #16
	orr	r2, r2, r1, lsl #16
	asr	r3, r1, #16
	mov	r3, r2
	str	r3, [fp, #-32]
	ldr	r3, [fp, #-32]
	mov	r0, r3
	sub	sp, fp, #16
	@ sp needed
	pop	{r4, r5, r6, r7, fp}
	bx	lr
	.size	fx_mul, .-fx_mul
	.global	__aeabi_ldivmod
	.align	2
	.syntax unified
	.arm
	.fpu vfp
	.type	fx_div, %function
fx_div:
	@ args = 0, pretend = 0, frame = 24
	@ frame_needed = 1, uses_anonymous_args = 0
	push	{r4, r5, fp, lr}
	add	fp, sp, #12
	sub	sp, sp, #24
	str	r0, [fp, #-32]
	str	r1, [fp, #-36]
	ldr	r1, [fp, #-32]
	asr	r0, r1, #31
	mov	r4, r1
	mov	r5, r0
	strd	r4, [fp, #-20]
	ldr	r1, [fp, #-36]
	asr	r0, r1, #31
	mov	r2, r1
	mov	r3, r0
	strd	r2, [fp, #-28]
	ldrd	r0, [fp, #-20]
	mov	r2, #0
	mov	r3, #0
	lsl	r3, r1, #16
	orr	r3, r3, r0, lsr #16
	lsl	r2, r0, #16
	strd	r2, [fp, #-20]
	ldrd	r2, [fp, #-28]
	ldrd	r0, [fp, #-20]
	bl	__aeabi_ldivmod
	mov	r2, r0
	mov	r3, r1
	mov	r3, r2
	str	r3, [fp, #-32]
	ldr	r3, [fp, #-32]
	mov	r0, r3
	sub	sp, fp, #12
	@ sp needed
	pop	{r4, r5, fp, pc}
	.size	fx_div, .-fx_div
	.align	2
	.syntax unified
	.arm
	.fpu vfp
	.type	abs_32, %function
abs_32:
	@ args = 0, pretend = 0, frame = 8
	@ frame_needed = 1, uses_anonymous_args = 0
	@ link register save eliminated.
	str	fp, [sp, #-4]!
	add	fp, sp, #0
	sub	sp, sp, #12
	str	r0, [fp, #-8]
	ldr	r3, [fp, #-8]
	cmp	r3, #0
	bge	.L6
	ldr	r3, [fp, #-8]
	rsb	r3, r3, #0
	b	.L7
.L6:
	ldr	r3, [fp, #-8]
.L7:
	mov	r0, r3
	add	sp, fp, #0
	@ sp needed
	ldr	fp, [sp], #4
	bx	lr
	.size	abs_32, .-abs_32
	.section	.rodata
	.align	2
.LC0:
	.ascii	"%f seconds to execute\012\000"
	.text
	.align	2
	.global	end_timer
	.syntax unified
	.arm
	.fpu vfp
	.type	end_timer, %function
end_timer:
	@ args = 0, pretend = 0, frame = 24
	@ frame_needed = 1, uses_anonymous_args = 0
	push	{fp, lr}
	add	fp, sp, #4
	sub	sp, sp, #24
	str	r0, [fp, #-24]
	bl	clock
	str	r0, [fp, #-8]
	ldr	r2, [fp, #-8]
	ldr	r3, [fp, #-24]
	sub	r3, r2, r3
	vmov	s15, r3	@ int
	vcvt.f64.s32	d6, s15
	vldr.64	d5, .L9
	vdiv.f64	d7, d6, d5
	vstr.64	d7, [fp, #-20]
	ldrd	r2, [fp, #-20]
	ldr	r0, .L9+8
	bl	printf
	nop
	sub	sp, fp, #4
	@ sp needed
	pop	{fp, pc}
.L10:
	.align	3
.L9:
	.word	0
	.word	1093567616
	.word	.LC0
	.size	end_timer, .-end_timer
	.section	.rodata
	.align	2
.LC1:
	.ascii	"A is not invertible\000"
	.global	__aeabi_idivmod
	.text
	.align	2
	.global	gauss
	.syntax unified
	.arm
	.fpu vfp
	.type	gauss, %function
gauss:
	@ args = 0, pretend = 0, frame = 64
	@ frame_needed = 1, uses_anonymous_args = 0
	push	{r4, r5, r6, r7, r8, fp, lr}
	add	fp, sp, #24
	sub	sp, sp, #68
	str	r0, [fp, #-80]
	str	r1, [fp, #-84]
	str	r2, [fp, #-88]
	mov	r3, sp
	mov	r8, r3
	ldr	r1, [fp, #-80]
	sub	r3, r1, #1
	str	r3, [fp, #-40]
	mov	r2, r1
	mov	r3, #0
	mov	r6, r2
	mov	r7, r3
	mov	r2, #0
	mov	r3, #0
	lsl	r3, r7, #5
	orr	r3, r3, r6, lsr #27
	lsl	r2, r6, #5
	mov	r2, r1
	mov	r3, #0
	mov	r4, r2
	mov	r5, r3
	mov	r2, #0
	mov	r3, #0
	lsl	r3, r5, #5
	orr	r3, r3, r4, lsr #27
	lsl	r2, r4, #5
	mov	r3, r1
	lsl	r3, r3, #2
	add	r3, r3, #7
	lsr	r3, r3, #3
	lsl	r3, r3, #3
	sub	sp, sp, r3
	mov	r3, sp
	add	r3, r3, #3
	lsr	r3, r3, #2
	lsl	r3, r3, #2
	str	r3, [fp, #-44]
	mov	r3, #65536
	str	r3, [fp, #-48]
	mov	r4, #0
	b	.L12
.L25:
	str	r4, [fp, #-32]
	mov	r3, r4
	lsl	r3, r3, #2
	ldr	r2, [fp, #-84]
	add	r3, r2, r3
	ldr	r2, [r3]
	mov	r3, r4
	lsl	r3, r3, #2
	add	r3, r2, r3
	ldr	r3, [r3]
	mov	r0, r3
	bl	abs_32
	str	r0, [fp, #-36]
	add	r5, r4, #1
	b	.L13
.L15:
	mov	r3, r5
	lsl	r3, r3, #2
	ldr	r2, [fp, #-84]
	add	r3, r2, r3
	ldr	r2, [r3]
	mov	r3, r4
	lsl	r3, r3, #2
	add	r3, r2, r3
	ldr	r3, [r3]
	mov	r0, r3
	bl	abs_32
	str	r0, [fp, #-72]
	ldr	r2, [fp, #-72]
	ldr	r3, [fp, #-36]
	cmp	r2, r3
	ble	.L14
	str	r5, [fp, #-32]
	ldr	r3, [fp, #-72]
	str	r3, [fp, #-36]
.L14:
	add	r5, r5, #1
.L13:
	ldr	r3, [fp, #-80]
	cmp	r5, r3
	blt	.L15
	ldr	r3, [fp, #-32]
	cmp	r4, r3
	beq	.L16
	mov	r3, r4
	lsl	r3, r3, #2
	ldr	r2, [fp, #-84]
	add	r3, r2, r3
	ldr	r3, [r3]
	str	r3, [fp, #-52]
	mov	r3, r4
	lsl	r3, r3, #2
	ldr	r2, [fp, #-88]
	add	r3, r2, r3
	ldr	r5, [r3]
	ldr	r3, [fp, #-32]
	lsl	r3, r3, #2
	ldr	r2, [fp, #-84]
	add	r2, r2, r3
	mov	r3, r4
	lsl	r3, r3, #2
	ldr	r1, [fp, #-84]
	add	r3, r1, r3
	ldr	r2, [r2]
	str	r2, [r3]
	ldr	r3, [fp, #-32]
	lsl	r3, r3, #2
	ldr	r2, [fp, #-88]
	add	r2, r2, r3
	mov	r3, r4
	lsl	r3, r3, #2
	ldr	r1, [fp, #-88]
	add	r3, r1, r3
	ldr	r2, [r2]
	str	r2, [r3]
	ldr	r3, [fp, #-32]
	lsl	r3, r3, #2
	ldr	r2, [fp, #-84]
	add	r3, r2, r3
	ldr	r2, [fp, #-52]
	str	r2, [r3]
	ldr	r3, [fp, #-32]
	lsl	r3, r3, #2
	ldr	r2, [fp, #-88]
	add	r3, r2, r3
	str	r5, [r3]
.L16:
	mov	r3, r4
	lsl	r3, r3, #2
	ldr	r2, [fp, #-84]
	add	r3, r2, r3
	ldr	r3, [r3]
	str	r3, [fp, #-56]
	mov	r3, r4
	lsl	r3, r3, #2
	ldr	r2, [fp, #-56]
	add	r3, r2, r3
	ldr	r2, [r3]
	ldr	r3, [fp, #-44]
	str	r2, [r3, r4, lsl #2]
	ldr	r3, [fp, #-44]
	ldr	r3, [r3, r4, lsl #2]
	cmp	r3, #0
	bne	.L17
	ldr	r0, .L26
	bl	puts
	mvn	r0, #0
	bl	exit
.L17:
	add	r3, r4, #1
	ldr	r1, [fp, #-80]
	mov	r0, r3
	bl	__aeabi_idivmod
	mov	r3, r1
	mov	r5, r3
	ldr	r3, [fp, #-44]
	ldr	r3, [r3, r4, lsl #2]
	mov	r1, r3
	ldr	r0, [fp, #-48]
	bl	fx_div
	str	r0, [fp, #-60]
	b	.L18
.L19:
	mov	r3, r5
	lsl	r3, r3, #2
	ldr	r2, [fp, #-56]
	add	r3, r2, r3
	ldr	r0, [r3]
	mov	r3, r5
	lsl	r3, r3, #2
	ldr	r2, [fp, #-56]
	add	r6, r2, r3
	ldr	r1, [fp, #-60]
	bl	fx_mul
	mov	r3, r0
	str	r3, [r6]
	add	r3, r5, #1
	ldr	r1, [fp, #-80]
	mov	r0, r3
	bl	__aeabi_idivmod
	mov	r3, r1
	mov	r5, r3
.L18:
	cmp	r5, r4
	bne	.L19
	mov	r3, r4
	lsl	r3, r3, #2
	ldr	r2, [fp, #-56]
	add	r3, r2, r3
	ldr	r2, [fp, #-60]
	str	r2, [r3]
	mov	r6, #0
	b	.L20
.L24:
	cmp	r6, r4
	beq	.L21
	mov	r3, r6
	lsl	r3, r3, #2
	ldr	r2, [fp, #-84]
	add	r3, r2, r3
	ldr	r3, [r3]
	str	r3, [fp, #-64]
	mov	r3, r4
	lsl	r3, r3, #2
	ldr	r2, [fp, #-64]
	add	r3, r2, r3
	ldr	r2, [r3]
	ldr	r3, [fp, #-44]
	str	r2, [r3, r6, lsl #2]
	add	r3, r4, #1
	ldr	r1, [fp, #-80]
	mov	r0, r3
	bl	__aeabi_idivmod
	mov	r3, r1
	mov	r5, r3
	b	.L22
.L23:
	mov	r3, r5
	lsl	r3, r3, #2
	ldr	r2, [fp, #-56]
	add	r3, r2, r3
	ldr	r2, [r3]
	ldr	r3, [fp, #-44]
	ldr	r3, [r3, r6, lsl #2]
	mov	r1, r3
	mov	r0, r2
	bl	fx_mul
	str	r0, [fp, #-68]
	mov	r3, r5
	lsl	r3, r3, #2
	ldr	r2, [fp, #-64]
	add	r3, r2, r3
	ldr	r1, [r3]
	mov	r3, r5
	lsl	r3, r3, #2
	ldr	r2, [fp, #-64]
	add	r3, r2, r3
	ldr	r2, [fp, #-68]
	sub	r2, r1, r2
	str	r2, [r3]
	add	r3, r5, #1
	ldr	r1, [fp, #-80]
	mov	r0, r3
	bl	__aeabi_idivmod
	mov	r3, r1
	mov	r5, r3
.L22:
	cmp	r5, r4
	bne	.L23
	mov	r3, r4
	lsl	r3, r3, #2
	ldr	r2, [fp, #-56]
	add	r3, r2, r3
	ldr	r0, [r3]
	ldr	r3, [fp, #-44]
	ldr	r3, [r3, r6, lsl #2]
	rsb	r1, r3, #0
	mov	r3, r4
	lsl	r3, r3, #2
	ldr	r2, [fp, #-64]
	add	r5, r2, r3
	bl	fx_mul
	mov	r3, r0
	str	r3, [r5]
.L21:
	add	r6, r6, #1
.L20:
	ldr	r3, [fp, #-80]
	cmp	r6, r3
	blt	.L24
	add	r4, r4, #1
.L12:
	ldr	r3, [fp, #-80]
	cmp	r4, r3
	blt	.L25
	mov	sp, r8
	nop
	sub	sp, fp, #24
	@ sp needed
	pop	{r4, r5, r6, r7, r8, fp, pc}
.L27:
	.align	2
.L26:
	.word	.LC1
	.size	gauss, .-gauss
	.align	2
	.global	calculate_inverse_testbench
	.syntax unified
	.arm
	.fpu vfp
	.type	calculate_inverse_testbench, %function
calculate_inverse_testbench:
	@ args = 0, pretend = 0, frame = 40
	@ frame_needed = 1, uses_anonymous_args = 0
	push	{r4, r5, r6, r7, r8, r9, r10, fp, lr}
	add	fp, sp, #32
	sub	sp, sp, #44
	str	r0, [fp, #-64]
	str	r1, [fp, #-68]
	mov	r3, sp
	mov	r10, r3
	ldr	r1, [fp, #-64]
	sub	r3, r1, #1
	str	r3, [fp, #-40]
	mov	r2, r1
	mov	r3, #0
	str	r2, [fp, #-76]
	str	r3, [fp, #-72]
	mov	r2, #0
	mov	r3, #0
	ldr	r0, [fp, #-72]
	lsl	r3, r0, #5
	ldr	r0, [fp, #-76]
	orr	r3, r3, r0, lsr #27
	ldr	r0, [fp, #-76]
	lsl	r2, r0, #5
	mov	r2, r1
	mov	r3, #0
	mov	r8, r2
	mov	r9, r3
	mov	r2, #0
	mov	r3, #0
	lsl	r3, r9, #5
	orr	r3, r3, r8, lsr #27
	lsl	r2, r8, #5
	mov	r3, r1
	lsl	r3, r3, #2
	add	r3, r3, #7
	lsr	r3, r3, #3
	lsl	r3, r3, #3
	sub	sp, sp, r3
	mov	r3, sp
	add	r3, r3, #3
	lsr	r3, r3, #2
	lsl	r3, r3, #2
	str	r3, [fp, #-48]
	ldr	r1, [fp, #-64]
	sub	r3, r1, #1
	str	r3, [fp, #-52]
	mov	r2, r1
	mov	r3, #0
	mov	r6, r2
	mov	r7, r3
	mov	r2, #0
	mov	r3, #0
	lsl	r3, r7, #5
	orr	r3, r3, r6, lsr #27
	lsl	r2, r6, #5
	mov	r2, r1
	mov	r3, #0
	mov	r4, r2
	mov	r5, r3
	mov	r2, #0
	mov	r3, #0
	lsl	r3, r5, #5
	orr	r3, r3, r4, lsr #27
	lsl	r2, r4, #5
	mov	r3, r1
	lsl	r3, r3, #2
	add	r3, r3, #7
	lsr	r3, r3, #3
	lsl	r3, r3, #3
	sub	sp, sp, r3
	mov	r3, sp
	add	r3, r3, #3
	lsr	r3, r3, #2
	lsl	r3, r3, #2
	str	r3, [fp, #-56]
	mov	r3, #0
	str	r3, [fp, #-44]
	b	.L29
.L30:
	ldr	r3, [fp, #-64]
	lsl	r3, r3, #2
	mov	r0, r3
	bl	malloc
	mov	r3, r0
	mov	r1, r3
	ldr	r3, [fp, #-48]
	ldr	r2, [fp, #-44]
	str	r1, [r3, r2, lsl #2]
	ldr	r3, [fp, #-56]
	ldr	r2, [fp, #-44]
	ldr	r1, [fp, #-44]
	str	r1, [r3, r2, lsl #2]
	ldr	r3, [fp, #-44]
	add	r3, r3, #1
	str	r3, [fp, #-44]
.L29:
	ldr	r2, [fp, #-44]
	ldr	r3, [fp, #-64]
	cmp	r2, r3
	blt	.L30
	ldr	r3, [fp, #-68]
	ldr	r2, [fp, #-48]
	ldr	r1, [fp, #-56]
	ldr	r0, [fp, #-64]
	bl	read_matrix_from_file
	bl	clock
	str	r0, [fp, #-60]
	ldr	r2, [fp, #-56]
	ldr	r1, [fp, #-48]
	ldr	r0, [fp, #-64]
	bl	gauss
	ldr	r0, [fp, #-60]
	bl	end_timer
	mov	r3, #0
	str	r3, [fp, #-44]
	b	.L31
.L32:
	ldr	r3, [fp, #-48]
	ldr	r2, [fp, #-44]
	ldr	r3, [r3, r2, lsl #2]
	mov	r0, r3
	bl	free
	ldr	r3, [fp, #-44]
	add	r3, r3, #1
	str	r3, [fp, #-44]
.L31:
	ldr	r2, [fp, #-44]
	ldr	r3, [fp, #-64]
	cmp	r2, r3
	blt	.L32
	mov	sp, r10
	nop
	sub	sp, fp, #32
	@ sp needed
	pop	{r4, r5, r6, r7, r8, r9, r10, fp, pc}
	.size	calculate_inverse_testbench, .-calculate_inverse_testbench
	.section	.rodata
	.align	2
.LC2:
	.ascii	"A\000"
	.align	2
.LC3:
	.ascii	"A_inv\000"
	.text
	.align	2
	.global	calculate_inverse_filein
	.syntax unified
	.arm
	.fpu vfp
	.type	calculate_inverse_filein, %function
calculate_inverse_filein:
	@ args = 0, pretend = 0, frame = 40
	@ frame_needed = 1, uses_anonymous_args = 0
	push	{r4, r5, r6, r7, r8, r9, r10, fp, lr}
	add	fp, sp, #32
	sub	sp, sp, #44
	str	r0, [fp, #-64]
	str	r1, [fp, #-68]
	mov	r3, sp
	mov	r10, r3
	ldr	r1, [fp, #-64]
	sub	r3, r1, #1
	str	r3, [fp, #-40]
	mov	r2, r1
	mov	r3, #0
	str	r2, [fp, #-76]
	str	r3, [fp, #-72]
	mov	r2, #0
	mov	r3, #0
	ldr	r0, [fp, #-72]
	lsl	r3, r0, #5
	ldr	r0, [fp, #-76]
	orr	r3, r3, r0, lsr #27
	ldr	r0, [fp, #-76]
	lsl	r2, r0, #5
	mov	r2, r1
	mov	r3, #0
	mov	r8, r2
	mov	r9, r3
	mov	r2, #0
	mov	r3, #0
	lsl	r3, r9, #5
	orr	r3, r3, r8, lsr #27
	lsl	r2, r8, #5
	mov	r3, r1
	lsl	r3, r3, #2
	add	r3, r3, #7
	lsr	r3, r3, #3
	lsl	r3, r3, #3
	sub	sp, sp, r3
	mov	r3, sp
	add	r3, r3, #3
	lsr	r3, r3, #2
	lsl	r3, r3, #2
	str	r3, [fp, #-48]
	ldr	r1, [fp, #-64]
	sub	r3, r1, #1
	str	r3, [fp, #-52]
	mov	r2, r1
	mov	r3, #0
	mov	r6, r2
	mov	r7, r3
	mov	r2, #0
	mov	r3, #0
	lsl	r3, r7, #5
	orr	r3, r3, r6, lsr #27
	lsl	r2, r6, #5
	mov	r2, r1
	mov	r3, #0
	mov	r4, r2
	mov	r5, r3
	mov	r2, #0
	mov	r3, #0
	lsl	r3, r5, #5
	orr	r3, r3, r4, lsr #27
	lsl	r2, r4, #5
	mov	r3, r1
	lsl	r3, r3, #2
	add	r3, r3, #7
	lsr	r3, r3, #3
	lsl	r3, r3, #3
	sub	sp, sp, r3
	mov	r3, sp
	add	r3, r3, #3
	lsr	r3, r3, #2
	lsl	r3, r3, #2
	str	r3, [fp, #-56]
	mov	r3, #0
	str	r3, [fp, #-44]
	b	.L34
.L35:
	ldr	r3, [fp, #-64]
	lsl	r3, r3, #2
	mov	r0, r3
	bl	malloc
	mov	r3, r0
	mov	r1, r3
	ldr	r3, [fp, #-48]
	ldr	r2, [fp, #-44]
	str	r1, [r3, r2, lsl #2]
	ldr	r3, [fp, #-56]
	ldr	r2, [fp, #-44]
	ldr	r1, [fp, #-44]
	str	r1, [r3, r2, lsl #2]
	ldr	r3, [fp, #-44]
	add	r3, r3, #1
	str	r3, [fp, #-44]
.L34:
	ldr	r2, [fp, #-44]
	ldr	r3, [fp, #-64]
	cmp	r2, r3
	blt	.L35
	ldr	r3, [fp, #-68]
	ldr	r2, [fp, #-48]
	ldr	r1, [fp, #-56]
	ldr	r0, [fp, #-64]
	bl	read_matrix_from_file
	ldr	r3, .L38
	ldr	r2, [fp, #-48]
	ldr	r1, [fp, #-56]
	ldr	r0, [fp, #-64]
	bl	print_matrix
	bl	clock
	str	r0, [fp, #-60]
	ldr	r2, [fp, #-56]
	ldr	r1, [fp, #-48]
	ldr	r0, [fp, #-64]
	bl	gauss
	ldr	r0, [fp, #-60]
	bl	end_timer
	ldr	r3, .L38+4
	ldr	r2, [fp, #-48]
	ldr	r1, [fp, #-56]
	ldr	r0, [fp, #-64]
	bl	print_matrix
	mov	r3, #0
	str	r3, [fp, #-44]
	b	.L36
.L37:
	ldr	r3, [fp, #-48]
	ldr	r2, [fp, #-44]
	ldr	r3, [r3, r2, lsl #2]
	mov	r0, r3
	bl	free
	ldr	r3, [fp, #-44]
	add	r3, r3, #1
	str	r3, [fp, #-44]
.L36:
	ldr	r2, [fp, #-44]
	ldr	r3, [fp, #-64]
	cmp	r2, r3
	blt	.L37
	mov	sp, r10
	nop
	sub	sp, fp, #32
	@ sp needed
	pop	{r4, r5, r6, r7, r8, r9, r10, fp, pc}
.L39:
	.align	2
.L38:
	.word	.LC2
	.word	.LC3
	.size	calculate_inverse_filein, .-calculate_inverse_filein
	.section	.rodata
	.align	2
.LC4:
	.ascii	"r\000"
	.align	2
.LC5:
	.ascii	"Error while opening the file.\012\000"
	.align	2
.LC6:
	.ascii	"%f\000"
	.text
	.align	2
	.global	read_matrix_from_file
	.syntax unified
	.arm
	.fpu vfp
	.type	read_matrix_from_file, %function
read_matrix_from_file:
	@ args = 0, pretend = 0, frame = 40
	@ frame_needed = 1, uses_anonymous_args = 0
	push	{fp, lr}
	add	fp, sp, #4
	sub	sp, sp, #40
	str	r0, [fp, #-32]
	str	r1, [fp, #-36]
	str	r2, [fp, #-40]
	str	r3, [fp, #-44]
	ldr	r1, .L46+8
	ldr	r0, [fp, #-44]
	bl	fopen
	str	r0, [fp, #-16]
	ldr	r3, [fp, #-16]
	cmp	r3, #0
	bne	.L41
	ldr	r0, .L46+12
	bl	perror
	mvn	r0, #0
	bl	exit
.L41:
	mov	r3, #0
	str	r3, [fp, #-8]
	b	.L42
.L45:
	ldr	r3, [fp, #-8]
	lsl	r3, r3, #2
	ldr	r2, [fp, #-40]
	add	r3, r2, r3
	ldr	r3, [r3]
	str	r3, [fp, #-20]
	mov	r3, #0
	str	r3, [fp, #-12]
	b	.L43
.L44:
	sub	r3, fp, #28
	mov	r2, r3
	ldr	r1, .L46+16
	ldr	r0, [fp, #-16]
	bl	__isoc99_fscanf
	vldr.32	s15, [fp, #-28]
	vcvt.f64.f32	d7, s15
	vldr.64	d6, .L46
	vmul.f64	d7, d7, d6
	vcvt.s32.f64	s15, d7
	vmov	r3, s15	@ int
	str	r3, [fp, #-24]
	ldr	r3, [fp, #-12]
	lsl	r3, r3, #2
	ldr	r2, [fp, #-20]
	add	r3, r2, r3
	ldr	r2, [fp, #-24]
	str	r2, [r3]
	ldr	r3, [fp, #-12]
	add	r3, r3, #1
	str	r3, [fp, #-12]
.L43:
	ldr	r2, [fp, #-12]
	ldr	r3, [fp, #-32]
	cmp	r2, r3
	blt	.L44
	ldr	r3, [fp, #-8]
	add	r3, r3, #1
	str	r3, [fp, #-8]
.L42:
	ldr	r2, [fp, #-8]
	ldr	r3, [fp, #-32]
	cmp	r2, r3
	blt	.L45
	ldr	r0, [fp, #-16]
	bl	fclose
	nop
	sub	sp, fp, #4
	@ sp needed
	pop	{fp, pc}
.L47:
	.align	3
.L46:
	.word	0
	.word	1089470464
	.word	.LC4
	.word	.LC5
	.word	.LC6
	.size	read_matrix_from_file, .-read_matrix_from_file
	.section	.rodata
	.align	2
.LC7:
	.ascii	"%s = [\000"
	.align	2
.LC8:
	.ascii	"\011%.4f\000"
	.align	2
.LC9:
	.ascii	"\012]\000"
	.text
	.align	2
	.global	print_matrix
	.syntax unified
	.arm
	.fpu vfp
	.type	print_matrix, %function
print_matrix:
	@ args = 0, pretend = 0, frame = 48
	@ frame_needed = 1, uses_anonymous_args = 0
	push	{r4, r5, r6, r7, r8, fp, lr}
	add	fp, sp, #24
	sub	sp, sp, #52
	str	r0, [fp, #-64]
	str	r1, [fp, #-68]
	str	r2, [fp, #-72]
	str	r3, [fp, #-76]
	mov	r3, sp
	mov	r8, r3
	ldr	r1, [fp, #-64]
	sub	r3, r1, #1
	str	r3, [fp, #-40]
	mov	r2, r1
	mov	r3, #0
	mov	r6, r2
	mov	r7, r3
	mov	r2, #0
	mov	r3, #0
	lsl	r3, r7, #5
	orr	r3, r3, r6, lsr #27
	lsl	r2, r6, #5
	mov	r2, r1
	mov	r3, #0
	mov	r4, r2
	mov	r5, r3
	mov	r2, #0
	mov	r3, #0
	lsl	r3, r5, #5
	orr	r3, r3, r4, lsr #27
	lsl	r2, r4, #5
	mov	r3, r1
	lsl	r3, r3, #2
	add	r3, r3, #7
	lsr	r3, r3, #3
	lsl	r3, r3, #3
	sub	sp, sp, r3
	mov	r3, sp
	add	r3, r3, #3
	lsr	r3, r3, #2
	lsl	r3, r3, #2
	str	r3, [fp, #-44]
	mov	r3, #0
	str	r3, [fp, #-36]
	b	.L49
.L50:
	ldr	r3, [fp, #-36]
	lsl	r3, r3, #2
	ldr	r2, [fp, #-68]
	add	r3, r2, r3
	ldr	r2, [r3]
	ldr	r3, [fp, #-44]
	ldr	r1, [fp, #-36]
	str	r1, [r3, r2, lsl #2]
	ldr	r3, [fp, #-36]
	add	r3, r3, #1
	str	r3, [fp, #-36]
.L49:
	ldr	r2, [fp, #-36]
	ldr	r3, [fp, #-64]
	cmp	r2, r3
	blt	.L50
	ldr	r1, [fp, #-76]
	ldr	r0, .L55+8
	bl	printf
	mov	r3, #0
	str	r3, [fp, #-36]
	b	.L51
.L54:
	ldr	r3, [fp, #-36]
	lsl	r3, r3, #2
	ldr	r2, [fp, #-72]
	add	r3, r2, r3
	ldr	r3, [r3]
	str	r3, [fp, #-48]
	mov	r0, #10
	bl	putchar
	mov	r3, #0
	str	r3, [fp, #-32]
	b	.L52
.L53:
	ldr	r3, [fp, #-44]
	ldr	r2, [fp, #-32]
	ldr	r3, [r3, r2, lsl #2]
	str	r3, [fp, #-52]
	ldr	r3, [fp, #-52]
	lsl	r3, r3, #2
	ldr	r2, [fp, #-48]
	add	r3, r2, r3
	ldr	r3, [r3]
	str	r3, [fp, #-56]
	ldr	r3, [fp, #-56]
	vmov	s15, r3	@ int
	vcvt.f64.s32	d6, s15
	vldr.64	d5, .L55
	vdiv.f64	d7, d6, d5
	vcvt.f32.f64	s15, d7
	vstr.32	s15, [fp, #-60]
	vldr.32	s15, [fp, #-60]
	vcvt.f64.f32	d7, s15
	vmov	r2, r3, d7
	ldr	r0, .L55+12
	bl	printf
	ldr	r3, [fp, #-32]
	add	r3, r3, #1
	str	r3, [fp, #-32]
.L52:
	ldr	r2, [fp, #-32]
	ldr	r3, [fp, #-64]
	cmp	r2, r3
	blt	.L53
	ldr	r3, [fp, #-36]
	add	r3, r3, #1
	str	r3, [fp, #-36]
.L51:
	ldr	r2, [fp, #-36]
	ldr	r3, [fp, #-64]
	cmp	r2, r3
	blt	.L54
	ldr	r0, .L55+16
	bl	puts
	mov	sp, r8
	nop
	sub	sp, fp, #24
	@ sp needed
	pop	{r4, r5, r6, r7, r8, fp, pc}
.L56:
	.align	3
.L55:
	.word	0
	.word	1089470464
	.word	.LC7
	.word	.LC8
	.word	.LC9
	.size	print_matrix, .-print_matrix
	.section	.rodata
	.align	2
.LC10:
	.ascii	"Select action:\012(f) = run on local input file\012"
	.ascii	"(0, 1, 2, 3) = run test i from testbench 10 times\000"
	.align	2
.LC11:
	.ascii	"%c\000"
	.align	2
.LC16:
	.ascii	"Input file name:\000"
	.align	2
.LC17:
	.ascii	"%s\000"
	.align	2
.LC18:
	.ascii	"Next input size of input matrix:\000"
	.align	2
.LC19:
	.ascii	"%d\000"
	.align	2
.LC12:
	.ascii	"input/n100_1.txt\000"
	.space	33
	.align	2
.LC13:
	.ascii	"input/n250_1.txt\000"
	.space	33
	.align	2
.LC14:
	.ascii	"input/n100_ill.txt\000"
	.space	31
	.align	2
.LC15:
	.ascii	"input/n100_well.txt\000"
	.space	30
	.text
	.align	2
	.global	main
	.syntax unified
	.arm
	.fpu vfp
	.type	main, %function
main:
	@ args = 0, pretend = 0, frame = 80
	@ frame_needed = 1, uses_anonymous_args = 0
	push	{fp, lr}
	add	fp, sp, #4
	sub	sp, sp, #80
	ldr	r0, .L72
	bl	puts
	sub	r3, fp, #21
	mov	r1, r3
	ldr	r0, .L72+4
	bl	__isoc99_scanf
	ldrb	r3, [fp, #-21]	@ zero_extendqisi2
	cmp	r3, #48
	bne	.L58
	ldr	r3, .L72+8
	sub	ip, fp, #80
	mov	lr, r3
	ldmia	lr!, {r0, r1, r2, r3}
	stmia	ip!, {r0, r1, r2, r3}
	ldr	r3, [lr]
	strb	r3, [ip]
	sub	r3, fp, #63
	mov	r2, #33
	mov	r1, #0
	mov	r0, r3
	bl	memset
	mov	r3, #100
	str	r3, [fp, #-28]
	mov	r3, #0
	str	r3, [fp, #-8]
	b	.L59
.L60:
	ldr	r3, [fp, #-28]
	sub	r2, fp, #80
	mov	r1, r2
	mov	r0, r3
	bl	calculate_inverse_testbench
	ldr	r3, [fp, #-8]
	add	r3, r3, #1
	str	r3, [fp, #-8]
.L59:
	ldr	r3, [fp, #-8]
	cmp	r3, #9
	ble	.L60
	b	.L71
.L58:
	ldrb	r3, [fp, #-21]	@ zero_extendqisi2
	cmp	r3, #49
	bne	.L62
	ldr	r3, .L72+12
	sub	ip, fp, #80
	mov	lr, r3
	ldmia	lr!, {r0, r1, r2, r3}
	stmia	ip!, {r0, r1, r2, r3}
	ldr	r3, [lr]
	strb	r3, [ip]
	sub	r3, fp, #63
	mov	r2, #33
	mov	r1, #0
	mov	r0, r3
	bl	memset
	mov	r3, #250
	str	r3, [fp, #-28]
	mov	r3, #0
	str	r3, [fp, #-12]
	b	.L63
.L64:
	ldr	r3, [fp, #-28]
	sub	r2, fp, #80
	mov	r1, r2
	mov	r0, r3
	bl	calculate_inverse_testbench
	ldr	r3, [fp, #-12]
	add	r3, r3, #1
	str	r3, [fp, #-12]
.L63:
	ldr	r3, [fp, #-12]
	cmp	r3, #9
	ble	.L64
	b	.L71
.L62:
	ldrb	r3, [fp, #-21]	@ zero_extendqisi2
	cmp	r3, #50
	bne	.L65
	ldr	r3, .L72+16
	sub	ip, fp, #80
	mov	lr, r3
	ldmia	lr!, {r0, r1, r2, r3}
	stmia	ip!, {r0, r1, r2, r3}
	ldr	r3, [lr]
	strh	r3, [ip]	@ movhi
	add	ip, ip, #2
	lsr	r3, r3, #16
	strb	r3, [ip]
	sub	r3, fp, #61
	mov	r2, #31
	mov	r1, #0
	mov	r0, r3
	bl	memset
	mov	r3, #100
	str	r3, [fp, #-28]
	mov	r3, #0
	str	r3, [fp, #-16]
	b	.L66
.L67:
	ldr	r3, [fp, #-28]
	sub	r2, fp, #80
	mov	r1, r2
	mov	r0, r3
	bl	calculate_inverse_testbench
	ldr	r3, [fp, #-16]
	add	r3, r3, #1
	str	r3, [fp, #-16]
.L66:
	ldr	r3, [fp, #-16]
	cmp	r3, #9
	ble	.L67
	b	.L71
.L65:
	ldrb	r3, [fp, #-21]	@ zero_extendqisi2
	cmp	r3, #51
	bne	.L68
	ldr	r3, .L72+20
	sub	ip, fp, #80
	mov	lr, r3
	ldmia	lr!, {r0, r1, r2, r3}
	stmia	ip!, {r0, r1, r2, r3}
	ldr	r3, [lr]
	str	r3, [ip]
	sub	r3, fp, #60
	mov	r2, #30
	mov	r1, #0
	mov	r0, r3
	bl	memset
	mov	r3, #100
	str	r3, [fp, #-28]
	mov	r3, #0
	str	r3, [fp, #-20]
	b	.L69
.L70:
	ldr	r3, [fp, #-28]
	sub	r2, fp, #80
	mov	r1, r2
	mov	r0, r3
	bl	calculate_inverse_testbench
	ldr	r3, [fp, #-20]
	add	r3, r3, #1
	str	r3, [fp, #-20]
.L69:
	ldr	r3, [fp, #-20]
	cmp	r3, #9
	ble	.L70
	b	.L71
.L68:
	ldrb	r3, [fp, #-21]	@ zero_extendqisi2
	cmp	r3, #102
	bne	.L71
	ldr	r0, .L72+24
	bl	puts
	sub	r3, fp, #80
	mov	r1, r3
	ldr	r0, .L72+28
	bl	__isoc99_scanf
	ldr	r0, .L72+32
	bl	puts
	sub	r3, fp, #28
	mov	r1, r3
	ldr	r0, .L72+36
	bl	__isoc99_scanf
	ldr	r3, [fp, #-28]
	sub	r2, fp, #80
	mov	r1, r2
	mov	r0, r3
	bl	calculate_inverse_filein
.L71:
	nop
	sub	sp, fp, #4
	@ sp needed
	pop	{fp, pc}
.L73:
	.align	2
.L72:
	.word	.LC10
	.word	.LC11
	.word	.LC12
	.word	.LC13
	.word	.LC14
	.word	.LC15
	.word	.LC16
	.word	.LC17
	.word	.LC18
	.word	.LC19
	.size	main, .-main
	.ident	"GCC: (Raspbian 10.2.1-6+rpi1) 10.2.1 20210110"
	.section	.note.GNU-stack,"",%progbits
