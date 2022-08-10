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
	.section	.rodata
	.align	2
.LC0:
	.ascii	"input/n4_m1.txt\000"
	.align	2
.LC1:
	.ascii	"input/n5_m1.txt\000"
	.align	2
.LC2:
	.ascii	"input/n5_m2.txt\000"
	.align	2
.LC4:
	.ascii	"output/n4_m1.txt\000"
	.align	2
.LC5:
	.ascii	"output/n5_m1.txt\000"
	.align	2
.LC6:
	.ascii	"output/n5_m2.txt\000"
	.text
	.section	.rodata
	.align	2
.LC8:
	.ascii	"%f\012\000"
	.text
	.align	2
	.global	end_timer
	.arch armv6
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
	vldr.64	d5, .L2
	vdiv.f64	d7, d6, d5
	vstr.64	d7, [fp, #-20]
	ldrd	r2, [fp, #-20]
	ldr	r0, .L2+8
	bl	printf
	nop
	sub	sp, fp, #4
	@ sp needed
	pop	{fp, pc}
.L3:
	.align	3
.L2:
	.word	0
	.word	1093567616
	.word	.LC8
	.size	end_timer, .-end_timer
	.section	.rodata
	.align	2
.LC9:
	.ascii	"A is not invertible\000"
	.global	__aeabi_ldivmod
	.text
	.align	2
	.global	gauss
	.syntax unified
	.arm
	.fpu vfp
	.type	gauss, %function
gauss:
	@ args = 0, pretend = 0, frame = 144
	@ frame_needed = 1, uses_anonymous_args = 0
	push	{r4, r5, r6, r7, r8, r9, r10, fp, lr}
	add	fp, sp, #32
	sub	sp, sp, #148
	str	r0, [fp, #-104]
	str	r1, [fp, #-108]
	str	r2, [fp, #-112]
	mov	r3, sp
	mov	r10, r3
	ldr	r1, [fp, #-104]
	sub	r3, r1, #1
	str	r3, [fp, #-64]
	mov	r2, r1
	mov	r3, #0
	mov	r4, r2
	mov	r5, r3
	mov	r2, #0
	mov	r3, #0
	lsl	r3, r5, #5
	orr	r3, r3, r4, lsr #27
	lsl	r2, r4, #5
	mov	r2, r1
	mov	r3, #0
	mov	r6, r2
	mov	r7, r3
	mov	r2, #0
	mov	r3, #0
	lsl	r3, r7, #5
	orr	r3, r3, r6, lsr #27
	lsl	r2, r6, #5
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
	str	r3, [fp, #-68]
	mov	r3, #65536
	str	r3, [fp, #-72]
	mov	r3, #0
	str	r3, [fp, #-52]
	b	.L5
.L18:
	ldr	r3, [fp, #-52]
	str	r3, [fp, #-56]
	ldr	r3, [fp, #-52]
	lsl	r2, r3, #2
	ldr	r3, [fp, #-108]
	add	r3, r3, r2
	ldr	r2, [r3]
	ldr	r3, [fp, #-52]
	lsl	r3, r3, #2
	add	r3, r2, r3
	ldr	r3, [r3]
	cmp	r3, #0
	rsblt	r3, r3, #0
	str	r3, [fp, #-60]
	ldr	r3, [fp, #-52]
	add	r3, r3, #1
	str	r3, [fp, #-44]
	b	.L6
.L8:
	ldr	r3, [fp, #-44]
	lsl	r2, r3, #2
	ldr	r3, [fp, #-108]
	add	r3, r3, r2
	ldr	r2, [r3]
	ldr	r3, [fp, #-52]
	lsl	r3, r3, #2
	add	r3, r2, r3
	ldr	r3, [r3]
	cmp	r3, #0
	rsblt	r3, r3, #0
	str	r3, [fp, #-96]
	ldr	r2, [fp, #-96]
	ldr	r3, [fp, #-60]
	cmp	r2, r3
	ble	.L7
	ldr	r3, [fp, #-44]
	str	r3, [fp, #-56]
	ldr	r3, [fp, #-96]
	str	r3, [fp, #-60]
.L7:
	ldr	r3, [fp, #-44]
	add	r3, r3, #1
	str	r3, [fp, #-44]
.L6:
	ldr	r2, [fp, #-44]
	ldr	r3, [fp, #-104]
	cmp	r2, r3
	blt	.L8
	ldr	r2, [fp, #-52]
	ldr	r3, [fp, #-56]
	cmp	r2, r3
	beq	.L9
	ldr	r3, [fp, #-52]
	lsl	r2, r3, #2
	ldr	r3, [fp, #-108]
	add	r3, r3, r2
	ldr	r3, [r3]
	str	r3, [fp, #-76]
	ldr	r3, [fp, #-52]
	lsl	r2, r3, #2
	ldr	r3, [fp, #-112]
	add	r3, r3, r2
	ldr	r3, [r3]
	str	r3, [fp, #-44]
	ldr	r3, [fp, #-56]
	lsl	r2, r3, #2
	ldr	r3, [fp, #-108]
	add	r1, r3, r2
	ldr	r3, [fp, #-52]
	lsl	r2, r3, #2
	ldr	r3, [fp, #-108]
	add	r2, r3, r2
	ldr	r3, [r1]
	str	r3, [r2]
	ldr	r3, [fp, #-56]
	lsl	r2, r3, #2
	ldr	r3, [fp, #-112]
	add	r1, r3, r2
	ldr	r3, [fp, #-52]
	lsl	r2, r3, #2
	ldr	r3, [fp, #-112]
	add	r2, r3, r2
	ldr	r3, [r1]
	str	r3, [r2]
	ldr	r3, [fp, #-56]
	lsl	r2, r3, #2
	ldr	r3, [fp, #-108]
	add	r2, r3, r2
	ldr	r3, [fp, #-76]
	str	r3, [r2]
	ldr	r3, [fp, #-56]
	lsl	r2, r3, #2
	ldr	r3, [fp, #-112]
	add	r2, r3, r2
	ldr	r3, [fp, #-44]
	str	r3, [r2]
.L9:
	ldr	r3, [fp, #-52]
	lsl	r2, r3, #2
	ldr	r3, [fp, #-108]
	add	r3, r3, r2
	ldr	r3, [r3]
	str	r3, [fp, #-80]
	ldr	r3, [fp, #-52]
	lsl	r2, r3, #2
	ldr	r3, [fp, #-80]
	add	r3, r3, r2
	ldr	r1, [r3]
	ldr	r2, [fp, #-68]
	ldr	r3, [fp, #-52]
	str	r1, [r2, r3, lsl #2]
	ldr	r2, [fp, #-68]
	ldr	r3, [fp, #-52]
	ldr	r3, [r2, r3, lsl #2]
	cmp	r3, #0
	bne	.L10
	ldr	r0, .L19
	bl	puts
	mvn	r0, #0
	bl	exit
.L10:
	ldr	r3, [fp, #-52]
	lsl	r2, r3, #2
	ldr	r3, [fp, #-80]
	add	r2, r3, r2
	ldr	r3, [fp, #-72]
	str	r3, [r2]
	ldr	r3, [fp, #-72]
	asr	r2, r3, #31
	str	r3, [fp, #-132]
	str	r2, [fp, #-128]
	ldrd	r2, [fp, #-132]
	mov	r1, r2
	asr	r1, r1, #16
	str	r1, [fp, #-136]
	mov	r3, r2
	lsl	r3, r3, #16
	str	r3, [fp, #-140]
	ldr	r2, [fp, #-68]
	ldr	r3, [fp, #-52]
	ldr	r3, [r2, r3, lsl #2]
	asr	r2, r3, #31
	str	r3, [fp, #-148]
	str	r2, [fp, #-144]
	ldrd	r2, [fp, #-148]
	ldrd	r0, [fp, #-140]
	bl	__aeabi_ldivmod
	mov	r2, r0
	mov	r3, r1
	mov	r3, r2
	str	r3, [fp, #-84]
	mov	r3, #0
	str	r3, [fp, #-40]
	b	.L11
.L12:
	ldr	r3, [fp, #-40]
	lsl	r2, r3, #2
	ldr	r3, [fp, #-80]
	add	r3, r3, r2
	ldr	r3, [r3]
	asr	r2, r3, #31
	str	r3, [fp, #-156]
	str	r2, [fp, #-152]
	ldr	r3, [fp, #-84]
	asr	r2, r3, #31
	str	r3, [fp, #-164]
	str	r2, [fp, #-160]
	ldrd	r0, [fp, #-156]
	mov	r3, r1
	ldrd	r4, [fp, #-164]
	mov	r2, r4
	mul	r2, r2, r3
	mov	r3, r5
	mov	ip, r0
	mul	r3, ip, r3
	add	r3, r2, r3
	mov	r2, r0
	mov	r1, r4
	umull	r8, r9, r2, r1
	add	r3, r3, r9
	mov	r9, r3
	mov	r0, #0
	mov	r1, #0
	lsr	r0, r8, #16
	orr	r0, r0, r9, lsl #16
	asr	r1, r9, #16
	ldr	r3, [fp, #-40]
	lsl	r2, r3, #2
	ldr	r3, [fp, #-80]
	add	r2, r3, r2
	mov	r3, r0
	str	r3, [r2]
	ldr	r3, [fp, #-40]
	add	r3, r3, #1
	str	r3, [fp, #-40]
.L11:
	ldr	r2, [fp, #-40]
	ldr	r3, [fp, #-104]
	cmp	r2, r3
	blt	.L12
	mov	r3, #0
	str	r3, [fp, #-48]
	b	.L13
.L17:
	ldr	r2, [fp, #-48]
	ldr	r3, [fp, #-52]
	cmp	r2, r3
	beq	.L14
	ldr	r3, [fp, #-48]
	lsl	r2, r3, #2
	ldr	r3, [fp, #-108]
	add	r3, r3, r2
	ldr	r3, [r3]
	str	r3, [fp, #-88]
	ldr	r3, [fp, #-52]
	lsl	r2, r3, #2
	ldr	r3, [fp, #-88]
	add	r3, r3, r2
	ldr	r1, [r3]
	ldr	r2, [fp, #-68]
	ldr	r3, [fp, #-48]
	str	r1, [r2, r3, lsl #2]
	ldr	r3, [fp, #-52]
	lsl	r2, r3, #2
	ldr	r3, [fp, #-88]
	add	r2, r3, r2
	mov	r3, #0
	str	r3, [r2]
	mov	r3, #0
	str	r3, [fp, #-44]
	b	.L15
.L16:
	ldr	r3, [fp, #-44]
	lsl	r2, r3, #2
	ldr	r3, [fp, #-80]
	add	r3, r3, r2
	ldr	r3, [r3]
	asr	r2, r3, #31
	str	r3, [fp, #-172]
	str	r2, [fp, #-168]
	ldr	r2, [fp, #-68]
	ldr	r3, [fp, #-48]
	ldr	r3, [r2, r3, lsl #2]
	asr	r2, r3, #31
	str	r3, [fp, #-180]
	str	r2, [fp, #-176]
	ldrd	r0, [fp, #-172]
	mov	r3, r1
	ldrd	r4, [fp, #-180]
	mov	r2, r4
	mul	r2, r2, r3
	mov	r3, r5
	mov	ip, r0
	mul	r3, ip, r3
	add	r3, r2, r3
	mov	r2, r0
	mov	r1, r4
	umull	r2, r1, r2, r1
	str	r1, [fp, #-120]
	str	r2, [fp, #-124]
	ldr	r2, [fp, #-120]
	add	r3, r3, r2
	str	r3, [fp, #-120]
	mov	r2, #0
	mov	r3, #0
	ldrd	r0, [fp, #-124]
	mov	ip, r0
	lsr	r2, ip, #16
	mov	ip, r1
	orr	r2, r2, ip, lsl #16
	asr	r3, r1, #16
	mov	r3, r2
	str	r3, [fp, #-92]
	ldr	r3, [fp, #-44]
	lsl	r2, r3, #2
	ldr	r3, [fp, #-88]
	add	r3, r3, r2
	ldr	r1, [r3]
	ldr	r3, [fp, #-44]
	lsl	r2, r3, #2
	ldr	r3, [fp, #-88]
	add	r2, r3, r2
	ldr	r3, [fp, #-92]
	sub	r3, r1, r3
	str	r3, [r2]
	ldr	r3, [fp, #-44]
	add	r3, r3, #1
	str	r3, [fp, #-44]
.L15:
	ldr	r2, [fp, #-44]
	ldr	r3, [fp, #-104]
	cmp	r2, r3
	blt	.L16
.L14:
	ldr	r3, [fp, #-48]
	add	r3, r3, #1
	str	r3, [fp, #-48]
.L13:
	ldr	r2, [fp, #-48]
	ldr	r3, [fp, #-104]
	cmp	r2, r3
	blt	.L17
	ldr	r3, [fp, #-52]
	add	r3, r3, #1
	str	r3, [fp, #-52]
.L5:
	ldr	r2, [fp, #-52]
	ldr	r3, [fp, #-104]
	cmp	r2, r3
	blt	.L18
	mov	sp, r10
	nop
	sub	sp, fp, #32
	@ sp needed
	pop	{r4, r5, r6, r7, r8, r9, r10, fp, pc}
.L20:
	.align	2
.L19:
	.word	.LC9
	.size	gauss, .-gauss
	.section	.rodata
	.align	2
.LC10:
	.ascii	"Input order of matrix:\000"
	.align	2
.LC11:
	.ascii	"%d\000"
	.text
	.align	2
	.global	calculate_inverse
	.syntax unified
	.arm
	.fpu vfp
	.type	calculate_inverse, %function
calculate_inverse:
	@ args = 0, pretend = 0, frame = 48
	@ frame_needed = 1, uses_anonymous_args = 0
	push	{r4, r5, r6, r7, r8, r9, r10, fp, lr}
	add	fp, sp, #32
	sub	sp, sp, #52
	str	r0, [fp, #-72]
	str	r1, [fp, #-76]
	mov	r3, sp
	mov	r10, r3
	ldr	r0, .L26
	bl	puts
	sub	r3, fp, #64
	mov	r1, r3
	ldr	r0, .L26+4
	bl	__isoc99_scanf
	ldr	r2, [fp, #-64]
	ldr	r3, [fp, #-72]
	str	r2, [r3]
	ldr	r1, [fp, #-64]
	sub	r3, r1, #1
	str	r3, [fp, #-44]
	mov	r2, r1
	mov	r3, #0
	str	r2, [fp, #-84]
	str	r3, [fp, #-80]
	mov	r2, #0
	mov	r3, #0
	ldr	r0, [fp, #-80]
	lsl	r3, r0, #5
	ldr	r0, [fp, #-84]
	orr	r3, r3, r0, lsr #27
	ldr	r0, [fp, #-84]
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
	str	r3, [fp, #-40]
	b	.L22
.L23:
	ldr	r3, [fp, #-64]
	lsl	r3, r3, #2
	mov	r0, r3
	bl	malloc
	mov	r3, r0
	mov	r1, r3
	ldr	r3, [fp, #-48]
	ldr	r2, [fp, #-40]
	str	r1, [r3, r2, lsl #2]
	ldr	r3, [fp, #-56]
	ldr	r2, [fp, #-40]
	ldr	r1, [fp, #-40]
	str	r1, [r3, r2, lsl #2]
	ldr	r3, [fp, #-40]
	add	r3, r3, #1
	str	r3, [fp, #-40]
.L22:
	ldr	r3, [fp, #-64]
	ldr	r2, [fp, #-40]
	cmp	r2, r3
	blt	.L23
	ldr	r0, [fp, #-64]
	ldr	r3, [fp, #-76]
	ldr	r2, [fp, #-48]
	ldr	r1, [fp, #-56]
	bl	read_matrix_from_file
	bl	clock
	str	r0, [fp, #-60]
	ldr	r3, [fp, #-64]
	ldr	r2, [fp, #-56]
	ldr	r1, [fp, #-48]
	mov	r0, r3
	bl	gauss
	ldr	r0, [fp, #-60]
	bl	end_timer
	mov	r3, #0
	str	r3, [fp, #-40]
	b	.L24
.L25:
	ldr	r3, [fp, #-48]
	ldr	r2, [fp, #-40]
	ldr	r3, [r3, r2, lsl #2]
	mov	r0, r3
	bl	free
	ldr	r3, [fp, #-40]
	add	r3, r3, #1
	str	r3, [fp, #-40]
.L24:
	ldr	r3, [fp, #-64]
	ldr	r2, [fp, #-40]
	cmp	r2, r3
	blt	.L25
	mov	sp, r10
	nop
	sub	sp, fp, #32
	@ sp needed
	pop	{r4, r5, r6, r7, r8, r9, r10, fp, pc}
.L27:
	.align	2
.L26:
	.word	.LC10
	.word	.LC11
	.size	calculate_inverse, .-calculate_inverse
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
.LC12:
	.ascii	"r\000"
	.align	2
.LC13:
	.ascii	"Error while opening the file.\012\000"
	.align	2
.LC14:
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
	ldr	r1, .L39+8
	ldr	r0, [fp, #-44]
	bl	fopen
	str	r0, [fp, #-16]
	ldr	r3, [fp, #-16]
	cmp	r3, #0
	bne	.L34
	ldr	r0, .L39+12
	bl	perror
	mvn	r0, #0
	bl	exit
.L34:
	mov	r3, #0
	str	r3, [fp, #-8]
	b	.L35
.L38:
	ldr	r3, [fp, #-8]
	lsl	r3, r3, #2
	ldr	r2, [fp, #-40]
	add	r3, r2, r3
	ldr	r3, [r3]
	str	r3, [fp, #-20]
	mov	r3, #0
	str	r3, [fp, #-12]
	b	.L36
.L37:
	sub	r3, fp, #28
	mov	r2, r3
	ldr	r1, .L39+16
	ldr	r0, [fp, #-16]
	bl	__isoc99_fscanf
	vldr.32	s15, [fp, #-28]
	vcvt.f64.f32	d7, s15
	vldr.64	d6, .L39
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
.L36:
	ldr	r2, [fp, #-12]
	ldr	r3, [fp, #-32]
	cmp	r2, r3
	blt	.L37
	ldr	r3, [fp, #-8]
	add	r3, r3, #1
	str	r3, [fp, #-8]
.L35:
	ldr	r2, [fp, #-8]
	ldr	r3, [fp, #-32]
	cmp	r2, r3
	blt	.L38
	ldr	r0, [fp, #-16]
	bl	fclose
	nop
	sub	sp, fp, #4
	@ sp needed
	pop	{fp, pc}
.L40:
	.align	3
.L39:
	.word	0
	.word	1089470464
	.word	.LC12
	.word	.LC13
	.word	.LC14
	.size	read_matrix_from_file, .-read_matrix_from_file
	.section	.rodata
	.align	2
.LC15:
	.ascii	"A_exp\000"
	.text
	.align	2
	.global	read_expected_output_from_file
	.syntax unified
	.arm
	.fpu vfp
	.type	read_expected_output_from_file, %function
read_expected_output_from_file:
	@ args = 0, pretend = 0, frame = 64
	@ frame_needed = 1, uses_anonymous_args = 0
	push	{r4, r5, r6, r7, r8, r9, r10, fp, lr}
	add	fp, sp, #32
	sub	sp, sp, #68
	str	r0, [fp, #-72]
	str	r1, [fp, #-76]
	mov	r3, sp
	mov	r10, r3
	ldr	r1, [fp, #-72]
	sub	r3, r1, #1
	str	r3, [fp, #-40]
	mov	r2, r1
	mov	r3, #0
	mov	r4, r2
	mov	r5, r3
	mov	r2, #0
	mov	r3, #0
	lsl	r3, r5, #5
	orr	r3, r3, r4, lsr #27
	lsl	r2, r4, #5
	mov	r2, r1
	mov	r3, #0
	str	r2, [fp, #-84]
	str	r3, [fp, #-80]
	mov	r2, #0
	mov	r3, #0
	ldrd	r4, [fp, #-84]
	mov	r0, r5
	lsl	r3, r0, #5
	mov	r0, r4
	orr	r3, r3, r0, lsr #27
	mov	r0, r4
	lsl	r2, r0, #5
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
	ldr	r1, [fp, #-72]
	sub	r3, r1, #1
	str	r3, [fp, #-52]
	mov	r2, r1
	mov	r3, #0
	str	r2, [fp, #-92]
	str	r3, [fp, #-88]
	mov	r2, #0
	mov	r3, #0
	ldrd	r4, [fp, #-92]
	mov	r0, r5
	lsl	r3, r0, #5
	mov	r0, r4
	orr	r3, r3, r0, lsr #27
	mov	r0, r4
	lsl	r2, r0, #5
	mov	r2, r1
	mov	r3, #0
	str	r2, [fp, #-100]
	str	r3, [fp, #-96]
	mov	r2, #0
	mov	r3, #0
	ldrd	r4, [fp, #-100]
	mov	r0, r5
	lsl	r3, r0, #5
	mov	r0, r4
	orr	r3, r3, r0, lsr #27
	mov	r0, r4
	lsl	r2, r0, #5
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
	ldr	r1, [fp, #-72]
	sub	r3, r1, #1
	str	r3, [fp, #-60]
	mov	r2, r1
	mov	r3, #0
	mov	r8, r2
	mov	r9, r3
	mov	r2, #0
	mov	r3, #0
	lsl	r3, r9, #5
	orr	r3, r3, r8, lsr #27
	lsl	r2, r8, #5
	mov	r2, r1
	mov	r3, #0
	mov	r6, r2
	mov	r7, r3
	mov	r2, #0
	mov	r3, #0
	lsl	r3, r7, #5
	orr	r3, r3, r6, lsr #27
	lsl	r2, r6, #5
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
	str	r3, [fp, #-64]
	mov	r3, #0
	str	r3, [fp, #-44]
	b	.L42
.L43:
	ldr	r3, [fp, #-72]
	lsl	r3, r3, #2
	mov	r0, r3
	bl	malloc
	mov	r3, r0
	mov	r1, r3
	ldr	r3, [fp, #-56]
	ldr	r2, [fp, #-44]
	str	r1, [r3, r2, lsl #2]
	ldr	r3, [fp, #-48]
	ldr	r2, [fp, #-44]
	ldr	r1, [fp, #-44]
	str	r1, [r3, r2, lsl #2]
	ldr	r3, [fp, #-44]
	add	r3, r3, #1
	str	r3, [fp, #-44]
.L42:
	ldr	r2, [fp, #-44]
	ldr	r3, [fp, #-72]
	cmp	r2, r3
	blt	.L43
	ldr	r3, [fp, #-76]
	ldr	r2, [fp, #-56]
	ldr	r1, [fp, #-64]
	ldr	r0, [fp, #-72]
	bl	read_matrix_from_file
	ldr	r3, .L46
	ldr	r2, [fp, #-56]
	ldr	r1, [fp, #-48]
	ldr	r0, [fp, #-72]
	bl	print_matrix
	mov	r3, #0
	str	r3, [fp, #-44]
	b	.L44
.L45:
	ldr	r3, [fp, #-56]
	ldr	r2, [fp, #-44]
	ldr	r3, [r3, r2, lsl #2]
	mov	r0, r3
	bl	free
	ldr	r3, [fp, #-44]
	add	r3, r3, #1
	str	r3, [fp, #-44]
.L44:
	ldr	r2, [fp, #-44]
	ldr	r3, [fp, #-72]
	cmp	r2, r3
	blt	.L45
	mov	sp, r10
	nop
	sub	sp, fp, #32
	@ sp needed
	pop	{r4, r5, r6, r7, r8, r9, r10, fp, pc}
.L47:
	.align	2
.L46:
	.word	.LC15
	.size	read_expected_output_from_file, .-read_expected_output_from_file
	.section	.rodata
	.align	2
.LC16:
	.ascii	"%s = [\000"
	.align	2
.LC17:
	.ascii	"\011%.4f\000"
	.align	2
.LC18:
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
	.word	.LC16
	.word	.LC17
	.word	.LC18
	.size	print_matrix, .-print_matrix
	.section	.rodata
	.align	2
.LC19:
	.ascii	"Select action:\012(f) = input matrix from file; (t)"
	.ascii	" = run test suite; (0, 1, 2, 3) = run test from tes"
	.ascii	"tbench\000"
	.align	2
.LC20:
	.ascii	"%c\000"
	.align	2
.LC21:
	.ascii	"Input file name:\000"
	.align	2
.LC22:
	.ascii	"%s\000"
	.align	2
.LC25:
	.ascii	"Test %d Reading from %s\012\000"
	.align	2
.LC23:
	.word	.LC0
	.word	.LC1
	.word	.LC2
	.align	2
.LC24:
	.word	.LC4
	.word	.LC5
	.word	.LC6
	.align	2
.LC26:
	.ascii	"input/n100_1.txt\000"
	.space	33
	.align	2
.LC27:
	.ascii	"input/n250_1.txt\000"
	.space	33
	.align	2
.LC28:
	.ascii	"input/n100_ill.txt\000"
	.space	31
	.align	2
.LC29:
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
	@ args = 0, pretend = 0, frame = 112
	@ frame_needed = 1, uses_anonymous_args = 0
	push	{fp, lr}
	add	fp, sp, #4
	sub	sp, sp, #112
	ldr	r0, .L75
	bl	puts
	sub	r3, fp, #33
	mov	r1, r3
	ldr	r0, .L75+4
	bl	__isoc99_scanf
	sub	r3, fp, #40
	str	r3, [fp, #-28]
	ldrb	r3, [fp, #-33]	@ zero_extendqisi2
	cmp	r3, #102
	bne	.L58
	ldr	r0, .L75+8
	bl	puts
	sub	r3, fp, #116
	mov	r1, r3
	ldr	r0, .L75+12
	bl	__isoc99_scanf
	sub	r3, fp, #116
	mov	r1, r3
	ldr	r0, [fp, #-28]
	bl	calculate_inverse
	b	.L74
.L58:
	ldrb	r3, [fp, #-33]	@ zero_extendqisi2
	cmp	r3, #116
	bne	.L60
	mov	r3, #3
	str	r3, [fp, #-32]
	ldr	r2, .L75+16
	sub	r3, fp, #52
	ldm	r2, {r0, r1, r2}
	stm	r3, {r0, r1, r2}
	ldr	r2, .L75+20
	sub	r3, fp, #64
	ldm	r2, {r0, r1, r2}
	stm	r3, {r0, r1, r2}
	mov	r3, #0
	str	r3, [fp, #-8]
	b	.L61
.L62:
	ldr	r3, [fp, #-8]
	add	r1, r3, #1
	ldr	r3, [fp, #-8]
	lsl	r3, r3, #2
	sub	r2, fp, #4
	add	r3, r2, r3
	ldr	r3, [r3, #-48]
	mov	r2, r3
	ldr	r0, .L75+24
	bl	printf
	ldr	r3, [fp, #-8]
	lsl	r3, r3, #2
	sub	r2, fp, #4
	add	r3, r2, r3
	ldr	r3, [r3, #-48]
	mov	r1, r3
	ldr	r0, [fp, #-28]
	bl	calculate_inverse
	ldr	r2, [fp, #-40]
	ldr	r3, [fp, #-8]
	lsl	r3, r3, #2
	sub	r1, fp, #4
	add	r3, r1, r3
	ldr	r3, [r3, #-60]
	mov	r1, r3
	mov	r0, r2
	bl	read_expected_output_from_file
	ldr	r3, [fp, #-8]
	add	r3, r3, #1
	str	r3, [fp, #-8]
.L61:
	ldr	r2, [fp, #-8]
	ldr	r3, [fp, #-32]
	cmp	r2, r3
	blt	.L62
	b	.L74
.L60:
	ldrb	r3, [fp, #-33]	@ zero_extendqisi2
	cmp	r3, #48
	bne	.L63
	ldr	r3, .L75+28
	sub	ip, fp, #116
	mov	lr, r3
	ldmia	lr!, {r0, r1, r2, r3}
	stmia	ip!, {r0, r1, r2, r3}
	ldr	r3, [lr]
	strb	r3, [ip]
	sub	r3, fp, #99
	mov	r2, #33
	mov	r1, #0
	mov	r0, r3
	bl	memset
	mov	r3, #100
	str	r3, [fp, #-40]
	mov	r3, #0
	str	r3, [fp, #-12]
	b	.L64
.L65:
	ldr	r3, [fp, #-40]
	sub	r2, fp, #116
	mov	r1, r2
	mov	r0, r3
	bl	calculate_inverse_testbench
	ldr	r3, [fp, #-12]
	add	r3, r3, #1
	str	r3, [fp, #-12]
.L64:
	ldr	r3, [fp, #-12]
	cmp	r3, #0
	ble	.L65
	b	.L74
.L63:
	ldrb	r3, [fp, #-33]	@ zero_extendqisi2
	cmp	r3, #49
	bne	.L66
	ldr	r3, .L75+32
	sub	ip, fp, #116
	mov	lr, r3
	ldmia	lr!, {r0, r1, r2, r3}
	stmia	ip!, {r0, r1, r2, r3}
	ldr	r3, [lr]
	strb	r3, [ip]
	sub	r3, fp, #99
	mov	r2, #33
	mov	r1, #0
	mov	r0, r3
	bl	memset
	mov	r3, #250
	str	r3, [fp, #-40]
	mov	r3, #0
	str	r3, [fp, #-16]
	b	.L67
.L68:
	ldr	r3, [fp, #-40]
	sub	r2, fp, #116
	mov	r1, r2
	mov	r0, r3
	bl	calculate_inverse_testbench
	ldr	r3, [fp, #-16]
	add	r3, r3, #1
	str	r3, [fp, #-16]
.L67:
	ldr	r3, [fp, #-16]
	cmp	r3, #0
	ble	.L68
	b	.L74
.L66:
	ldrb	r3, [fp, #-33]	@ zero_extendqisi2
	cmp	r3, #50
	bne	.L69
	ldr	r3, .L75+36
	sub	ip, fp, #116
	mov	lr, r3
	ldmia	lr!, {r0, r1, r2, r3}
	stmia	ip!, {r0, r1, r2, r3}
	ldr	r3, [lr]
	strh	r3, [ip]	@ movhi
	add	ip, ip, #2
	lsr	r3, r3, #16
	strb	r3, [ip]
	sub	r3, fp, #97
	mov	r2, #31
	mov	r1, #0
	mov	r0, r3
	bl	memset
	mov	r3, #100
	str	r3, [fp, #-40]
	mov	r3, #0
	str	r3, [fp, #-20]
	b	.L70
.L71:
	ldr	r3, [fp, #-40]
	sub	r2, fp, #116
	mov	r1, r2
	mov	r0, r3
	bl	calculate_inverse_testbench
	ldr	r3, [fp, #-20]
	add	r3, r3, #1
	str	r3, [fp, #-20]
.L70:
	ldr	r3, [fp, #-20]
	cmp	r3, #29
	ble	.L71
	b	.L74
.L69:
	ldrb	r3, [fp, #-33]	@ zero_extendqisi2
	cmp	r3, #51
	bne	.L74
	ldr	r3, .L75+40
	sub	ip, fp, #116
	mov	lr, r3
	ldmia	lr!, {r0, r1, r2, r3}
	stmia	ip!, {r0, r1, r2, r3}
	ldr	r3, [lr]
	str	r3, [ip]
	sub	r3, fp, #96
	mov	r2, #30
	mov	r1, #0
	mov	r0, r3
	bl	memset
	mov	r3, #100
	str	r3, [fp, #-40]
	mov	r3, #0
	str	r3, [fp, #-24]
	b	.L72
.L73:
	ldr	r3, [fp, #-40]
	sub	r2, fp, #116
	mov	r1, r2
	mov	r0, r3
	bl	calculate_inverse_testbench
	ldr	r3, [fp, #-24]
	add	r3, r3, #1
	str	r3, [fp, #-24]
.L72:
	ldr	r3, [fp, #-24]
	cmp	r3, #29
	ble	.L73
.L74:
	nop
	sub	sp, fp, #4
	@ sp needed
	pop	{fp, pc}
.L76:
	.align	2
.L75:
	.word	.LC19
	.word	.LC20
	.word	.LC21
	.word	.LC22
	.word	.LC23
	.word	.LC24
	.word	.LC25
	.word	.LC26
	.word	.LC27
	.word	.LC28
	.word	.LC29
	.size	main, .-main
	.ident	"GCC: (Raspbian 10.2.1-6+rpi1) 10.2.1 20210110"
	.section	.note.GNU-stack,"",%progbits
