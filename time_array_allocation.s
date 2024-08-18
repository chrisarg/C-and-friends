	.file	"time_array_allocation.c"
	.text
	.section	.rodata.str1.1,"aMS",@progbits,1
.LC0:
	.string	"Memory allocation failed\n"
.LC2:
	.string	"array[%zu] = %c\n"
	.text
	.p2align 4
	.globl	time_allocation_and_initialization
	.type	time_allocation_and_initialization, @function
time_allocation_and_initialization:
.LFB51:
	.cfi_startproc
	endbr64
	pushq	%r15
	.cfi_def_cfa_offset 16
	.cfi_offset 15, -16
	pushq	%r14
	.cfi_def_cfa_offset 24
	.cfi_offset 14, -24
	pushq	%r13
	.cfi_def_cfa_offset 32
	.cfi_offset 13, -32
	movq	%rdi, %r13
	xorl	%edi, %edi
	pushq	%r12
	.cfi_def_cfa_offset 40
	.cfi_offset 12, -40
	pushq	%rbp
	.cfi_def_cfa_offset 48
	.cfi_offset 6, -48
	pushq	%rbx
	.cfi_def_cfa_offset 56
	.cfi_offset 3, -56
	movl	%esi, %ebx
	subq	$72, %rsp
	.cfi_def_cfa_offset 128
	movq	%fs:40, %rax
	movq	%rax, 56(%rsp)
	xorl	%eax, %eax
	leaq	16(%rsp), %rsi
	call	clock_gettime@PLT
	movq	%r13, %rdi
	call	malloc@PLT
	testq	%rax, %rax
	je	.L14
	movsbl	%bl, %esi
	movq	%r13, %rdx
	movq	%rax, %rdi
	movq	%rax, %r12
	call	memset@PLT
	leaq	32(%rsp), %rsi
	xorl	%edi, %edi
	call	clock_gettime@PLT
	movq	40(%rsp), %rax
	pxor	%xmm0, %xmm0
	subq	24(%rsp), %rax
	cvtsi2sdq	%rax, %xmm0
	pxor	%xmm1, %xmm1
	movq	32(%rsp), %rax
	subq	16(%rsp), %rax
	cvtsi2sdq	%rax, %xmm1
	divsd	.LC1(%rip), %xmm0
	addsd	%xmm1, %xmm0
	movsd	%xmm0, 8(%rsp)
	cmpq	$1, %r13
	jbe	.L6
	addb	$1, 1(%r12)
	movl	$2, %ebx
	movabsq	$-8194354213138031507, %r15
	movabsq	$18446744073, %r14
	leaq	.LC2(%rip), %rbp
	cmpq	$2, %r13
	je	.L6
	.p2align 4,,10
	.p2align 3
.L5:
	movzbl	(%r12,%rbx), %eax
	leal	1(%rax), %ecx
	movq	%rbx, %rax
	imulq	%r15, %rax
	movb	%cl, (%r12,%rbx)
	rorq	$9, %rax
	cmpq	%r14, %rax
	ja	.L4
	movsbl	%cl, %ecx
	movq	%rbx, %rdx
	movq	%rbp, %rsi
	movl	$1, %edi
	xorl	%eax, %eax
	call	__printf_chk@PLT
.L4:
	addq	$1, %rbx
	cmpq	%rbx, %r13
	jne	.L5
.L6:
	movq	%r12, %rdi
	call	free@PLT
	movq	56(%rsp), %rax
	subq	%fs:40, %rax
	jne	.L15
	movsd	8(%rsp), %xmm0
	addq	$72, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 56
	popq	%rbx
	.cfi_def_cfa_offset 48
	popq	%rbp
	.cfi_def_cfa_offset 40
	popq	%r12
	.cfi_def_cfa_offset 32
	popq	%r13
	.cfi_def_cfa_offset 24
	popq	%r14
	.cfi_def_cfa_offset 16
	popq	%r15
	.cfi_def_cfa_offset 8
	ret
.L14:
	.cfi_restore_state
	movq	stderr(%rip), %rcx
	movl	$25, %edx
	movl	$1, %esi
	leaq	.LC0(%rip), %rdi
	call	fwrite@PLT
	movl	$1, %edi
	call	exit@PLT
.L15:
	call	__stack_chk_fail@PLT
	.cfi_endproc
.LFE51:
	.size	time_allocation_and_initialization, .-time_allocation_and_initialization
	.p2align 4
	.globl	time_callocation_and_initialization
	.type	time_callocation_and_initialization, @function
time_callocation_and_initialization:
.LFB52:
	.cfi_startproc
	endbr64
	pushq	%r15
	.cfi_def_cfa_offset 16
	.cfi_offset 15, -16
	pushq	%r14
	.cfi_def_cfa_offset 24
	.cfi_offset 14, -24
	pushq	%r13
	.cfi_def_cfa_offset 32
	.cfi_offset 13, -32
	movq	%rdi, %r13
	xorl	%edi, %edi
	pushq	%r12
	.cfi_def_cfa_offset 40
	.cfi_offset 12, -40
	pushq	%rbp
	.cfi_def_cfa_offset 48
	.cfi_offset 6, -48
	pushq	%rbx
	.cfi_def_cfa_offset 56
	.cfi_offset 3, -56
	movl	%esi, %ebx
	subq	$72, %rsp
	.cfi_def_cfa_offset 128
	movq	%fs:40, %rax
	movq	%rax, 56(%rsp)
	xorl	%eax, %eax
	leaq	16(%rsp), %rsi
	call	clock_gettime@PLT
	movl	$1, %esi
	movq	%r13, %rdi
	call	calloc@PLT
	testq	%rax, %rax
	je	.L28
	movsbl	%bl, %esi
	movq	%r13, %rdx
	movq	%rax, %rdi
	movq	%rax, %r12
	call	memset@PLT
	leaq	32(%rsp), %rsi
	xorl	%edi, %edi
	call	clock_gettime@PLT
	movq	40(%rsp), %rax
	pxor	%xmm0, %xmm0
	subq	24(%rsp), %rax
	cvtsi2sdq	%rax, %xmm0
	pxor	%xmm1, %xmm1
	movq	32(%rsp), %rax
	subq	16(%rsp), %rax
	cvtsi2sdq	%rax, %xmm1
	divsd	.LC1(%rip), %xmm0
	addsd	%xmm1, %xmm0
	movsd	%xmm0, 8(%rsp)
	cmpq	$1, %r13
	jbe	.L21
	addb	$1, 1(%r12)
	movl	$2, %ebx
	movabsq	$-8194354213138031507, %r15
	movabsq	$18446744073, %r14
	leaq	.LC2(%rip), %rbp
	cmpq	$2, %r13
	je	.L21
	.p2align 4,,10
	.p2align 3
.L20:
	movzbl	(%r12,%rbx), %eax
	leal	1(%rax), %ecx
	movq	%rbx, %rax
	imulq	%r15, %rax
	movb	%cl, (%r12,%rbx)
	rorq	$9, %rax
	cmpq	%r14, %rax
	ja	.L19
	movsbl	%cl, %ecx
	movq	%rbx, %rdx
	movq	%rbp, %rsi
	movl	$1, %edi
	xorl	%eax, %eax
	call	__printf_chk@PLT
.L19:
	addq	$1, %rbx
	cmpq	%rbx, %r13
	jne	.L20
.L21:
	movq	%r12, %rdi
	call	free@PLT
	movq	56(%rsp), %rax
	subq	%fs:40, %rax
	jne	.L29
	movsd	8(%rsp), %xmm0
	addq	$72, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 56
	popq	%rbx
	.cfi_def_cfa_offset 48
	popq	%rbp
	.cfi_def_cfa_offset 40
	popq	%r12
	.cfi_def_cfa_offset 32
	popq	%r13
	.cfi_def_cfa_offset 24
	popq	%r14
	.cfi_def_cfa_offset 16
	popq	%r15
	.cfi_def_cfa_offset 8
	ret
.L28:
	.cfi_restore_state
	movq	stderr(%rip), %rcx
	movl	$25, %edx
	movl	$1, %esi
	leaq	.LC0(%rip), %rdi
	call	fwrite@PLT
	movl	$1, %edi
	call	exit@PLT
.L29:
	call	__stack_chk_fail@PLT
	.cfi_endproc
.LFE52:
	.size	time_callocation_and_initialization, .-time_callocation_and_initialization
	.p2align 4
	.globl	time_allocation_and_initialization_loop
	.type	time_allocation_and_initialization_loop, @function
time_allocation_and_initialization_loop:
.LFB53:
	.cfi_startproc
	endbr64
	pushq	%r15
	.cfi_def_cfa_offset 16
	.cfi_offset 15, -16
	pushq	%r14
	.cfi_def_cfa_offset 24
	.cfi_offset 14, -24
	pushq	%r13
	.cfi_def_cfa_offset 32
	.cfi_offset 13, -32
	movq	%rdi, %r13
	xorl	%edi, %edi
	pushq	%r12
	.cfi_def_cfa_offset 40
	.cfi_offset 12, -40
	pushq	%rbp
	.cfi_def_cfa_offset 48
	.cfi_offset 6, -48
	pushq	%rbx
	.cfi_def_cfa_offset 56
	.cfi_offset 3, -56
	movl	%esi, %ebx
	subq	$72, %rsp
	.cfi_def_cfa_offset 128
	movq	%fs:40, %rax
	movq	%rax, 56(%rsp)
	xorl	%eax, %eax
	leaq	16(%rsp), %rsi
	call	clock_gettime@PLT
	movq	%r13, %rdi
	call	malloc@PLT
	testq	%rax, %rax
	je	.L31
	movq	%rax, %r12
	testq	%r13, %r13
	je	.L45
	movsbl	%bl, %esi
	movq	%r13, %rdx
	movq	%rax, %rdi
	call	memset@PLT
	leaq	32(%rsp), %rsi
	xorl	%edi, %edi
	call	clock_gettime@PLT
	movq	40(%rsp), %rax
	pxor	%xmm0, %xmm0
	subq	24(%rsp), %rax
	cvtsi2sdq	%rax, %xmm0
	pxor	%xmm1, %xmm1
	movq	32(%rsp), %rax
	subq	16(%rsp), %rax
	cvtsi2sdq	%rax, %xmm1
	divsd	.LC1(%rip), %xmm0
	addsd	%xmm1, %xmm0
	movsd	%xmm0, 8(%rsp)
	cmpq	$1, %r13
	je	.L35
	addb	$1, 1(%r12)
	movl	$2, %ebx
	movabsq	$-8194354213138031507, %r15
	movabsq	$18446744073, %r14
	leaq	.LC2(%rip), %rbp
	cmpq	$2, %r13
	je	.L35
	.p2align 4,,10
	.p2align 3
.L37:
	movzbl	(%r12,%rbx), %eax
	leal	1(%rax), %ecx
	movq	%rbx, %rax
	imulq	%r15, %rax
	movb	%cl, (%r12,%rbx)
	rorq	$9, %rax
	cmpq	%r14, %rax
	ja	.L36
	movsbl	%cl, %ecx
	movq	%rbx, %rdx
	movq	%rbp, %rsi
	movl	$1, %edi
	xorl	%eax, %eax
	call	__printf_chk@PLT
.L36:
	addq	$1, %rbx
	cmpq	%rbx, %r13
	jne	.L37
.L35:
	movq	%r12, %rdi
	call	free@PLT
	movq	56(%rsp), %rax
	subq	%fs:40, %rax
	jne	.L46
	movsd	8(%rsp), %xmm0
	addq	$72, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 56
	popq	%rbx
	.cfi_def_cfa_offset 48
	popq	%rbp
	.cfi_def_cfa_offset 40
	popq	%r12
	.cfi_def_cfa_offset 32
	popq	%r13
	.cfi_def_cfa_offset 24
	popq	%r14
	.cfi_def_cfa_offset 16
	popq	%r15
	.cfi_def_cfa_offset 8
	ret
	.p2align 4,,10
	.p2align 3
.L45:
	.cfi_restore_state
	leaq	32(%rsp), %rsi
	xorl	%edi, %edi
	call	clock_gettime@PLT
	movq	40(%rsp), %rax
	pxor	%xmm0, %xmm0
	subq	24(%rsp), %rax
	cvtsi2sdq	%rax, %xmm0
	pxor	%xmm1, %xmm1
	movq	32(%rsp), %rax
	subq	16(%rsp), %rax
	cvtsi2sdq	%rax, %xmm1
	divsd	.LC1(%rip), %xmm0
	addsd	%xmm1, %xmm0
	movsd	%xmm0, 8(%rsp)
	jmp	.L35
.L46:
	call	__stack_chk_fail@PLT
.L31:
	movq	stderr(%rip), %rcx
	movl	$25, %edx
	movl	$1, %esi
	leaq	.LC0(%rip), %rdi
	call	fwrite@PLT
	movl	$1, %edi
	call	exit@PLT
	.cfi_endproc
.LFE53:
	.size	time_allocation_and_initialization_loop, .-time_allocation_and_initialization_loop
	.p2align 4
	.globl	time_callocation_and_initialization_loop
	.type	time_callocation_and_initialization_loop, @function
time_callocation_and_initialization_loop:
.LFB54:
	.cfi_startproc
	endbr64
	pushq	%r15
	.cfi_def_cfa_offset 16
	.cfi_offset 15, -16
	pushq	%r14
	.cfi_def_cfa_offset 24
	.cfi_offset 14, -24
	pushq	%r13
	.cfi_def_cfa_offset 32
	.cfi_offset 13, -32
	movq	%rdi, %r13
	xorl	%edi, %edi
	pushq	%r12
	.cfi_def_cfa_offset 40
	.cfi_offset 12, -40
	pushq	%rbp
	.cfi_def_cfa_offset 48
	.cfi_offset 6, -48
	pushq	%rbx
	.cfi_def_cfa_offset 56
	.cfi_offset 3, -56
	movl	%esi, %ebx
	subq	$72, %rsp
	.cfi_def_cfa_offset 128
	movq	%fs:40, %rax
	movq	%rax, 56(%rsp)
	xorl	%eax, %eax
	leaq	16(%rsp), %rsi
	call	clock_gettime@PLT
	movl	$1, %esi
	movq	%r13, %rdi
	call	calloc@PLT
	testq	%rax, %rax
	je	.L48
	movq	%rax, %r12
	testq	%r13, %r13
	je	.L62
	movsbl	%bl, %esi
	movq	%r13, %rdx
	movq	%rax, %rdi
	call	memset@PLT
	leaq	32(%rsp), %rsi
	xorl	%edi, %edi
	call	clock_gettime@PLT
	movq	40(%rsp), %rax
	pxor	%xmm0, %xmm0
	subq	24(%rsp), %rax
	cvtsi2sdq	%rax, %xmm0
	pxor	%xmm1, %xmm1
	movq	32(%rsp), %rax
	subq	16(%rsp), %rax
	cvtsi2sdq	%rax, %xmm1
	divsd	.LC1(%rip), %xmm0
	addsd	%xmm1, %xmm0
	movsd	%xmm0, 8(%rsp)
	cmpq	$1, %r13
	je	.L52
	addb	$1, 1(%r12)
	movl	$2, %ebx
	movabsq	$-8194354213138031507, %r15
	movabsq	$18446744073, %r14
	leaq	.LC2(%rip), %rbp
	cmpq	$2, %r13
	je	.L52
	.p2align 4,,10
	.p2align 3
.L54:
	movzbl	(%r12,%rbx), %eax
	leal	1(%rax), %ecx
	movq	%rbx, %rax
	imulq	%r15, %rax
	movb	%cl, (%r12,%rbx)
	rorq	$9, %rax
	cmpq	%r14, %rax
	ja	.L53
	movsbl	%cl, %ecx
	movq	%rbx, %rdx
	movq	%rbp, %rsi
	movl	$1, %edi
	xorl	%eax, %eax
	call	__printf_chk@PLT
.L53:
	addq	$1, %rbx
	cmpq	%rbx, %r13
	jne	.L54
.L52:
	movq	%r12, %rdi
	call	free@PLT
	movq	56(%rsp), %rax
	subq	%fs:40, %rax
	jne	.L63
	movsd	8(%rsp), %xmm0
	addq	$72, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 56
	popq	%rbx
	.cfi_def_cfa_offset 48
	popq	%rbp
	.cfi_def_cfa_offset 40
	popq	%r12
	.cfi_def_cfa_offset 32
	popq	%r13
	.cfi_def_cfa_offset 24
	popq	%r14
	.cfi_def_cfa_offset 16
	popq	%r15
	.cfi_def_cfa_offset 8
	ret
	.p2align 4,,10
	.p2align 3
.L62:
	.cfi_restore_state
	leaq	32(%rsp), %rsi
	xorl	%edi, %edi
	call	clock_gettime@PLT
	movq	40(%rsp), %rax
	pxor	%xmm0, %xmm0
	subq	24(%rsp), %rax
	cvtsi2sdq	%rax, %xmm0
	pxor	%xmm1, %xmm1
	movq	32(%rsp), %rax
	subq	16(%rsp), %rax
	cvtsi2sdq	%rax, %xmm1
	divsd	.LC1(%rip), %xmm0
	addsd	%xmm1, %xmm0
	movsd	%xmm0, 8(%rsp)
	jmp	.L52
.L63:
	call	__stack_chk_fail@PLT
.L48:
	movq	stderr(%rip), %rcx
	movl	$25, %edx
	movl	$1, %esi
	leaq	.LC0(%rip), %rdi
	call	fwrite@PLT
	movl	$1, %edi
	call	exit@PLT
	.cfi_endproc
.LFE54:
	.size	time_callocation_and_initialization_loop, .-time_callocation_and_initialization_loop
	.p2align 4
	.globl	time_allocation_and_initialization_openmp_simd
	.type	time_allocation_and_initialization_openmp_simd, @function
time_allocation_and_initialization_openmp_simd:
.LFB61:
	.cfi_startproc
	endbr64
	jmp	time_allocation_and_initialization_loop
	.cfi_endproc
.LFE61:
	.size	time_allocation_and_initialization_openmp_simd, .-time_allocation_and_initialization_openmp_simd
	.p2align 4
	.globl	time_callocation_and_initialization_openmp_simd
	.type	time_callocation_and_initialization_openmp_simd, @function
time_callocation_and_initialization_openmp_simd:
.LFB63:
	.cfi_startproc
	endbr64
	jmp	time_callocation_and_initialization_loop
	.cfi_endproc
.LFE63:
	.size	time_callocation_and_initialization_openmp_simd, .-time_callocation_and_initialization_openmp_simd
	.p2align 4
	.globl	time_allocation
	.type	time_allocation, @function
time_allocation:
.LFB57:
	.cfi_startproc
	endbr64
	pushq	%r15
	.cfi_def_cfa_offset 16
	.cfi_offset 15, -16
	pushq	%r14
	.cfi_def_cfa_offset 24
	.cfi_offset 14, -24
	pushq	%r13
	.cfi_def_cfa_offset 32
	.cfi_offset 13, -32
	pushq	%r12
	.cfi_def_cfa_offset 40
	.cfi_offset 12, -40
	pushq	%rbp
	.cfi_def_cfa_offset 48
	.cfi_offset 6, -48
	movq	%rdi, %rbp
	xorl	%edi, %edi
	pushq	%rbx
	.cfi_def_cfa_offset 56
	.cfi_offset 3, -56
	subq	$72, %rsp
	.cfi_def_cfa_offset 128
	movq	%fs:40, %rax
	movq	%rax, 56(%rsp)
	xorl	%eax, %eax
	leaq	16(%rsp), %rsi
	call	clock_gettime@PLT
	movq	%rbp, %rdi
	call	malloc@PLT
	testq	%rax, %rax
	je	.L78
	leaq	32(%rsp), %rsi
	xorl	%edi, %edi
	movq	%rax, %r13
	call	clock_gettime@PLT
	movq	40(%rsp), %rax
	pxor	%xmm0, %xmm0
	subq	24(%rsp), %rax
	cvtsi2sdq	%rax, %xmm0
	pxor	%xmm1, %xmm1
	movq	32(%rsp), %rax
	subq	16(%rsp), %rax
	cvtsi2sdq	%rax, %xmm1
	divsd	.LC1(%rip), %xmm0
	addsd	%xmm1, %xmm0
	movsd	%xmm0, 8(%rsp)
	cmpq	$1, %rbp
	jbe	.L71
	addb	$1, 1(%r13)
	movl	$2, %ebx
	movabsq	$-8194354213138031507, %r15
	movabsq	$18446744073, %r14
	leaq	.LC2(%rip), %r12
	cmpq	$2, %rbp
	je	.L71
	.p2align 4,,10
	.p2align 3
.L70:
	movzbl	0(%r13,%rbx), %eax
	leal	1(%rax), %ecx
	movq	%rbx, %rax
	imulq	%r15, %rax
	movb	%cl, 0(%r13,%rbx)
	rorq	$9, %rax
	cmpq	%r14, %rax
	ja	.L69
	movsbl	%cl, %ecx
	movq	%rbx, %rdx
	movq	%r12, %rsi
	movl	$1, %edi
	xorl	%eax, %eax
	call	__printf_chk@PLT
.L69:
	addq	$1, %rbx
	cmpq	%rbx, %rbp
	jne	.L70
.L71:
	movq	%r13, %rdi
	call	free@PLT
	movq	56(%rsp), %rax
	subq	%fs:40, %rax
	jne	.L79
	movsd	8(%rsp), %xmm0
	addq	$72, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 56
	popq	%rbx
	.cfi_def_cfa_offset 48
	popq	%rbp
	.cfi_def_cfa_offset 40
	popq	%r12
	.cfi_def_cfa_offset 32
	popq	%r13
	.cfi_def_cfa_offset 24
	popq	%r14
	.cfi_def_cfa_offset 16
	popq	%r15
	.cfi_def_cfa_offset 8
	ret
.L78:
	.cfi_restore_state
	movq	stderr(%rip), %rcx
	movl	$25, %edx
	movl	$1, %esi
	leaq	.LC0(%rip), %rdi
	call	fwrite@PLT
	movl	$1, %edi
	call	exit@PLT
.L79:
	call	__stack_chk_fail@PLT
	.cfi_endproc
.LFE57:
	.size	time_allocation, .-time_allocation
	.p2align 4
	.globl	time_callocation
	.type	time_callocation, @function
time_callocation:
.LFB58:
	.cfi_startproc
	endbr64
	pushq	%r15
	.cfi_def_cfa_offset 16
	.cfi_offset 15, -16
	pushq	%r14
	.cfi_def_cfa_offset 24
	.cfi_offset 14, -24
	pushq	%r13
	.cfi_def_cfa_offset 32
	.cfi_offset 13, -32
	pushq	%r12
	.cfi_def_cfa_offset 40
	.cfi_offset 12, -40
	pushq	%rbp
	.cfi_def_cfa_offset 48
	.cfi_offset 6, -48
	movq	%rdi, %rbp
	xorl	%edi, %edi
	pushq	%rbx
	.cfi_def_cfa_offset 56
	.cfi_offset 3, -56
	subq	$72, %rsp
	.cfi_def_cfa_offset 128
	movq	%fs:40, %rax
	movq	%rax, 56(%rsp)
	xorl	%eax, %eax
	leaq	16(%rsp), %rsi
	call	clock_gettime@PLT
	movl	$1, %esi
	movq	%rbp, %rdi
	call	calloc@PLT
	testq	%rax, %rax
	je	.L92
	leaq	32(%rsp), %rsi
	xorl	%edi, %edi
	movq	%rax, %r13
	call	clock_gettime@PLT
	movq	40(%rsp), %rax
	pxor	%xmm0, %xmm0
	subq	24(%rsp), %rax
	cvtsi2sdq	%rax, %xmm0
	pxor	%xmm1, %xmm1
	movq	32(%rsp), %rax
	subq	16(%rsp), %rax
	cvtsi2sdq	%rax, %xmm1
	divsd	.LC1(%rip), %xmm0
	addsd	%xmm1, %xmm0
	movsd	%xmm0, 8(%rsp)
	cmpq	$1, %rbp
	jbe	.L85
	addb	$1, 1(%r13)
	movl	$2, %ebx
	movabsq	$-8194354213138031507, %r15
	movabsq	$18446744073, %r14
	leaq	.LC2(%rip), %r12
	cmpq	$2, %rbp
	je	.L85
	.p2align 4,,10
	.p2align 3
.L84:
	movzbl	0(%r13,%rbx), %eax
	leal	1(%rax), %ecx
	movq	%rbx, %rax
	imulq	%r15, %rax
	movb	%cl, 0(%r13,%rbx)
	rorq	$9, %rax
	cmpq	%r14, %rax
	ja	.L83
	movsbl	%cl, %ecx
	movq	%rbx, %rdx
	movq	%r12, %rsi
	movl	$1, %edi
	xorl	%eax, %eax
	call	__printf_chk@PLT
.L83:
	addq	$1, %rbx
	cmpq	%rbx, %rbp
	jne	.L84
.L85:
	movq	%r13, %rdi
	call	free@PLT
	movq	56(%rsp), %rax
	subq	%fs:40, %rax
	jne	.L93
	movsd	8(%rsp), %xmm0
	addq	$72, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 56
	popq	%rbx
	.cfi_def_cfa_offset 48
	popq	%rbp
	.cfi_def_cfa_offset 40
	popq	%r12
	.cfi_def_cfa_offset 32
	popq	%r13
	.cfi_def_cfa_offset 24
	popq	%r14
	.cfi_def_cfa_offset 16
	popq	%r15
	.cfi_def_cfa_offset 8
	ret
.L92:
	.cfi_restore_state
	movq	stderr(%rip), %rcx
	movl	$25, %edx
	movl	$1, %esi
	leaq	.LC0(%rip), %rdi
	call	fwrite@PLT
	movl	$1, %edi
	call	exit@PLT
.L93:
	call	__stack_chk_fail@PLT
	.cfi_endproc
.LFE58:
	.size	time_callocation, .-time_callocation
	.section	.rodata.str1.8,"aMS",@progbits,1
	.align 8
.LC3:
	.string	"Usage: %s <length> <initial_value> <iterations> <csv_file>\n"
	.section	.rodata.str1.1
.LC4:
	.string	"a"
	.section	.rodata.str1.8
	.align 8
.LC5:
	.string	"Could not open file for writing\n"
	.align 8
.LC6:
	.string	"Language,Operation,Iteration,Time,Length\n"
	.section	.rodata.str1.1
.LC7:
	.string	"C,Alloc_set,%zu,%f,%zu\n"
.LC8:
	.string	"C,Alloc,%zu,%f,%zu\n"
.LC9:
	.string	"C,Calloc_set,%zu,%f,%zu\n"
.LC10:
	.string	"C,Calloc_zero,%zu,%f,%zu\n"
.LC11:
	.string	"C,Alloc_set_loop,%zu,%f,%zu\n"
.LC12:
	.string	"C,Calloc_set_loop,%zu,%f,%zu\n"
	.section	.rodata.str1.8
	.align 8
.LC13:
	.string	"C,Alloc_set_openmp_simd,%zu,%f,%zu\n"
	.align 8
.LC14:
	.string	"C,Calloc_set_openmp_simd,%zu,%f,%zu\n"
	.section	.text.startup,"ax",@progbits
	.p2align 4
	.globl	main
	.type	main, @function
main:
.LFB59:
	.cfi_startproc
	endbr64
	pushq	%r15
	.cfi_def_cfa_offset 16
	.cfi_offset 15, -16
	pushq	%r14
	.cfi_def_cfa_offset 24
	.cfi_offset 14, -24
	pushq	%r13
	.cfi_def_cfa_offset 32
	.cfi_offset 13, -32
	pushq	%r12
	.cfi_def_cfa_offset 40
	.cfi_offset 12, -40
	pushq	%rbp
	.cfi_def_cfa_offset 48
	.cfi_offset 6, -48
	movq	%rsi, %rbp
	pushq	%rbx
	.cfi_def_cfa_offset 56
	.cfi_offset 3, -56
	subq	$24, %rsp
	.cfi_def_cfa_offset 80
	cmpl	$5, %edi
	je	.L95
	movq	(%rsi), %rcx
	movq	stderr(%rip), %rdi
	movl	$1, %esi
	xorl	%eax, %eax
	leaq	.LC3(%rip), %rdx
	call	__fprintf_chk@PLT
	movl	$1, %eax
.L94:
	addq	$24, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 56
	popq	%rbx
	.cfi_def_cfa_offset 48
	popq	%rbp
	.cfi_def_cfa_offset 40
	popq	%r12
	.cfi_def_cfa_offset 32
	popq	%r13
	.cfi_def_cfa_offset 24
	popq	%r14
	.cfi_def_cfa_offset 16
	popq	%r15
	.cfi_def_cfa_offset 8
	ret
.L95:
	.cfi_restore_state
	movq	8(%rsi), %rdi
	movl	$10, %edx
	xorl	%esi, %esi
	call	strtoull@PLT
	movq	24(%rbp), %rdi
	movl	$10, %edx
	xorl	%esi, %esi
	movq	%rax, %rbx
	movq	16(%rbp), %rax
	movsbl	(%rax), %r13d
	call	strtoull@PLT
	movq	32(%rbp), %rdi
	leaq	.LC4(%rip), %rsi
	movq	%rax, 8(%rsp)
	call	fopen@PLT
	movq	%rax, %r12
	testq	%rax, %rax
	je	.L104
	xorl	%esi, %esi
	movq	%rax, %rdi
	movl	$2, %edx
	call	fseek@PLT
	movq	%r12, %rdi
	call	ftell@PLT
	testq	%rax, %rax
	je	.L105
.L98:
	xorl	%ebp, %ebp
	cmpq	$0, 8(%rsp)
	leaq	.LC7(%rip), %r15
	leaq	.LC8(%rip), %r14
	je	.L101
	.p2align 4,,10
	.p2align 3
.L100:
	addq	$1, %rbp
	movl	%r13d, %esi
	movq	%rbx, %rdi
	call	time_allocation_and_initialization
	movq	%rbx, %r8
	movq	%rbp, %rcx
	movq	%r15, %rdx
	movl	$1, %esi
	movq	%r12, %rdi
	movl	$1, %eax
	call	__fprintf_chk@PLT
	movq	%rbx, %rdi
	call	time_allocation
	movq	%rbx, %r8
	movq	%rbp, %rcx
	movq	%r14, %rdx
	movl	$1, %esi
	movq	%r12, %rdi
	movl	$1, %eax
	call	__fprintf_chk@PLT
	movl	%r13d, %esi
	movq	%rbx, %rdi
	call	time_callocation_and_initialization
	movq	%rbx, %r8
	movq	%rbp, %rcx
	movl	$1, %esi
	leaq	.LC9(%rip), %rdx
	movq	%r12, %rdi
	movl	$1, %eax
	call	__fprintf_chk@PLT
	movq	%rbx, %rdi
	call	time_callocation
	movq	%rbx, %r8
	movq	%rbp, %rcx
	movl	$1, %esi
	leaq	.LC10(%rip), %rdx
	movq	%r12, %rdi
	movl	$1, %eax
	call	__fprintf_chk@PLT
	movl	%r13d, %esi
	movq	%rbx, %rdi
	call	time_allocation_and_initialization_loop
	movq	%rbx, %r8
	movq	%rbp, %rcx
	movl	$1, %esi
	leaq	.LC11(%rip), %rdx
	movq	%r12, %rdi
	movl	$1, %eax
	call	__fprintf_chk@PLT
	movl	%r13d, %esi
	movq	%rbx, %rdi
	call	time_callocation_and_initialization_loop
	movq	%rbx, %r8
	movq	%rbp, %rcx
	movl	$1, %esi
	leaq	.LC12(%rip), %rdx
	movq	%r12, %rdi
	movl	$1, %eax
	call	__fprintf_chk@PLT
	movl	%r13d, %esi
	movq	%rbx, %rdi
	call	time_allocation_and_initialization_loop
	movq	%rbx, %r8
	movq	%rbp, %rcx
	movl	$1, %esi
	leaq	.LC13(%rip), %rdx
	movq	%r12, %rdi
	movl	$1, %eax
	call	__fprintf_chk@PLT
	movl	%r13d, %esi
	movq	%rbx, %rdi
	call	time_callocation_and_initialization_loop
	movq	%rbx, %r8
	movq	%rbp, %rcx
	movl	$1, %esi
	leaq	.LC14(%rip), %rdx
	movq	%r12, %rdi
	movl	$1, %eax
	call	__fprintf_chk@PLT
	cmpq	8(%rsp), %rbp
	jne	.L100
.L101:
	movq	%r12, %rdi
	call	fclose@PLT
	xorl	%eax, %eax
	jmp	.L94
.L105:
	movq	%r12, %rcx
	movl	$41, %edx
	movl	$1, %esi
	leaq	.LC6(%rip), %rdi
	call	fwrite@PLT
	jmp	.L98
.L104:
	movq	stderr(%rip), %rcx
	movl	$32, %edx
	movl	$1, %esi
	leaq	.LC5(%rip), %rdi
	call	fwrite@PLT
	movl	$1, %eax
	jmp	.L94
	.cfi_endproc
.LFE59:
	.size	main, .-main
	.section	.rodata.cst8,"aM",@progbits,8
	.align 8
.LC1:
	.long	0
	.long	1104006501
	.ident	"GCC: (Ubuntu 11.4.0-1ubuntu1~22.04) 11.4.0"
	.section	.note.GNU-stack,"",@progbits
	.section	.note.gnu.property,"a"
	.align 8
	.long	1f - 0f
	.long	4f - 1f
	.long	5
0:
	.string	"GNU"
1:
	.align 8
	.long	0xc0000002
	.long	3f - 2f
2:
	.long	0x3
3:
	.align 8
4:
