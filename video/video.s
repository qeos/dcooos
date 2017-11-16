	.file	"video.c"
	.text
.Ltext0:
	.cfi_sections	.debug_frame
	.p2align 4,,15
	.globl	syscall
	.def	syscall;	.scl	2;	.type	32;	.endef
	.seh_proc	syscall
syscall:
.LFB0:
	.file 1 "D:/WORK/BUILD/OS/dcooos/kernel64/syscall.h"
	.loc 1 5 0
	.cfi_startproc
.LVL0:
	pushq	%rbx
	.seh_pushreg	%rbx
	.cfi_def_cfa_offset 16
	.cfi_offset 3, -16
	.seh_endprologue
	.loc 1 7 0
	movq	%rcx, %rax
	movq	%rdx, %rbx
/APP
 # 7 "D:/WORK/BUILD/OS/dcooos/kernel64/syscall.h" 1
	int $0x80
 # 0 "" 2
.LVL1:
	.loc 1 9 0
/NO_APP
	popq	%rbx
	.cfi_restore 3
	.cfi_def_cfa_offset 8
	ret
	.cfi_endproc
.LFE0:
	.seh_endproc
	.p2align 4,,15
	.globl	memcpy
	.def	memcpy;	.scl	2;	.type	32;	.endef
	.seh_proc	memcpy
memcpy:
.LFB1:
	.file 2 "D:/WORK/BUILD/OS/dcooos/kernel64/strings.c"
	.loc 2 5 0
	.cfi_startproc
.LVL2:
	.seh_endprologue
.LVL3:
	.loc 2 9 0
	xorl	%eax, %eax
	testq	%r8, %r8
	je	.L2
.LVL4:
	.p2align 4,,10
.L6:
	.loc 2 10 0
	movzbl	(%rdx,%rax), %r9d
	movb	%r9b, (%rcx,%rax)
.LVL5:
	addq	$1, %rax
.LVL6:
	.loc 2 9 0
	cmpq	%r8, %rax
	jne	.L6
.LVL7:
.L2:
	ret
	.cfi_endproc
.LFE1:
	.seh_endproc
	.p2align 4,,15
	.globl	memset
	.def	memset;	.scl	2;	.type	32;	.endef
	.seh_proc	memset
memset:
.LFB2:
	.loc 2 15 0
	.cfi_startproc
.LVL8:
	.seh_endprologue
.LVL9:
	leaq	(%rcx,%r8), %rax
	.loc 2 17 0
	testq	%r8, %r8
	je	.L9
.LVL10:
	.p2align 4,,10
.L13:
	.loc 2 18 0
	addq	$1, %rcx
.LVL11:
	movb	%dl, -1(%rcx)
	.loc 2 17 0
	cmpq	%rcx, %rax
	jne	.L13
.LVL12:
.L9:
	ret
	.cfi_endproc
.LFE2:
	.seh_endproc
	.p2align 4,,15
	.globl	strcmp
	.def	strcmp;	.scl	2;	.type	32;	.endef
	.seh_proc	strcmp
strcmp:
.LFB3:
	.loc 2 24 0
	.cfi_startproc
.LVL13:
	.seh_endprologue
.LVL14:
	.loc 2 27 0
	movzbl	(%rcx), %eax
	testb	%al, %al
	je	.L21
	movzbl	(%rdx), %r8d
	testb	%r8b, %r8b
	je	.L24
	.loc 2 29 0
	cmpb	%al, %r8b
	jne	.L24
	xorl	%eax, %eax
	jmp	.L19
.LVL15:
	.p2align 4,,10
.L28:
	.loc 2 27 0 discriminator 1
	movzbl	(%rdx,%rax), %r9d
	testb	%r9b, %r9b
	je	.L24
	.loc 2 29 0
	cmpb	%r9b, %r8b
	jne	.L24
.LVL16:
.L19:
	.loc 2 34 0
	addq	$1, %rax
.LVL17:
	.loc 2 27 0
	movzbl	(%rcx,%rax), %r8d
	testb	%r8b, %r8b
	jne	.L28
.LVL18:
.L16:
	.loc 2 37 0
	cmpb	$0, (%rdx,%rax)
	setne	%al
	movzbl	%al, %eax
	.loc 2 41 0
	ret
	.p2align 4,,10
.L24:
	.loc 2 38 0
	movl	$1, %eax
.LVL19:
	.loc 2 40 0
	ret
.LVL20:
.L21:
	.loc 2 25 0
	xorl	%eax, %eax
	jmp	.L16
	.cfi_endproc
.LFE3:
	.seh_endproc
	.p2align 4,,15
	.globl	strcpy
	.def	strcpy;	.scl	2;	.type	32;	.endef
	.seh_proc	strcpy
strcpy:
.LFB4:
	.loc 2 45 0
	.cfi_startproc
.LVL21:
	.seh_endprologue
	movzbl	(%rdx), %eax
	.p2align 4,,10
.L30:
	.loc 2 48 0 discriminator 1
	addq	$1, %rcx
.LVL22:
	addq	$1, %rdx
.LVL23:
	movb	%al, -1(%rcx)
	.loc 2 50 0 discriminator 1
	movzbl	(%rdx), %eax
	testb	%al, %al
	jne	.L30
.LVL24:
	.loc 2 51 0
	movb	$0, (%rcx)
	.loc 2 52 0
	ret
	.cfi_endproc
.LFE4:
	.seh_endproc
	.p2align 4,,15
	.globl	strncpy
	.def	strncpy;	.scl	2;	.type	32;	.endef
	.seh_proc	strncpy
strncpy:
.LFB5:
	.loc 2 56 0
	.cfi_startproc
.LVL25:
	.seh_endprologue
	.loc 2 57 0
	subl	$1, %r8d
.LVL26:
	.loc 2 58 0
	testl	%r8d, %r8d
	movslq	%r8d, %rax
	js	.L35
.LVL27:
	.p2align 4,,10
.L36:
	.loc 2 59 0
	movzbl	(%rdx,%rax), %r8d
	movb	%r8b, (%rcx,%rax)
.LVL28:
	subq	$1, %rax
.LVL29:
	.loc 2 58 0
	testl	%eax, %eax
	jns	.L36
.L35:
	.loc 2 62 0
	xorl	%eax, %eax
	ret
	.cfi_endproc
.LFE5:
	.seh_endproc
	.p2align 4,,15
	.globl	strcat
	.def	strcat;	.scl	2;	.type	32;	.endef
	.seh_proc	strcat
strcat:
.LFB6:
	.loc 2 66 0
	.cfi_startproc
.LVL30:
	.seh_endprologue
	.loc 2 66 0
	movq	%rcx, %rax
	.loc 2 67 0
	movzbl	(%rcx), %ecx
.LVL31:
	testb	%cl, %cl
	je	.L40
	.p2align 4,,10
.L41:
	.loc 2 69 0
	addq	$1, %rax
.LVL32:
	movb	%cl, (%rax)
	jmp	.L41
.L40:
	movzbl	(%rdx), %ecx
	.p2align 4,,10
.L42:
	.loc 2 74 0 discriminator 1
	addq	$1, %rax
.LVL33:
	addq	$1, %rdx
.LVL34:
	movb	%cl, -1(%rax)
	.loc 2 76 0 discriminator 1
	movzbl	(%rdx), %ecx
	testb	%cl, %cl
	jne	.L42
	.loc 2 78 0
	ret
	.cfi_endproc
.LFE6:
	.seh_endproc
	.p2align 4,,15
	.globl	strchr
	.def	strchr;	.scl	2;	.type	32;	.endef
	.seh_proc	strchr
strchr:
.LFB7:
	.loc 2 81 0
	.cfi_startproc
.LVL35:
	.seh_endprologue
.LVL36:
	.loc 2 83 0
	movzbl	(%rcx), %eax
	testb	%al, %al
	.loc 2 81 0
	movl	%edx, %r8d
	.loc 2 83 0
	je	.L49
	.loc 2 84 0
	cmpb	%al, %dl
	.loc 2 89 0
	movl	$0, %eax
	.loc 2 84 0
	jne	.L47
	jmp	.L44
.LVL37:
	.p2align 4,,10
.L48:
	cmpb	%r8b, %dl
	je	.L44
.LVL38:
.L47:
	.loc 2 87 0
	addq	$1, %rax
.LVL39:
	.loc 2 83 0
	movzbl	(%rcx,%rax), %edx
	testb	%dl, %dl
	jne	.L48
.LVL40:
.L49:
	.loc 2 89 0
	xorl	%eax, %eax
	ret
	.p2align 4,,10
.L44:
	.loc 2 90 0
	ret
	.cfi_endproc
.LFE7:
	.seh_endproc
	.p2align 4,,15
	.globl	strlen
	.def	strlen;	.scl	2;	.type	32;	.endef
	.seh_proc	strlen
strlen:
.LFB8:
	.loc 2 93 0
	.cfi_startproc
.LVL41:
	.seh_endprologue
.LVL42:
	.loc 2 95 0
	xorl	%eax, %eax
	cmpb	$0, (%rcx)
	je	.L54
.LVL43:
	.p2align 4,,10
.L53:
	.loc 2 96 0
	addq	$1, %rax
.LVL44:
	.loc 2 95 0
	cmpb	$0, (%rcx,%rax)
	jne	.L53
	ret
.LVL45:
.L54:
	.loc 2 98 0
	ret
	.cfi_endproc
.LFE8:
	.seh_endproc
	.p2align 4,,15
	.globl	str2int
	.def	str2int;	.scl	2;	.type	32;	.endef
	.seh_proc	str2int
str2int:
.LFB9:
	.loc 2 100 0
	.cfi_startproc
.LVL46:
	.seh_endprologue
.LVL47:
	.loc 2 103 0
	movzbl	(%rcx), %eax
	subl	$48, %eax
	cmpb	$9, %al
	movl	$0, %eax
	ja	.L60
.LVL48:
	.p2align 4,,10
.L58:
	movzbl	1(%rcx,%rax), %edx
	movslq	%eax, %r9
.LVL49:
	addq	$1, %rax
.LVL50:
	subl	$48, %edx
	cmpb	$9, %dl
	jbe	.L58
	movl	$1, %r8d
	xorl	%eax, %eax
.LVL51:
	.p2align 4,,10
.L59:
	.loc 2 108 0
	movzbl	(%rcx,%r9), %edx
	subq	$1, %r9
.LVL52:
	subl	$48, %edx
	movslq	%edx, %rdx
	imulq	%r8, %rdx
	.loc 2 109 0
	leaq	(%r8,%r8,4), %r8
.LVL53:
	addq	%r8, %r8
	.loc 2 108 0
	addq	%rdx, %rax
.LVL54:
	.loc 2 107 0
	cmpl	$-1, %r9d
	jne	.L59
	ret
.LVL55:
.L60:
	.loc 2 113 0
	ret
	.cfi_endproc
.LFE9:
	.seh_endproc
	.p2align 4,,15
	.globl	str2hex
	.def	str2hex;	.scl	2;	.type	32;	.endef
	.seh_proc	str2hex
str2hex:
.LFB10:
	.loc 2 116 0
	.cfi_startproc
.LVL56:
	.seh_endprologue
.LVL57:
	.loc 2 119 0
	xorl	%edx, %edx
	jmp	.L64
.LVL58:
	.p2align 4,,10
.L65:
	addq	$1, %rdx
.LVL59:
.L64:
	movzbl	(%rcx,%rdx), %eax
	movl	%edx, %r8d
.LVL60:
	leal	-48(%rax), %r9d
	cmpb	$9, %r9b
	jbe	.L65
	.loc 2 119 0 is_stmt 0 discriminator 1
	andl	$-33, %eax
	subl	$65, %eax
	cmpb	$5, %al
	jbe	.L65
	.loc 2 122 0 is_stmt 1
	subl	$1, %r8d
.LVL61:
	.loc 2 123 0
	cmpl	$-1, %r8d
	je	.L71
	movslq	%r8d, %r8
	movl	$1, %r9d
	xorl	%eax, %eax
	jmp	.L70
.LVL62:
	.p2align 4,,10
.L74:
	.loc 2 125 0
	subl	$87, %edx
	movslq	%edx, %rdx
	imulq	%r9, %rdx
	addq	%rdx, %rax
.LVL63:
.L68:
	subq	$1, %r8
.LVL64:
	.loc 2 131 0
	salq	$4, %r9
.LVL65:
	.loc 2 123 0
	cmpl	$-1, %r8d
	je	.L73
.LVL66:
.L70:
	.loc 2 124 0
	movzbl	(%rcx,%r8), %edx
	leal	-97(%rdx), %r10d
	cmpb	$5, %r10b
	jbe	.L74
	.loc 2 126 0
	leal	-65(%rdx), %r10d
	cmpb	$5, %r10b
	ja	.L69
	.loc 2 127 0
	subl	$55, %edx
	subq	$1, %r8
.LVL67:
	movslq	%edx, %rdx
	imulq	%r9, %rdx
	.loc 2 131 0
	salq	$4, %r9
.LVL68:
	.loc 2 127 0
	addq	%rdx, %rax
.LVL69:
	.loc 2 123 0
	cmpl	$-1, %r8d
	jne	.L70
.L73:
	ret
.LVL70:
	.p2align 4,,10
.L69:
	.loc 2 128 0
	leal	-48(%rdx), %r10d
	cmpb	$9, %r10b
	ja	.L68
	.loc 2 129 0
	subl	$48, %edx
	movslq	%edx, %rdx
	imulq	%r9, %rdx
	addq	%rdx, %rax
.LVL71:
	jmp	.L68
.LVL72:
.L71:
	.loc 2 118 0
	xorl	%eax, %eax
	.loc 2 135 0
	ret
	.cfi_endproc
.LFE10:
	.seh_endproc
	.p2align 4,,15
	.globl	inb
	.def	inb;	.scl	2;	.type	32;	.endef
	.seh_proc	inb
inb:
.LFB11:
	.file 3 "D:/WORK/BUILD/OS/dcooos/kernel64/system_ll/ioport.c"
	.loc 3 3 0
	.cfi_startproc
.LVL73:
	.seh_endprologue
	.loc 3 5 0
	movl	%ecx, %edx
/APP
 # 5 "D:/WORK/BUILD/OS/dcooos/kernel64/system_ll/ioport.c" 1
	inb (%dx)
 # 0 "" 2
.LVL74:
	.loc 3 7 0
/NO_APP
	ret
	.cfi_endproc
.LFE11:
	.seh_endproc
	.p2align 4,,15
	.globl	inw
	.def	inw;	.scl	2;	.type	32;	.endef
	.seh_proc	inw
inw:
.LFB12:
	.loc 3 8 0
	.cfi_startproc
.LVL75:
	.seh_endprologue
	.loc 3 10 0
	movl	%ecx, %edx
/APP
 # 10 "D:/WORK/BUILD/OS/dcooos/kernel64/system_ll/ioport.c" 1
	inw (%dx)
 # 0 "" 2
.LVL76:
	.loc 3 12 0
/NO_APP
	ret
	.cfi_endproc
.LFE12:
	.seh_endproc
	.p2align 4,,15
	.globl	inl
	.def	inl;	.scl	2;	.type	32;	.endef
	.seh_proc	inl
inl:
.LFB13:
	.loc 3 13 0
	.cfi_startproc
.LVL77:
	.seh_endprologue
	.loc 3 15 0
	movl	%ecx, %edx
/APP
 # 15 "D:/WORK/BUILD/OS/dcooos/kernel64/system_ll/ioport.c" 1
	inl (%dx)
 # 0 "" 2
.LVL78:
	.loc 3 16 0
/NO_APP
	movzwl	%ax, %eax
	.loc 3 17 0
	ret
	.cfi_endproc
.LFE13:
	.seh_endproc
	.p2align 4,,15
	.globl	outb
	.def	outb;	.scl	2;	.type	32;	.endef
	.seh_proc	outb
outb:
.LFB14:
	.loc 3 18 0
	.cfi_startproc
.LVL79:
	.seh_endprologue
	.loc 3 18 0
	movl	%edx, %eax
	.loc 3 19 0
	movl	%ecx, %edx
.LVL80:
/APP
 # 19 "D:/WORK/BUILD/OS/dcooos/kernel64/system_ll/ioport.c" 1
	outb (%dx)
 # 0 "" 2
/NO_APP
	ret
	.cfi_endproc
.LFE14:
	.seh_endproc
	.p2align 4,,15
	.globl	outw
	.def	outw;	.scl	2;	.type	32;	.endef
	.seh_proc	outw
outw:
.LFB15:
	.loc 3 21 0
	.cfi_startproc
.LVL81:
	.seh_endprologue
	.loc 3 21 0
	movl	%edx, %eax
	.loc 3 22 0
	movl	%ecx, %edx
.LVL82:
/APP
 # 22 "D:/WORK/BUILD/OS/dcooos/kernel64/system_ll/ioport.c" 1
	outw (%dx)
 # 0 "" 2
/NO_APP
	ret
	.cfi_endproc
.LFE15:
	.seh_endproc
	.p2align 4,,15
	.globl	outl
	.def	outl;	.scl	2;	.type	32;	.endef
	.seh_proc	outl
outl:
.LFB16:
	.loc 3 24 0
	.cfi_startproc
.LVL83:
	.seh_endprologue
	.loc 3 24 0
	movl	%edx, %eax
	.loc 3 25 0
	movl	%ecx, %edx
.LVL84:
/APP
 # 25 "D:/WORK/BUILD/OS/dcooos/kernel64/system_ll/ioport.c" 1
	outl (%dx)
 # 0 "" 2
/NO_APP
	ret
	.cfi_endproc
.LFE16:
	.seh_endproc
	.p2align 4,,15
	.globl	put_pixel
	.def	put_pixel;	.scl	2;	.type	32;	.endef
	.seh_proc	put_pixel
put_pixel:
.LFB17:
	.file 4 "D:/WORK/BUILD/OS/dcooos/video/video.c"
	.loc 4 33 0
	.cfi_startproc
.LVL85:
	.seh_endprologue
.LVL86:
	.loc 4 38 0
	leaq	(%rdx,%rdx,4), %rax
	leaq	(%rax,%rax,4), %rax
	salq	$5, %rax
	addq	%rax, %rcx
.LVL87:
	movq	video_buffer(%rip), %rax
	movw	%r8w, (%rax,%rcx,2)
	ret
	.cfi_endproc
.LFE17:
	.seh_endproc
	.p2align 4,,15
	.globl	get_pixel
	.def	get_pixel;	.scl	2;	.type	32;	.endef
	.seh_proc	get_pixel
get_pixel:
.LFB18:
	.loc 4 41 0
	.cfi_startproc
.LVL88:
	.seh_endprologue
.LVL89:
	.loc 4 43 0
	leaq	(%rdx,%rdx,4), %rax
	leaq	(%rax,%rax,4), %rax
	salq	$5, %rax
	addq	%rax, %rcx
.LVL90:
	.loc 4 45 0
	movq	video_buffer(%rip), %rax
	leaq	(%rax,%rcx,2), %rdx
.LVL91:
	.loc 4 46 0
	xorl	%eax, %eax
	.loc 4 45 0
	movzbl	1(%rdx), %ecx
.LVL92:
	.loc 4 46 0
	movb	(%rdx), %al
	movb	%cl, %ah
.LVL93:
	.loc 4 47 0
	ret
	.cfi_endproc
.LFE18:
	.seh_endproc
	.p2align 4,,15
	.globl	put_line
	.def	put_line;	.scl	2;	.type	32;	.endef
	.seh_proc	put_line
put_line:
.LFB19:
	.loc 4 50 0
	.cfi_startproc
.LVL94:
	pushq	%r12
	.seh_pushreg	%r12
	.cfi_def_cfa_offset 16
	.cfi_offset 12, -16
	pushq	%rbp
	.seh_pushreg	%rbp
	.cfi_def_cfa_offset 24
	.cfi_offset 6, -24
	pushq	%rdi
	.seh_pushreg	%rdi
	.cfi_def_cfa_offset 32
	.cfi_offset 5, -32
	pushq	%rsi
	.seh_pushreg	%rsi
	.cfi_def_cfa_offset 40
	.cfi_offset 4, -40
	pushq	%rbx
	.seh_pushreg	%rbx
	.cfi_def_cfa_offset 48
	.cfi_offset 3, -48
	.seh_endprologue
	.loc 4 50 0
	movzwl	80(%rsp), %ebx
.LVL95:
	.loc 4 57 0
	cmpl	%r8d, %ecx
	movl	%ebx, %r11d
.LVL96:
	movzbl	%bh, %ebx
.LVL97:
	jle	.L84
	cmpl	%r9d, %edx
	jle	.L84
.LVL98:
	.loc 4 67 0
	movl	%ecx, %eax
	.loc 4 68 0
	movl	%edx, %r10d
	.loc 4 67 0
	subl	%r8d, %eax
.LVL99:
	.loc 4 68 0
	subl	%r9d, %r10d
.LVL100:
	.loc 4 135 0
	cmpl	%r10d, %eax
	jl	.L86
.LVL101:
.L85:
	movslq	%r8d, %r12
	subl	%r8d, %ecx
.LVL102:
	movq	video_buffer(%rip), %rbp
	leaq	1(%r12), %rsi
	leaq	(%rsi,%rcx), %r8
.LVL103:
	.loc 4 120 0
	xorl	%ecx, %ecx
	jmp	.L96
.LVL104:
	.p2align 4,,10
.L112:
	addq	$1, %rsi
.LVL105:
.L96:
	.loc 4 141 0
	movslq	%r9d, %rdi
.LVL106:
	.loc 4 142 0
	addl	%r10d, %ecx
.LVL107:
.LBB92:
.LBB93:
	.loc 4 37 0
	leaq	(%rdi,%rdi,4), %rdi
.LVL108:
	leaq	(%rdi,%rdi,4), %rdx
	salq	$5, %rdx
	addq	%r12, %rdx
.LBE93:
.LBE92:
	.loc 4 143 0
	cmpl	%eax, %ecx
.LBB95:
.LBB94:
	.loc 4 38 0
	leaq	0(%rbp,%rdx,2), %rdx
	movb	%r11b, (%rdx)
	movb	%bl, 1(%rdx)
.LVL109:
.LBE94:
.LBE95:
	.loc 4 143 0
	jl	.L95
	.loc 4 146 0
	addl	$1, %r9d
.LVL110:
	.loc 4 147 0
	subl	%eax, %ecx
.LVL111:
.L95:
	.loc 4 138 0 discriminator 2
	cmpq	%rsi, %r8
	movq	%rsi, %r12
	jne	.L112
.LVL112:
.L83:
	.loc 4 169 0
	popq	%rbx
	.cfi_remember_state
	.cfi_restore 3
	.cfi_def_cfa_offset 40
.LVL113:
	popq	%rsi
	.cfi_restore 4
	.cfi_def_cfa_offset 32
	popq	%rdi
	.cfi_restore 5
	.cfi_def_cfa_offset 24
	popq	%rbp
	.cfi_restore 6
	.cfi_def_cfa_offset 16
	popq	%r12
	.cfi_restore 12
	.cfi_def_cfa_offset 8
	ret
.LVL114:
	.p2align 4,,10
.L84:
	.cfi_restore_state
	.loc 4 71 0
	movl	%r8d, %eax
	.loc 4 74 0
	movl	%r9d, %r10d
	.loc 4 71 0
	subl	%ecx, %eax
.LVL115:
	.loc 4 74 0
	subl	%edx, %r10d
.LVL116:
	js	.L113
	.loc 4 84 0
	testl	%eax, %eax
	js	.L114
	.loc 4 135 0
	cmpl	%r10d, %eax
	jl	.L115
.LVL117:
	.loc 4 138 0 discriminator 1
	cmpl	%r8d, %ecx
	jg	.L83
	.loc 4 138 0 is_stmt 0
	movl	%edx, %r9d
.LVL118:
	movl	%r8d, %edx
.LVL119:
	movl	%ecx, %r8d
.LVL120:
	movl	%edx, %ecx
.LVL121:
	jmp	.L85
.LVL122:
	.p2align 4,,10
.L115:
	movl	%r9d, %r8d
.LVL123:
	movl	%edx, %r9d
.LVL124:
	movl	%r8d, %edx
.LVL125:
	movl	%ecx, %r8d
.LVL126:
.L86:
	.loc 4 156 0 is_stmt 1 discriminator 1
	cmpl	%edx, %r9d
	jg	.L83
	movslq	%r9d, %rsi
	subl	%r9d, %edx
.LVL127:
	movq	video_buffer(%rip), %rdi
	leaq	1(%rsi,%rdx), %rdx
	leaq	(%rsi,%rsi,4), %rcx
	leaq	(%rdx,%rdx,4), %rdx
	leaq	(%rdx,%rdx,4), %rsi
	.loc 4 156 0 is_stmt 0
	xorl	%edx, %edx
	leaq	(%rcx,%rcx,4), %rcx
	salq	$5, %rsi
	salq	$5, %rcx
.LVL128:
	.p2align 4,,10
.L98:
	.loc 4 159 0 is_stmt 1
	movslq	%r8d, %r9
.LVL129:
	.loc 4 160 0
	addl	%eax, %edx
.LVL130:
.LBB96:
.LBB97:
	.loc 4 37 0
	addq	%rcx, %r9
.LVL131:
.LBE97:
.LBE96:
	.loc 4 161 0
	cmpl	%r10d, %edx
.LBB99:
.LBB98:
	.loc 4 38 0
	leaq	(%rdi,%r9,2), %r9
.LVL132:
	movb	%r11b, (%r9)
	movb	%bl, 1(%r9)
.LVL133:
.LBE98:
.LBE99:
	.loc 4 161 0
	jl	.L97
	.loc 4 163 0
	addl	$1, %r8d
.LVL134:
	.loc 4 164 0
	subl	%r10d, %edx
.LVL135:
.L97:
	addq	$800, %rcx
	.loc 4 156 0 discriminator 2
	cmpq	%rcx, %rsi
	jne	.L98
	.loc 4 169 0
	popq	%rbx
	.cfi_remember_state
	.cfi_restore 3
	.cfi_def_cfa_offset 40
.LVL136:
	popq	%rsi
	.cfi_restore 4
	.cfi_def_cfa_offset 32
	popq	%rdi
	.cfi_restore 5
	.cfi_def_cfa_offset 24
	popq	%rbp
	.cfi_restore 6
	.cfi_def_cfa_offset 16
	popq	%r12
	.cfi_restore 12
	.cfi_def_cfa_offset 8
	ret
.LVL137:
	.p2align 4,,10
.L113:
	.cfi_restore_state
	.loc 4 76 0
	negl	%r10d
.LVL138:
.L88:
	.loc 4 99 0
	cmpl	%r10d, %eax
	jge	.L99
.LVL139:
	.loc 4 120 0 discriminator 1
	cmpl	%edx, %r9d
	jg	.L83
	movslq	%r9d, %rsi
	subl	%r9d, %edx
.LVL140:
	movq	video_buffer(%rip), %rdi
	leaq	1(%rsi,%rdx), %rdx
	leaq	(%rsi,%rsi,4), %rcx
.LVL141:
	leaq	(%rdx,%rdx,4), %rdx
	leaq	(%rdx,%rdx,4), %rsi
	.loc 4 120 0 is_stmt 0
	xorl	%edx, %edx
	leaq	(%rcx,%rcx,4), %rcx
	salq	$5, %rsi
	salq	$5, %rcx
.LVL142:
	.p2align 4,,10
.L93:
	.loc 4 123 0 is_stmt 1
	movslq	%r8d, %r9
.LVL143:
	.loc 4 124 0
	addl	%eax, %edx
.LVL144:
.LBB100:
.LBB101:
	.loc 4 37 0
	addq	%rcx, %r9
.LVL145:
.LBE101:
.LBE100:
	.loc 4 125 0
	cmpl	%r10d, %edx
.LBB103:
.LBB102:
	.loc 4 38 0
	leaq	(%rdi,%r9,2), %r9
.LVL146:
	movb	%r11b, (%r9)
	movb	%bl, 1(%r9)
.LVL147:
.LBE102:
.LBE103:
	.loc 4 125 0
	jl	.L92
	.loc 4 127 0
	subl	$1, %r8d
.LVL148:
	.loc 4 128 0
	subl	%r10d, %edx
.LVL149:
.L92:
	addq	$800, %rcx
	.loc 4 120 0 discriminator 2
	cmpq	%rsi, %rcx
	jne	.L93
	.loc 4 169 0
	popq	%rbx
	.cfi_remember_state
	.cfi_restore 3
	.cfi_def_cfa_offset 40
.LVL150:
	popq	%rsi
	.cfi_restore 4
	.cfi_def_cfa_offset 32
	popq	%rdi
	.cfi_restore 5
	.cfi_def_cfa_offset 24
	popq	%rbp
	.cfi_restore 6
	.cfi_def_cfa_offset 16
	popq	%r12
	.cfi_restore 12
	.cfi_def_cfa_offset 8
	ret
.LVL151:
	.p2align 4,,10
.L99:
	.cfi_restore_state
	.loc 4 102 0 discriminator 1
	cmpl	%r8d, %ecx
	jg	.L83
	movslq	%ecx, %r12
	subl	%ecx, %r8d
.LVL152:
	movq	video_buffer(%rip), %rbp
	.loc 4 102 0 is_stmt 0
	xorl	%r9d, %r9d
.LVL153:
	leaq	1(%r12), %rsi
	addq	%rsi, %r8
	jmp	.L91
.LVL154:
	.p2align 4,,10
.L116:
	addq	$1, %rsi
.LVL155:
.L91:
	.loc 4 105 0 is_stmt 1
	movslq	%edx, %rcx
.LVL156:
	.loc 4 106 0
	addl	%r10d, %r9d
.LVL157:
.LBB104:
.LBB105:
	.loc 4 37 0
	leaq	(%rcx,%rcx,4), %rdi
	leaq	(%rdi,%rdi,4), %rcx
.LVL158:
	salq	$5, %rcx
	addq	%r12, %rcx
.LBE105:
.LBE104:
	.loc 4 107 0
	cmpl	%eax, %r9d
.LBB107:
.LBB106:
	.loc 4 38 0
	leaq	0(%rbp,%rcx,2), %rcx
	movb	%r11b, (%rcx)
	movb	%bl, 1(%rcx)
.LVL159:
.LBE106:
.LBE107:
	.loc 4 107 0
	jl	.L90
	.loc 4 110 0
	subl	$1, %edx
.LVL160:
	.loc 4 111 0
	subl	%eax, %r9d
.LVL161:
.L90:
	.loc 4 102 0 discriminator 2
	cmpq	%rsi, %r8
	movq	%rsi, %r12
	jne	.L116
	.loc 4 169 0
	popq	%rbx
	.cfi_remember_state
	.cfi_restore 3
	.cfi_def_cfa_offset 40
.LVL162:
	popq	%rsi
	.cfi_restore 4
	.cfi_def_cfa_offset 32
.LVL163:
	popq	%rdi
	.cfi_restore 5
	.cfi_def_cfa_offset 24
	popq	%rbp
	.cfi_restore 6
	.cfi_def_cfa_offset 16
	popq	%r12
	.cfi_restore 12
	.cfi_def_cfa_offset 8
.LVL164:
	ret
.LVL165:
	.p2align 4,,10
.L114:
	.cfi_restore_state
	.loc 4 86 0
	movl	%r9d, %esi
	movl	%edx, %r9d
.LVL166:
	negl	%eax
.LVL167:
	movl	%esi, %edx
.LVL168:
	movl	%ecx, %esi
.LVL169:
	movl	%r8d, %ecx
.LVL170:
	movl	%esi, %r8d
.LVL171:
	jmp	.L88
	.cfi_endproc
.LFE19:
	.seh_endproc
	.p2align 4,,15
	.globl	put_char
	.def	put_char;	.scl	2;	.type	32;	.endef
	.seh_proc	put_char
put_char:
.LFB20:
	.loc 4 180 0
	.cfi_startproc
.LVL172:
	.seh_endprologue
.LVL173:
	leaq	font(%rip), %r9
	imulq	$10400, %rdx, %rdx
.LVL174:
	.loc 4 187 0
	movzbl	%r8b, %r8d
	leal	(%r8,%r8,2), %eax
	leal	(%r8,%rax,4), %eax
	cltq
.LVL175:
	leaq	(%rax,%r9), %r10
	leaq	8(%rdx,%rcx,8), %rcx
.LVL176:
	movq	video_buffer(%rip), %rdx
	leaq	13(%r9,%rax), %r11
	leaq	(%rdx,%rcx,2), %r8
.LVL177:
	.p2align 4,,10
.L120:
	.loc 4 194 0
	movzbl	(%r10), %r9d
.LVL178:
	leaq	-16(%r8), %rdx
	.loc 4 196 0
	movl	$-128, %eax
	jmp	.L119
.LVL179:
	.p2align 4,,10
.L118:
	addq	$2, %rdx
	.loc 4 202 0 discriminator 2
	shrb	%al
.LVL180:
	.loc 4 197 0 discriminator 2
	cmpq	%r8, %rdx
	je	.L123
.LVL181:
.L119:
	.loc 4 198 0
	movl	%r9d, %ecx
	andl	%eax, %ecx
	cmpb	%al, %cl
	jne	.L118
.LVL182:
.LBB108:
.LBB109:
	.loc 4 38 0
	movb	$-128, (%rdx)
	addq	$2, %rdx
.LBE109:
.LBE108:
	.loc 4 202 0
	shrb	%al
.LVL183:
.LBB111:
.LBB110:
	.loc 4 38 0
	movb	$0, -1(%rdx)
.LVL184:
.LBE110:
.LBE111:
	.loc 4 197 0
	cmpq	%r8, %rdx
	jne	.L119
.LVL185:
.L123:
	leaq	1600(%rdx), %r8
	addq	$1, %r10
.LVL186:
	.loc 4 193 0 discriminator 2
	cmpq	%r11, %r10
	jne	.L120
	.loc 4 206 0
	ret
	.cfi_endproc
.LFE20:
	.seh_endproc
	.p2align 4,,15
	.globl	put_string
	.def	put_string;	.scl	2;	.type	32;	.endef
	.seh_proc	put_string
put_string:
.LFB21:
	.loc 4 211 0
	.cfi_startproc
.LVL187:
	pushq	%rsi
	.seh_pushreg	%rsi
	.cfi_def_cfa_offset 16
	.cfi_offset 4, -16
	pushq	%rbx
	.seh_pushreg	%rbx
	.cfi_def_cfa_offset 24
	.cfi_offset 3, -24
	subq	$40, %rsp
	.seh_stackalloc	40
	.cfi_def_cfa_offset 64
	.seh_endprologue
.LVL188:
	.loc 4 213 0
	movl	$1, %ebx
	.loc 4 211 0
	movq	%rcx, %rsi
	.loc 4 213 0
	jmp	.L125
.LVL189:
	.p2align 4,,10
.L132:
	.loc 4 220 0
	movq	$0, curx(%rip)
.LVL190:
.L127:
	addq	$1, %rbx
.LVL191:
.L125:
	.loc 4 213 0
	movzbl	-1(%rsi,%rbx), %r8d
	testb	%r8b, %r8b
	je	.L130
	.loc 4 214 0
	cmpb	$10, %r8b
	je	.L131
	.loc 4 219 0
	cmpb	$13, %r8b
	je	.L132
	.loc 4 224 0
	movq	cury(%rip), %rdx
	movq	curx(%rip), %rcx
	call	put_char
.LVL192:
	.loc 4 227 0
	movq	cury(%rip), %rax
	.loc 4 226 0
	addq	$1, curx(%rip)
	.loc 4 227 0
	cmpq	$79, %rax
	jbe	.L127
	.loc 4 228 0
	movq	$0, curx(%rip)
	.loc 4 229 0
	addq	$1, %rax
	movq	%rax, cury(%rip)
	jmp	.L127
.LVL193:
	.p2align 4,,10
.L131:
	.loc 4 215 0
	addq	$1, cury(%rip)
.LVL194:
	.loc 4 217 0
	jmp	.L127
.LVL195:
	.p2align 4,,10
.L130:
	.loc 4 232 0
	addq	$40, %rsp
	.cfi_def_cfa_offset 24
	popq	%rbx
	.cfi_restore 3
	.cfi_def_cfa_offset 16
.LVL196:
	popq	%rsi
	.cfi_restore 4
	.cfi_def_cfa_offset 8
.LVL197:
	ret
	.cfi_endproc
.LFE21:
	.seh_endproc
	.section .rdata,"dr"
.LC0:
	.ascii "malloc $req_mem\0"
.LC1:
	.ascii "0123456789ABCDEF\0"
.LC2:
	.ascii "unknown type\12\15\0"
.LC3:
	.ascii "free $req_mem\0"
	.text
	.p2align 4,,15
	.globl	put_number
	.def	put_number;	.scl	2;	.type	32;	.endef
	.seh_proc	put_number
put_number:
.LFB22:
	.loc 4 237 0
	.cfi_startproc
.LVL198:
	pushq	%rbx
	.seh_pushreg	%rbx
	.cfi_def_cfa_offset 16
	.cfi_offset 3, -16
	subq	$32, %rsp
	.seh_stackalloc	32
	.cfi_def_cfa_offset 48
	.seh_endprologue
.LVL199:
	.loc 4 242 0
	movq	memory_req_mem(%rip), %rax
.LBB112:
.LBB113:
	.loc 1 7 0
	leaq	.LC0(%rip), %rbx
.LBE113:
.LBE112:
	.loc 4 242 0
	movq	$256, (%rax)
.LVL200:
.LBB116:
.LBB114:
	.loc 1 7 0
	movq	memory(%rip), %rax
/APP
 # 7 "D:/WORK/BUILD/OS/dcooos/kernel64/syscall.h" 1
	int $0x80
 # 0 "" 2
/NO_APP
.LBE114:
.LBE116:
	.loc 4 247 0
	cmpb	$100, %dl
.LBB117:
.LBB115:
	.loc 1 7 0
	movq	%rax, %rbx
.LVL201:
.LBE115:
.LBE117:
	.loc 4 245 0
	movb	$0, 255(%rax)
	.loc 4 247 0
	je	.L145
	.loc 4 257 0
	cmpb	$104, %dl
	je	.L146
	.loc 4 272 0
	leaq	.LC2(%rip), %rcx
.LVL202:
	call	put_string
.LVL203:
	movl	$255, %ecx
.LVL204:
.L136:
	.loc 4 274 0
	addq	%rbx, %rcx
	call	put_string
.LVL205:
	.loc 4 276 0
	movq	memory_req_mem(%rip), %rax
	movq	%rbx, (%rax)
.LVL206:
.LBB118:
.LBB119:
	.loc 1 7 0
	leaq	.LC3(%rip), %rbx
.LVL207:
	movq	memory(%rip), %rax
.LVL208:
/APP
 # 7 "D:/WORK/BUILD/OS/dcooos/kernel64/syscall.h" 1
	int $0x80
 # 0 "" 2
.LVL209:
/NO_APP
.LBE119:
.LBE118:
	.loc 4 279 0
	addq	$32, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 16
	popq	%rbx
	.cfi_restore 3
	.cfi_def_cfa_offset 8
	ret
.LVL210:
	.p2align 4,,10
.L146:
	.cfi_restore_state
	.loc 4 258 0
	testq	%rcx, %rcx
	je	.L143
	leaq	.LC1(%rip), %r8
	movl	$253, %edx
.LVL211:
	.p2align 4,,10
.L140:
	.loc 4 263 0
	movq	%rcx, %rax
	.loc 4 264 0
	shrq	$4, %rcx
.LVL212:
	.loc 4 263 0
	andl	$15, %eax
	movzbl	(%r8,%rax), %eax
	movb	%al, 1(%rdx,%rbx)
	.loc 4 265 0
	movl	%edx, %eax
.LVL213:
	subq	$1, %rdx
.LVL214:
	.loc 4 262 0
	testq	%rcx, %rcx
	jne	.L140
	movslq	%eax, %rcx
.LVL215:
	addq	$1, %rcx
	jmp	.L136
.LVL216:
	.p2align 4,,10
.L145:
	.loc 4 248 0
	testq	%rcx, %rcx
	jne	.L147
.L143:
	.loc 4 259 0
	movb	$48, 254(%rbx)
.LVL217:
	movl	$254, %ecx
.LVL218:
	jmp	.L136
.LVL219:
	.p2align 4,,10
.L147:
	.loc 4 253 0
	movabsq	$-3689348814741910323, %r9
	movl	$253, %r8d
.LVL220:
	.p2align 4,,10
.L137:
	movq	%rcx, %rax
	mulq	%r9
	shrq	$3, %rdx
	leaq	(%rdx,%rdx,4), %rax
	addq	%rax, %rax
	subq	%rax, %rcx
.LVL221:
	.loc 4 255 0
	movl	%r8d, %eax
	subq	$1, %r8
.LVL222:
	.loc 4 253 0
	addl	$48, %ecx
	movb	%cl, 2(%r8,%rbx)
	.loc 4 252 0
	testq	%rdx, %rdx
	.loc 4 254 0
	movq	%rdx, %rcx
.LVL223:
	.loc 4 252 0
	jne	.L137
	movslq	%eax, %rcx
	addq	$1, %rcx
	jmp	.L136
	.cfi_endproc
.LFE22:
	.seh_endproc
	.p2align 4,,15
	.globl	put_box
	.def	put_box;	.scl	2;	.type	32;	.endef
	.seh_proc	put_box
put_box:
.LFB23:
	.loc 4 281 0
	.cfi_startproc
.LVL224:
	pushq	%r12
	.seh_pushreg	%r12
	.cfi_def_cfa_offset 16
	.cfi_offset 12, -16
	pushq	%rbp
	.seh_pushreg	%rbp
	.cfi_def_cfa_offset 24
	.cfi_offset 6, -24
	pushq	%rdi
	.seh_pushreg	%rdi
	.cfi_def_cfa_offset 32
	.cfi_offset 5, -32
	pushq	%rsi
	.seh_pushreg	%rsi
	.cfi_def_cfa_offset 40
	.cfi_offset 4, -40
	pushq	%rbx
	.seh_pushreg	%rbx
	.cfi_def_cfa_offset 48
	.cfi_offset 3, -48
	subq	$48, %rsp
	.seh_stackalloc	48
	.cfi_def_cfa_offset 96
	.seh_endprologue
	.loc 4 281 0
	movzwl	128(%rsp), %ebp
.LVL225:
	movq	%r9, %rsi
	movq	%r8, %rdi
	movq	%rdx, %r12
.LVL226:
	.loc 4 282 0
	movw	%bp, 32(%rsp)
	movl	%edx, %r9d
.LVL227:
	.loc 4 281 0
	movq	%rcx, %rbx
	.loc 4 282 0
	call	put_line
.LVL228:
	.loc 4 283 0
	movl	%esi, %r9d
	movl	%edi, %r8d
	movl	%r12d, %edx
	movl	%edi, %ecx
	movw	%bp, 32(%rsp)
	call	put_line
.LVL229:
	.loc 4 284 0
	movl	%esi, %r9d
	movl	%ebx, %r8d
	movl	%r12d, %edx
	movl	%ebx, %ecx
	movw	%bp, 32(%rsp)
	call	put_line
.LVL230:
	.loc 4 285 0
	movl	%esi, %r9d
	movl	%edi, %r8d
	movl	%esi, %edx
	movl	%ebx, %ecx
	movw	%bp, 128(%rsp)
	.loc 4 286 0
	addq	$48, %rsp
	.cfi_def_cfa_offset 48
	popq	%rbx
	.cfi_restore 3
	.cfi_def_cfa_offset 40
.LVL231:
	popq	%rsi
	.cfi_restore 4
	.cfi_def_cfa_offset 32
.LVL232:
	popq	%rdi
	.cfi_restore 5
	.cfi_def_cfa_offset 24
.LVL233:
	popq	%rbp
	.cfi_restore 6
	.cfi_def_cfa_offset 16
.LVL234:
	popq	%r12
	.cfi_restore 12
	.cfi_def_cfa_offset 8
.LVL235:
	.loc 4 285 0
	jmp	put_line
.LVL236:
	.cfi_endproc
.LFE23:
	.seh_endproc
	.p2align 4,,15
	.globl	put_pixel_callback
	.def	put_pixel_callback;	.scl	2;	.type	32;	.endef
	.seh_proc	put_pixel_callback
put_pixel_callback:
.LFB24:
	.loc 4 288 0
	.cfi_startproc
.LVL237:
	subq	$56, %rsp
	.seh_stackalloc	56
	.cfi_def_cfa_offset 64
	.seh_endprologue
	.loc 4 293 0
	movl	$128, %eax
	movl	$200, %edx
.LVL238:
	movl	$200, %ecx
	movl	$400, %r9d
	movl	$400, %r8d
	movw	%ax, 32(%rsp)
	call	put_box
	nop
.LVL239:
	.loc 4 294 0
	addq	$56, %rsp
	.cfi_def_cfa_offset 8
	ret
	.cfi_endproc
.LFE24:
	.seh_endproc
	.section .rdata,"dr"
.LC4:
	.ascii "\1\1\1\1\1\1\1\1\0"
	.text
	.p2align 4,,15
	.globl	make_blur
	.def	make_blur;	.scl	2;	.type	32;	.endef
	.seh_proc	make_blur
make_blur:
.LFB25:
	.loc 4 296 0
	.cfi_startproc
	.seh_endprologue
.LVL240:
	.loc 4 300 0
/APP
 # 300 "D:\WORK\BUILD\OS\dcooos\video\video.c" 1
	movq .LC4(%rip), %mm0
 # 0 "" 2
.LVL241:
/NO_APP
	movq	video_buffer(%rip), %rax
	leaq	1920000(%rax), %rdx
.LVL242:
	.p2align 4,,10
.L151:
	.loc 4 303 0 discriminator 3
/APP
 # 303 "D:\WORK\BUILD\OS\dcooos\video\video.c" 1
	movq   (%rax), %mm1
psubusb    %mm0, %mm1
movq   %mm1, (%rax)
 # 0 "" 2
/NO_APP
	addq	$8, %rax
	.loc 4 302 0 discriminator 3
	cmpq	%rdx, %rax
	jne	.L151
	.loc 4 307 0
	ret
	.cfi_endproc
.LFE25:
	.seh_endproc
	.p2align 4,,15
	.globl	show_video_buffer
	.def	show_video_buffer;	.scl	2;	.type	32;	.endef
	.seh_proc	show_video_buffer
show_video_buffer:
.LFB26:
	.loc 4 309 0
	.cfi_startproc
	.seh_endprologue
.LVL243:
	.loc 4 317 0
	movq	video_tmp_buffer(%rip), %r8
.LVL244:
	movq	video_buffer(%rip), %rcx
	movq	video_bg_buffer(%rip), %rdx
	leaq	1920000(%r8), %rax
	addq	$1920000, %rcx
	addq	$1920000, %rdx
.LVL245:
	.p2align 4,,10
.L154:
	.loc 4 319 0 discriminator 3
/APP
 # 319 "D:\WORK\BUILD\OS\dcooos\video\video.c" 1
	movd   (%rcx), %mm0
movd   (%rdx), %mm1
paddusb  %mm1, %mm0
movd   %mm0, (%rax)
 # 0 "" 2
/NO_APP
	subq	$8, %rax
	subq	$8, %rcx
	subq	$8, %rdx
	.loc 4 318 0 discriminator 3
	cmpq	%r8, %rax
	jne	.L154
	leaq	vbe_lfb(%rip), %rcx
	movl	$1920000, %eax
	.p2align 4,,10
.L155:
	.loc 4 336 0 discriminator 3
	movq	(%rcx), %rdx
/APP
 # 336 "D:\WORK\BUILD\OS\dcooos\video\video.c" 1
	movd   (%r8,%rax), %mm0
movd   %mm0, (%rdx,%rax)
 # 0 "" 2
	.loc 4 335 0 discriminator 3
/NO_APP
	subq	$8, %rax
	jne	.L155
	.loc 4 340 0
	ret
	.cfi_endproc
.LFE26:
	.seh_endproc
	.p2align 4,,15
	.globl	video_print_callback
	.def	video_print_callback;	.scl	2;	.type	32;	.endef
	.seh_proc	video_print_callback
video_print_callback:
.LFB28:
	.loc 4 446 0
	.cfi_startproc
.LVL246:
	subq	$40, %rsp
	.seh_stackalloc	40
	.cfi_def_cfa_offset 48
	.seh_endprologue
	movq	initDone(%rip), %rax
	.p2align 4,,10
.L159:
	.loc 4 447 0 discriminator 1
	cmpq	$1, %rax
	jne	.L159
	.loc 4 451 0
	movq	16(%rdx), %rcx
	call	put_string
	nop
.LVL247:
	.loc 4 454 0
	addq	$40, %rsp
	.cfi_def_cfa_offset 8
	.loc 4 453 0
	jmp	show_video_buffer
.LVL248:
	.cfi_endproc
.LFE28:
	.seh_endproc
	.p2align 4,,15
	.globl	copy_rect
	.def	copy_rect;	.scl	2;	.type	32;	.endef
	.seh_proc	copy_rect
copy_rect:
.LFB27:
	.loc 4 437 0
	.cfi_startproc
.LVL249:
	pushq	%rdi
	.seh_pushreg	%rdi
	.cfi_def_cfa_offset 16
	.cfi_offset 5, -16
	pushq	%rsi
	.seh_pushreg	%rsi
	.cfi_def_cfa_offset 24
	.cfi_offset 4, -24
	pushq	%rbx
	.seh_pushreg	%rbx
	.cfi_def_cfa_offset 32
	.cfi_offset 3, -32
	.seh_endprologue
.LVL250:
	movq	(%rcx), %r11
.LVL251:
	movq	16(%rcx), %rax
	movq	8(%r8), %r10
	.loc 4 439 0
	movq	24(%r8), %rsi
	movq	(%r8), %rbx
.LVL252:
	subq	%r11, %rax
	movq	16(%r8), %r8
.LVL253:
	leaq	(%rax,%rax), %rdi
	imulq	8(%rcx), %rax
	subq	%r10, %rsi
	leaq	(%r10,%r10,4), %r10
.LVL254:
	leaq	(%r10,%r10,4), %r10
	subq	%rbx, %r8
	salq	$5, %r10
	addq	%r8, %r8
	addq	%rbx, %r10
	leaq	(%r9,%r10,2), %rbx
.LVL255:
	addq	%r11, %rax
	xorl	%r10d, %r10d
	leaq	(%rdx,%rax,2), %r11
.LVL256:
	.p2align 4,,10
.L163:
.LBB120:
.LBB121:
	.loc 2 9 0 discriminator 3
	xorl	%eax, %eax
	testq	%r8, %r8
	movzbl	(%rbx), %r9d
	movzbl	(%r11), %ecx
	je	.L166
.LVL257:
	.p2align 4,,10
.L167:
	.loc 2 10 0
	movzbl	(%rax,%r9), %edx
	addq	$1, %rax
.LVL258:
	movb	%dl, -1(%rax,%rcx)
.LVL259:
	.loc 2 9 0
	cmpq	%r8, %rax
	jne	.L167
.LVL260:
.L166:
.LBE121:
.LBE120:
	.loc 4 439 0
	addq	$1, %r10
.LVL261:
	addq	$1600, %rbx
	addq	%rdi, %r11
	cmpq	%rsi, %r10
	jbe	.L163
	.loc 4 444 0
	popq	%rbx
	.cfi_restore 3
	.cfi_def_cfa_offset 24
	popq	%rsi
	.cfi_restore 4
	.cfi_def_cfa_offset 16
	popq	%rdi
	.cfi_restore 5
	.cfi_def_cfa_offset 8
	ret
	.cfi_endproc
.LFE27:
	.seh_endproc
	.section .rdata,"dr"
.LC5:
	.ascii "find_object log\0"
.LC6:
	.ascii "print \"OBJECT VIDEO EXECUTE\"\0"
	.align 8
.LC7:
	.ascii "print \"OBJECT VIDEO: making video object\"\0"
	.align 8
.LC8:
	.ascii "create video {C8283DA0-87A6-69CF-AF16-48616423}\0"
.LC9:
	.ascii "new_property tmp 8\0"
.LC10:
	.ascii "new_method putpixel $tmp\0"
.LC11:
	.ascii "new_method print $tmp\0"
	.align 8
.LC12:
	.ascii "print \"OBJECT VIDEO: added methods: test, putpixel, print\"\0"
.LC13:
	.ascii "find_object memory\0"
.LC14:
	.ascii "new_property req_mem 8\0"
	.align 8
.LC15:
	.ascii "print \"OBJECT VIDEO: require video memory 1024x768\"\0"
.LC16:
	.ascii "get_video_mem $req_mem\0"
	.align 8
.LC17:
	.ascii "print \"OBJECT VIDEO: require memory for buffers...\"\0"
	.align 8
.LC18:
	.ascii "print \"OBJECT VIDEO: video_buffer\"\0"
	.align 8
.LC19:
	.ascii "print \"OBJECT VIDEO: video_bg_buffer\"\0"
	.align 8
.LC20:
	.ascii "print \"OBJECT VIDEO: video_tmp_buffer\"\0"
	.align 8
.LC21:
	.ascii "print \"OBJECT VIDEO: printing hello message\"\0"
	.align 8
.LC22:
	.ascii "PIXITALIPHINA Operation system (c) 2009-2016\12\15\0"
	.align 8
.LC23:
	.ascii "print \"OBJECT VIDEO: draw some elements\"\0"
	.align 8
.LC24:
	.ascii "print \"OBJECT VIDEO: print test number 12345678\"\0"
	.align 8
.LC25:
	.ascii "print \"OBJECT VIDEO: show buffer\"\0"
.LC26:
	.ascii "\12\15\0"
	.align 8
.LC27:
	.ascii "print \"OBJECT VIDEO: now read background image..\"\0"
.LC28:
	.ascii "find_object fs\0"
.LC29:
	.ascii "fopen /BG\0"
.LC30:
	.ascii "fsize\0"
.LC31:
	.ascii "new_property data 8\0"
.LC32:
	.ascii "fread $data\0"
.LC33:
	.ascii "print \"TEST!!!\"\0"
.LC34:
	.ascii "find_object system\0"
.LC35:
	.ascii "\15counter: \0"
.LC36:
	.ascii "sleep 1\0"
	.text
	.p2align 4,,15
	.globl	initialize_object
	.def	initialize_object;	.scl	2;	.type	32;	.endef
	.seh_proc	initialize_object
initialize_object:
.LFB29:
	.loc 4 456 0
	.cfi_startproc
	pushq	%r15
	.seh_pushreg	%r15
	.cfi_def_cfa_offset 16
	.cfi_offset 15, -16
	pushq	%r14
	.seh_pushreg	%r14
	.cfi_def_cfa_offset 24
	.cfi_offset 14, -24
	pushq	%r13
	.seh_pushreg	%r13
	.cfi_def_cfa_offset 32
	.cfi_offset 13, -32
	pushq	%r12
	.seh_pushreg	%r12
	.cfi_def_cfa_offset 40
	.cfi_offset 12, -40
	pushq	%rbp
	.seh_pushreg	%rbp
	.cfi_def_cfa_offset 48
	.cfi_offset 6, -48
	pushq	%rdi
	.seh_pushreg	%rdi
	.cfi_def_cfa_offset 56
	.cfi_offset 5, -56
	pushq	%rsi
	.seh_pushreg	%rsi
	.cfi_def_cfa_offset 64
	.cfi_offset 4, -64
	pushq	%rbx
	.seh_pushreg	%rbx
	.cfi_def_cfa_offset 72
	.cfi_offset 3, -72
	subq	$184, %rsp
	.seh_stackalloc	184
	.cfi_def_cfa_offset 256
	.seh_endprologue
.LBB122:
.LBB123:
	.loc 1 7 0
	leaq	.LC5(%rip), %rbx
	xorl	%ecx, %ecx
.LBE123:
.LBE122:
	.loc 4 457 0
	movq	$0, initDone(%rip)
.LVL262:
.LBB126:
.LBB124:
	.loc 1 7 0
	movq	%rcx, %rax
/APP
 # 7 "D:/WORK/BUILD/OS/dcooos/kernel64/syscall.h" 1
	int $0x80
 # 0 "" 2
/NO_APP
.LBE124:
.LBE126:
.LBB127:
.LBB128:
	leaq	.LC6(%rip), %rbx
.LBE128:
.LBE127:
.LBB130:
.LBB125:
	movq	%rax, %rsi
.LVL263:
.LBE125:
.LBE130:
.LBB131:
.LBB129:
/APP
 # 7 "D:/WORK/BUILD/OS/dcooos/kernel64/syscall.h" 1
	int $0x80
 # 0 "" 2
.LVL264:
/NO_APP
.LBE129:
.LBE131:
.LBB132:
.LBB133:
	leaq	.LC7(%rip), %rbx
	movq	%rsi, %rax
/APP
 # 7 "D:/WORK/BUILD/OS/dcooos/kernel64/syscall.h" 1
	int $0x80
 # 0 "" 2
.LVL265:
/NO_APP
.LBE133:
.LBE132:
.LBB134:
.LBB135:
	leaq	.LC8(%rip), %rbx
	movq	%rcx, %rax
/APP
 # 7 "D:/WORK/BUILD/OS/dcooos/kernel64/syscall.h" 1
	int $0x80
 # 0 "" 2
/NO_APP
.LBE135:
.LBE134:
.LBB137:
.LBB138:
	leaq	.LC9(%rip), %rdx
.LBE138:
.LBE137:
.LBB141:
.LBB136:
	movq	%rax, %rcx
.LVL266:
.LBE136:
.LBE141:
.LBB142:
.LBB139:
	movq	%rdx, %rbx
/APP
 # 7 "D:/WORK/BUILD/OS/dcooos/kernel64/syscall.h" 1
	int $0x80
 # 0 "" 2
.LVL267:
/NO_APP
.LBE139:
.LBE142:
.LBB143:
.LBB144:
	leaq	.LC10(%rip), %rbx
.LBE144:
.LBE143:
.LBB146:
.LBB140:
	movq	%rax, %rdx
.LVL268:
.LBE140:
.LBE146:
.LBB147:
.LBB145:
	movq	%rcx, %rax
.LVL269:
/APP
 # 7 "D:/WORK/BUILD/OS/dcooos/kernel64/syscall.h" 1
	int $0x80
 # 0 "" 2
.LVL270:
/NO_APP
.LBE145:
.LBE147:
	.loc 4 482 0
	leaq	video_print_callback(%rip), %rax
	movq	%rax, (%rdx)
.LVL271:
.LBB148:
.LBB149:
	.loc 1 7 0
	leaq	.LC11(%rip), %rbx
	movq	%rcx, %rax
/APP
 # 7 "D:/WORK/BUILD/OS/dcooos/kernel64/syscall.h" 1
	int $0x80
 # 0 "" 2
.LVL272:
/NO_APP
.LBE149:
.LBE148:
	.loc 4 485 0
	leaq	2000(%rcx), %rdx
.LVL273:
	leaq	7000(%rcx), %rax
.LVL274:
.L173:
.LBB150:
.LBB151:
	.loc 2 18 0
	addq	$1, %rdx
.LVL275:
	movb	$-1, -1(%rdx)
.LVL276:
	.loc 2 17 0
	cmpq	%rdx, %rax
	jne	.L173
.LVL277:
.LBE151:
.LBE150:
.LBB152:
.LBB153:
	.loc 1 7 0
	leaq	.LC12(%rip), %rbx
	movq	%rsi, %rax
/APP
 # 7 "D:/WORK/BUILD/OS/dcooos/kernel64/syscall.h" 1
	int $0x80
 # 0 "" 2
.LVL278:
/NO_APP
.LBE153:
.LBE152:
.LBB154:
.LBB155:
	leaq	.LC13(%rip), %rdx
	xorl	%edi, %edi
	movq	%rdi, %rax
	movq	%rdx, %rbx
/APP
 # 7 "D:/WORK/BUILD/OS/dcooos/kernel64/syscall.h" 1
	int $0x80
 # 0 "" 2
/NO_APP
.LBE155:
.LBE154:
.LBB157:
.LBB158:
	leaq	.LC14(%rip), %rcx
.LVL279:
.LBE158:
.LBE157:
.LBB161:
.LBB156:
	movq	%rax, %rdx
.LVL280:
.LBE156:
.LBE161:
	.loc 4 491 0
	movq	%rax, memory(%rip)
.LVL281:
.LBB162:
.LBB159:
	.loc 1 7 0
	movq	%rcx, %rbx
/APP
 # 7 "D:/WORK/BUILD/OS/dcooos/kernel64/syscall.h" 1
	int $0x80
 # 0 "" 2
.LVL282:
/NO_APP
.LBE159:
.LBE162:
.LBB163:
.LBB164:
	leaq	.LC15(%rip), %rbx
.LBE164:
.LBE163:
.LBB166:
.LBB160:
	movq	%rax, %rcx
.LVL283:
.LBE160:
.LBE166:
	.loc 4 499 0
	movq	%rax, memory_req_mem(%rip)
.LVL284:
.LBB167:
.LBB165:
	.loc 1 7 0
	movq	%rsi, %rax
/APP
 # 7 "D:/WORK/BUILD/OS/dcooos/kernel64/syscall.h" 1
	int $0x80
 # 0 "" 2
.LVL285:
/NO_APP
.LBE165:
.LBE167:
.LBB168:
.LBB169:
	leaq	.LC16(%rip), %rbx
	movq	%rdx, %rax
/APP
 # 7 "D:/WORK/BUILD/OS/dcooos/kernel64/syscall.h" 1
	int $0x80
 # 0 "" 2
.LVL286:
/NO_APP
.LBE169:
.LBE168:
.LBB170:
.LBB171:
	leaq	.LC17(%rip), %rbx
.LBE171:
.LBE170:
	.loc 4 511 0
	movq	%rax, vbe_lfb(%rip)
.LVL287:
.LBB173:
.LBB172:
	.loc 1 7 0
	movq	%rsi, %rax
/APP
 # 7 "D:/WORK/BUILD/OS/dcooos/kernel64/syscall.h" 1
	int $0x80
 # 0 "" 2
.LVL288:
/NO_APP
.LBE172:
.LBE173:
.LBB174:
.LBB175:
	leaq	.LC18(%rip), %rbx
.LBE175:
.LBE174:
	.loc 4 516 0
	movq	$960100, (%rcx)
.LVL289:
.LBB177:
.LBB176:
	.loc 1 7 0
	movq	%rsi, %rax
/APP
 # 7 "D:/WORK/BUILD/OS/dcooos/kernel64/syscall.h" 1
	int $0x80
 # 0 "" 2
.LVL290:
/NO_APP
.LBE176:
.LBE177:
.LBB178:
.LBB179:
	leaq	.LC0(%rip), %rbp
	movq	%rdx, %rax
	movq	%rbp, %rbx
/APP
 # 7 "D:/WORK/BUILD/OS/dcooos/kernel64/syscall.h" 1
	int $0x80
 # 0 "" 2
/NO_APP
.LBE179:
.LBE178:
.LBB181:
.LBB182:
	leaq	.LC19(%rip), %rbx
.LBE182:
.LBE181:
.LBB184:
.LBB180:
	movq	%rax, %rcx
.LVL291:
.LBE180:
.LBE184:
	.loc 4 520 0
	movq	%rax, video_buffer(%rip)
.LVL292:
.LBB185:
.LBB183:
	.loc 1 7 0
	movq	%rsi, %rax
/APP
 # 7 "D:/WORK/BUILD/OS/dcooos/kernel64/syscall.h" 1
	int $0x80
 # 0 "" 2
.LVL293:
/NO_APP
.LBE183:
.LBE185:
.LBB186:
.LBB187:
	movq	%rdx, %rax
	movq	%rbp, %rbx
/APP
 # 7 "D:/WORK/BUILD/OS/dcooos/kernel64/syscall.h" 1
	int $0x80
 # 0 "" 2
.LVL294:
/NO_APP
.LBE187:
.LBE186:
.LBB188:
.LBB189:
	leaq	.LC20(%rip), %rbx
.LBE189:
.LBE188:
	.loc 4 524 0
	movq	%rax, video_bg_buffer(%rip)
.LVL295:
.LBB191:
.LBB190:
	.loc 1 7 0
	movq	%rsi, %rax
/APP
 # 7 "D:/WORK/BUILD/OS/dcooos/kernel64/syscall.h" 1
	int $0x80
 # 0 "" 2
.LVL296:
/NO_APP
.LBE190:
.LBE191:
.LBB192:
.LBB193:
	movq	%rdx, %rax
	movq	%rbp, %rbx
/APP
 # 7 "D:/WORK/BUILD/OS/dcooos/kernel64/syscall.h" 1
	int $0x80
 # 0 "" 2
.LVL297:
/NO_APP
.LBE193:
.LBE192:
.LBB194:
.LBB195:
	leaq	.LC21(%rip), %rbx
.LBE195:
.LBE194:
	.loc 4 528 0
	movq	%rax, video_tmp_buffer(%rip)
.LVL298:
.LBB198:
.LBB196:
	.loc 1 7 0
	movq	%rsi, %rax
.LBE196:
.LBE198:
	.loc 4 530 0
	movq	%rcx, 65536
.LVL299:
.LBB199:
.LBB197:
	.loc 1 7 0
/APP
 # 7 "D:/WORK/BUILD/OS/dcooos/kernel64/syscall.h" 1
	int $0x80
 # 0 "" 2
.LVL300:
/NO_APP
.LBE197:
.LBE199:
	.loc 4 535 0
	leaq	.LC22(%rip), %rcx
	call	put_string
.LVL301:
	.loc 4 536 0
	xorl	%edx, %edx
.LVL302:
.LBB200:
.LBB201:
	.loc 1 7 0
	movq	%rsi, %rax
	leaq	.LC23(%rip), %rbx
.LBE201:
.LBE200:
	.loc 4 536 0
	movb	$0, %dh
.LVL303:
.LBB203:
.LBB202:
	.loc 1 7 0
/APP
 # 7 "D:/WORK/BUILD/OS/dcooos/kernel64/syscall.h" 1
	int $0x80
 # 0 "" 2
.LVL304:
/NO_APP
.LBE202:
.LBE203:
	.loc 4 540 0
	movl	$14, %r9d
	movw	%dx, 32(%rsp)
	movl	$800, %r8d
	movl	$14, %edx
.LVL305:
.LBB204:
.LBB205:
	.loc 1 7 0
	leaq	.LC24(%rip), %r12
.LBE205:
.LBE204:
	.loc 4 540 0
	xorl	%ecx, %ecx
	call	put_line
.LVL306:
.LBB207:
.LBB206:
	.loc 1 7 0
	movq	%r12, %rbx
	movq	%rsi, %rax
/APP
 # 7 "D:/WORK/BUILD/OS/dcooos/kernel64/syscall.h" 1
	int $0x80
 # 0 "" 2
.LVL307:
/NO_APP
.LBE206:
.LBE207:
	.loc 4 545 0
	movl	$100, %edx
	movl	$1234567890, %ecx
	call	put_number
.LVL308:
.LBB208:
.LBB209:
	.loc 1 7 0
	leaq	.LC25(%rip), %rbx
	movq	%rsi, %rax
/APP
 # 7 "D:/WORK/BUILD/OS/dcooos/kernel64/syscall.h" 1
	int $0x80
 # 0 "" 2
.LVL309:
/NO_APP
.LBE209:
.LBE208:
	.loc 4 549 0
	call	show_video_buffer
.LVL310:
.LBB210:
.LBB211:
	.loc 1 7 0
	movq	%r12, %rbx
	movq	%rsi, %rax
/APP
 # 7 "D:/WORK/BUILD/OS/dcooos/kernel64/syscall.h" 1
	int $0x80
 # 0 "" 2
.LVL311:
/NO_APP
.LBE211:
.LBE210:
	.loc 4 553 0
	movl	$100, %edx
	movl	$1234567890, %ecx
	call	put_number
.LVL312:
	.loc 4 554 0
	leaq	.LC26(%rip), %rcx
	call	put_string
.LVL313:
.LBB212:
.LBB213:
	.loc 1 7 0
	leaq	.LC27(%rip), %rbx
	movq	%rsi, %rax
/APP
 # 7 "D:/WORK/BUILD/OS/dcooos/kernel64/syscall.h" 1
	int $0x80
 # 0 "" 2
.LVL314:
/NO_APP
.LBE213:
.LBE212:
.LBB214:
.LBB215:
	leaq	.LC28(%rip), %rdx
	movq	%rdi, %rax
	movq	%rdx, %rbx
/APP
 # 7 "D:/WORK/BUILD/OS/dcooos/kernel64/syscall.h" 1
	int $0x80
 # 0 "" 2
/NO_APP
.LBE215:
.LBE214:
.LBB217:
.LBB218:
	leaq	.LC29(%rip), %rbx
.LBE218:
.LBE217:
.LBB220:
.LBB216:
	movq	%rax, %rdx
.LVL315:
.LBE216:
.LBE220:
.LBB221:
.LBB219:
/APP
 # 7 "D:/WORK/BUILD/OS/dcooos/kernel64/syscall.h" 1
	int $0x80
 # 0 "" 2
.LVL316:
/NO_APP
.LBE219:
.LBE221:
.LBB222:
.LBB223:
	leaq	.LC30(%rip), %r9
	movq	%rdx, %rax
	movq	%r9, %rbx
/APP
 # 7 "D:/WORK/BUILD/OS/dcooos/kernel64/syscall.h" 1
	int $0x80
 # 0 "" 2
/NO_APP
.LBE223:
.LBE222:
	.loc 4 569 0
	leaq	100(%rax), %rcx
.LBB225:
.LBB224:
	.loc 1 7 0
	movq	%rax, %r9
.LVL317:
.LBE224:
.LBE225:
	.loc 4 569 0
	movq	memory_req_mem(%rip), %rax
.LBB226:
.LBB227:
	.loc 1 7 0
	movq	%rbp, %rbx
.LBE227:
.LBE226:
	.loc 4 569 0
	movq	%rcx, (%rax)
.LVL318:
.LBB230:
.LBB228:
	.loc 1 7 0
	movq	memory(%rip), %rax
/APP
 # 7 "D:/WORK/BUILD/OS/dcooos/kernel64/syscall.h" 1
	int $0x80
 # 0 "" 2
/NO_APP
.LBE228:
.LBE230:
.LBB231:
.LBB232:
	leaq	.LC31(%rip), %rbx
.LBE232:
.LBE231:
.LBB234:
.LBB229:
	movq	%rax, %rcx
.LVL319:
.LBE229:
.LBE234:
.LBB235:
.LBB233:
	movq	%rdx, %rax
.LVL320:
/APP
 # 7 "D:/WORK/BUILD/OS/dcooos/kernel64/syscall.h" 1
	int $0x80
 # 0 "" 2
.LVL321:
/NO_APP
.LBE233:
.LBE235:
	.loc 4 574 0
	movq	%rcx, (%rax)
	.loc 4 575 0
/APP
 # 575 "D:\WORK\BUILD\OS\dcooos\video\video.c" 1
	xchg %bx, %bx
 # 0 "" 2
.LVL322:
/NO_APP
.LBB236:
.LBB237:
	.loc 1 7 0
	leaq	.LC32(%rip), %rbx
	movq	%rdx, %rax
.LVL323:
/APP
 # 7 "D:/WORK/BUILD/OS/dcooos/kernel64/syscall.h" 1
	int $0x80
 # 0 "" 2
.LVL324:
/NO_APP
.LBE237:
.LBE236:
	.loc 4 577 0
	movq	video_bg_buffer(%rip), %rdx
.LVL325:
	leaq	960000(%rdx), %rax
.LVL326:
.L174:
.LBB238:
.LBB239:
	.loc 2 18 0
	addq	$1, %rdx
.LVL327:
	movb	$0, -1(%rdx)
.LVL328:
	.loc 2 17 0
	cmpq	%rax, %rdx
	jne	.L174
.LVL329:
.LBE239:
.LBE238:
	.loc 4 590 0
	call	show_video_buffer
.LVL330:
.LBB240:
.LBB241:
	.loc 1 7 0
	leaq	.LC33(%rip), %rbx
	movq	%rsi, %rax
.LBE241:
.LBE240:
	.loc 4 592 0
	movq	$1, initDone(%rip)
.LVL331:
.LBB243:
.LBB242:
	.loc 1 7 0
/APP
 # 7 "D:/WORK/BUILD/OS/dcooos/kernel64/syscall.h" 1
	int $0x80
 # 0 "" 2
.LVL332:
/NO_APP
.LBE242:
.LBE243:
	.loc 4 605 0
	movq	memory_req_mem(%rip), %rax
.LBB244:
.LBB245:
	.loc 1 7 0
	movq	%rbp, %rbx
.LBE245:
.LBE244:
	.loc 4 602 0
	movq	$0, 112(%rsp)
	movq	$0, 120(%rsp)
	movq	$100, 128(%rsp)
	movq	$100, 136(%rsp)
	.loc 4 605 0
	movq	%r9, (%rax)
.LVL333:
.LBB248:
.LBB246:
	.loc 1 7 0
	movq	memory(%rip), %rax
.LBE246:
.LBE248:
	.loc 4 603 0
	movq	$100, 144(%rsp)
	movq	$100, 152(%rsp)
	movq	$200, 160(%rsp)
	movq	$200, 168(%rsp)
.LBB249:
.LBB247:
	.loc 1 7 0
/APP
 # 7 "D:/WORK/BUILD/OS/dcooos/kernel64/syscall.h" 1
	int $0x80
 # 0 "" 2
/NO_APP
	movq	%rax, %rbp
.LVL334:
.LBE247:
.LBE249:
	.loc 4 608 0
	movl	$14335, %eax
.LVL335:
	movl	$100, %r9d
	movw	%ax, 32(%rsp)
	movl	$100, %r8d
	xorl	%edx, %edx
	xorl	%ecx, %ecx
	call	put_box
.LVL336:
.LBB250:
.LBB251:
	.loc 1 7 0
	leaq	.LC34(%rip), %rbx
	xorl	%eax, %eax
/APP
 # 7 "D:/WORK/BUILD/OS/dcooos/kernel64/syscall.h" 1
	int $0x80
 # 0 "" 2
/NO_APP
	leaq	video_tmp_buffer(%rip), %r14
	movq	%rax, %rdi
.LVL337:
.LBE251:
.LBE250:
	.loc 4 599 0
	xorl	%esi, %esi
.LVL338:
	leaq	48(%rsp), %r15
	leaq	80(%rsp), %r13
	leaq	.LC36(%rip), %rbx
	.loc 4 617 0
	leaq	.LC35(%rip), %r12
.LVL339:
	.p2align 4,,10
.L175:
	.loc 4 615 0 discriminator 1
	movq	(%r14), %rdx
	movq	%rbp, %r9
	movq	%r15, %r8
	movq	%r13, %rcx
	movq	144(%rsp), %rax
	.loc 4 616 0 discriminator 1
	addq	$1, %rsi
.LVL340:
	.loc 4 615 0 discriminator 1
	movq	%rax, 80(%rsp)
	movq	152(%rsp), %rax
	movq	%rax, 88(%rsp)
	movq	160(%rsp), %rax
	movq	%rax, 96(%rsp)
	movq	168(%rsp), %rax
	movq	%rax, 104(%rsp)
	movq	112(%rsp), %rax
	movq	%rax, 48(%rsp)
	movq	120(%rsp), %rax
	movq	%rax, 56(%rsp)
	movq	128(%rsp), %rax
	movq	%rax, 64(%rsp)
	movq	136(%rsp), %rax
	movq	%rax, 72(%rsp)
	call	copy_rect
.LVL341:
	.loc 4 617 0 discriminator 1
	movq	%r12, %rcx
	call	put_string
.LVL342:
	.loc 4 618 0 discriminator 1
	movl	$100, %edx
	movq	%rsi, %rcx
	call	put_number
.LVL343:
	.loc 4 619 0 discriminator 1
	call	show_video_buffer
.LVL344:
.LBB252:
.LBB253:
	.loc 1 7 0 discriminator 1
	movq	%rdi, %rax
/APP
 # 7 "D:/WORK/BUILD/OS/dcooos/kernel64/syscall.h" 1
	int $0x80
 # 0 "" 2
.LVL345:
/NO_APP
	jmp	.L175
.LBE253:
.LBE252:
	.cfi_endproc
.LFE29:
	.seh_endproc
	.comm	memory, 8, 3
	.globl	cury
	.data
	.align 8
cury:
	.quad	1
	.globl	curx
	.align 8
curx:
	.quad	1
	.comm	video_tmp_buffer, 8, 3
	.comm	video_bg_buffer, 8, 3
	.comm	video_buffer, 8, 3
	.comm	initDone, 8, 3
	.comm	memory_req_mem, 8, 3
	.comm	obj_memory, 8, 3
	.comm	vbe_lfb, 8, 3
	.globl	font
	.align 32
font:
	.byte	0
	.byte	0
	.byte	-2
	.byte	-110
	.byte	16
	.byte	16
	.byte	30
	.byte	17
	.byte	17
	.byte	21
	.byte	22
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	-2
	.byte	-110
	.byte	16
	.byte	16
	.byte	30
	.byte	17
	.byte	17
	.byte	21
	.byte	22
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	-2
	.byte	-110
	.byte	16
	.byte	16
	.byte	30
	.byte	17
	.byte	17
	.byte	21
	.byte	22
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	-2
	.byte	-110
	.byte	16
	.byte	16
	.byte	30
	.byte	17
	.byte	17
	.byte	21
	.byte	22
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	-2
	.byte	-110
	.byte	16
	.byte	16
	.byte	30
	.byte	17
	.byte	17
	.byte	21
	.byte	22
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	-2
	.byte	-110
	.byte	16
	.byte	16
	.byte	30
	.byte	17
	.byte	17
	.byte	21
	.byte	22
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	-2
	.byte	-110
	.byte	16
	.byte	16
	.byte	30
	.byte	17
	.byte	17
	.byte	21
	.byte	22
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	-2
	.byte	-110
	.byte	16
	.byte	16
	.byte	30
	.byte	17
	.byte	17
	.byte	21
	.byte	22
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	-2
	.byte	-110
	.byte	16
	.byte	16
	.byte	30
	.byte	17
	.byte	17
	.byte	21
	.byte	22
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	-2
	.byte	-110
	.byte	16
	.byte	16
	.byte	30
	.byte	17
	.byte	17
	.byte	21
	.byte	22
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	-2
	.byte	-110
	.byte	16
	.byte	16
	.byte	30
	.byte	17
	.byte	17
	.byte	21
	.byte	22
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	-2
	.byte	-110
	.byte	16
	.byte	16
	.byte	30
	.byte	17
	.byte	17
	.byte	21
	.byte	22
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	-2
	.byte	-110
	.byte	16
	.byte	16
	.byte	30
	.byte	17
	.byte	17
	.byte	21
	.byte	22
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	-2
	.byte	-110
	.byte	16
	.byte	16
	.byte	30
	.byte	17
	.byte	17
	.byte	21
	.byte	22
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	-2
	.byte	-110
	.byte	16
	.byte	16
	.byte	30
	.byte	17
	.byte	17
	.byte	21
	.byte	22
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	-2
	.byte	-110
	.byte	16
	.byte	16
	.byte	30
	.byte	17
	.byte	17
	.byte	21
	.byte	22
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	-2
	.byte	-110
	.byte	16
	.byte	16
	.byte	30
	.byte	17
	.byte	17
	.byte	21
	.byte	22
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	-2
	.byte	-110
	.byte	16
	.byte	16
	.byte	30
	.byte	17
	.byte	17
	.byte	21
	.byte	22
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	-2
	.byte	-110
	.byte	16
	.byte	16
	.byte	30
	.byte	17
	.byte	17
	.byte	21
	.byte	22
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	-2
	.byte	-110
	.byte	16
	.byte	16
	.byte	30
	.byte	17
	.byte	17
	.byte	21
	.byte	22
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	-2
	.byte	-110
	.byte	16
	.byte	16
	.byte	30
	.byte	17
	.byte	17
	.byte	21
	.byte	22
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	-2
	.byte	-110
	.byte	16
	.byte	16
	.byte	30
	.byte	17
	.byte	17
	.byte	21
	.byte	22
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	-2
	.byte	-110
	.byte	16
	.byte	16
	.byte	30
	.byte	17
	.byte	17
	.byte	21
	.byte	22
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	-2
	.byte	-110
	.byte	16
	.byte	16
	.byte	30
	.byte	17
	.byte	17
	.byte	21
	.byte	22
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	-2
	.byte	-110
	.byte	16
	.byte	16
	.byte	30
	.byte	17
	.byte	17
	.byte	21
	.byte	22
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	-2
	.byte	-110
	.byte	16
	.byte	16
	.byte	30
	.byte	17
	.byte	17
	.byte	21
	.byte	22
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	-2
	.byte	-110
	.byte	16
	.byte	16
	.byte	30
	.byte	17
	.byte	17
	.byte	21
	.byte	22
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	-2
	.byte	-110
	.byte	16
	.byte	16
	.byte	30
	.byte	17
	.byte	17
	.byte	21
	.byte	22
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	-2
	.byte	-110
	.byte	16
	.byte	16
	.byte	30
	.byte	17
	.byte	17
	.byte	21
	.byte	22
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	-2
	.byte	-110
	.byte	16
	.byte	16
	.byte	30
	.byte	17
	.byte	17
	.byte	21
	.byte	22
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	-2
	.byte	-110
	.byte	16
	.byte	16
	.byte	30
	.byte	17
	.byte	17
	.byte	21
	.byte	22
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	-2
	.byte	-110
	.byte	16
	.byte	16
	.byte	30
	.byte	17
	.byte	17
	.byte	21
	.byte	22
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	8
	.byte	8
	.byte	8
	.byte	8
	.byte	8
	.byte	8
	.byte	8
	.byte	0
	.byte	8
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	20
	.byte	20
	.byte	20
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	10
	.byte	10
	.byte	63
	.byte	20
	.byte	20
	.byte	20
	.byte	126
	.byte	40
	.byte	40
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	8
	.byte	28
	.byte	34
	.byte	32
	.byte	28
	.byte	2
	.byte	34
	.byte	28
	.byte	8
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	32
	.byte	81
	.byte	34
	.byte	4
	.byte	8
	.byte	16
	.byte	34
	.byte	69
	.byte	2
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	24
	.byte	32
	.byte	32
	.byte	16
	.byte	48
	.byte	73
	.byte	74
	.byte	68
	.byte	59
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	8
	.byte	8
	.byte	8
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	4
	.byte	8
	.byte	8
	.byte	16
	.byte	16
	.byte	16
	.byte	16
	.byte	16
	.byte	8
	.byte	8
	.byte	4
	.byte	0
	.byte	0
	.byte	16
	.byte	8
	.byte	8
	.byte	4
	.byte	4
	.byte	4
	.byte	4
	.byte	4
	.byte	8
	.byte	8
	.byte	16
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	54
	.byte	28
	.byte	127
	.byte	28
	.byte	54
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	8
	.byte	8
	.byte	8
	.byte	127
	.byte	8
	.byte	8
	.byte	8
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	8
	.byte	16
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	127
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	8
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	1
	.byte	2
	.byte	4
	.byte	8
	.byte	16
	.byte	32
	.byte	64
	.byte	-128
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	28
	.byte	34
	.byte	34
	.byte	34
	.byte	34
	.byte	34
	.byte	34
	.byte	34
	.byte	28
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	8
	.byte	56
	.byte	8
	.byte	8
	.byte	8
	.byte	8
	.byte	8
	.byte	8
	.byte	62
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	28
	.byte	34
	.byte	2
	.byte	2
	.byte	4
	.byte	8
	.byte	16
	.byte	32
	.byte	62
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	28
	.byte	34
	.byte	2
	.byte	2
	.byte	12
	.byte	2
	.byte	2
	.byte	34
	.byte	28
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	4
	.byte	12
	.byte	12
	.byte	20
	.byte	20
	.byte	36
	.byte	62
	.byte	4
	.byte	14
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	62
	.byte	32
	.byte	32
	.byte	32
	.byte	60
	.byte	2
	.byte	2
	.byte	34
	.byte	28
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	12
	.byte	16
	.byte	32
	.byte	32
	.byte	60
	.byte	34
	.byte	34
	.byte	34
	.byte	28
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	62
	.byte	34
	.byte	2
	.byte	4
	.byte	4
	.byte	8
	.byte	8
	.byte	16
	.byte	16
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	28
	.byte	34
	.byte	34
	.byte	34
	.byte	28
	.byte	34
	.byte	34
	.byte	34
	.byte	28
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	28
	.byte	34
	.byte	34
	.byte	34
	.byte	30
	.byte	2
	.byte	2
	.byte	4
	.byte	24
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	8
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	8
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	8
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	8
	.byte	16
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	4
	.byte	8
	.byte	16
	.byte	32
	.byte	16
	.byte	8
	.byte	4
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	62
	.byte	0
	.byte	62
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	16
	.byte	8
	.byte	4
	.byte	2
	.byte	4
	.byte	8
	.byte	16
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	28
	.byte	34
	.byte	2
	.byte	2
	.byte	4
	.byte	8
	.byte	8
	.byte	0
	.byte	8
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	30
	.byte	33
	.byte	77
	.byte	85
	.byte	85
	.byte	85
	.byte	78
	.byte	32
	.byte	28
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	24
	.byte	8
	.byte	8
	.byte	20
	.byte	20
	.byte	34
	.byte	62
	.byte	34
	.byte	119
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	126
	.byte	33
	.byte	33
	.byte	33
	.byte	62
	.byte	33
	.byte	33
	.byte	33
	.byte	126
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	30
	.byte	33
	.byte	64
	.byte	64
	.byte	64
	.byte	64
	.byte	64
	.byte	33
	.byte	30
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	124
	.byte	34
	.byte	33
	.byte	33
	.byte	33
	.byte	33
	.byte	33
	.byte	34
	.byte	124
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	127
	.byte	33
	.byte	32
	.byte	36
	.byte	60
	.byte	36
	.byte	32
	.byte	33
	.byte	127
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	127
	.byte	33
	.byte	32
	.byte	36
	.byte	60
	.byte	36
	.byte	32
	.byte	32
	.byte	120
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	30
	.byte	33
	.byte	64
	.byte	64
	.byte	64
	.byte	71
	.byte	65
	.byte	33
	.byte	30
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	119
	.byte	34
	.byte	34
	.byte	34
	.byte	62
	.byte	34
	.byte	34
	.byte	34
	.byte	119
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	62
	.byte	8
	.byte	8
	.byte	8
	.byte	8
	.byte	8
	.byte	8
	.byte	8
	.byte	62
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	30
	.byte	4
	.byte	4
	.byte	4
	.byte	4
	.byte	4
	.byte	68
	.byte	68
	.byte	56
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	115
	.byte	34
	.byte	36
	.byte	36
	.byte	40
	.byte	56
	.byte	36
	.byte	34
	.byte	115
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	124
	.byte	16
	.byte	16
	.byte	16
	.byte	16
	.byte	16
	.byte	16
	.byte	17
	.byte	127
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	99
	.byte	34
	.byte	54
	.byte	54
	.byte	42
	.byte	42
	.byte	34
	.byte	34
	.byte	119
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	103
	.byte	34
	.byte	50
	.byte	50
	.byte	42
	.byte	38
	.byte	38
	.byte	34
	.byte	114
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	28
	.byte	34
	.byte	65
	.byte	65
	.byte	65
	.byte	65
	.byte	65
	.byte	34
	.byte	28
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	126
	.byte	33
	.byte	33
	.byte	33
	.byte	62
	.byte	32
	.byte	32
	.byte	32
	.byte	126
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	28
	.byte	34
	.byte	65
	.byte	65
	.byte	65
	.byte	65
	.byte	65
	.byte	34
	.byte	28
	.byte	27
	.byte	0
	.byte	0
	.byte	0
	.byte	126
	.byte	33
	.byte	33
	.byte	33
	.byte	62
	.byte	36
	.byte	36
	.byte	37
	.byte	115
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	62
	.byte	65
	.byte	64
	.byte	64
	.byte	62
	.byte	1
	.byte	1
	.byte	97
	.byte	62
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	127
	.byte	73
	.byte	8
	.byte	8
	.byte	8
	.byte	8
	.byte	8
	.byte	8
	.byte	28
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	119
	.byte	34
	.byte	34
	.byte	34
	.byte	34
	.byte	34
	.byte	34
	.byte	34
	.byte	28
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	119
	.byte	34
	.byte	34
	.byte	34
	.byte	20
	.byte	20
	.byte	20
	.byte	8
	.byte	8
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	119
	.byte	34
	.byte	34
	.byte	34
	.byte	42
	.byte	42
	.byte	42
	.byte	20
	.byte	20
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	119
	.byte	34
	.byte	20
	.byte	20
	.byte	8
	.byte	20
	.byte	20
	.byte	34
	.byte	119
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	119
	.byte	34
	.byte	34
	.byte	20
	.byte	20
	.byte	8
	.byte	8
	.byte	8
	.byte	28
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	127
	.byte	66
	.byte	4
	.byte	4
	.byte	8
	.byte	16
	.byte	16
	.byte	33
	.byte	127
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	28
	.byte	16
	.byte	16
	.byte	16
	.byte	16
	.byte	16
	.byte	16
	.byte	16
	.byte	16
	.byte	16
	.byte	28
	.byte	0
	.byte	0
	.byte	0
	.byte	64
	.byte	32
	.byte	16
	.byte	8
	.byte	4
	.byte	2
	.byte	1
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	28
	.byte	4
	.byte	4
	.byte	4
	.byte	4
	.byte	4
	.byte	4
	.byte	4
	.byte	4
	.byte	4
	.byte	28
	.byte	0
	.byte	8
	.byte	20
	.byte	34
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	-1
	.byte	0
	.byte	0
	.byte	16
	.byte	8
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	60
	.byte	2
	.byte	62
	.byte	66
	.byte	66
	.byte	61
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	96
	.byte	32
	.byte	32
	.byte	62
	.byte	33
	.byte	33
	.byte	33
	.byte	33
	.byte	126
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	62
	.byte	65
	.byte	64
	.byte	64
	.byte	65
	.byte	62
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	6
	.byte	2
	.byte	2
	.byte	62
	.byte	66
	.byte	66
	.byte	66
	.byte	66
	.byte	63
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	62
	.byte	65
	.byte	127
	.byte	64
	.byte	65
	.byte	62
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	12
	.byte	16
	.byte	16
	.byte	60
	.byte	16
	.byte	16
	.byte	16
	.byte	16
	.byte	60
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	63
	.byte	66
	.byte	66
	.byte	66
	.byte	62
	.byte	2
	.byte	2
	.byte	60
	.byte	0
	.byte	0
	.byte	96
	.byte	32
	.byte	32
	.byte	44
	.byte	50
	.byte	34
	.byte	34
	.byte	34
	.byte	119
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	8
	.byte	0
	.byte	0
	.byte	56
	.byte	8
	.byte	8
	.byte	8
	.byte	8
	.byte	62
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	4
	.byte	0
	.byte	0
	.byte	60
	.byte	4
	.byte	4
	.byte	4
	.byte	4
	.byte	4
	.byte	4
	.byte	56
	.byte	0
	.byte	0
	.byte	96
	.byte	32
	.byte	32
	.byte	38
	.byte	36
	.byte	40
	.byte	56
	.byte	38
	.byte	99
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	24
	.byte	8
	.byte	8
	.byte	8
	.byte	8
	.byte	8
	.byte	8
	.byte	8
	.byte	62
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	116
	.byte	42
	.byte	42
	.byte	42
	.byte	42
	.byte	107
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	108
	.byte	50
	.byte	34
	.byte	34
	.byte	34
	.byte	119
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	62
	.byte	65
	.byte	65
	.byte	65
	.byte	65
	.byte	62
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	126
	.byte	33
	.byte	33
	.byte	33
	.byte	33
	.byte	62
	.byte	32
	.byte	112
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	63
	.byte	66
	.byte	66
	.byte	66
	.byte	66
	.byte	62
	.byte	2
	.byte	7
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	118
	.byte	25
	.byte	16
	.byte	16
	.byte	16
	.byte	124
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	62
	.byte	65
	.byte	56
	.byte	6
	.byte	65
	.byte	62
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	16
	.byte	16
	.byte	62
	.byte	16
	.byte	16
	.byte	16
	.byte	18
	.byte	14
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	102
	.byte	34
	.byte	34
	.byte	34
	.byte	38
	.byte	27
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	119
	.byte	34
	.byte	34
	.byte	20
	.byte	20
	.byte	8
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	119
	.byte	34
	.byte	42
	.byte	42
	.byte	20
	.byte	20
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	119
	.byte	34
	.byte	28
	.byte	28
	.byte	34
	.byte	119
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	119
	.byte	34
	.byte	34
	.byte	20
	.byte	20
	.byte	8
	.byte	8
	.byte	48
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	126
	.byte	68
	.byte	8
	.byte	16
	.byte	34
	.byte	126
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	6
	.byte	8
	.byte	8
	.byte	8
	.byte	8
	.byte	48
	.byte	8
	.byte	8
	.byte	8
	.byte	8
	.byte	6
	.byte	0
	.byte	8
	.byte	8
	.byte	8
	.byte	8
	.byte	8
	.byte	8
	.byte	8
	.byte	8
	.byte	8
	.byte	8
	.byte	8
	.byte	8
	.byte	0
	.byte	0
	.byte	48
	.byte	8
	.byte	8
	.byte	8
	.byte	8
	.byte	6
	.byte	8
	.byte	8
	.byte	8
	.byte	8
	.byte	48
	.byte	0
	.byte	0
	.byte	0
	.byte	49
	.byte	73
	.byte	70
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.comm	objects_main_tree, 8, 3
	.comm	tasks, 8, 3
	.comm	current_task, 8, 3
	.comm	parametresHW, 8, 3
	.text
.Letext0:
	.file 5 "D:/WORK/BUILD/OS/dcooos/kernel64/types.h"
	.file 6 "D:/WORK/BUILD/OS/dcooos/kernel64/main.h"
	.file 7 "D:/WORK/BUILD/OS/dcooos/kernel64/idt.h"
	.file 8 "D:/WORK/BUILD/OS/dcooos/kernel64/task.h"
	.file 9 "D:/WORK/BUILD/OS/dcooos/kernel64/objects.h"
	.file 10 "D:/WORK/BUILD/OS/dcooos/video/video.h"
	.section	.debug_info,"dr"
.Ldebug_info0:
	.long	0x220d
	.word	0x4
	.secrel32	.Ldebug_abbrev0
	.byte	0x8
	.uleb128 0x1
	.ascii "GNU C11 6.3.0 -mtune=core2 -march=nocona -ggdb -O2\0"
	.byte	0xc
	.ascii "D:\\WORK\\BUILD\\OS\\dcooos\\video\\video.c\0"
	.quad	.Ltext0
	.quad	.Letext0-.Ltext0
	.secrel32	.Ldebug_line0
	.uleb128 0x2
	.ascii "u1\0"
	.byte	0x5
	.byte	0x4
	.long	0x89
	.uleb128 0x3
	.long	0x7a
	.uleb128 0x4
	.byte	0x1
	.byte	0x8
	.ascii "unsigned char\0"
	.uleb128 0x2
	.ascii "u2\0"
	.byte	0x5
	.byte	0x5
	.long	0xa4
	.uleb128 0x4
	.byte	0x2
	.byte	0x7
	.ascii "short unsigned int\0"
	.uleb128 0x2
	.ascii "u4\0"
	.byte	0x5
	.byte	0x6
	.long	0xc4
	.uleb128 0x4
	.byte	0x4
	.byte	0x7
	.ascii "long unsigned int\0"
	.uleb128 0x2
	.ascii "u8\0"
	.byte	0x5
	.byte	0x7
	.long	0xe8
	.uleb128 0x3
	.long	0xd9
	.uleb128 0x4
	.byte	0x8
	.byte	0x7
	.ascii "long long unsigned int\0"
	.uleb128 0x5
	.byte	0x18
	.byte	0x6
	.byte	0x3f
	.long	0x16e
	.uleb128 0x6
	.ascii "bootDrive\0"
	.byte	0x6
	.byte	0x40
	.long	0xba
	.byte	0
	.uleb128 0x6
	.ascii "memorySize\0"
	.byte	0x6
	.byte	0x41
	.long	0xba
	.byte	0x4
	.uleb128 0x6
	.ascii "VBElfb\0"
	.byte	0x6
	.byte	0x42
	.long	0xba
	.byte	0x8
	.uleb128 0x6
	.ascii "VBEResX\0"
	.byte	0x6
	.byte	0x43
	.long	0xba
	.byte	0xc
	.uleb128 0x6
	.ascii "VBEResY\0"
	.byte	0x6
	.byte	0x44
	.long	0xba
	.byte	0x10
	.uleb128 0x6
	.ascii "VBEBPP\0"
	.byte	0x6
	.byte	0x45
	.long	0xba
	.byte	0x14
	.byte	0
	.uleb128 0x2
	.ascii "t_parametresHW\0"
	.byte	0x6
	.byte	0x46
	.long	0x102
	.uleb128 0x7
	.ascii "parametresHW\0"
	.byte	0x6
	.byte	0x48
	.long	0x1a2
	.uleb128 0x9
	.byte	0x3
	.quad	parametresHW
	.uleb128 0x8
	.byte	0x8
	.long	0x16e
	.uleb128 0x9
	.ascii "registers\0"
	.byte	0x80
	.byte	0x7
	.byte	0x4
	.long	0x287
	.uleb128 0x6
	.ascii "ds\0"
	.byte	0x7
	.byte	0x6
	.long	0xd9
	.byte	0
	.uleb128 0x6
	.ascii "rax\0"
	.byte	0x7
	.byte	0x8
	.long	0xd9
	.byte	0x8
	.uleb128 0x6
	.ascii "rcx\0"
	.byte	0x7
	.byte	0x8
	.long	0xd9
	.byte	0x10
	.uleb128 0x6
	.ascii "rdx\0"
	.byte	0x7
	.byte	0x8
	.long	0xd9
	.byte	0x18
	.uleb128 0x6
	.ascii "rbx\0"
	.byte	0x7
	.byte	0x8
	.long	0xd9
	.byte	0x20
	.uleb128 0x6
	.ascii "rsp\0"
	.byte	0x7
	.byte	0x8
	.long	0xd9
	.byte	0x28
	.uleb128 0x6
	.ascii "rbp\0"
	.byte	0x7
	.byte	0x8
	.long	0xd9
	.byte	0x30
	.uleb128 0x6
	.ascii "rsi\0"
	.byte	0x7
	.byte	0x8
	.long	0xd9
	.byte	0x38
	.uleb128 0x6
	.ascii "rdi\0"
	.byte	0x7
	.byte	0x8
	.long	0xd9
	.byte	0x40
	.uleb128 0x6
	.ascii "int_no\0"
	.byte	0x7
	.byte	0x9
	.long	0xd9
	.byte	0x48
	.uleb128 0x6
	.ascii "err_code\0"
	.byte	0x7
	.byte	0x9
	.long	0xd9
	.byte	0x50
	.uleb128 0x6
	.ascii "rip\0"
	.byte	0x7
	.byte	0xa
	.long	0xd9
	.byte	0x58
	.uleb128 0x6
	.ascii "cs\0"
	.byte	0x7
	.byte	0xa
	.long	0xd9
	.byte	0x60
	.uleb128 0x6
	.ascii "eflags\0"
	.byte	0x7
	.byte	0xa
	.long	0xd9
	.byte	0x68
	.uleb128 0x6
	.ascii "useresp\0"
	.byte	0x7
	.byte	0xa
	.long	0xd9
	.byte	0x70
	.uleb128 0x6
	.ascii "ss\0"
	.byte	0x7
	.byte	0xa
	.long	0xd9
	.byte	0x78
	.byte	0
	.uleb128 0x2
	.ascii "registers_t\0"
	.byte	0x7
	.byte	0xb
	.long	0x1a8
	.uleb128 0xa
	.ascii "clisti\0"
	.byte	0x7
	.byte	0x10
	.long	0xd9
	.uleb128 0x9
	.ascii "task\0"
	.byte	0xd0
	.byte	0x8
	.byte	0x10
	.long	0x36b
	.uleb128 0x6
	.ascii "id\0"
	.byte	0x8
	.byte	0x11
	.long	0xd9
	.byte	0
	.uleb128 0x6
	.ascii "state\0"
	.byte	0x8
	.byte	0x13
	.long	0x7a
	.byte	0x8
	.uleb128 0x6
	.ascii "wakeup_time\0"
	.byte	0x8
	.byte	0x14
	.long	0xd9
	.byte	0x10
	.uleb128 0x6
	.ascii "pdir\0"
	.byte	0x8
	.byte	0x16
	.long	0xd9
	.byte	0x18
	.uleb128 0x6
	.ascii "task_pdir\0"
	.byte	0x8
	.byte	0x17
	.long	0xd9
	.byte	0x20
	.uleb128 0x6
	.ascii "timer_tick\0"
	.byte	0x8
	.byte	0x19
	.long	0xd9
	.byte	0x28
	.uleb128 0x6
	.ascii "switch_count\0"
	.byte	0x8
	.byte	0x1a
	.long	0xd9
	.byte	0x30
	.uleb128 0x6
	.ascii "name\0"
	.byte	0x8
	.byte	0x1c
	.long	0x36b
	.byte	0x38
	.uleb128 0x6
	.ascii "task_interrupted\0"
	.byte	0x8
	.byte	0x1f
	.long	0x7a
	.byte	0x40
	.uleb128 0x6
	.ascii "stack\0"
	.byte	0x8
	.byte	0x20
	.long	0x287
	.byte	0x48
	.uleb128 0x6
	.ascii "next\0"
	.byte	0x8
	.byte	0x22
	.long	0x379
	.byte	0xc8
	.byte	0
	.uleb128 0x8
	.byte	0x8
	.long	0x371
	.uleb128 0x4
	.byte	0x1
	.byte	0x6
	.ascii "char\0"
	.uleb128 0x8
	.byte	0x8
	.long	0x2a8
	.uleb128 0x2
	.ascii "task_t\0"
	.byte	0x8
	.byte	0x24
	.long	0x2a8
	.uleb128 0x7
	.ascii "current_task\0"
	.byte	0x8
	.byte	0x26
	.long	0x3ab
	.uleb128 0x9
	.byte	0x3
	.quad	current_task
	.uleb128 0x8
	.byte	0x8
	.long	0x37f
	.uleb128 0x7
	.ascii "tasks\0"
	.byte	0x8
	.byte	0x27
	.long	0x3ab
	.uleb128 0x9
	.byte	0x3
	.quad	tasks
	.uleb128 0x5
	.byte	0x10
	.byte	0x9
	.byte	0x7
	.long	0x417
	.uleb128 0x6
	.ascii "data1\0"
	.byte	0x9
	.byte	0x8
	.long	0xba
	.byte	0
	.uleb128 0x6
	.ascii "data2\0"
	.byte	0x9
	.byte	0x9
	.long	0x9a
	.byte	0x4
	.uleb128 0x6
	.ascii "data3\0"
	.byte	0x9
	.byte	0xa
	.long	0x9a
	.byte	0x6
	.uleb128 0x6
	.ascii "data4\0"
	.byte	0x9
	.byte	0xb
	.long	0x9a
	.byte	0x8
	.uleb128 0x6
	.ascii "data5\0"
	.byte	0x9
	.byte	0xc
	.long	0xba
	.byte	0xc
	.byte	0
	.uleb128 0x2
	.ascii "GUID\0"
	.byte	0x9
	.byte	0xd
	.long	0x3c8
	.uleb128 0xb
	.secrel32	.LASF0
	.byte	0x30
	.byte	0x9
	.byte	0x13
	.long	0x47d
	.uleb128 0x6
	.ascii "name\0"
	.byte	0x9
	.byte	0x14
	.long	0x47d
	.byte	0
	.uleb128 0x6
	.ascii "type\0"
	.byte	0x9
	.byte	0x15
	.long	0xd9
	.byte	0x8
	.uleb128 0x6
	.ascii "size\0"
	.byte	0x9
	.byte	0x16
	.long	0xd9
	.byte	0x10
	.uleb128 0xc
	.secrel32	.LASF1
	.byte	0x9
	.byte	0x17
	.long	0xd9
	.byte	0x18
	.uleb128 0x6
	.ascii "prev\0"
	.byte	0x9
	.byte	0x18
	.long	0x483
	.byte	0x20
	.uleb128 0x6
	.ascii "next\0"
	.byte	0x9
	.byte	0x19
	.long	0x483
	.byte	0x28
	.byte	0
	.uleb128 0x8
	.byte	0x8
	.long	0x7a
	.uleb128 0x8
	.byte	0x8
	.long	0x423
	.uleb128 0x2
	.ascii "t_property\0"
	.byte	0x9
	.byte	0x1b
	.long	0x423
	.uleb128 0x9
	.ascii "method\0"
	.byte	0x20
	.byte	0x9
	.byte	0x1d
	.long	0x4de
	.uleb128 0x6
	.ascii "name\0"
	.byte	0x9
	.byte	0x1e
	.long	0x47d
	.byte	0
	.uleb128 0xc
	.secrel32	.LASF1
	.byte	0x9
	.byte	0x1f
	.long	0xd9
	.byte	0x8
	.uleb128 0x6
	.ascii "prev\0"
	.byte	0x9
	.byte	0x20
	.long	0x4de
	.byte	0x10
	.uleb128 0x6
	.ascii "next\0"
	.byte	0x9
	.byte	0x21
	.long	0x4de
	.byte	0x18
	.byte	0
	.uleb128 0x8
	.byte	0x8
	.long	0x49b
	.uleb128 0x2
	.ascii "t_method\0"
	.byte	0x9
	.byte	0x23
	.long	0x49b
	.uleb128 0x9
	.ascii "heap\0"
	.byte	0x18
	.byte	0x9
	.byte	0x28
	.long	0x529
	.uleb128 0xc
	.secrel32	.LASF1
	.byte	0x9
	.byte	0x29
	.long	0xd9
	.byte	0
	.uleb128 0x6
	.ascii "size\0"
	.byte	0x9
	.byte	0x2a
	.long	0xd9
	.byte	0x8
	.uleb128 0x6
	.ascii "state\0"
	.byte	0x9
	.byte	0x2b
	.long	0xd9
	.byte	0x10
	.byte	0
	.uleb128 0x2
	.ascii "t_heap\0"
	.byte	0x9
	.byte	0x2d
	.long	0x4f4
	.uleb128 0x9
	.ascii "object\0"
	.byte	0x60
	.byte	0x9
	.byte	0x30
	.long	0x5d9
	.uleb128 0x6
	.ascii "guid\0"
	.byte	0x9
	.byte	0x31
	.long	0x417
	.byte	0
	.uleb128 0x6
	.ascii "name\0"
	.byte	0x9
	.byte	0x32
	.long	0x47d
	.byte	0x10
	.uleb128 0x6
	.ascii "pdir\0"
	.byte	0x9
	.byte	0x33
	.long	0xd9
	.byte	0x18
	.uleb128 0xc
	.secrel32	.LASF0
	.byte	0x9
	.byte	0x34
	.long	0x5d9
	.byte	0x20
	.uleb128 0x6
	.ascii "method\0"
	.byte	0x9
	.byte	0x35
	.long	0x5df
	.byte	0x28
	.uleb128 0x6
	.ascii "heap\0"
	.byte	0x9
	.byte	0x36
	.long	0x5e5
	.byte	0x30
	.uleb128 0x6
	.ascii "is_class\0"
	.byte	0x9
	.byte	0x37
	.long	0xd9
	.byte	0x38
	.uleb128 0x6
	.ascii "prev\0"
	.byte	0x9
	.byte	0x38
	.long	0x5eb
	.byte	0x40
	.uleb128 0x6
	.ascii "next\0"
	.byte	0x9
	.byte	0x39
	.long	0x5eb
	.byte	0x48
	.uleb128 0x6
	.ascii "sub\0"
	.byte	0x9
	.byte	0x3a
	.long	0x5eb
	.byte	0x50
	.uleb128 0x6
	.ascii "sup\0"
	.byte	0x9
	.byte	0x3b
	.long	0x5eb
	.byte	0x58
	.byte	0
	.uleb128 0x8
	.byte	0x8
	.long	0x489
	.uleb128 0x8
	.byte	0x8
	.long	0x4e4
	.uleb128 0x8
	.byte	0x8
	.long	0x529
	.uleb128 0x8
	.byte	0x8
	.long	0x537
	.uleb128 0x2
	.ascii "t_object\0"
	.byte	0x9
	.byte	0x3d
	.long	0x537
	.uleb128 0x8
	.byte	0x8
	.long	0x5f1
	.uleb128 0x7
	.ascii "objects_main_tree\0"
	.byte	0x9
	.byte	0x46
	.long	0x601
	.uleb128 0x9
	.byte	0x3
	.quad	objects_main_tree
	.uleb128 0xd
	.long	0x371
	.long	0x63b
	.uleb128 0xe
	.long	0x63b
	.word	0x672
	.byte	0
	.uleb128 0x4
	.byte	0x8
	.byte	0x7
	.ascii "sizetype\0"
	.uleb128 0x7
	.ascii "font\0"
	.byte	0xa
	.byte	0x6
	.long	0x62a
	.uleb128 0x9
	.byte	0x3
	.quad	font
	.uleb128 0x7
	.ascii "vbe_lfb\0"
	.byte	0x4
	.byte	0x10
	.long	0x676
	.uleb128 0x9
	.byte	0x3
	.quad	vbe_lfb
	.uleb128 0x8
	.byte	0x8
	.long	0xd9
	.uleb128 0x7
	.ascii "obj_memory\0"
	.byte	0x4
	.byte	0x12
	.long	0x47d
	.uleb128 0x9
	.byte	0x3
	.quad	obj_memory
	.uleb128 0x7
	.ascii "memory_req_mem\0"
	.byte	0x4
	.byte	0x13
	.long	0x676
	.uleb128 0x9
	.byte	0x3
	.quad	memory_req_mem
	.uleb128 0x7
	.ascii "initDone\0"
	.byte	0x4
	.byte	0x15
	.long	0xd9
	.uleb128 0x9
	.byte	0x3
	.quad	initDone
	.uleb128 0x9
	.ascii "color\0"
	.byte	0x2
	.byte	0x4
	.byte	0x17
	.long	0x6ed
	.uleb128 0x6
	.ascii "rgb\0"
	.byte	0x4
	.byte	0x18
	.long	0x6ed
	.byte	0
	.byte	0
	.uleb128 0xd
	.long	0x7a
	.long	0x6fd
	.uleb128 0xf
	.long	0x63b
	.byte	0x1
	.byte	0
	.uleb128 0x2
	.ascii "t_color\0"
	.byte	0x4
	.byte	0x1b
	.long	0x6d2
	.uleb128 0x7
	.ascii "video_buffer\0"
	.byte	0x4
	.byte	0x1d
	.long	0x72a
	.uleb128 0x9
	.byte	0x3
	.quad	video_buffer
	.uleb128 0x8
	.byte	0x8
	.long	0x6fd
	.uleb128 0x7
	.ascii "video_bg_buffer\0"
	.byte	0x4
	.byte	0x1e
	.long	0x72a
	.uleb128 0x9
	.byte	0x3
	.quad	video_bg_buffer
	.uleb128 0x7
	.ascii "video_tmp_buffer\0"
	.byte	0x4
	.byte	0x1f
	.long	0x72a
	.uleb128 0x9
	.byte	0x3
	.quad	video_tmp_buffer
	.uleb128 0x7
	.ascii "curx\0"
	.byte	0x4
	.byte	0xd0
	.long	0xd9
	.uleb128 0x9
	.byte	0x3
	.quad	curx
	.uleb128 0x7
	.ascii "cury\0"
	.byte	0x4
	.byte	0xd0
	.long	0xd9
	.uleb128 0x9
	.byte	0x3
	.quad	cury
	.uleb128 0x7
	.ascii "memory\0"
	.byte	0x4
	.byte	0xea
	.long	0x47d
	.uleb128 0x9
	.byte	0x3
	.quad	memory
	.uleb128 0x10
	.ascii "rect\0"
	.byte	0x20
	.byte	0x4
	.word	0x1af
	.long	0x800
	.uleb128 0x11
	.ascii "left\0"
	.byte	0x4
	.word	0x1b0
	.long	0xd9
	.byte	0
	.uleb128 0x11
	.ascii "top\0"
	.byte	0x4
	.word	0x1b0
	.long	0xd9
	.byte	0x8
	.uleb128 0x11
	.ascii "right\0"
	.byte	0x4
	.word	0x1b0
	.long	0xd9
	.byte	0x10
	.uleb128 0x11
	.ascii "bottom\0"
	.byte	0x4
	.word	0x1b0
	.long	0xd9
	.byte	0x18
	.byte	0
	.uleb128 0x12
	.ascii "t_rect\0"
	.byte	0x4
	.word	0x1b3
	.long	0x7b7
	.uleb128 0x13
	.ascii "initialize_object\0"
	.byte	0x4
	.word	0x1c8
	.quad	.LFB29
	.quad	.LFE29-.LFB29
	.uleb128 0x1
	.byte	0x9c
	.long	0x1391
	.uleb128 0x14
	.ascii "log\0"
	.byte	0x4
	.word	0x1cb
	.long	0x47d
	.secrel32	.LLST91
	.uleb128 0x15
	.ascii "i\0"
	.byte	0x4
	.word	0x1cf
	.long	0xd9
	.uleb128 0x14
	.ascii "video\0"
	.byte	0x4
	.word	0x1d8
	.long	0x47d
	.secrel32	.LLST92
	.uleb128 0x14
	.ascii "video_tmp\0"
	.byte	0x4
	.word	0x1db
	.long	0x676
	.secrel32	.LLST93
	.uleb128 0x16
	.ascii "s\0"
	.byte	0x4
	.word	0x211
	.long	0x676
	.long	0x10000
	.uleb128 0x14
	.ascii "col\0"
	.byte	0x4
	.word	0x218
	.long	0x6fd
	.secrel32	.LLST94
	.uleb128 0x14
	.ascii "fs\0"
	.byte	0x4
	.word	0x234
	.long	0x47d
	.secrel32	.LLST95
	.uleb128 0x15
	.ascii "sizeoffile\0"
	.byte	0x4
	.word	0x236
	.long	0xd9
	.uleb128 0x14
	.ascii "fbuf\0"
	.byte	0x4
	.word	0x237
	.long	0x47d
	.secrel32	.LLST96
	.uleb128 0x14
	.ascii "fs_data\0"
	.byte	0x4
	.word	0x23d
	.long	0x676
	.secrel32	.LLST97
	.uleb128 0x15
	.ascii "x\0"
	.byte	0x4
	.word	0x242
	.long	0xd9
	.uleb128 0x15
	.ascii "y\0"
	.byte	0x4
	.word	0x242
	.long	0xd9
	.uleb128 0x17
	.ascii "j\0"
	.byte	0x4
	.word	0x242
	.long	0xd9
	.word	0x3d5
	.uleb128 0x15
	.ascii "d\0"
	.byte	0x4
	.word	0x252
	.long	0xd9
	.uleb128 0x14
	.ascii "st\0"
	.byte	0x4
	.word	0x257
	.long	0xd9
	.secrel32	.LLST98
	.uleb128 0x18
	.ascii "ii\0"
	.byte	0x4
	.word	0x258
	.long	0xd9
	.byte	0
	.uleb128 0x19
	.ascii "dst\0"
	.byte	0x4
	.word	0x25a
	.long	0x800
	.uleb128 0x3
	.byte	0x91
	.sleb128 -144
	.uleb128 0x19
	.ascii "dst1\0"
	.byte	0x4
	.word	0x25b
	.long	0x800
	.uleb128 0x3
	.byte	0x91
	.sleb128 -112
	.uleb128 0x14
	.ascii "mem\0"
	.byte	0x4
	.word	0x25e
	.long	0x47d
	.secrel32	.LLST99
	.uleb128 0x14
	.ascii "system\0"
	.byte	0x4
	.word	0x263
	.long	0x47d
	.secrel32	.LLST100
	.uleb128 0x1a
	.long	0x20ea
	.quad	.LBB122
	.secrel32	.Ldebug_ranges0+0x130
	.byte	0x4
	.word	0x1cb
	.long	0x9a1
	.uleb128 0x1b
	.long	0x210c
	.secrel32	.LLST101
	.uleb128 0x1b
	.long	0x20fe
	.secrel32	.LLST102
	.uleb128 0x1c
	.secrel32	.Ldebug_ranges0+0x130
	.uleb128 0x1d
	.long	0x214f
	.byte	0
	.byte	0
	.uleb128 0x1a
	.long	0x20ea
	.quad	.LBB127
	.secrel32	.Ldebug_ranges0+0x170
	.byte	0x4
	.word	0x1cd
	.long	0x9d7
	.uleb128 0x1b
	.long	0x210c
	.secrel32	.LLST103
	.uleb128 0x1b
	.long	0x20fe
	.secrel32	.LLST104
	.uleb128 0x1c
	.secrel32	.Ldebug_ranges0+0x170
	.uleb128 0x1d
	.long	0x214f
	.byte	0
	.byte	0
	.uleb128 0x1e
	.long	0x20ea
	.quad	.LBB132
	.quad	.LBE132-.LBB132
	.byte	0x4
	.word	0x1d5
	.long	0xa1d
	.uleb128 0x1b
	.long	0x210c
	.secrel32	.LLST105
	.uleb128 0x1b
	.long	0x20fe
	.secrel32	.LLST106
	.uleb128 0x1f
	.quad	.LBB133
	.quad	.LBE133-.LBB133
	.uleb128 0x1d
	.long	0x214f
	.byte	0
	.byte	0
	.uleb128 0x1a
	.long	0x20ea
	.quad	.LBB134
	.secrel32	.Ldebug_ranges0+0x1a0
	.byte	0x4
	.word	0x1d8
	.long	0xa53
	.uleb128 0x1b
	.long	0x210c
	.secrel32	.LLST107
	.uleb128 0x1b
	.long	0x20fe
	.secrel32	.LLST108
	.uleb128 0x1c
	.secrel32	.Ldebug_ranges0+0x1a0
	.uleb128 0x1d
	.long	0x214f
	.byte	0
	.byte	0
	.uleb128 0x1a
	.long	0x20ea
	.quad	.LBB137
	.secrel32	.Ldebug_ranges0+0x1d0
	.byte	0x4
	.word	0x1db
	.long	0xa89
	.uleb128 0x1b
	.long	0x210c
	.secrel32	.LLST109
	.uleb128 0x1b
	.long	0x20fe
	.secrel32	.LLST110
	.uleb128 0x1c
	.secrel32	.Ldebug_ranges0+0x1d0
	.uleb128 0x1d
	.long	0x214f
	.byte	0
	.byte	0
	.uleb128 0x1a
	.long	0x20ea
	.quad	.LBB143
	.secrel32	.Ldebug_ranges0+0x210
	.byte	0x4
	.word	0x1e0
	.long	0xabf
	.uleb128 0x1b
	.long	0x210c
	.secrel32	.LLST111
	.uleb128 0x1b
	.long	0x20fe
	.secrel32	.LLST112
	.uleb128 0x1c
	.secrel32	.Ldebug_ranges0+0x210
	.uleb128 0x1d
	.long	0x214f
	.byte	0
	.byte	0
	.uleb128 0x1e
	.long	0x20ea
	.quad	.LBB148
	.quad	.LBE148-.LBB148
	.byte	0x4
	.word	0x1e3
	.long	0xb05
	.uleb128 0x1b
	.long	0x210c
	.secrel32	.LLST113
	.uleb128 0x1b
	.long	0x20fe
	.secrel32	.LLST114
	.uleb128 0x1f
	.quad	.LBB149
	.quad	.LBE149-.LBB149
	.uleb128 0x1d
	.long	0x214f
	.byte	0
	.byte	0
	.uleb128 0x1e
	.long	0x2068
	.quad	.LBB150
	.quad	.LBE150-.LBB150
	.byte	0x4
	.word	0x1e5
	.long	0xb54
	.uleb128 0x1b
	.long	0x208e
	.secrel32	.LLST115
	.uleb128 0x1b
	.long	0x2083
	.secrel32	.LLST116
	.uleb128 0x1b
	.long	0x2077
	.secrel32	.LLST117
	.uleb128 0x1f
	.quad	.LBB151
	.quad	.LBE151-.LBB151
	.uleb128 0x1d
	.long	0x21d0
	.byte	0
	.byte	0
	.uleb128 0x1e
	.long	0x20ea
	.quad	.LBB152
	.quad	.LBE152-.LBB152
	.byte	0x4
	.word	0x1e8
	.long	0xb9a
	.uleb128 0x1b
	.long	0x210c
	.secrel32	.LLST118
	.uleb128 0x1b
	.long	0x20fe
	.secrel32	.LLST119
	.uleb128 0x1f
	.quad	.LBB153
	.quad	.LBE153-.LBB153
	.uleb128 0x1d
	.long	0x214f
	.byte	0
	.byte	0
	.uleb128 0x1a
	.long	0x20ea
	.quad	.LBB154
	.secrel32	.Ldebug_ranges0+0x240
	.byte	0x4
	.word	0x1eb
	.long	0xbd0
	.uleb128 0x1b
	.long	0x210c
	.secrel32	.LLST120
	.uleb128 0x1b
	.long	0x20fe
	.secrel32	.LLST121
	.uleb128 0x1c
	.secrel32	.Ldebug_ranges0+0x240
	.uleb128 0x1d
	.long	0x214f
	.byte	0
	.byte	0
	.uleb128 0x1a
	.long	0x20ea
	.quad	.LBB157
	.secrel32	.Ldebug_ranges0+0x270
	.byte	0x4
	.word	0x1f3
	.long	0xc06
	.uleb128 0x1b
	.long	0x210c
	.secrel32	.LLST122
	.uleb128 0x1b
	.long	0x20fe
	.secrel32	.LLST123
	.uleb128 0x1c
	.secrel32	.Ldebug_ranges0+0x270
	.uleb128 0x1d
	.long	0x214f
	.byte	0
	.byte	0
	.uleb128 0x1a
	.long	0x20ea
	.quad	.LBB163
	.secrel32	.Ldebug_ranges0+0x2b0
	.byte	0x4
	.word	0x1fb
	.long	0xc3c
	.uleb128 0x1b
	.long	0x210c
	.secrel32	.LLST124
	.uleb128 0x1b
	.long	0x20fe
	.secrel32	.LLST125
	.uleb128 0x1c
	.secrel32	.Ldebug_ranges0+0x2b0
	.uleb128 0x1d
	.long	0x214f
	.byte	0
	.byte	0
	.uleb128 0x1e
	.long	0x20ea
	.quad	.LBB168
	.quad	.LBE168-.LBB168
	.byte	0x4
	.word	0x1ff
	.long	0xc82
	.uleb128 0x1b
	.long	0x210c
	.secrel32	.LLST126
	.uleb128 0x1b
	.long	0x20fe
	.secrel32	.LLST127
	.uleb128 0x1f
	.quad	.LBB169
	.quad	.LBE169-.LBB169
	.uleb128 0x1d
	.long	0x214f
	.byte	0
	.byte	0
	.uleb128 0x1a
	.long	0x20ea
	.quad	.LBB170
	.secrel32	.Ldebug_ranges0+0x2e0
	.byte	0x4
	.word	0x202
	.long	0xcb8
	.uleb128 0x1b
	.long	0x210c
	.secrel32	.LLST128
	.uleb128 0x1b
	.long	0x20fe
	.secrel32	.LLST129
	.uleb128 0x1c
	.secrel32	.Ldebug_ranges0+0x2e0
	.uleb128 0x1d
	.long	0x214f
	.byte	0
	.byte	0
	.uleb128 0x1a
	.long	0x20ea
	.quad	.LBB174
	.secrel32	.Ldebug_ranges0+0x310
	.byte	0x4
	.word	0x206
	.long	0xcee
	.uleb128 0x1b
	.long	0x210c
	.secrel32	.LLST130
	.uleb128 0x1b
	.long	0x20fe
	.secrel32	.LLST131
	.uleb128 0x1c
	.secrel32	.Ldebug_ranges0+0x310
	.uleb128 0x1d
	.long	0x214f
	.byte	0
	.byte	0
	.uleb128 0x1a
	.long	0x20ea
	.quad	.LBB178
	.secrel32	.Ldebug_ranges0+0x340
	.byte	0x4
	.word	0x208
	.long	0xd24
	.uleb128 0x1b
	.long	0x210c
	.secrel32	.LLST132
	.uleb128 0x1b
	.long	0x20fe
	.secrel32	.LLST133
	.uleb128 0x1c
	.secrel32	.Ldebug_ranges0+0x340
	.uleb128 0x1d
	.long	0x214f
	.byte	0
	.byte	0
	.uleb128 0x1a
	.long	0x20ea
	.quad	.LBB181
	.secrel32	.Ldebug_ranges0+0x370
	.byte	0x4
	.word	0x20a
	.long	0xd5a
	.uleb128 0x1b
	.long	0x210c
	.secrel32	.LLST134
	.uleb128 0x1b
	.long	0x20fe
	.secrel32	.LLST135
	.uleb128 0x1c
	.secrel32	.Ldebug_ranges0+0x370
	.uleb128 0x1d
	.long	0x214f
	.byte	0
	.byte	0
	.uleb128 0x1e
	.long	0x20ea
	.quad	.LBB186
	.quad	.LBE186-.LBB186
	.byte	0x4
	.word	0x20c
	.long	0xda0
	.uleb128 0x1b
	.long	0x210c
	.secrel32	.LLST136
	.uleb128 0x1b
	.long	0x20fe
	.secrel32	.LLST137
	.uleb128 0x1f
	.quad	.LBB187
	.quad	.LBE187-.LBB187
	.uleb128 0x1d
	.long	0x214f
	.byte	0
	.byte	0
	.uleb128 0x1a
	.long	0x20ea
	.quad	.LBB188
	.secrel32	.Ldebug_ranges0+0x3a0
	.byte	0x4
	.word	0x20e
	.long	0xdd6
	.uleb128 0x1b
	.long	0x210c
	.secrel32	.LLST138
	.uleb128 0x1b
	.long	0x20fe
	.secrel32	.LLST139
	.uleb128 0x1c
	.secrel32	.Ldebug_ranges0+0x3a0
	.uleb128 0x1d
	.long	0x214f
	.byte	0
	.byte	0
	.uleb128 0x1e
	.long	0x20ea
	.quad	.LBB192
	.quad	.LBE192-.LBB192
	.byte	0x4
	.word	0x210
	.long	0xe1c
	.uleb128 0x1b
	.long	0x210c
	.secrel32	.LLST140
	.uleb128 0x1b
	.long	0x20fe
	.secrel32	.LLST141
	.uleb128 0x1f
	.quad	.LBB193
	.quad	.LBE193-.LBB193
	.uleb128 0x1d
	.long	0x214f
	.byte	0
	.byte	0
	.uleb128 0x1a
	.long	0x20ea
	.quad	.LBB194
	.secrel32	.Ldebug_ranges0+0x3d0
	.byte	0x4
	.word	0x215
	.long	0xe52
	.uleb128 0x1b
	.long	0x210c
	.secrel32	.LLST142
	.uleb128 0x1b
	.long	0x20fe
	.secrel32	.LLST143
	.uleb128 0x1c
	.secrel32	.Ldebug_ranges0+0x3d0
	.uleb128 0x1d
	.long	0x214f
	.byte	0
	.byte	0
	.uleb128 0x1a
	.long	0x20ea
	.quad	.LBB200
	.secrel32	.Ldebug_ranges0+0x410
	.byte	0x4
	.word	0x21a
	.long	0xe88
	.uleb128 0x1b
	.long	0x210c
	.secrel32	.LLST144
	.uleb128 0x1b
	.long	0x20fe
	.secrel32	.LLST145
	.uleb128 0x1c
	.secrel32	.Ldebug_ranges0+0x410
	.uleb128 0x1d
	.long	0x214f
	.byte	0
	.byte	0
	.uleb128 0x1a
	.long	0x20ea
	.quad	.LBB204
	.secrel32	.Ldebug_ranges0+0x440
	.byte	0x4
	.word	0x21f
	.long	0xebe
	.uleb128 0x1b
	.long	0x210c
	.secrel32	.LLST146
	.uleb128 0x1b
	.long	0x20fe
	.secrel32	.LLST147
	.uleb128 0x1c
	.secrel32	.Ldebug_ranges0+0x440
	.uleb128 0x1d
	.long	0x214f
	.byte	0
	.byte	0
	.uleb128 0x1e
	.long	0x20ea
	.quad	.LBB208
	.quad	.LBE208-.LBB208
	.byte	0x4
	.word	0x223
	.long	0xf04
	.uleb128 0x1b
	.long	0x210c
	.secrel32	.LLST148
	.uleb128 0x1b
	.long	0x20fe
	.secrel32	.LLST149
	.uleb128 0x1f
	.quad	.LBB209
	.quad	.LBE209-.LBB209
	.uleb128 0x1d
	.long	0x214f
	.byte	0
	.byte	0
	.uleb128 0x1e
	.long	0x20ea
	.quad	.LBB210
	.quad	.LBE210-.LBB210
	.byte	0x4
	.word	0x227
	.long	0xf4a
	.uleb128 0x1b
	.long	0x210c
	.secrel32	.LLST150
	.uleb128 0x1b
	.long	0x20fe
	.secrel32	.LLST151
	.uleb128 0x1f
	.quad	.LBB211
	.quad	.LBE211-.LBB211
	.uleb128 0x1d
	.long	0x214f
	.byte	0
	.byte	0
	.uleb128 0x1e
	.long	0x20ea
	.quad	.LBB212
	.quad	.LBE212-.LBB212
	.byte	0x4
	.word	0x232
	.long	0xf90
	.uleb128 0x1b
	.long	0x210c
	.secrel32	.LLST152
	.uleb128 0x1b
	.long	0x20fe
	.secrel32	.LLST153
	.uleb128 0x1f
	.quad	.LBB213
	.quad	.LBE213-.LBB213
	.uleb128 0x1d
	.long	0x214f
	.byte	0
	.byte	0
	.uleb128 0x1a
	.long	0x20ea
	.quad	.LBB214
	.secrel32	.Ldebug_ranges0+0x470
	.byte	0x4
	.word	0x234
	.long	0xfc6
	.uleb128 0x1b
	.long	0x210c
	.secrel32	.LLST154
	.uleb128 0x1b
	.long	0x20fe
	.secrel32	.LLST155
	.uleb128 0x1c
	.secrel32	.Ldebug_ranges0+0x470
	.uleb128 0x1d
	.long	0x214f
	.byte	0
	.byte	0
	.uleb128 0x1a
	.long	0x20ea
	.quad	.LBB217
	.secrel32	.Ldebug_ranges0+0x4a0
	.byte	0x4
	.word	0x235
	.long	0xffc
	.uleb128 0x1b
	.long	0x210c
	.secrel32	.LLST156
	.uleb128 0x1b
	.long	0x20fe
	.secrel32	.LLST157
	.uleb128 0x1c
	.secrel32	.Ldebug_ranges0+0x4a0
	.uleb128 0x1d
	.long	0x214f
	.byte	0
	.byte	0
	.uleb128 0x1a
	.long	0x20ea
	.quad	.LBB222
	.secrel32	.Ldebug_ranges0+0x4d0
	.byte	0x4
	.word	0x236
	.long	0x1032
	.uleb128 0x1b
	.long	0x210c
	.secrel32	.LLST158
	.uleb128 0x1b
	.long	0x20fe
	.secrel32	.LLST159
	.uleb128 0x1c
	.secrel32	.Ldebug_ranges0+0x4d0
	.uleb128 0x1d
	.long	0x214f
	.byte	0
	.byte	0
	.uleb128 0x1a
	.long	0x20ea
	.quad	.LBB226
	.secrel32	.Ldebug_ranges0+0x500
	.byte	0x4
	.word	0x23a
	.long	0x1068
	.uleb128 0x1b
	.long	0x210c
	.secrel32	.LLST160
	.uleb128 0x1b
	.long	0x20fe
	.secrel32	.LLST161
	.uleb128 0x1c
	.secrel32	.Ldebug_ranges0+0x500
	.uleb128 0x1d
	.long	0x214f
	.byte	0
	.byte	0
	.uleb128 0x1a
	.long	0x20ea
	.quad	.LBB231
	.secrel32	.Ldebug_ranges0+0x540
	.byte	0x4
	.word	0x23d
	.long	0x109e
	.uleb128 0x1b
	.long	0x210c
	.secrel32	.LLST162
	.uleb128 0x1b
	.long	0x20fe
	.secrel32	.LLST163
	.uleb128 0x1c
	.secrel32	.Ldebug_ranges0+0x540
	.uleb128 0x1d
	.long	0x214f
	.byte	0
	.byte	0
	.uleb128 0x1e
	.long	0x20ea
	.quad	.LBB236
	.quad	.LBE236-.LBB236
	.byte	0x4
	.word	0x240
	.long	0x10e4
	.uleb128 0x1b
	.long	0x210c
	.secrel32	.LLST164
	.uleb128 0x1b
	.long	0x20fe
	.secrel32	.LLST165
	.uleb128 0x1f
	.quad	.LBB237
	.quad	.LBE237-.LBB237
	.uleb128 0x1d
	.long	0x214f
	.byte	0
	.byte	0
	.uleb128 0x1e
	.long	0x2068
	.quad	.LBB238
	.quad	.LBE238-.LBB238
	.byte	0x4
	.word	0x241
	.long	0x1133
	.uleb128 0x1b
	.long	0x208e
	.secrel32	.LLST166
	.uleb128 0x1b
	.long	0x2083
	.secrel32	.LLST167
	.uleb128 0x1b
	.long	0x2077
	.secrel32	.LLST168
	.uleb128 0x1f
	.quad	.LBB239
	.quad	.LBE239-.LBB239
	.uleb128 0x1d
	.long	0x21d0
	.byte	0
	.byte	0
	.uleb128 0x1a
	.long	0x20ea
	.quad	.LBB240
	.secrel32	.Ldebug_ranges0+0x570
	.byte	0x4
	.word	0x252
	.long	0x1169
	.uleb128 0x1b
	.long	0x210c
	.secrel32	.LLST169
	.uleb128 0x1b
	.long	0x20fe
	.secrel32	.LLST170
	.uleb128 0x1c
	.secrel32	.Ldebug_ranges0+0x570
	.uleb128 0x1d
	.long	0x214f
	.byte	0
	.byte	0
	.uleb128 0x1a
	.long	0x20ea
	.quad	.LBB244
	.secrel32	.Ldebug_ranges0+0x5a0
	.byte	0x4
	.word	0x25e
	.long	0x119f
	.uleb128 0x1b
	.long	0x210c
	.secrel32	.LLST171
	.uleb128 0x1b
	.long	0x20fe
	.secrel32	.LLST172
	.uleb128 0x1c
	.secrel32	.Ldebug_ranges0+0x5a0
	.uleb128 0x1d
	.long	0x214f
	.byte	0
	.byte	0
	.uleb128 0x1e
	.long	0x20ea
	.quad	.LBB250
	.quad	.LBE250-.LBB250
	.byte	0x4
	.word	0x263
	.long	0x11e5
	.uleb128 0x1b
	.long	0x210c
	.secrel32	.LLST173
	.uleb128 0x1b
	.long	0x20fe
	.secrel32	.LLST174
	.uleb128 0x1f
	.quad	.LBB251
	.quad	.LBE251-.LBB251
	.uleb128 0x1d
	.long	0x214f
	.byte	0
	.byte	0
	.uleb128 0x1e
	.long	0x20ea
	.quad	.LBB252
	.quad	.LBE252-.LBB252
	.byte	0x4
	.word	0x26f
	.long	0x1230
	.uleb128 0x20
	.long	0x210c
	.uleb128 0xa
	.byte	0x3
	.quad	.LC36
	.byte	0x9f
	.uleb128 0x20
	.long	0x20fe
	.uleb128 0x1
	.byte	0x55
	.uleb128 0x1f
	.quad	.LBB253
	.quad	.LBE253-.LBB253
	.uleb128 0x1d
	.long	0x214f
	.byte	0
	.byte	0
	.uleb128 0x21
	.quad	.LVL301
	.long	0x18c5
	.long	0x124f
	.uleb128 0x22
	.uleb128 0x1
	.byte	0x52
	.uleb128 0x9
	.byte	0x3
	.quad	.LC22
	.byte	0
	.uleb128 0x21
	.quad	.LVL306
	.long	0x1a09
	.long	0x1278
	.uleb128 0x22
	.uleb128 0x1
	.byte	0x52
	.uleb128 0x2
	.byte	0x75
	.sleb128 0
	.uleb128 0x22
	.uleb128 0x1
	.byte	0x51
	.uleb128 0x1
	.byte	0x3e
	.uleb128 0x22
	.uleb128 0x1
	.byte	0x58
	.uleb128 0x3
	.byte	0xa
	.word	0x320
	.uleb128 0x22
	.uleb128 0x1
	.byte	0x59
	.uleb128 0x1
	.byte	0x3e
	.byte	0
	.uleb128 0x21
	.quad	.LVL308
	.long	0x1795
	.long	0x1299
	.uleb128 0x22
	.uleb128 0x1
	.byte	0x52
	.uleb128 0x5
	.byte	0xc
	.long	0x499602d2
	.uleb128 0x22
	.uleb128 0x1
	.byte	0x51
	.uleb128 0x2
	.byte	0x8
	.byte	0x64
	.byte	0
	.uleb128 0x23
	.quad	.LVL310
	.long	0x14e1
	.uleb128 0x21
	.quad	.LVL312
	.long	0x1795
	.long	0x12c7
	.uleb128 0x22
	.uleb128 0x1
	.byte	0x52
	.uleb128 0x5
	.byte	0xc
	.long	0x499602d2
	.uleb128 0x22
	.uleb128 0x1
	.byte	0x51
	.uleb128 0x2
	.byte	0x8
	.byte	0x64
	.byte	0
	.uleb128 0x21
	.quad	.LVL313
	.long	0x18c5
	.long	0x12e6
	.uleb128 0x22
	.uleb128 0x1
	.byte	0x52
	.uleb128 0x9
	.byte	0x3
	.quad	.LC26
	.byte	0
	.uleb128 0x23
	.quad	.LVL330
	.long	0x14e1
	.uleb128 0x21
	.quad	.LVL336
	.long	0x1669
	.long	0x1329
	.uleb128 0x22
	.uleb128 0x1
	.byte	0x52
	.uleb128 0x2
	.byte	0x75
	.sleb128 0
	.uleb128 0x22
	.uleb128 0x1
	.byte	0x51
	.uleb128 0x2
	.byte	0x75
	.sleb128 0
	.uleb128 0x22
	.uleb128 0x1
	.byte	0x58
	.uleb128 0x4
	.byte	0x91
	.sleb128 -128
	.byte	0x6
	.uleb128 0x22
	.uleb128 0x1
	.byte	0x59
	.uleb128 0x4
	.byte	0x91
	.sleb128 -128
	.byte	0x6
	.uleb128 0x22
	.uleb128 0x2
	.byte	0x77
	.sleb128 32
	.uleb128 0x3
	.byte	0xa
	.word	0x37ff
	.byte	0
	.uleb128 0x21
	.quad	.LVL341
	.long	0x13fe
	.long	0x134d
	.uleb128 0x22
	.uleb128 0x1
	.byte	0x52
	.uleb128 0x2
	.byte	0x7d
	.sleb128 0
	.uleb128 0x22
	.uleb128 0x1
	.byte	0x58
	.uleb128 0x2
	.byte	0x7f
	.sleb128 0
	.uleb128 0x22
	.uleb128 0x1
	.byte	0x59
	.uleb128 0x2
	.byte	0x76
	.sleb128 0
	.byte	0
	.uleb128 0x21
	.quad	.LVL342
	.long	0x18c5
	.long	0x1365
	.uleb128 0x22
	.uleb128 0x1
	.byte	0x52
	.uleb128 0x2
	.byte	0x7c
	.sleb128 0
	.byte	0
	.uleb128 0x21
	.quad	.LVL343
	.long	0x1795
	.long	0x1383
	.uleb128 0x22
	.uleb128 0x1
	.byte	0x52
	.uleb128 0x2
	.byte	0x74
	.sleb128 0
	.uleb128 0x22
	.uleb128 0x1
	.byte	0x51
	.uleb128 0x2
	.byte	0x8
	.byte	0x64
	.byte	0
	.uleb128 0x23
	.quad	.LVL344
	.long	0x14e1
	.byte	0
	.uleb128 0x24
	.ascii "video_print_callback\0"
	.byte	0x4
	.word	0x1be
	.quad	.LFB28
	.quad	.LFE28-.LFB28
	.uleb128 0x1
	.byte	0x9c
	.long	0x13fe
	.uleb128 0x25
	.ascii "guid\0"
	.byte	0x4
	.word	0x1be
	.long	0x417
	.uleb128 0x2
	.byte	0x72
	.sleb128 0
	.uleb128 0x26
	.ascii "params\0"
	.byte	0x4
	.word	0x1be
	.long	0x676
	.secrel32	.LLST82
	.uleb128 0x23
	.quad	.LVL247
	.long	0x18c5
	.uleb128 0x27
	.quad	.LVL248
	.long	0x14e1
	.byte	0
	.uleb128 0x24
	.ascii "copy_rect\0"
	.byte	0x4
	.word	0x1b5
	.quad	.LFB27
	.quad	.LFE27-.LFB27
	.uleb128 0x1
	.byte	0x9c
	.long	0x14e1
	.uleb128 0x26
	.ascii "dst_rect\0"
	.byte	0x4
	.word	0x1b5
	.long	0x800
	.secrel32	.LLST83
	.uleb128 0x26
	.ascii "dst\0"
	.byte	0x4
	.word	0x1b5
	.long	0x47d
	.secrel32	.LLST84
	.uleb128 0x26
	.ascii "src_rect\0"
	.byte	0x4
	.word	0x1b5
	.long	0x800
	.secrel32	.LLST85
	.uleb128 0x26
	.ascii "src\0"
	.byte	0x4
	.word	0x1b5
	.long	0x47d
	.secrel32	.LLST86
	.uleb128 0x15
	.ascii "x\0"
	.byte	0x4
	.word	0x1b6
	.long	0xd9
	.uleb128 0x14
	.ascii "y\0"
	.byte	0x4
	.word	0x1b6
	.long	0xd9
	.secrel32	.LLST87
	.uleb128 0x18
	.ascii "ci\0"
	.byte	0x4
	.word	0x1b6
	.long	0xd9
	.byte	0
	.uleb128 0x28
	.long	0x20a4
	.quad	.LBB120
	.quad	.LBE120-.LBB120
	.byte	0x4
	.word	0x1b8
	.uleb128 0x1b
	.long	0x20ca
	.secrel32	.LLST88
	.uleb128 0x1b
	.long	0x20bf
	.secrel32	.LLST89
	.uleb128 0x1b
	.long	0x20b3
	.secrel32	.LLST90
	.uleb128 0x1f
	.quad	.LBB121
	.quad	.LBE121-.LBB121
	.uleb128 0x1d
	.long	0x2189
	.uleb128 0x1d
	.long	0x2192
	.byte	0
	.byte	0
	.byte	0
	.uleb128 0x13
	.ascii "show_video_buffer\0"
	.byte	0x4
	.word	0x135
	.quad	.LFB26
	.quad	.LFE26-.LFB26
	.uleb128 0x1
	.byte	0x9c
	.long	0x1573
	.uleb128 0x14
	.ascii "i\0"
	.byte	0x4
	.word	0x136
	.long	0xd9
	.secrel32	.LLST81
	.uleb128 0x16
	.ascii "sizeofbuffer\0"
	.byte	0x4
	.word	0x139
	.long	0xd9
	.long	0xea600
	.uleb128 0x19
	.ascii "vb_bg\0"
	.byte	0x4
	.word	0x13b
	.long	0x676
	.uleb128 0x9
	.byte	0x3
	.quad	video_bg_buffer
	.uleb128 0x19
	.ascii "vb\0"
	.byte	0x4
	.word	0x13c
	.long	0x676
	.uleb128 0x9
	.byte	0x3
	.quad	video_buffer
	.uleb128 0x19
	.ascii "vb_tmp\0"
	.byte	0x4
	.word	0x13d
	.long	0x676
	.uleb128 0x1
	.byte	0x58
	.byte	0
	.uleb128 0x13
	.ascii "make_blur\0"
	.byte	0x4
	.word	0x128
	.quad	.LFB25
	.quad	.LFE25-.LFB25
	.uleb128 0x1
	.byte	0x9c
	.long	0x15df
	.uleb128 0x14
	.ascii "i\0"
	.byte	0x4
	.word	0x129
	.long	0xd9
	.secrel32	.LLST80
	.uleb128 0x19
	.ascii "vb\0"
	.byte	0x4
	.word	0x12a
	.long	0x676
	.uleb128 0x9
	.byte	0x3
	.quad	video_buffer
	.uleb128 0x19
	.ascii "m\0"
	.byte	0x4
	.word	0x12b
	.long	0x47d
	.uleb128 0xa
	.byte	0x3
	.quad	.LC4
	.byte	0x9f
	.uleb128 0x16
	.ascii "mm\0"
	.byte	0x4
	.word	0x12d
	.long	0xd9
	.long	0x3a980
	.byte	0
	.uleb128 0x24
	.ascii "put_pixel_callback\0"
	.byte	0x4
	.word	0x120
	.quad	.LFB24
	.quad	.LFE24-.LFB24
	.uleb128 0x1
	.byte	0x9c
	.long	0x1669
	.uleb128 0x25
	.ascii "guid\0"
	.byte	0x4
	.word	0x120
	.long	0x417
	.uleb128 0x2
	.byte	0x72
	.sleb128 0
	.uleb128 0x26
	.ascii "params\0"
	.byte	0x4
	.word	0x120
	.long	0x676
	.secrel32	.LLST79
	.uleb128 0x15
	.ascii "r\0"
	.byte	0x4
	.word	0x121
	.long	0x6fd
	.uleb128 0x29
	.quad	.LVL239
	.long	0x1669
	.uleb128 0x22
	.uleb128 0x1
	.byte	0x52
	.uleb128 0x2
	.byte	0x8
	.byte	0xc8
	.uleb128 0x22
	.uleb128 0x1
	.byte	0x51
	.uleb128 0x2
	.byte	0x8
	.byte	0xc8
	.uleb128 0x22
	.uleb128 0x1
	.byte	0x58
	.uleb128 0x3
	.byte	0xa
	.word	0x190
	.uleb128 0x22
	.uleb128 0x1
	.byte	0x59
	.uleb128 0x3
	.byte	0xa
	.word	0x190
	.uleb128 0x22
	.uleb128 0x2
	.byte	0x77
	.sleb128 32
	.uleb128 0x2
	.byte	0x8
	.byte	0x80
	.byte	0
	.byte	0
	.uleb128 0x24
	.ascii "put_box\0"
	.byte	0x4
	.word	0x119
	.quad	.LFB23
	.quad	.LFE23-.LFB23
	.uleb128 0x1
	.byte	0x9c
	.long	0x1795
	.uleb128 0x26
	.ascii "x0\0"
	.byte	0x4
	.word	0x119
	.long	0xd9
	.secrel32	.LLST74
	.uleb128 0x26
	.ascii "y0\0"
	.byte	0x4
	.word	0x119
	.long	0xd9
	.secrel32	.LLST75
	.uleb128 0x26
	.ascii "x1\0"
	.byte	0x4
	.word	0x119
	.long	0xd9
	.secrel32	.LLST76
	.uleb128 0x26
	.ascii "y1\0"
	.byte	0x4
	.word	0x119
	.long	0xd9
	.secrel32	.LLST77
	.uleb128 0x26
	.ascii "col\0"
	.byte	0x4
	.word	0x119
	.long	0x6fd
	.secrel32	.LLST78
	.uleb128 0x21
	.quad	.LVL228
	.long	0x1a09
	.long	0x1708
	.uleb128 0x22
	.uleb128 0x1
	.byte	0x52
	.uleb128 0x2
	.byte	0x73
	.sleb128 0
	.uleb128 0x22
	.uleb128 0x1
	.byte	0x51
	.uleb128 0x2
	.byte	0x7c
	.sleb128 0
	.uleb128 0x22
	.uleb128 0x1
	.byte	0x58
	.uleb128 0x2
	.byte	0x75
	.sleb128 0
	.uleb128 0x22
	.uleb128 0x1
	.byte	0x59
	.uleb128 0x2
	.byte	0x7c
	.sleb128 0
	.uleb128 0x22
	.uleb128 0x2
	.byte	0x77
	.sleb128 32
	.uleb128 0x2
	.byte	0x76
	.sleb128 0
	.byte	0
	.uleb128 0x21
	.quad	.LVL229
	.long	0x1a09
	.long	0x1739
	.uleb128 0x22
	.uleb128 0x1
	.byte	0x52
	.uleb128 0x2
	.byte	0x75
	.sleb128 0
	.uleb128 0x22
	.uleb128 0x1
	.byte	0x51
	.uleb128 0x2
	.byte	0x7c
	.sleb128 0
	.uleb128 0x22
	.uleb128 0x1
	.byte	0x58
	.uleb128 0x2
	.byte	0x75
	.sleb128 0
	.uleb128 0x22
	.uleb128 0x1
	.byte	0x59
	.uleb128 0x2
	.byte	0x74
	.sleb128 0
	.uleb128 0x22
	.uleb128 0x2
	.byte	0x77
	.sleb128 32
	.uleb128 0x2
	.byte	0x76
	.sleb128 0
	.byte	0
	.uleb128 0x21
	.quad	.LVL230
	.long	0x1a09
	.long	0x176a
	.uleb128 0x22
	.uleb128 0x1
	.byte	0x52
	.uleb128 0x2
	.byte	0x73
	.sleb128 0
	.uleb128 0x22
	.uleb128 0x1
	.byte	0x51
	.uleb128 0x2
	.byte	0x7c
	.sleb128 0
	.uleb128 0x22
	.uleb128 0x1
	.byte	0x58
	.uleb128 0x2
	.byte	0x73
	.sleb128 0
	.uleb128 0x22
	.uleb128 0x1
	.byte	0x59
	.uleb128 0x2
	.byte	0x74
	.sleb128 0
	.uleb128 0x22
	.uleb128 0x2
	.byte	0x77
	.sleb128 32
	.uleb128 0x2
	.byte	0x76
	.sleb128 0
	.byte	0
	.uleb128 0x2a
	.quad	.LVL236
	.long	0x1a09
	.uleb128 0x22
	.uleb128 0x1
	.byte	0x52
	.uleb128 0x3
	.byte	0xf3
	.uleb128 0x1
	.byte	0x52
	.uleb128 0x22
	.uleb128 0x1
	.byte	0x51
	.uleb128 0x3
	.byte	0xf3
	.uleb128 0x1
	.byte	0x59
	.uleb128 0x22
	.uleb128 0x1
	.byte	0x58
	.uleb128 0x3
	.byte	0xf3
	.uleb128 0x1
	.byte	0x58
	.uleb128 0x22
	.uleb128 0x1
	.byte	0x59
	.uleb128 0x3
	.byte	0xf3
	.uleb128 0x1
	.byte	0x59
	.byte	0
	.byte	0
	.uleb128 0x2b
	.ascii "put_number\0"
	.byte	0x4
	.byte	0xed
	.quad	.LFB22
	.quad	.LFE22-.LFB22
	.uleb128 0x1
	.byte	0x9c
	.long	0x18be
	.uleb128 0x2c
	.ascii "n\0"
	.byte	0x4
	.byte	0xed
	.long	0xe3
	.secrel32	.LLST65
	.uleb128 0x2c
	.ascii "type\0"
	.byte	0x4
	.byte	0xed
	.long	0x371
	.secrel32	.LLST66
	.uleb128 0x2d
	.ascii "i\0"
	.byte	0x4
	.byte	0xee
	.long	0x18be
	.secrel32	.LLST67
	.uleb128 0x2e
	.ascii "hh\0"
	.byte	0x4
	.byte	0xef
	.long	0x36b
	.uleb128 0xa
	.byte	0x3
	.quad	.LC1
	.byte	0x9f
	.uleb128 0x2d
	.ascii "nn\0"
	.byte	0x4
	.byte	0xf0
	.long	0xd9
	.secrel32	.LLST68
	.uleb128 0x2d
	.ascii "kbuf\0"
	.byte	0x4
	.byte	0xf4
	.long	0x47d
	.secrel32	.LLST69
	.uleb128 0x2f
	.long	0x20ea
	.quad	.LBB112
	.secrel32	.Ldebug_ranges0+0xf0
	.byte	0x4
	.byte	0xf4
	.long	0x184b
	.uleb128 0x1b
	.long	0x210c
	.secrel32	.LLST70
	.uleb128 0x1b
	.long	0x20fe
	.secrel32	.LLST71
	.uleb128 0x1c
	.secrel32	.Ldebug_ranges0+0xf0
	.uleb128 0x1d
	.long	0x214f
	.byte	0
	.byte	0
	.uleb128 0x1e
	.long	0x20ea
	.quad	.LBB118
	.quad	.LBE118-.LBB118
	.byte	0x4
	.word	0x116
	.long	0x1891
	.uleb128 0x1b
	.long	0x210c
	.secrel32	.LLST72
	.uleb128 0x1b
	.long	0x20fe
	.secrel32	.LLST73
	.uleb128 0x1f
	.quad	.LBB119
	.quad	.LBE119-.LBB119
	.uleb128 0x1d
	.long	0x214f
	.byte	0
	.byte	0
	.uleb128 0x21
	.quad	.LVL203
	.long	0x18c5
	.long	0x18b0
	.uleb128 0x22
	.uleb128 0x1
	.byte	0x52
	.uleb128 0x9
	.byte	0x3
	.quad	.LC2
	.byte	0
	.uleb128 0x23
	.quad	.LVL205
	.long	0x18c5
	.byte	0
	.uleb128 0x4
	.byte	0x4
	.byte	0x5
	.ascii "int\0"
	.uleb128 0x2b
	.ascii "put_string\0"
	.byte	0x4
	.byte	0xd3
	.quad	.LFB21
	.quad	.LFE21-.LFB21
	.uleb128 0x1
	.byte	0x9c
	.long	0x1913
	.uleb128 0x2c
	.ascii "str\0"
	.byte	0x4
	.byte	0xd3
	.long	0x47d
	.secrel32	.LLST63
	.uleb128 0x2d
	.ascii "i\0"
	.byte	0x4
	.byte	0xd4
	.long	0xd9
	.secrel32	.LLST64
	.uleb128 0x23
	.quad	.LVL192
	.long	0x1913
	.byte	0
	.uleb128 0x2b
	.ascii "put_char\0"
	.byte	0x4
	.byte	0xb4
	.quad	.LFB20
	.quad	.LFE20-.LFB20
	.uleb128 0x1
	.byte	0x9c
	.long	0x1a09
	.uleb128 0x2c
	.ascii "x\0"
	.byte	0x4
	.byte	0xb4
	.long	0xd9
	.secrel32	.LLST54
	.uleb128 0x2c
	.ascii "y\0"
	.byte	0x4
	.byte	0xb4
	.long	0xd9
	.secrel32	.LLST55
	.uleb128 0x2c
	.ascii "s\0"
	.byte	0x4
	.byte	0xb4
	.long	0x7a
	.secrel32	.LLST56
	.uleb128 0x2e
	.ascii "textcolor\0"
	.byte	0x4
	.byte	0xb5
	.long	0x6fd
	.uleb128 0x7
	.byte	0x9
	.byte	0x80
	.byte	0x9f
	.byte	0x93
	.uleb128 0x1
	.byte	0x93
	.uleb128 0x1
	.uleb128 0x2d
	.ascii "bit\0"
	.byte	0x4
	.byte	0xb8
	.long	0x7a
	.secrel32	.LLST57
	.uleb128 0x2e
	.ascii "bitmask\0"
	.byte	0x4
	.byte	0xb9
	.long	0x7a
	.uleb128 0x1
	.byte	0x59
	.uleb128 0x2d
	.ascii "pos\0"
	.byte	0x4
	.byte	0xbb
	.long	0xd9
	.secrel32	.LLST58
	.uleb128 0x2d
	.ascii "xx\0"
	.byte	0x4
	.byte	0xbc
	.long	0xd9
	.secrel32	.LLST59
	.uleb128 0x30
	.ascii "yy\0"
	.byte	0x4
	.byte	0xbc
	.long	0xd9
	.uleb128 0x2d
	.ascii "i\0"
	.byte	0x4
	.byte	0xbe
	.long	0xd9
	.secrel32	.LLST60
	.uleb128 0x2d
	.ascii "j\0"
	.byte	0x4
	.byte	0xbf
	.long	0xd9
	.secrel32	.LLST61
	.uleb128 0x31
	.long	0x1c3b
	.quad	.LBB108
	.secrel32	.Ldebug_ranges0+0xc0
	.byte	0x4
	.byte	0xc7
	.uleb128 0x1b
	.long	0x1c5f
	.secrel32	.LLST62
	.uleb128 0x32
	.long	0x1c56
	.uleb128 0x32
	.long	0x1c4d
	.uleb128 0x1c
	.secrel32	.Ldebug_ranges0+0xc0
	.uleb128 0x1d
	.long	0x2206
	.byte	0
	.byte	0
	.byte	0
	.uleb128 0x2b
	.ascii "put_line\0"
	.byte	0x4
	.byte	0x31
	.quad	.LFB19
	.quad	.LFE19-.LFB19
	.uleb128 0x1
	.byte	0x9c
	.long	0x1bcb
	.uleb128 0x2c
	.ascii "x1\0"
	.byte	0x4
	.byte	0x31
	.long	0x18be
	.secrel32	.LLST32
	.uleb128 0x2c
	.ascii "y1\0"
	.byte	0x4
	.byte	0x31
	.long	0x18be
	.secrel32	.LLST33
	.uleb128 0x2c
	.ascii "x2\0"
	.byte	0x4
	.byte	0x31
	.long	0x18be
	.secrel32	.LLST34
	.uleb128 0x2c
	.ascii "y2\0"
	.byte	0x4
	.byte	0x31
	.long	0x18be
	.secrel32	.LLST35
	.uleb128 0x2c
	.ascii "nState\0"
	.byte	0x4
	.byte	0x31
	.long	0x6fd
	.secrel32	.LLST36
	.uleb128 0x2d
	.ascii "nTmp\0"
	.byte	0x4
	.byte	0x33
	.long	0x1bcb
	.secrel32	.LLST37
	.uleb128 0x2d
	.ascii "nAlt\0"
	.byte	0x4
	.byte	0x34
	.long	0x1bcb
	.secrel32	.LLST38
	.uleb128 0x2d
	.ascii "x\0"
	.byte	0x4
	.byte	0x35
	.long	0x18be
	.secrel32	.LLST39
	.uleb128 0x2d
	.ascii "y\0"
	.byte	0x4
	.byte	0x35
	.long	0x18be
	.secrel32	.LLST40
	.uleb128 0x2d
	.ascii "dx\0"
	.byte	0x4
	.byte	0x36
	.long	0x18be
	.secrel32	.LLST41
	.uleb128 0x2d
	.ascii "dy\0"
	.byte	0x4
	.byte	0x37
	.long	0x18be
	.secrel32	.LLST42
	.uleb128 0x2d
	.ascii "StepVal\0"
	.byte	0x4
	.byte	0x38
	.long	0x18be
	.secrel32	.LLST43
	.uleb128 0x2f
	.long	0x1c3b
	.quad	.LBB92
	.secrel32	.Ldebug_ranges0+0
	.byte	0x4
	.byte	0x8d
	.long	0x1b1c
	.uleb128 0x1b
	.long	0x1c5f
	.secrel32	.LLST44
	.uleb128 0x1b
	.long	0x1c56
	.secrel32	.LLST45
	.uleb128 0x1b
	.long	0x1c4d
	.secrel32	.LLST46
	.uleb128 0x1c
	.secrel32	.Ldebug_ranges0+0
	.uleb128 0x1d
	.long	0x2206
	.byte	0
	.byte	0
	.uleb128 0x2f
	.long	0x1c3b
	.quad	.LBB96
	.secrel32	.Ldebug_ranges0+0x30
	.byte	0x4
	.byte	0x9f
	.long	0x1b56
	.uleb128 0x1b
	.long	0x1c5f
	.secrel32	.LLST47
	.uleb128 0x32
	.long	0x1c56
	.uleb128 0x1b
	.long	0x1c4d
	.secrel32	.LLST48
	.uleb128 0x1c
	.secrel32	.Ldebug_ranges0+0x30
	.uleb128 0x1d
	.long	0x2206
	.byte	0
	.byte	0
	.uleb128 0x2f
	.long	0x1c3b
	.quad	.LBB100
	.secrel32	.Ldebug_ranges0+0x60
	.byte	0x4
	.byte	0x7b
	.long	0x1b90
	.uleb128 0x1b
	.long	0x1c5f
	.secrel32	.LLST49
	.uleb128 0x32
	.long	0x1c56
	.uleb128 0x1b
	.long	0x1c4d
	.secrel32	.LLST50
	.uleb128 0x1c
	.secrel32	.Ldebug_ranges0+0x60
	.uleb128 0x1d
	.long	0x2206
	.byte	0
	.byte	0
	.uleb128 0x31
	.long	0x1c3b
	.quad	.LBB104
	.secrel32	.Ldebug_ranges0+0x90
	.byte	0x4
	.byte	0x69
	.uleb128 0x1b
	.long	0x1c5f
	.secrel32	.LLST51
	.uleb128 0x1b
	.long	0x1c56
	.secrel32	.LLST52
	.uleb128 0x1b
	.long	0x1c4d
	.secrel32	.LLST53
	.uleb128 0x1c
	.secrel32	.Ldebug_ranges0+0x90
	.uleb128 0x1d
	.long	0x2206
	.byte	0
	.byte	0
	.byte	0
	.uleb128 0x4
	.byte	0x4
	.byte	0x7
	.ascii "unsigned int\0"
	.uleb128 0x33
	.ascii "get_pixel\0"
	.byte	0x4
	.byte	0x29
	.long	0x6fd
	.quad	.LFB18
	.quad	.LFE18-.LFB18
	.uleb128 0x1
	.byte	0x9c
	.long	0x1c3b
	.uleb128 0x2c
	.ascii "x\0"
	.byte	0x4
	.byte	0x29
	.long	0xd9
	.secrel32	.LLST28
	.uleb128 0x2c
	.ascii "y\0"
	.byte	0x4
	.byte	0x29
	.long	0xd9
	.secrel32	.LLST29
	.uleb128 0x34
	.secrel32	.LASF2
	.byte	0x4
	.byte	0x2a
	.long	0xd9
	.secrel32	.LLST30
	.uleb128 0x2d
	.ascii "ret\0"
	.byte	0x4
	.byte	0x2c
	.long	0x6fd
	.secrel32	.LLST31
	.byte	0
	.uleb128 0x35
	.ascii "put_pixel\0"
	.byte	0x4
	.byte	0x21
	.byte	0x1
	.long	0x1c76
	.uleb128 0x36
	.ascii "x\0"
	.byte	0x4
	.byte	0x21
	.long	0xd9
	.uleb128 0x36
	.ascii "y\0"
	.byte	0x4
	.byte	0x21
	.long	0xd9
	.uleb128 0x36
	.ascii "col\0"
	.byte	0x4
	.byte	0x21
	.long	0x6fd
	.uleb128 0x37
	.secrel32	.LASF2
	.byte	0x4
	.byte	0x25
	.long	0xd9
	.byte	0
	.uleb128 0x2b
	.ascii "outl\0"
	.byte	0x3
	.byte	0x18
	.quad	.LFB16
	.quad	.LFE16-.LFB16
	.uleb128 0x1
	.byte	0x9c
	.long	0x1cb1
	.uleb128 0x38
	.secrel32	.LASF3
	.byte	0x3
	.byte	0x18
	.long	0x9a
	.uleb128 0x1
	.byte	0x52
	.uleb128 0x39
	.secrel32	.LASF4
	.byte	0x3
	.byte	0x18
	.long	0xba
	.secrel32	.LLST25
	.byte	0
	.uleb128 0x2b
	.ascii "outw\0"
	.byte	0x3
	.byte	0x15
	.quad	.LFB15
	.quad	.LFE15-.LFB15
	.uleb128 0x1
	.byte	0x9c
	.long	0x1cec
	.uleb128 0x38
	.secrel32	.LASF3
	.byte	0x3
	.byte	0x15
	.long	0x9a
	.uleb128 0x1
	.byte	0x52
	.uleb128 0x39
	.secrel32	.LASF4
	.byte	0x3
	.byte	0x15
	.long	0x9a
	.secrel32	.LLST24
	.byte	0
	.uleb128 0x2b
	.ascii "outb\0"
	.byte	0x3
	.byte	0x12
	.quad	.LFB14
	.quad	.LFE14-.LFB14
	.uleb128 0x1
	.byte	0x9c
	.long	0x1d27
	.uleb128 0x38
	.secrel32	.LASF3
	.byte	0x3
	.byte	0x12
	.long	0x9a
	.uleb128 0x1
	.byte	0x52
	.uleb128 0x39
	.secrel32	.LASF4
	.byte	0x3
	.byte	0x12
	.long	0x7a
	.secrel32	.LLST23
	.byte	0
	.uleb128 0x33
	.ascii "inl\0"
	.byte	0x3
	.byte	0xd
	.long	0xba
	.quad	.LFB13
	.quad	.LFE13-.LFB13
	.uleb128 0x1
	.byte	0x9c
	.long	0x1d63
	.uleb128 0x38
	.secrel32	.LASF3
	.byte	0x3
	.byte	0xd
	.long	0x9a
	.uleb128 0x1
	.byte	0x52
	.uleb128 0x3a
	.secrel32	.LASF4
	.byte	0x3
	.byte	0xe
	.long	0xa4
	.uleb128 0x1
	.byte	0x50
	.byte	0
	.uleb128 0x33
	.ascii "inw\0"
	.byte	0x3
	.byte	0x8
	.long	0x9a
	.quad	.LFB12
	.quad	.LFE12-.LFB12
	.uleb128 0x1
	.byte	0x9c
	.long	0x1d9f
	.uleb128 0x38
	.secrel32	.LASF3
	.byte	0x3
	.byte	0x8
	.long	0x9a
	.uleb128 0x1
	.byte	0x52
	.uleb128 0x3a
	.secrel32	.LASF4
	.byte	0x3
	.byte	0x9
	.long	0xa4
	.uleb128 0x1
	.byte	0x50
	.byte	0
	.uleb128 0x33
	.ascii "inb\0"
	.byte	0x3
	.byte	0x3
	.long	0x7a
	.quad	.LFB11
	.quad	.LFE11-.LFB11
	.uleb128 0x1
	.byte	0x9c
	.long	0x1ddb
	.uleb128 0x38
	.secrel32	.LASF3
	.byte	0x3
	.byte	0x3
	.long	0x9a
	.uleb128 0x1
	.byte	0x52
	.uleb128 0x3a
	.secrel32	.LASF4
	.byte	0x3
	.byte	0x4
	.long	0x7a
	.uleb128 0x1
	.byte	0x50
	.byte	0
	.uleb128 0x33
	.ascii "str2hex\0"
	.byte	0x2
	.byte	0x74
	.long	0xd9
	.quad	.LFB10
	.quad	.LFE10-.LFB10
	.uleb128 0x1
	.byte	0x9c
	.long	0x1e35
	.uleb128 0x3b
	.ascii "str\0"
	.byte	0x2
	.byte	0x74
	.long	0x47d
	.uleb128 0x1
	.byte	0x52
	.uleb128 0x2d
	.ascii "i\0"
	.byte	0x2
	.byte	0x75
	.long	0x18be
	.secrel32	.LLST20
	.uleb128 0x2d
	.ascii "j\0"
	.byte	0x2
	.byte	0x76
	.long	0xd9
	.secrel32	.LLST21
	.uleb128 0x2d
	.ascii "k\0"
	.byte	0x2
	.byte	0x76
	.long	0xd9
	.secrel32	.LLST22
	.byte	0
	.uleb128 0x33
	.ascii "str2int\0"
	.byte	0x2
	.byte	0x64
	.long	0xd9
	.quad	.LFB9
	.quad	.LFE9-.LFB9
	.uleb128 0x1
	.byte	0x9c
	.long	0x1e8f
	.uleb128 0x3b
	.ascii "str\0"
	.byte	0x2
	.byte	0x64
	.long	0x47d
	.uleb128 0x1
	.byte	0x52
	.uleb128 0x2d
	.ascii "i\0"
	.byte	0x2
	.byte	0x65
	.long	0x18be
	.secrel32	.LLST17
	.uleb128 0x2d
	.ascii "j\0"
	.byte	0x2
	.byte	0x66
	.long	0xd9
	.secrel32	.LLST18
	.uleb128 0x2d
	.ascii "k\0"
	.byte	0x2
	.byte	0x66
	.long	0xd9
	.secrel32	.LLST19
	.byte	0
	.uleb128 0x33
	.ascii "strlen\0"
	.byte	0x2
	.byte	0x5c
	.long	0xd9
	.quad	.LFB8
	.quad	.LFE8-.LFB8
	.uleb128 0x1
	.byte	0x9c
	.long	0x1ed0
	.uleb128 0x2c
	.ascii "src\0"
	.byte	0x2
	.byte	0x5c
	.long	0x47d
	.secrel32	.LLST15
	.uleb128 0x2d
	.ascii "i\0"
	.byte	0x2
	.byte	0x5e
	.long	0xd9
	.secrel32	.LLST16
	.byte	0
	.uleb128 0x33
	.ascii "strchr\0"
	.byte	0x2
	.byte	0x50
	.long	0xd9
	.quad	.LFB7
	.quad	.LFE7-.LFB7
	.uleb128 0x1
	.byte	0x9c
	.long	0x1f1d
	.uleb128 0x3b
	.ascii "str\0"
	.byte	0x2
	.byte	0x50
	.long	0x47d
	.uleb128 0x1
	.byte	0x52
	.uleb128 0x2c
	.ascii "ch\0"
	.byte	0x2
	.byte	0x50
	.long	0x7a
	.secrel32	.LLST13
	.uleb128 0x2d
	.ascii "i\0"
	.byte	0x2
	.byte	0x52
	.long	0xd9
	.secrel32	.LLST14
	.byte	0
	.uleb128 0x33
	.ascii "strcat\0"
	.byte	0x2
	.byte	0x41
	.long	0x47d
	.quad	.LFB6
	.quad	.LFE6-.LFB6
	.uleb128 0x1
	.byte	0x9c
	.long	0x1f61
	.uleb128 0x2c
	.ascii "dest\0"
	.byte	0x2
	.byte	0x41
	.long	0x47d
	.secrel32	.LLST11
	.uleb128 0x2c
	.ascii "src\0"
	.byte	0x2
	.byte	0x41
	.long	0x1f61
	.secrel32	.LLST12
	.byte	0
	.uleb128 0x8
	.byte	0x8
	.long	0x84
	.uleb128 0x33
	.ascii "strncpy\0"
	.byte	0x2
	.byte	0x37
	.long	0x47d
	.quad	.LFB5
	.quad	.LFE5-.LFB5
	.uleb128 0x1
	.byte	0x9c
	.long	0x1fc4
	.uleb128 0x3b
	.ascii "dest\0"
	.byte	0x2
	.byte	0x37
	.long	0x47d
	.uleb128 0x1
	.byte	0x52
	.uleb128 0x3b
	.ascii "src\0"
	.byte	0x2
	.byte	0x37
	.long	0x1f61
	.uleb128 0x1
	.byte	0x51
	.uleb128 0x2c
	.ascii "len\0"
	.byte	0x2
	.byte	0x37
	.long	0xd9
	.secrel32	.LLST9
	.uleb128 0x2d
	.ascii "i\0"
	.byte	0x2
	.byte	0x39
	.long	0x18be
	.secrel32	.LLST10
	.byte	0
	.uleb128 0x33
	.ascii "strcpy\0"
	.byte	0x2
	.byte	0x2c
	.long	0x47d
	.quad	.LFB4
	.quad	.LFE4-.LFB4
	.uleb128 0x1
	.byte	0x9c
	.long	0x2008
	.uleb128 0x2c
	.ascii "dest\0"
	.byte	0x2
	.byte	0x2c
	.long	0x47d
	.secrel32	.LLST7
	.uleb128 0x2c
	.ascii "src\0"
	.byte	0x2
	.byte	0x2c
	.long	0x1f61
	.secrel32	.LLST8
	.byte	0
	.uleb128 0x33
	.ascii "strcmp\0"
	.byte	0x2
	.byte	0x17
	.long	0xd9
	.quad	.LFB3
	.quad	.LFE3-.LFB3
	.uleb128 0x1
	.byte	0x9c
	.long	0x2068
	.uleb128 0x3b
	.ascii "str1\0"
	.byte	0x2
	.byte	0x17
	.long	0x47d
	.uleb128 0x1
	.byte	0x52
	.uleb128 0x3b
	.ascii "str2\0"
	.byte	0x2
	.byte	0x17
	.long	0x47d
	.uleb128 0x1
	.byte	0x51
	.uleb128 0x2d
	.ascii "i\0"
	.byte	0x2
	.byte	0x19
	.long	0xd9
	.secrel32	.LLST5
	.uleb128 0x2d
	.ascii "failed\0"
	.byte	0x2
	.byte	0x1a
	.long	0xd9
	.secrel32	.LLST6
	.byte	0
	.uleb128 0x35
	.ascii "memset\0"
	.byte	0x2
	.byte	0xe
	.byte	0x1
	.long	0x20a4
	.uleb128 0x36
	.ascii "dest\0"
	.byte	0x2
	.byte	0xe
	.long	0x47d
	.uleb128 0x36
	.ascii "val\0"
	.byte	0x2
	.byte	0xe
	.long	0x7a
	.uleb128 0x36
	.ascii "len\0"
	.byte	0x2
	.byte	0xe
	.long	0xd9
	.uleb128 0x30
	.ascii "xs\0"
	.byte	0x2
	.byte	0x10
	.long	0x47d
	.byte	0
	.uleb128 0x35
	.ascii "memcpy\0"
	.byte	0x2
	.byte	0x4
	.byte	0x1
	.long	0x20ea
	.uleb128 0x36
	.ascii "dest\0"
	.byte	0x2
	.byte	0x4
	.long	0x47d
	.uleb128 0x36
	.ascii "src\0"
	.byte	0x2
	.byte	0x4
	.long	0x1f61
	.uleb128 0x36
	.ascii "len\0"
	.byte	0x2
	.byte	0x4
	.long	0xd9
	.uleb128 0x30
	.ascii "tmp\0"
	.byte	0x2
	.byte	0x6
	.long	0x47d
	.uleb128 0x30
	.ascii "s\0"
	.byte	0x2
	.byte	0x7
	.long	0x1f61
	.byte	0
	.uleb128 0x3c
	.ascii "syscall\0"
	.byte	0x1
	.byte	0x5
	.long	0xd9
	.byte	0x1
	.long	0x2124
	.uleb128 0x36
	.ascii "object\0"
	.byte	0x1
	.byte	0x5
	.long	0x2124
	.uleb128 0x36
	.ascii "func\0"
	.byte	0x1
	.byte	0x5
	.long	0x36b
	.uleb128 0x30
	.ascii "ret\0"
	.byte	0x1
	.byte	0x6
	.long	0xd9
	.byte	0
	.uleb128 0x3d
	.byte	0x8
	.uleb128 0x3e
	.long	0x20ea
	.quad	.LFB0
	.quad	.LFE0-.LFB0
	.uleb128 0x1
	.byte	0x9c
	.long	0x2157
	.uleb128 0x20
	.long	0x20fe
	.uleb128 0x1
	.byte	0x52
	.uleb128 0x20
	.long	0x210c
	.uleb128 0x1
	.byte	0x51
	.uleb128 0x3f
	.long	0x2118
	.uleb128 0x1
	.byte	0x50
	.byte	0
	.uleb128 0x3e
	.long	0x20a4
	.quad	.LFB1
	.quad	.LFE1-.LFB1
	.uleb128 0x1
	.byte	0x9c
	.long	0x219c
	.uleb128 0x20
	.long	0x20b3
	.uleb128 0x1
	.byte	0x52
	.uleb128 0x20
	.long	0x20bf
	.uleb128 0x1
	.byte	0x51
	.uleb128 0x1b
	.long	0x20ca
	.secrel32	.LLST0
	.uleb128 0x40
	.long	0x20d5
	.secrel32	.LLST1
	.uleb128 0x40
	.long	0x20e0
	.secrel32	.LLST2
	.byte	0
	.uleb128 0x3e
	.long	0x2068
	.quad	.LFB2
	.quad	.LFE2-.LFB2
	.uleb128 0x1
	.byte	0x9c
	.long	0x21d8
	.uleb128 0x1b
	.long	0x2077
	.secrel32	.LLST3
	.uleb128 0x20
	.long	0x2083
	.uleb128 0x1
	.byte	0x51
	.uleb128 0x1b
	.long	0x208e
	.secrel32	.LLST4
	.uleb128 0x3f
	.long	0x2099
	.uleb128 0x1
	.byte	0x52
	.byte	0
	.uleb128 0x41
	.long	0x1c3b
	.quad	.LFB17
	.quad	.LFE17-.LFB17
	.uleb128 0x1
	.byte	0x9c
	.uleb128 0x1b
	.long	0x1c4d
	.secrel32	.LLST26
	.uleb128 0x20
	.long	0x1c56
	.uleb128 0x1
	.byte	0x51
	.uleb128 0x20
	.long	0x1c5f
	.uleb128 0x1
	.byte	0x58
	.uleb128 0x40
	.long	0x1c6a
	.secrel32	.LLST27
	.byte	0
	.byte	0
	.section	.debug_abbrev,"dr"
.Ldebug_abbrev0:
	.uleb128 0x1
	.uleb128 0x11
	.byte	0x1
	.uleb128 0x25
	.uleb128 0x8
	.uleb128 0x13
	.uleb128 0xb
	.uleb128 0x3
	.uleb128 0x8
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x12
	.uleb128 0x7
	.uleb128 0x10
	.uleb128 0x17
	.byte	0
	.byte	0
	.uleb128 0x2
	.uleb128 0x16
	.byte	0
	.uleb128 0x3
	.uleb128 0x8
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x3
	.uleb128 0x26
	.byte	0
	.uleb128 0x49
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x4
	.uleb128 0x24
	.byte	0
	.uleb128 0xb
	.uleb128 0xb
	.uleb128 0x3e
	.uleb128 0xb
	.uleb128 0x3
	.uleb128 0x8
	.byte	0
	.byte	0
	.uleb128 0x5
	.uleb128 0x13
	.byte	0x1
	.uleb128 0xb
	.uleb128 0xb
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x6
	.uleb128 0xd
	.byte	0
	.uleb128 0x3
	.uleb128 0x8
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x38
	.uleb128 0xb
	.byte	0
	.byte	0
	.uleb128 0x7
	.uleb128 0x34
	.byte	0
	.uleb128 0x3
	.uleb128 0x8
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x3f
	.uleb128 0x19
	.uleb128 0x2
	.uleb128 0x18
	.byte	0
	.byte	0
	.uleb128 0x8
	.uleb128 0xf
	.byte	0
	.uleb128 0xb
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x9
	.uleb128 0x13
	.byte	0x1
	.uleb128 0x3
	.uleb128 0x8
	.uleb128 0xb
	.uleb128 0xb
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0xa
	.uleb128 0x34
	.byte	0
	.uleb128 0x3
	.uleb128 0x8
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x3f
	.uleb128 0x19
	.uleb128 0x3c
	.uleb128 0x19
	.byte	0
	.byte	0
	.uleb128 0xb
	.uleb128 0x13
	.byte	0x1
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0xb
	.uleb128 0xb
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0xc
	.uleb128 0xd
	.byte	0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x38
	.uleb128 0xb
	.byte	0
	.byte	0
	.uleb128 0xd
	.uleb128 0x1
	.byte	0x1
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0xe
	.uleb128 0x21
	.byte	0
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x2f
	.uleb128 0x5
	.byte	0
	.byte	0
	.uleb128 0xf
	.uleb128 0x21
	.byte	0
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x2f
	.uleb128 0xb
	.byte	0
	.byte	0
	.uleb128 0x10
	.uleb128 0x13
	.byte	0x1
	.uleb128 0x3
	.uleb128 0x8
	.uleb128 0xb
	.uleb128 0xb
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0x5
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x11
	.uleb128 0xd
	.byte	0
	.uleb128 0x3
	.uleb128 0x8
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0x5
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x38
	.uleb128 0xb
	.byte	0
	.byte	0
	.uleb128 0x12
	.uleb128 0x16
	.byte	0
	.uleb128 0x3
	.uleb128 0x8
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0x5
	.uleb128 0x49
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x13
	.uleb128 0x2e
	.byte	0x1
	.uleb128 0x3f
	.uleb128 0x19
	.uleb128 0x3
	.uleb128 0x8
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0x5
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x12
	.uleb128 0x7
	.uleb128 0x40
	.uleb128 0x18
	.uleb128 0x2117
	.uleb128 0x19
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x14
	.uleb128 0x34
	.byte	0
	.uleb128 0x3
	.uleb128 0x8
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0x5
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x2
	.uleb128 0x17
	.byte	0
	.byte	0
	.uleb128 0x15
	.uleb128 0x34
	.byte	0
	.uleb128 0x3
	.uleb128 0x8
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0x5
	.uleb128 0x49
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x16
	.uleb128 0x34
	.byte	0
	.uleb128 0x3
	.uleb128 0x8
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0x5
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x1c
	.uleb128 0x6
	.byte	0
	.byte	0
	.uleb128 0x17
	.uleb128 0x34
	.byte	0
	.uleb128 0x3
	.uleb128 0x8
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0x5
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x1c
	.uleb128 0x5
	.byte	0
	.byte	0
	.uleb128 0x18
	.uleb128 0x34
	.byte	0
	.uleb128 0x3
	.uleb128 0x8
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0x5
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x1c
	.uleb128 0xb
	.byte	0
	.byte	0
	.uleb128 0x19
	.uleb128 0x34
	.byte	0
	.uleb128 0x3
	.uleb128 0x8
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0x5
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x2
	.uleb128 0x18
	.byte	0
	.byte	0
	.uleb128 0x1a
	.uleb128 0x1d
	.byte	0x1
	.uleb128 0x31
	.uleb128 0x13
	.uleb128 0x52
	.uleb128 0x1
	.uleb128 0x55
	.uleb128 0x17
	.uleb128 0x58
	.uleb128 0xb
	.uleb128 0x59
	.uleb128 0x5
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x1b
	.uleb128 0x5
	.byte	0
	.uleb128 0x31
	.uleb128 0x13
	.uleb128 0x2
	.uleb128 0x17
	.byte	0
	.byte	0
	.uleb128 0x1c
	.uleb128 0xb
	.byte	0x1
	.uleb128 0x55
	.uleb128 0x17
	.byte	0
	.byte	0
	.uleb128 0x1d
	.uleb128 0x34
	.byte	0
	.uleb128 0x31
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x1e
	.uleb128 0x1d
	.byte	0x1
	.uleb128 0x31
	.uleb128 0x13
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x12
	.uleb128 0x7
	.uleb128 0x58
	.uleb128 0xb
	.uleb128 0x59
	.uleb128 0x5
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x1f
	.uleb128 0xb
	.byte	0x1
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x12
	.uleb128 0x7
	.byte	0
	.byte	0
	.uleb128 0x20
	.uleb128 0x5
	.byte	0
	.uleb128 0x31
	.uleb128 0x13
	.uleb128 0x2
	.uleb128 0x18
	.byte	0
	.byte	0
	.uleb128 0x21
	.uleb128 0x4109
	.byte	0x1
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x31
	.uleb128 0x13
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x22
	.uleb128 0x410a
	.byte	0
	.uleb128 0x2
	.uleb128 0x18
	.uleb128 0x2111
	.uleb128 0x18
	.byte	0
	.byte	0
	.uleb128 0x23
	.uleb128 0x4109
	.byte	0
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x31
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x24
	.uleb128 0x2e
	.byte	0x1
	.uleb128 0x3f
	.uleb128 0x19
	.uleb128 0x3
	.uleb128 0x8
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0x5
	.uleb128 0x27
	.uleb128 0x19
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x12
	.uleb128 0x7
	.uleb128 0x40
	.uleb128 0x18
	.uleb128 0x2117
	.uleb128 0x19
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x25
	.uleb128 0x5
	.byte	0
	.uleb128 0x3
	.uleb128 0x8
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0x5
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x2
	.uleb128 0x18
	.byte	0
	.byte	0
	.uleb128 0x26
	.uleb128 0x5
	.byte	0
	.uleb128 0x3
	.uleb128 0x8
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0x5
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x2
	.uleb128 0x17
	.byte	0
	.byte	0
	.uleb128 0x27
	.uleb128 0x4109
	.byte	0
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x2115
	.uleb128 0x19
	.uleb128 0x31
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x28
	.uleb128 0x1d
	.byte	0x1
	.uleb128 0x31
	.uleb128 0x13
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x12
	.uleb128 0x7
	.uleb128 0x58
	.uleb128 0xb
	.uleb128 0x59
	.uleb128 0x5
	.byte	0
	.byte	0
	.uleb128 0x29
	.uleb128 0x4109
	.byte	0x1
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x31
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x2a
	.uleb128 0x4109
	.byte	0x1
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x2115
	.uleb128 0x19
	.uleb128 0x31
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x2b
	.uleb128 0x2e
	.byte	0x1
	.uleb128 0x3f
	.uleb128 0x19
	.uleb128 0x3
	.uleb128 0x8
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x27
	.uleb128 0x19
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x12
	.uleb128 0x7
	.uleb128 0x40
	.uleb128 0x18
	.uleb128 0x2117
	.uleb128 0x19
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x2c
	.uleb128 0x5
	.byte	0
	.uleb128 0x3
	.uleb128 0x8
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x2
	.uleb128 0x17
	.byte	0
	.byte	0
	.uleb128 0x2d
	.uleb128 0x34
	.byte	0
	.uleb128 0x3
	.uleb128 0x8
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x2
	.uleb128 0x17
	.byte	0
	.byte	0
	.uleb128 0x2e
	.uleb128 0x34
	.byte	0
	.uleb128 0x3
	.uleb128 0x8
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x2
	.uleb128 0x18
	.byte	0
	.byte	0
	.uleb128 0x2f
	.uleb128 0x1d
	.byte	0x1
	.uleb128 0x31
	.uleb128 0x13
	.uleb128 0x52
	.uleb128 0x1
	.uleb128 0x55
	.uleb128 0x17
	.uleb128 0x58
	.uleb128 0xb
	.uleb128 0x59
	.uleb128 0xb
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x30
	.uleb128 0x34
	.byte	0
	.uleb128 0x3
	.uleb128 0x8
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x31
	.uleb128 0x1d
	.byte	0x1
	.uleb128 0x31
	.uleb128 0x13
	.uleb128 0x52
	.uleb128 0x1
	.uleb128 0x55
	.uleb128 0x17
	.uleb128 0x58
	.uleb128 0xb
	.uleb128 0x59
	.uleb128 0xb
	.byte	0
	.byte	0
	.uleb128 0x32
	.uleb128 0x5
	.byte	0
	.uleb128 0x31
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x33
	.uleb128 0x2e
	.byte	0x1
	.uleb128 0x3f
	.uleb128 0x19
	.uleb128 0x3
	.uleb128 0x8
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x27
	.uleb128 0x19
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x12
	.uleb128 0x7
	.uleb128 0x40
	.uleb128 0x18
	.uleb128 0x2117
	.uleb128 0x19
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x34
	.uleb128 0x34
	.byte	0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x2
	.uleb128 0x17
	.byte	0
	.byte	0
	.uleb128 0x35
	.uleb128 0x2e
	.byte	0x1
	.uleb128 0x3f
	.uleb128 0x19
	.uleb128 0x3
	.uleb128 0x8
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x27
	.uleb128 0x19
	.uleb128 0x20
	.uleb128 0xb
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x36
	.uleb128 0x5
	.byte	0
	.uleb128 0x3
	.uleb128 0x8
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x37
	.uleb128 0x34
	.byte	0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x38
	.uleb128 0x5
	.byte	0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x2
	.uleb128 0x18
	.byte	0
	.byte	0
	.uleb128 0x39
	.uleb128 0x5
	.byte	0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x2
	.uleb128 0x17
	.byte	0
	.byte	0
	.uleb128 0x3a
	.uleb128 0x34
	.byte	0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x2
	.uleb128 0x18
	.byte	0
	.byte	0
	.uleb128 0x3b
	.uleb128 0x5
	.byte	0
	.uleb128 0x3
	.uleb128 0x8
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x2
	.uleb128 0x18
	.byte	0
	.byte	0
	.uleb128 0x3c
	.uleb128 0x2e
	.byte	0x1
	.uleb128 0x3f
	.uleb128 0x19
	.uleb128 0x3
	.uleb128 0x8
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x27
	.uleb128 0x19
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x20
	.uleb128 0xb
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x3d
	.uleb128 0xf
	.byte	0
	.uleb128 0xb
	.uleb128 0xb
	.byte	0
	.byte	0
	.uleb128 0x3e
	.uleb128 0x2e
	.byte	0x1
	.uleb128 0x31
	.uleb128 0x13
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x12
	.uleb128 0x7
	.uleb128 0x40
	.uleb128 0x18
	.uleb128 0x2117
	.uleb128 0x19
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x3f
	.uleb128 0x34
	.byte	0
	.uleb128 0x31
	.uleb128 0x13
	.uleb128 0x2
	.uleb128 0x18
	.byte	0
	.byte	0
	.uleb128 0x40
	.uleb128 0x34
	.byte	0
	.uleb128 0x31
	.uleb128 0x13
	.uleb128 0x2
	.uleb128 0x17
	.byte	0
	.byte	0
	.uleb128 0x41
	.uleb128 0x2e
	.byte	0x1
	.uleb128 0x31
	.uleb128 0x13
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x12
	.uleb128 0x7
	.uleb128 0x40
	.uleb128 0x18
	.uleb128 0x2117
	.uleb128 0x19
	.byte	0
	.byte	0
	.byte	0
	.section	.debug_loc,"dr"
.Ldebug_loc0:
.LLST91:
	.quad	.LVL263-.Ltext0
	.quad	.LVL264-.Ltext0
	.word	0x1
	.byte	0x50
	.quad	.LVL264-.Ltext0
	.quad	.LVL338-.Ltext0
	.word	0x1
	.byte	0x54
	.quad	0
	.quad	0
.LLST92:
	.quad	.LVL266-.Ltext0
	.quad	.LVL267-.Ltext0
	.word	0x1
	.byte	0x50
	.quad	.LVL267-.Ltext0
	.quad	.LVL279-.Ltext0
	.word	0x1
	.byte	0x52
	.quad	0
	.quad	0
.LLST93:
	.quad	.LVL268-.Ltext0
	.quad	.LVL269-.Ltext0
	.word	0x1
	.byte	0x50
	.quad	.LVL269-.Ltext0
	.quad	.LVL273-.Ltext0
	.word	0x1
	.byte	0x51
	.quad	0
	.quad	0
.LLST94:
	.quad	.LVL303-.Ltext0
	.quad	.LVL305-.Ltext0
	.word	0x1
	.byte	0x51
	.quad	0
	.quad	0
.LLST95:
	.quad	.LVL315-.Ltext0
	.quad	.LVL316-.Ltext0
	.word	0x1
	.byte	0x50
	.quad	.LVL316-.Ltext0
	.quad	.LVL325-.Ltext0
	.word	0x1
	.byte	0x51
	.quad	0
	.quad	0
.LLST96:
	.quad	.LVL319-.Ltext0
	.quad	.LVL320-.Ltext0
	.word	0x1
	.byte	0x50
	.quad	.LVL320-.Ltext0
	.quad	.LVL330-1-.Ltext0
	.word	0x1
	.byte	0x52
	.quad	0
	.quad	0
.LLST97:
	.quad	.LVL321-.Ltext0
	.quad	.LVL323-.Ltext0
	.word	0x1
	.byte	0x50
	.quad	0
	.quad	0
.LLST98:
	.quad	.LVL332-.Ltext0
	.quad	.LVL339-.Ltext0
	.word	0x2
	.byte	0x30
	.byte	0x9f
	.quad	.LVL339-.Ltext0
	.quad	.LVL340-.Ltext0
	.word	0x1
	.byte	0x54
	.quad	.LVL340-.Ltext0
	.quad	.LVL341-.Ltext0
	.word	0x3
	.byte	0x74
	.sleb128 -1
	.byte	0x9f
	.quad	.LVL341-.Ltext0
	.quad	.LFE29-.Ltext0
	.word	0x1
	.byte	0x54
	.quad	0
	.quad	0
.LLST99:
	.quad	.LVL334-.Ltext0
	.quad	.LVL335-.Ltext0
	.word	0x1
	.byte	0x50
	.quad	.LVL335-.Ltext0
	.quad	.LFE29-.Ltext0
	.word	0x1
	.byte	0x56
	.quad	0
	.quad	0
.LLST100:
	.quad	.LVL337-.Ltext0
	.quad	.LVL339-.Ltext0
	.word	0x1
	.byte	0x50
	.quad	.LVL339-.Ltext0
	.quad	.LFE29-.Ltext0
	.word	0x1
	.byte	0x55
	.quad	0
	.quad	0
.LLST101:
	.quad	.LVL262-.Ltext0
	.quad	.LVL263-.Ltext0
	.word	0xa
	.byte	0x3
	.quad	.LC5
	.byte	0x9f
	.quad	0
	.quad	0
.LLST102:
	.quad	.LVL262-.Ltext0
	.quad	.LVL263-.Ltext0
	.word	0x2
	.byte	0x30
	.byte	0x9f
	.quad	0
	.quad	0
.LLST103:
	.quad	.LVL263-.Ltext0
	.quad	.LVL264-.Ltext0
	.word	0xa
	.byte	0x3
	.quad	.LC6
	.byte	0x9f
	.quad	0
	.quad	0
.LLST104:
	.quad	.LVL263-.Ltext0
	.quad	.LVL264-.Ltext0
	.word	0x1
	.byte	0x50
	.quad	0
	.quad	0
.LLST105:
	.quad	.LVL264-.Ltext0
	.quad	.LVL265-.Ltext0
	.word	0xa
	.byte	0x3
	.quad	.LC7
	.byte	0x9f
	.quad	0
	.quad	0
.LLST106:
	.quad	.LVL264-.Ltext0
	.quad	.LVL265-.Ltext0
	.word	0x1
	.byte	0x54
	.quad	0
	.quad	0
.LLST107:
	.quad	.LVL265-.Ltext0
	.quad	.LVL266-.Ltext0
	.word	0xa
	.byte	0x3
	.quad	.LC8
	.byte	0x9f
	.quad	0
	.quad	0
.LLST108:
	.quad	.LVL265-.Ltext0
	.quad	.LVL266-.Ltext0
	.word	0x2
	.byte	0x30
	.byte	0x9f
	.quad	0
	.quad	0
.LLST109:
	.quad	.LVL266-.Ltext0
	.quad	.LVL268-.Ltext0
	.word	0xa
	.byte	0x3
	.quad	.LC9
	.byte	0x9f
	.quad	0
	.quad	0
.LLST110:
	.quad	.LVL266-.Ltext0
	.quad	.LVL267-.Ltext0
	.word	0x1
	.byte	0x50
	.quad	.LVL267-.Ltext0
	.quad	.LVL268-.Ltext0
	.word	0x1
	.byte	0x52
	.quad	0
	.quad	0
.LLST111:
	.quad	.LVL268-.Ltext0
	.quad	.LVL270-.Ltext0
	.word	0xa
	.byte	0x3
	.quad	.LC10
	.byte	0x9f
	.quad	0
	.quad	0
.LLST112:
	.quad	.LVL268-.Ltext0
	.quad	.LVL270-.Ltext0
	.word	0x1
	.byte	0x52
	.quad	0
	.quad	0
.LLST113:
	.quad	.LVL271-.Ltext0
	.quad	.LVL272-.Ltext0
	.word	0xa
	.byte	0x3
	.quad	.LC11
	.byte	0x9f
	.quad	0
	.quad	0
.LLST114:
	.quad	.LVL271-.Ltext0
	.quad	.LVL272-.Ltext0
	.word	0x1
	.byte	0x52
	.quad	0
	.quad	0
.LLST115:
	.quad	.LVL273-.Ltext0
	.quad	.LVL274-.Ltext0
	.word	0x4
	.byte	0xa
	.word	0x1387
	.byte	0x9f
	.quad	.LVL274-.Ltext0
	.quad	.LVL275-.Ltext0
	.word	0x9
	.byte	0x72
	.sleb128 0
	.byte	0x71
	.sleb128 0
	.byte	0x1c
	.byte	0x23
	.uleb128 0x1b57
	.byte	0x9f
	.quad	.LVL275-.Ltext0
	.quad	.LVL276-.Ltext0
	.word	0x9
	.byte	0x72
	.sleb128 0
	.byte	0x71
	.sleb128 0
	.byte	0x1c
	.byte	0x23
	.uleb128 0x1b58
	.byte	0x9f
	.quad	.LVL276-.Ltext0
	.quad	.LVL277-.Ltext0
	.word	0x9
	.byte	0x72
	.sleb128 0
	.byte	0x71
	.sleb128 0
	.byte	0x1c
	.byte	0x23
	.uleb128 0x1b57
	.byte	0x9f
	.quad	0
	.quad	0
.LLST116:
	.quad	.LVL273-.Ltext0
	.quad	.LVL277-.Ltext0
	.word	0x3
	.byte	0x9
	.byte	0xff
	.byte	0x9f
	.quad	0
	.quad	0
.LLST117:
	.quad	.LVL273-.Ltext0
	.quad	.LVL274-.Ltext0
	.word	0x1
	.byte	0x51
	.quad	.LVL274-.Ltext0
	.quad	.LVL277-.Ltext0
	.word	0x4
	.byte	0x72
	.sleb128 2000
	.byte	0x9f
	.quad	0
	.quad	0
.LLST118:
	.quad	.LVL277-.Ltext0
	.quad	.LVL278-.Ltext0
	.word	0xa
	.byte	0x3
	.quad	.LC12
	.byte	0x9f
	.quad	0
	.quad	0
.LLST119:
	.quad	.LVL277-.Ltext0
	.quad	.LVL278-.Ltext0
	.word	0x1
	.byte	0x54
	.quad	0
	.quad	0
.LLST120:
	.quad	.LVL278-.Ltext0
	.quad	.LVL280-.Ltext0
	.word	0xa
	.byte	0x3
	.quad	.LC13
	.byte	0x9f
	.quad	0
	.quad	0
.LLST121:
	.quad	.LVL278-.Ltext0
	.quad	.LVL280-.Ltext0
	.word	0x2
	.byte	0x30
	.byte	0x9f
	.quad	0
	.quad	0
.LLST122:
	.quad	.LVL281-.Ltext0
	.quad	.LVL283-.Ltext0
	.word	0xa
	.byte	0x3
	.quad	.LC14
	.byte	0x9f
	.quad	0
	.quad	0
.LLST123:
	.quad	.LVL281-.Ltext0
	.quad	.LVL282-.Ltext0
	.word	0x1
	.byte	0x50
	.quad	.LVL282-.Ltext0
	.quad	.LVL283-.Ltext0
	.word	0x1
	.byte	0x51
	.quad	0
	.quad	0
.LLST124:
	.quad	.LVL284-.Ltext0
	.quad	.LVL285-.Ltext0
	.word	0xa
	.byte	0x3
	.quad	.LC15
	.byte	0x9f
	.quad	0
	.quad	0
.LLST125:
	.quad	.LVL284-.Ltext0
	.quad	.LVL285-.Ltext0
	.word	0x1
	.byte	0x54
	.quad	0
	.quad	0
.LLST126:
	.quad	.LVL285-.Ltext0
	.quad	.LVL286-.Ltext0
	.word	0xa
	.byte	0x3
	.quad	.LC16
	.byte	0x9f
	.quad	0
	.quad	0
.LLST127:
	.quad	.LVL285-.Ltext0
	.quad	.LVL286-.Ltext0
	.word	0x1
	.byte	0x51
	.quad	0
	.quad	0
.LLST128:
	.quad	.LVL287-.Ltext0
	.quad	.LVL288-.Ltext0
	.word	0xa
	.byte	0x3
	.quad	.LC17
	.byte	0x9f
	.quad	0
	.quad	0
.LLST129:
	.quad	.LVL287-.Ltext0
	.quad	.LVL288-.Ltext0
	.word	0x1
	.byte	0x54
	.quad	0
	.quad	0
.LLST130:
	.quad	.LVL289-.Ltext0
	.quad	.LVL290-.Ltext0
	.word	0xa
	.byte	0x3
	.quad	.LC18
	.byte	0x9f
	.quad	0
	.quad	0
.LLST131:
	.quad	.LVL289-.Ltext0
	.quad	.LVL290-.Ltext0
	.word	0x1
	.byte	0x54
	.quad	0
	.quad	0
.LLST132:
	.quad	.LVL290-.Ltext0
	.quad	.LVL291-.Ltext0
	.word	0xa
	.byte	0x3
	.quad	.LC0
	.byte	0x9f
	.quad	0
	.quad	0
.LLST133:
	.quad	.LVL290-.Ltext0
	.quad	.LVL291-.Ltext0
	.word	0x1
	.byte	0x51
	.quad	0
	.quad	0
.LLST134:
	.quad	.LVL292-.Ltext0
	.quad	.LVL293-.Ltext0
	.word	0xa
	.byte	0x3
	.quad	.LC19
	.byte	0x9f
	.quad	0
	.quad	0
.LLST135:
	.quad	.LVL292-.Ltext0
	.quad	.LVL293-.Ltext0
	.word	0x1
	.byte	0x54
	.quad	0
	.quad	0
.LLST136:
	.quad	.LVL293-.Ltext0
	.quad	.LVL294-.Ltext0
	.word	0xa
	.byte	0x3
	.quad	.LC0
	.byte	0x9f
	.quad	0
	.quad	0
.LLST137:
	.quad	.LVL293-.Ltext0
	.quad	.LVL294-.Ltext0
	.word	0x1
	.byte	0x51
	.quad	0
	.quad	0
.LLST138:
	.quad	.LVL295-.Ltext0
	.quad	.LVL296-.Ltext0
	.word	0xa
	.byte	0x3
	.quad	.LC20
	.byte	0x9f
	.quad	0
	.quad	0
.LLST139:
	.quad	.LVL295-.Ltext0
	.quad	.LVL296-.Ltext0
	.word	0x1
	.byte	0x54
	.quad	0
	.quad	0
.LLST140:
	.quad	.LVL296-.Ltext0
	.quad	.LVL297-.Ltext0
	.word	0xa
	.byte	0x3
	.quad	.LC0
	.byte	0x9f
	.quad	0
	.quad	0
.LLST141:
	.quad	.LVL296-.Ltext0
	.quad	.LVL297-.Ltext0
	.word	0x1
	.byte	0x51
	.quad	0
	.quad	0
.LLST142:
	.quad	.LVL299-.Ltext0
	.quad	.LVL300-.Ltext0
	.word	0xa
	.byte	0x3
	.quad	.LC21
	.byte	0x9f
	.quad	0
	.quad	0
.LLST143:
	.quad	.LVL299-.Ltext0
	.quad	.LVL300-.Ltext0
	.word	0x1
	.byte	0x54
	.quad	0
	.quad	0
.LLST144:
	.quad	.LVL303-.Ltext0
	.quad	.LVL304-.Ltext0
	.word	0xa
	.byte	0x3
	.quad	.LC23
	.byte	0x9f
	.quad	0
	.quad	0
.LLST145:
	.quad	.LVL303-.Ltext0
	.quad	.LVL304-.Ltext0
	.word	0x1
	.byte	0x54
	.quad	0
	.quad	0
.LLST146:
	.quad	.LVL306-.Ltext0
	.quad	.LVL307-.Ltext0
	.word	0xa
	.byte	0x3
	.quad	.LC24
	.byte	0x9f
	.quad	0
	.quad	0
.LLST147:
	.quad	.LVL306-.Ltext0
	.quad	.LVL307-.Ltext0
	.word	0x1
	.byte	0x54
	.quad	0
	.quad	0
.LLST148:
	.quad	.LVL308-.Ltext0
	.quad	.LVL309-.Ltext0
	.word	0xa
	.byte	0x3
	.quad	.LC25
	.byte	0x9f
	.quad	0
	.quad	0
.LLST149:
	.quad	.LVL308-.Ltext0
	.quad	.LVL309-.Ltext0
	.word	0x1
	.byte	0x54
	.quad	0
	.quad	0
.LLST150:
	.quad	.LVL310-.Ltext0
	.quad	.LVL311-.Ltext0
	.word	0xa
	.byte	0x3
	.quad	.LC24
	.byte	0x9f
	.quad	0
	.quad	0
.LLST151:
	.quad	.LVL310-.Ltext0
	.quad	.LVL311-.Ltext0
	.word	0x1
	.byte	0x54
	.quad	0
	.quad	0
.LLST152:
	.quad	.LVL313-.Ltext0
	.quad	.LVL314-.Ltext0
	.word	0xa
	.byte	0x3
	.quad	.LC27
	.byte	0x9f
	.quad	0
	.quad	0
.LLST153:
	.quad	.LVL313-.Ltext0
	.quad	.LVL314-.Ltext0
	.word	0x1
	.byte	0x54
	.quad	0
	.quad	0
.LLST154:
	.quad	.LVL314-.Ltext0
	.quad	.LVL315-.Ltext0
	.word	0xa
	.byte	0x3
	.quad	.LC28
	.byte	0x9f
	.quad	0
	.quad	0
.LLST155:
	.quad	.LVL314-.Ltext0
	.quad	.LVL315-.Ltext0
	.word	0x2
	.byte	0x30
	.byte	0x9f
	.quad	0
	.quad	0
.LLST156:
	.quad	.LVL315-.Ltext0
	.quad	.LVL316-.Ltext0
	.word	0xa
	.byte	0x3
	.quad	.LC29
	.byte	0x9f
	.quad	0
	.quad	0
.LLST157:
	.quad	.LVL315-.Ltext0
	.quad	.LVL316-.Ltext0
	.word	0x1
	.byte	0x50
	.quad	0
	.quad	0
.LLST158:
	.quad	.LVL316-.Ltext0
	.quad	.LVL317-.Ltext0
	.word	0xa
	.byte	0x3
	.quad	.LC30
	.byte	0x9f
	.quad	0
	.quad	0
.LLST159:
	.quad	.LVL316-.Ltext0
	.quad	.LVL317-.Ltext0
	.word	0x1
	.byte	0x51
	.quad	0
	.quad	0
.LLST160:
	.quad	.LVL318-.Ltext0
	.quad	.LVL319-.Ltext0
	.word	0xa
	.byte	0x3
	.quad	.LC0
	.byte	0x9f
	.quad	0
	.quad	0
.LLST161:
	.quad	.LVL318-.Ltext0
	.quad	.LVL319-.Ltext0
	.word	0x9
	.byte	0x3
	.quad	memory
	.quad	0
	.quad	0
.LLST162:
	.quad	.LVL319-.Ltext0
	.quad	.LVL321-.Ltext0
	.word	0xa
	.byte	0x3
	.quad	.LC31
	.byte	0x9f
	.quad	0
	.quad	0
.LLST163:
	.quad	.LVL319-.Ltext0
	.quad	.LVL321-.Ltext0
	.word	0x1
	.byte	0x51
	.quad	0
	.quad	0
.LLST164:
	.quad	.LVL322-.Ltext0
	.quad	.LVL324-.Ltext0
	.word	0xa
	.byte	0x3
	.quad	.LC32
	.byte	0x9f
	.quad	0
	.quad	0
.LLST165:
	.quad	.LVL322-.Ltext0
	.quad	.LVL324-.Ltext0
	.word	0x1
	.byte	0x51
	.quad	0
	.quad	0
.LLST166:
	.quad	.LVL325-.Ltext0
	.quad	.LVL326-.Ltext0
	.word	0x6
	.byte	0xc
	.long	0xea5ff
	.byte	0x9f
	.quad	.LVL326-.Ltext0
	.quad	.LVL327-.Ltext0
	.word	0x7
	.byte	0x71
	.sleb128 0
	.byte	0x20
	.byte	0x70
	.sleb128 0
	.byte	0x22
	.byte	0x9f
	.quad	.LVL327-.Ltext0
	.quad	.LVL328-.Ltext0
	.word	0x6
	.byte	0x70
	.sleb128 0
	.byte	0x71
	.sleb128 0
	.byte	0x1c
	.byte	0x9f
	.quad	.LVL328-.Ltext0
	.quad	.LVL329-.Ltext0
	.word	0x7
	.byte	0x71
	.sleb128 0
	.byte	0x20
	.byte	0x70
	.sleb128 0
	.byte	0x22
	.byte	0x9f
	.quad	0
	.quad	0
.LLST167:
	.quad	.LVL325-.Ltext0
	.quad	.LVL329-.Ltext0
	.word	0x2
	.byte	0x30
	.byte	0x9f
	.quad	0
	.quad	0
.LLST168:
	.quad	.LVL325-.Ltext0
	.quad	.LVL326-.Ltext0
	.word	0x1
	.byte	0x51
	.quad	.LVL326-.Ltext0
	.quad	.LVL329-.Ltext0
	.word	0x5
	.byte	0x70
	.sleb128 -960000
	.byte	0x9f
	.quad	0
	.quad	0
.LLST169:
	.quad	.LVL331-.Ltext0
	.quad	.LVL332-.Ltext0
	.word	0xa
	.byte	0x3
	.quad	.LC33
	.byte	0x9f
	.quad	0
	.quad	0
.LLST170:
	.quad	.LVL331-.Ltext0
	.quad	.LVL332-.Ltext0
	.word	0x1
	.byte	0x50
	.quad	0
	.quad	0
.LLST171:
	.quad	.LVL333-.Ltext0
	.quad	.LVL334-.Ltext0
	.word	0xa
	.byte	0x3
	.quad	.LC0
	.byte	0x9f
	.quad	0
	.quad	0
.LLST172:
	.quad	.LVL333-.Ltext0
	.quad	.LVL334-.Ltext0
	.word	0x9
	.byte	0x3
	.quad	memory
	.quad	0
	.quad	0
.LLST173:
	.quad	.LVL336-.Ltext0
	.quad	.LVL337-.Ltext0
	.word	0xa
	.byte	0x3
	.quad	.LC34
	.byte	0x9f
	.quad	0
	.quad	0
.LLST174:
	.quad	.LVL336-.Ltext0
	.quad	.LVL337-.Ltext0
	.word	0x2
	.byte	0x30
	.byte	0x9f
	.quad	0
	.quad	0
.LLST82:
	.quad	.LVL246-.Ltext0
	.quad	.LVL247-1-.Ltext0
	.word	0x1
	.byte	0x51
	.quad	.LVL247-1-.Ltext0
	.quad	.LFE28-.Ltext0
	.word	0x4
	.byte	0xf3
	.uleb128 0x1
	.byte	0x51
	.byte	0x9f
	.quad	0
	.quad	0
.LLST83:
	.quad	.LVL251-.Ltext0
	.quad	.LVL256-.Ltext0
	.word	0x5
	.byte	0x5b
	.byte	0x93
	.uleb128 0x8
	.byte	0x93
	.uleb128 0x18
	.quad	0
	.quad	0
.LLST84:
	.quad	.LVL249-.Ltext0
	.quad	.LVL256-.Ltext0
	.word	0x1
	.byte	0x51
	.quad	.LVL256-.Ltext0
	.quad	.LFE27-.Ltext0
	.word	0x4
	.byte	0xf3
	.uleb128 0x1
	.byte	0x51
	.byte	0x9f
	.quad	0
	.quad	0
.LLST85:
	.quad	.LVL250-.Ltext0
	.quad	.LVL252-.Ltext0
	.word	0x6
	.byte	0x93
	.uleb128 0x18
	.byte	0x78
	.sleb128 24
	.byte	0x93
	.uleb128 0x8
	.quad	.LVL252-.Ltext0
	.quad	.LVL253-.Ltext0
	.word	0xc
	.byte	0x53
	.byte	0x93
	.uleb128 0x8
	.byte	0x5a
	.byte	0x93
	.uleb128 0x8
	.byte	0x93
	.uleb128 0x8
	.byte	0x78
	.sleb128 24
	.byte	0x93
	.uleb128 0x8
	.quad	.LVL253-.Ltext0
	.quad	.LVL254-.Ltext0
	.word	0x8
	.byte	0x53
	.byte	0x93
	.uleb128 0x8
	.byte	0x5a
	.byte	0x93
	.uleb128 0x8
	.byte	0x93
	.uleb128 0x10
	.quad	.LVL254-.Ltext0
	.quad	.LVL255-.Ltext0
	.word	0x5
	.byte	0x53
	.byte	0x93
	.uleb128 0x8
	.byte	0x93
	.uleb128 0x18
	.quad	0
	.quad	0
.LLST86:
	.quad	.LVL249-.Ltext0
	.quad	.LVL256-.Ltext0
	.word	0x1
	.byte	0x59
	.quad	.LVL256-.Ltext0
	.quad	.LFE27-.Ltext0
	.word	0x4
	.byte	0xf3
	.uleb128 0x1
	.byte	0x59
	.byte	0x9f
	.quad	0
	.quad	0
.LLST87:
	.quad	.LVL252-.Ltext0
	.quad	.LVL256-.Ltext0
	.word	0x2
	.byte	0x30
	.byte	0x9f
	.quad	.LVL256-.Ltext0
	.quad	.LFE27-.Ltext0
	.word	0x1
	.byte	0x5a
	.quad	0
	.quad	0
.LLST88:
	.quad	.LVL257-.Ltext0
	.quad	.LVL258-.Ltext0
	.word	0x7
	.byte	0x70
	.sleb128 0
	.byte	0x20
	.byte	0x78
	.sleb128 0
	.byte	0x22
	.byte	0x9f
	.quad	.LVL258-.Ltext0
	.quad	.LVL259-.Ltext0
	.word	0x6
	.byte	0x78
	.sleb128 0
	.byte	0x70
	.sleb128 0
	.byte	0x1c
	.byte	0x9f
	.quad	0
	.quad	0
.LLST89:
	.quad	.LVL256-.Ltext0
	.quad	.LVL257-.Ltext0
	.word	0x8
	.byte	0x73
	.sleb128 0
	.byte	0x94
	.byte	0x1
	.byte	0x8
	.byte	0xff
	.byte	0x1a
	.byte	0x9f
	.quad	.LVL257-.Ltext0
	.quad	.LVL260-.Ltext0
	.word	0x6
	.byte	0x79
	.sleb128 0
	.byte	0x8
	.byte	0xff
	.byte	0x1a
	.byte	0x9f
	.quad	0
	.quad	0
.LLST90:
	.quad	.LVL256-.Ltext0
	.quad	.LVL257-.Ltext0
	.word	0x8
	.byte	0x7b
	.sleb128 0
	.byte	0x94
	.byte	0x1
	.byte	0x8
	.byte	0xff
	.byte	0x1a
	.byte	0x9f
	.quad	.LVL257-.Ltext0
	.quad	.LVL260-.Ltext0
	.word	0x6
	.byte	0x72
	.sleb128 0
	.byte	0x8
	.byte	0xff
	.byte	0x1a
	.byte	0x9f
	.quad	0
	.quad	0
.LLST81:
	.quad	.LVL244-.Ltext0
	.quad	.LVL245-.Ltext0
	.word	0x6
	.byte	0xc
	.long	0x3a980
	.byte	0x9f
	.quad	0
	.quad	0
.LLST80:
	.quad	.LVL241-.Ltext0
	.quad	.LVL242-.Ltext0
	.word	0x2
	.byte	0x30
	.byte	0x9f
	.quad	0
	.quad	0
.LLST79:
	.quad	.LVL237-.Ltext0
	.quad	.LVL238-.Ltext0
	.word	0x1
	.byte	0x51
	.quad	.LVL238-.Ltext0
	.quad	.LFE24-.Ltext0
	.word	0x4
	.byte	0xf3
	.uleb128 0x1
	.byte	0x51
	.byte	0x9f
	.quad	0
	.quad	0
.LLST74:
	.quad	.LVL224-.Ltext0
	.quad	.LVL228-1-.Ltext0
	.word	0x1
	.byte	0x52
	.quad	.LVL228-1-.Ltext0
	.quad	.LVL231-.Ltext0
	.word	0x1
	.byte	0x53
	.quad	.LVL231-.Ltext0
	.quad	.LFE23-.Ltext0
	.word	0x4
	.byte	0xf3
	.uleb128 0x1
	.byte	0x52
	.byte	0x9f
	.quad	0
	.quad	0
.LLST75:
	.quad	.LVL224-.Ltext0
	.quad	.LVL228-1-.Ltext0
	.word	0x1
	.byte	0x51
	.quad	.LVL228-1-.Ltext0
	.quad	.LVL235-.Ltext0
	.word	0x1
	.byte	0x5c
	.quad	.LVL235-.Ltext0
	.quad	.LFE23-.Ltext0
	.word	0x4
	.byte	0xf3
	.uleb128 0x1
	.byte	0x51
	.byte	0x9f
	.quad	0
	.quad	0
.LLST76:
	.quad	.LVL224-.Ltext0
	.quad	.LVL228-1-.Ltext0
	.word	0x1
	.byte	0x58
	.quad	.LVL228-1-.Ltext0
	.quad	.LVL233-.Ltext0
	.word	0x1
	.byte	0x55
	.quad	.LVL233-.Ltext0
	.quad	.LFE23-.Ltext0
	.word	0x4
	.byte	0xf3
	.uleb128 0x1
	.byte	0x58
	.byte	0x9f
	.quad	0
	.quad	0
.LLST77:
	.quad	.LVL224-.Ltext0
	.quad	.LVL227-.Ltext0
	.word	0x1
	.byte	0x59
	.quad	.LVL227-.Ltext0
	.quad	.LVL232-.Ltext0
	.word	0x1
	.byte	0x54
	.quad	.LVL232-.Ltext0
	.quad	.LFE23-.Ltext0
	.word	0x4
	.byte	0xf3
	.uleb128 0x1
	.byte	0x59
	.byte	0x9f
	.quad	0
	.quad	0
.LLST78:
	.quad	.LVL224-.Ltext0
	.quad	.LVL225-.Ltext0
	.word	0x2
	.byte	0x91
	.sleb128 32
	.quad	.LVL226-.Ltext0
	.quad	.LVL234-.Ltext0
	.word	0x1
	.byte	0x56
	.quad	0
	.quad	0
.LLST65:
	.quad	.LVL198-.Ltext0
	.quad	.LVL202-.Ltext0
	.word	0x1
	.byte	0x52
	.quad	.LVL202-.Ltext0
	.quad	.LVL210-.Ltext0
	.word	0x4
	.byte	0xf3
	.uleb128 0x1
	.byte	0x52
	.byte	0x9f
	.quad	.LVL210-.Ltext0
	.quad	.LVL211-.Ltext0
	.word	0x1
	.byte	0x52
	.quad	.LVL211-.Ltext0
	.quad	.LVL216-.Ltext0
	.word	0x4
	.byte	0xf3
	.uleb128 0x1
	.byte	0x52
	.byte	0x9f
	.quad	.LVL216-.Ltext0
	.quad	.LVL218-.Ltext0
	.word	0x1
	.byte	0x52
	.quad	.LVL218-.Ltext0
	.quad	.LVL219-.Ltext0
	.word	0x4
	.byte	0xf3
	.uleb128 0x1
	.byte	0x52
	.byte	0x9f
	.quad	.LVL219-.Ltext0
	.quad	.LVL220-.Ltext0
	.word	0x1
	.byte	0x52
	.quad	.LVL220-.Ltext0
	.quad	.LFE22-.Ltext0
	.word	0x4
	.byte	0xf3
	.uleb128 0x1
	.byte	0x52
	.byte	0x9f
	.quad	0
	.quad	0
.LLST66:
	.quad	.LVL198-.Ltext0
	.quad	.LVL203-1-.Ltext0
	.word	0x1
	.byte	0x51
	.quad	.LVL203-1-.Ltext0
	.quad	.LVL210-.Ltext0
	.word	0x4
	.byte	0xf3
	.uleb128 0x1
	.byte	0x51
	.byte	0x9f
	.quad	.LVL210-.Ltext0
	.quad	.LVL211-.Ltext0
	.word	0x1
	.byte	0x51
	.quad	.LVL211-.Ltext0
	.quad	.LVL216-.Ltext0
	.word	0x4
	.byte	0xf3
	.uleb128 0x1
	.byte	0x51
	.byte	0x9f
	.quad	.LVL216-.Ltext0
	.quad	.LVL220-.Ltext0
	.word	0x1
	.byte	0x51
	.quad	.LVL220-.Ltext0
	.quad	.LFE22-.Ltext0
	.word	0x4
	.byte	0xf3
	.uleb128 0x1
	.byte	0x51
	.byte	0x9f
	.quad	0
	.quad	0
.LLST67:
	.quad	.LVL199-.Ltext0
	.quad	.LVL204-.Ltext0
	.word	0x3
	.byte	0x8
	.byte	0xfe
	.byte	0x9f
	.quad	.LVL210-.Ltext0
	.quad	.LVL211-.Ltext0
	.word	0x3
	.byte	0x8
	.byte	0xfe
	.byte	0x9f
	.quad	.LVL211-.Ltext0
	.quad	.LVL213-.Ltext0
	.word	0x3
	.byte	0x71
	.sleb128 1
	.byte	0x9f
	.quad	.LVL213-.Ltext0
	.quad	.LVL214-.Ltext0
	.word	0x1
	.byte	0x51
	.quad	.LVL214-.Ltext0
	.quad	.LVL216-.Ltext0
	.word	0x1
	.byte	0x50
	.quad	.LVL216-.Ltext0
	.quad	.LVL217-.Ltext0
	.word	0x3
	.byte	0x8
	.byte	0xfe
	.byte	0x9f
	.quad	.LVL217-.Ltext0
	.quad	.LVL219-.Ltext0
	.word	0x3
	.byte	0x8
	.byte	0xfd
	.byte	0x9f
	.quad	.LVL219-.Ltext0
	.quad	.LVL220-.Ltext0
	.word	0x3
	.byte	0x8
	.byte	0xfe
	.byte	0x9f
	.quad	.LVL220-.Ltext0
	.quad	.LVL222-.Ltext0
	.word	0x3
	.byte	0x78
	.sleb128 1
	.byte	0x9f
	.quad	.LVL222-.Ltext0
	.quad	.LVL223-.Ltext0
	.word	0x3
	.byte	0x70
	.sleb128 1
	.byte	0x9f
	.quad	0
	.quad	0
.LLST68:
	.quad	.LVL199-.Ltext0
	.quad	.LVL202-.Ltext0
	.word	0x1
	.byte	0x52
	.quad	.LVL202-.Ltext0
	.quad	.LVL204-.Ltext0
	.word	0x4
	.byte	0xf3
	.uleb128 0x1
	.byte	0x52
	.byte	0x9f
	.quad	.LVL210-.Ltext0
	.quad	.LVL215-.Ltext0
	.word	0x1
	.byte	0x52
	.quad	.LVL216-.Ltext0
	.quad	.LVL217-.Ltext0
	.word	0x1
	.byte	0x52
	.quad	.LVL217-.Ltext0
	.quad	.LVL219-.Ltext0
	.word	0x2
	.byte	0x30
	.byte	0x9f
	.quad	.LVL219-.Ltext0
	.quad	.LVL221-.Ltext0
	.word	0x1
	.byte	0x52
	.quad	.LVL223-.Ltext0
	.quad	.LFE22-.Ltext0
	.word	0x1
	.byte	0x51
	.quad	0
	.quad	0
.LLST69:
	.quad	.LVL201-.Ltext0
	.quad	.LVL203-1-.Ltext0
	.word	0x1
	.byte	0x50
	.quad	.LVL203-1-.Ltext0
	.quad	.LVL207-.Ltext0
	.word	0x1
	.byte	0x53
	.quad	.LVL207-.Ltext0
	.quad	.LVL208-.Ltext0
	.word	0x2
	.byte	0x70
	.sleb128 0
	.quad	.LVL208-.Ltext0
	.quad	.LVL210-.Ltext0
	.word	0xa
	.byte	0x3
	.quad	memory_req_mem
	.byte	0x6
	.quad	.LVL210-.Ltext0
	.quad	.LVL211-.Ltext0
	.word	0x1
	.byte	0x50
	.quad	.LVL211-.Ltext0
	.quad	.LVL216-.Ltext0
	.word	0x1
	.byte	0x53
	.quad	.LVL216-.Ltext0
	.quad	.LVL220-.Ltext0
	.word	0x1
	.byte	0x50
	.quad	.LVL220-.Ltext0
	.quad	.LFE22-.Ltext0
	.word	0x1
	.byte	0x53
	.quad	0
	.quad	0
.LLST70:
	.quad	.LVL200-.Ltext0
	.quad	.LVL201-.Ltext0
	.word	0xa
	.byte	0x3
	.quad	.LC0
	.byte	0x9f
	.quad	0
	.quad	0
.LLST71:
	.quad	.LVL200-.Ltext0
	.quad	.LVL201-.Ltext0
	.word	0x9
	.byte	0x3
	.quad	memory
	.quad	0
	.quad	0
.LLST72:
	.quad	.LVL206-.Ltext0
	.quad	.LVL209-.Ltext0
	.word	0xa
	.byte	0x3
	.quad	.LC3
	.byte	0x9f
	.quad	0
	.quad	0
.LLST73:
	.quad	.LVL206-.Ltext0
	.quad	.LVL209-.Ltext0
	.word	0x9
	.byte	0x3
	.quad	memory
	.quad	0
	.quad	0
.LLST63:
	.quad	.LVL187-.Ltext0
	.quad	.LVL189-.Ltext0
	.word	0x1
	.byte	0x52
	.quad	.LVL189-.Ltext0
	.quad	.LVL197-.Ltext0
	.word	0x1
	.byte	0x54
	.quad	.LVL197-.Ltext0
	.quad	.LFE21-.Ltext0
	.word	0x4
	.byte	0xf3
	.uleb128 0x1
	.byte	0x52
	.byte	0x9f
	.quad	0
	.quad	0
.LLST64:
	.quad	.LVL188-.Ltext0
	.quad	.LVL189-.Ltext0
	.word	0x2
	.byte	0x30
	.byte	0x9f
	.quad	.LVL189-.Ltext0
	.quad	.LVL190-.Ltext0
	.word	0x3
	.byte	0x73
	.sleb128 -1
	.byte	0x9f
	.quad	.LVL190-.Ltext0
	.quad	.LVL191-.Ltext0
	.word	0x1
	.byte	0x53
	.quad	.LVL191-.Ltext0
	.quad	.LVL192-.Ltext0
	.word	0x3
	.byte	0x73
	.sleb128 -1
	.byte	0x9f
	.quad	.LVL192-.Ltext0
	.quad	.LVL193-.Ltext0
	.word	0x1
	.byte	0x53
	.quad	.LVL193-.Ltext0
	.quad	.LVL194-.Ltext0
	.word	0x3
	.byte	0x73
	.sleb128 -1
	.byte	0x9f
	.quad	.LVL194-.Ltext0
	.quad	.LVL195-.Ltext0
	.word	0x1
	.byte	0x53
	.quad	.LVL195-.Ltext0
	.quad	.LVL196-.Ltext0
	.word	0x3
	.byte	0x73
	.sleb128 -1
	.byte	0x9f
	.quad	0
	.quad	0
.LLST54:
	.quad	.LVL172-.Ltext0
	.quad	.LVL176-.Ltext0
	.word	0x1
	.byte	0x52
	.quad	.LVL176-.Ltext0
	.quad	.LFE20-.Ltext0
	.word	0x4
	.byte	0xf3
	.uleb128 0x1
	.byte	0x52
	.byte	0x9f
	.quad	0
	.quad	0
.LLST55:
	.quad	.LVL172-.Ltext0
	.quad	.LVL174-.Ltext0
	.word	0x1
	.byte	0x51
	.quad	.LVL174-.Ltext0
	.quad	.LFE20-.Ltext0
	.word	0x4
	.byte	0xf3
	.uleb128 0x1
	.byte	0x51
	.byte	0x9f
	.quad	0
	.quad	0
.LLST56:
	.quad	.LVL172-.Ltext0
	.quad	.LVL177-.Ltext0
	.word	0x1
	.byte	0x58
	.quad	.LVL177-.Ltext0
	.quad	.LFE20-.Ltext0
	.word	0x4
	.byte	0xf3
	.uleb128 0x1
	.byte	0x58
	.byte	0x9f
	.quad	0
	.quad	0
.LLST57:
	.quad	.LVL178-.Ltext0
	.quad	.LVL179-.Ltext0
	.word	0x3
	.byte	0x9
	.byte	0x80
	.byte	0x9f
	.quad	.LVL179-.Ltext0
	.quad	.LVL183-.Ltext0
	.word	0x1
	.byte	0x50
	.quad	.LVL184-.Ltext0
	.quad	.LFE20-.Ltext0
	.word	0x1
	.byte	0x50
	.quad	0
	.quad	0
.LLST58:
	.quad	.LVL175-.Ltext0
	.quad	.LVL177-.Ltext0
	.word	0x1
	.byte	0x50
	.quad	.LVL177-.Ltext0
	.quad	.LFE20-.Ltext0
	.word	0x18
	.byte	0xf3
	.uleb128 0x1
	.byte	0x58
	.byte	0x8
	.byte	0xff
	.byte	0x1a
	.byte	0x33
	.byte	0x1e
	.byte	0x32
	.byte	0x24
	.byte	0xf3
	.uleb128 0x1
	.byte	0x58
	.byte	0x8
	.byte	0xff
	.byte	0x1a
	.byte	0x22
	.byte	0x8
	.byte	0x20
	.byte	0x24
	.byte	0x8
	.byte	0x20
	.byte	0x26
	.byte	0x9f
	.quad	0
	.quad	0
.LLST59:
	.quad	.LVL178-.Ltext0
	.quad	.LVL179-.Ltext0
	.word	0x6
	.byte	0xf3
	.uleb128 0x1
	.byte	0x52
	.byte	0x33
	.byte	0x24
	.byte	0x9f
	.quad	0
	.quad	0
.LLST60:
	.quad	.LVL178-.Ltext0
	.quad	.LVL179-.Ltext0
	.word	0x2
	.byte	0x30
	.byte	0x9f
	.quad	0
	.quad	0
.LLST61:
	.quad	.LVL175-.Ltext0
	.quad	.LVL177-.Ltext0
	.word	0x2
	.byte	0x30
	.byte	0x9f
	.quad	.LVL177-.Ltext0
	.quad	.LVL185-.Ltext0
	.word	0x1c
	.byte	0x7a
	.sleb128 0
	.byte	0xf3
	.uleb128 0x1
	.byte	0x58
	.byte	0x8
	.byte	0xff
	.byte	0x1a
	.byte	0x3d
	.byte	0x1e
	.byte	0x8
	.byte	0x20
	.byte	0x24
	.byte	0x8
	.byte	0x20
	.byte	0x26
	.byte	0x1c
	.byte	0x3
	.quad	font
	.byte	0x1c
	.byte	0x9f
	.quad	.LVL185-.Ltext0
	.quad	.LVL186-.Ltext0
	.word	0x1c
	.byte	0x7a
	.sleb128 0
	.byte	0xf3
	.uleb128 0x1
	.byte	0x58
	.byte	0x8
	.byte	0xff
	.byte	0x1a
	.byte	0x3d
	.byte	0x1e
	.byte	0x8
	.byte	0x20
	.byte	0x24
	.byte	0x8
	.byte	0x20
	.byte	0x26
	.byte	0x1c
	.byte	0x3
	.quad	font-1
	.byte	0x1c
	.byte	0x9f
	.quad	.LVL186-.Ltext0
	.quad	.LFE20-.Ltext0
	.word	0x1c
	.byte	0x7a
	.sleb128 0
	.byte	0xf3
	.uleb128 0x1
	.byte	0x58
	.byte	0x8
	.byte	0xff
	.byte	0x1a
	.byte	0x3d
	.byte	0x1e
	.byte	0x8
	.byte	0x20
	.byte	0x24
	.byte	0x8
	.byte	0x20
	.byte	0x26
	.byte	0x1c
	.byte	0x3
	.quad	font
	.byte	0x1c
	.byte	0x9f
	.quad	0
	.quad	0
.LLST62:
	.quad	.LVL182-.Ltext0
	.quad	.LVL185-.Ltext0
	.word	0x7
	.byte	0x9
	.byte	0x80
	.byte	0x9f
	.byte	0x93
	.uleb128 0x1
	.byte	0x93
	.uleb128 0x1
	.quad	0
	.quad	0
.LLST32:
	.quad	.LVL94-.Ltext0
	.quad	.LVL98-.Ltext0
	.word	0x1
	.byte	0x52
	.quad	.LVL98-.Ltext0
	.quad	.LVL103-.Ltext0
	.word	0x1
	.byte	0x58
	.quad	.LVL103-.Ltext0
	.quad	.LVL104-.Ltext0
	.word	0x1
	.byte	0x5c
	.quad	.LVL114-.Ltext0
	.quad	.LVL121-.Ltext0
	.word	0x1
	.byte	0x52
	.quad	.LVL121-.Ltext0
	.quad	.LVL122-.Ltext0
	.word	0x1
	.byte	0x58
	.quad	.LVL122-.Ltext0
	.quad	.LVL126-.Ltext0
	.word	0x1
	.byte	0x52
	.quad	.LVL126-.Ltext0
	.quad	.LVL128-.Ltext0
	.word	0x1
	.byte	0x58
	.quad	.LVL137-.Ltext0
	.quad	.LVL141-.Ltext0
	.word	0x1
	.byte	0x52
	.quad	.LVL151-.Ltext0
	.quad	.LVL154-.Ltext0
	.word	0x1
	.byte	0x52
	.quad	.LVL165-.Ltext0
	.quad	.LVL167-.Ltext0
	.word	0x1
	.byte	0x52
	.quad	.LVL167-.Ltext0
	.quad	.LVL171-.Ltext0
	.word	0x1
	.byte	0x58
	.quad	.LVL171-.Ltext0
	.quad	.LFE19-.Ltext0
	.word	0x1
	.byte	0x52
	.quad	0
	.quad	0
.LLST33:
	.quad	.LVL94-.Ltext0
	.quad	.LVL98-.Ltext0
	.word	0x1
	.byte	0x51
	.quad	.LVL98-.Ltext0
	.quad	.LVL104-.Ltext0
	.word	0x1
	.byte	0x59
	.quad	.LVL114-.Ltext0
	.quad	.LVL119-.Ltext0
	.word	0x1
	.byte	0x51
	.quad	.LVL119-.Ltext0
	.quad	.LVL122-.Ltext0
	.word	0x1
	.byte	0x59
	.quad	.LVL122-.Ltext0
	.quad	.LVL125-.Ltext0
	.word	0x1
	.byte	0x51
	.quad	.LVL125-.Ltext0
	.quad	.LVL128-.Ltext0
	.word	0x1
	.byte	0x59
	.quad	.LVL137-.Ltext0
	.quad	.LVL138-.Ltext0
	.word	0x1
	.byte	0x51
	.quad	.LVL138-.Ltext0
	.quad	.LVL142-.Ltext0
	.word	0x1
	.byte	0x59
	.quad	.LVL151-.Ltext0
	.quad	.LVL153-.Ltext0
	.word	0x1
	.byte	0x59
	.quad	.LVL165-.Ltext0
	.quad	.LVL168-.Ltext0
	.word	0x1
	.byte	0x51
	.quad	.LVL168-.Ltext0
	.quad	.LFE19-.Ltext0
	.word	0x1
	.byte	0x59
	.quad	0
	.quad	0
.LLST34:
	.quad	.LVL94-.Ltext0
	.quad	.LVL98-.Ltext0
	.word	0x1
	.byte	0x58
	.quad	.LVL98-.Ltext0
	.quad	.LVL102-.Ltext0
	.word	0x1
	.byte	0x52
	.quad	.LVL114-.Ltext0
	.quad	.LVL120-.Ltext0
	.word	0x1
	.byte	0x58
	.quad	.LVL120-.Ltext0
	.quad	.LVL122-.Ltext0
	.word	0x1
	.byte	0x51
	.quad	.LVL122-.Ltext0
	.quad	.LVL123-.Ltext0
	.word	0x1
	.byte	0x58
	.quad	.LVL123-.Ltext0
	.quad	.LVL126-.Ltext0
	.word	0x4
	.byte	0xf3
	.uleb128 0x1
	.byte	0x58
	.byte	0x9f
	.quad	.LVL137-.Ltext0
	.quad	.LVL142-.Ltext0
	.word	0x1
	.byte	0x58
	.quad	.LVL151-.Ltext0
	.quad	.LVL152-.Ltext0
	.word	0x1
	.byte	0x58
	.quad	.LVL165-.Ltext0
	.quad	.LVL167-.Ltext0
	.word	0x1
	.byte	0x58
	.quad	.LVL167-.Ltext0
	.quad	.LVL170-.Ltext0
	.word	0x1
	.byte	0x52
	.quad	.LVL170-.Ltext0
	.quad	.LFE19-.Ltext0
	.word	0x1
	.byte	0x54
	.quad	0
	.quad	0
.LLST35:
	.quad	.LVL94-.Ltext0
	.quad	.LVL98-.Ltext0
	.word	0x1
	.byte	0x59
	.quad	.LVL98-.Ltext0
	.quad	.LVL101-.Ltext0
	.word	0x1
	.byte	0x51
	.quad	.LVL114-.Ltext0
	.quad	.LVL118-.Ltext0
	.word	0x1
	.byte	0x59
	.quad	.LVL118-.Ltext0
	.quad	.LVL122-.Ltext0
	.word	0x4
	.byte	0xf3
	.uleb128 0x1
	.byte	0x59
	.byte	0x9f
	.quad	.LVL122-.Ltext0
	.quad	.LVL124-.Ltext0
	.word	0x1
	.byte	0x59
	.quad	.LVL124-.Ltext0
	.quad	.LVL126-.Ltext0
	.word	0x1
	.byte	0x58
	.quad	.LVL126-.Ltext0
	.quad	.LVL127-.Ltext0
	.word	0x1
	.byte	0x51
	.quad	.LVL137-.Ltext0
	.quad	.LVL138-.Ltext0
	.word	0x1
	.byte	0x59
	.quad	.LVL138-.Ltext0
	.quad	.LVL140-.Ltext0
	.word	0x1
	.byte	0x51
	.quad	.LVL151-.Ltext0
	.quad	.LVL154-.Ltext0
	.word	0x1
	.byte	0x51
	.quad	.LVL165-.Ltext0
	.quad	.LVL166-.Ltext0
	.word	0x1
	.byte	0x59
	.quad	.LVL166-.Ltext0
	.quad	.LVL169-.Ltext0
	.word	0x1
	.byte	0x54
	.quad	.LVL169-.Ltext0
	.quad	.LFE19-.Ltext0
	.word	0x1
	.byte	0x51
	.quad	0
	.quad	0
.LLST36:
	.quad	.LVL94-.Ltext0
	.quad	.LVL95-.Ltext0
	.word	0x2
	.byte	0x91
	.sleb128 32
	.quad	.LVL96-.Ltext0
	.quad	.LVL97-.Ltext0
	.word	0x5
	.byte	0x53
	.byte	0x93
	.uleb128 0x1
	.byte	0x93
	.uleb128 0x1
	.quad	.LVL97-.Ltext0
	.quad	.LVL113-.Ltext0
	.word	0x6
	.byte	0x5b
	.byte	0x93
	.uleb128 0x1
	.byte	0x53
	.byte	0x93
	.uleb128 0x1
	.quad	.LVL113-.Ltext0
	.quad	.LVL114-.Ltext0
	.word	0xd
	.byte	0x5b
	.byte	0x93
	.uleb128 0x1
	.byte	0x91
	.sleb128 32
	.byte	0x94
	.byte	0x2
	.byte	0x9
	.byte	0xf8
	.byte	0x24
	.byte	0x9f
	.byte	0x93
	.uleb128 0x1
	.quad	.LVL114-.Ltext0
	.quad	.LVL136-.Ltext0
	.word	0x6
	.byte	0x5b
	.byte	0x93
	.uleb128 0x1
	.byte	0x53
	.byte	0x93
	.uleb128 0x1
	.quad	.LVL136-.Ltext0
	.quad	.LVL137-.Ltext0
	.word	0x7
	.byte	0x5b
	.byte	0x93
	.uleb128 0x1
	.byte	0x79
	.sleb128 1
	.byte	0x93
	.uleb128 0x1
	.quad	.LVL137-.Ltext0
	.quad	.LVL150-.Ltext0
	.word	0x6
	.byte	0x5b
	.byte	0x93
	.uleb128 0x1
	.byte	0x53
	.byte	0x93
	.uleb128 0x1
	.quad	.LVL150-.Ltext0
	.quad	.LVL151-.Ltext0
	.word	0x7
	.byte	0x5b
	.byte	0x93
	.uleb128 0x1
	.byte	0x79
	.sleb128 1
	.byte	0x93
	.uleb128 0x1
	.quad	.LVL151-.Ltext0
	.quad	.LVL162-.Ltext0
	.word	0x6
	.byte	0x5b
	.byte	0x93
	.uleb128 0x1
	.byte	0x53
	.byte	0x93
	.uleb128 0x1
	.quad	.LVL162-.Ltext0
	.quad	.LVL165-.Ltext0
	.word	0x7
	.byte	0x5b
	.byte	0x93
	.uleb128 0x1
	.byte	0x72
	.sleb128 1
	.byte	0x93
	.uleb128 0x1
	.quad	.LVL165-.Ltext0
	.quad	.LFE19-.Ltext0
	.word	0x6
	.byte	0x5b
	.byte	0x93
	.uleb128 0x1
	.byte	0x53
	.byte	0x93
	.uleb128 0x1
	.quad	0
	.quad	0
.LLST37:
	.quad	.LVL98-.Ltext0
	.quad	.LVL101-.Ltext0
	.word	0x1
	.byte	0x59
	.quad	.LVL167-.Ltext0
	.quad	.LVL171-.Ltext0
	.word	0x1
	.byte	0x58
	.quad	.LVL171-.Ltext0
	.quad	.LFE19-.Ltext0
	.word	0x1
	.byte	0x52
	.quad	0
	.quad	0
.LLST38:
	.quad	.LVL97-.Ltext0
	.quad	.LVL112-.Ltext0
	.word	0x2
	.byte	0x30
	.byte	0x9f
	.quad	.LVL114-.Ltext0
	.quad	.LVL138-.Ltext0
	.word	0x2
	.byte	0x30
	.byte	0x9f
	.quad	.LVL138-.Ltext0
	.quad	.LVL165-.Ltext0
	.word	0x2
	.byte	0x31
	.byte	0x9f
	.quad	.LVL165-.Ltext0
	.quad	.LVL167-.Ltext0
	.word	0x2
	.byte	0x30
	.byte	0x9f
	.quad	.LVL167-.Ltext0
	.quad	.LFE19-.Ltext0
	.word	0x2
	.byte	0x31
	.byte	0x9f
	.quad	0
	.quad	0
.LLST39:
	.quad	.LVL101-.Ltext0
	.quad	.LVL103-.Ltext0
	.word	0x1
	.byte	0x58
	.quad	.LVL103-.Ltext0
	.quad	.LVL104-.Ltext0
	.word	0x1
	.byte	0x5c
	.quad	.LVL104-.Ltext0
	.quad	.LVL105-.Ltext0
	.word	0x3
	.byte	0x74
	.sleb128 1
	.byte	0x9f
	.quad	.LVL105-.Ltext0
	.quad	.LVL111-.Ltext0
	.word	0x1
	.byte	0x5c
	.quad	.LVL111-.Ltext0
	.quad	.LVL112-.Ltext0
	.word	0x3
	.byte	0x74
	.sleb128 1
	.byte	0x9f
	.quad	.LVL117-.Ltext0
	.quad	.LVL121-.Ltext0
	.word	0x1
	.byte	0x52
	.quad	.LVL121-.Ltext0
	.quad	.LVL122-.Ltext0
	.word	0x1
	.byte	0x58
	.quad	.LVL126-.Ltext0
	.quad	.LVL137-.Ltext0
	.word	0x1
	.byte	0x58
	.quad	.LVL139-.Ltext0
	.quad	.LVL151-.Ltext0
	.word	0x1
	.byte	0x58
	.quad	.LVL151-.Ltext0
	.quad	.LVL154-.Ltext0
	.word	0x1
	.byte	0x52
	.quad	.LVL154-.Ltext0
	.quad	.LVL155-.Ltext0
	.word	0x3
	.byte	0x74
	.sleb128 1
	.byte	0x9f
	.quad	.LVL155-.Ltext0
	.quad	.LVL161-.Ltext0
	.word	0x1
	.byte	0x5c
	.quad	.LVL161-.Ltext0
	.quad	.LVL163-.Ltext0
	.word	0x3
	.byte	0x74
	.sleb128 1
	.byte	0x9f
	.quad	.LVL163-.Ltext0
	.quad	.LVL164-.Ltext0
	.word	0x3
	.byte	0x7c
	.sleb128 1
	.byte	0x9f
	.quad	0
	.quad	0
.LLST40:
	.quad	.LVL101-.Ltext0
	.quad	.LVL112-.Ltext0
	.word	0x1
	.byte	0x59
	.quad	.LVL117-.Ltext0
	.quad	.LVL119-.Ltext0
	.word	0x1
	.byte	0x51
	.quad	.LVL119-.Ltext0
	.quad	.LVL122-.Ltext0
	.word	0x1
	.byte	0x59
	.quad	.LVL126-.Ltext0
	.quad	.LVL128-.Ltext0
	.word	0x1
	.byte	0x59
	.quad	.LVL139-.Ltext0
	.quad	.LVL142-.Ltext0
	.word	0x1
	.byte	0x59
	.quad	.LVL151-.Ltext0
	.quad	.LVL165-.Ltext0
	.word	0x1
	.byte	0x51
	.quad	0
	.quad	0
.LLST41:
	.quad	.LVL99-.Ltext0
	.quad	.LVL114-.Ltext0
	.word	0x1
	.byte	0x50
	.quad	.LVL115-.Ltext0
	.quad	.LFE19-.Ltext0
	.word	0x1
	.byte	0x50
	.quad	0
	.quad	0
.LLST42:
	.quad	.LVL100-.Ltext0
	.quad	.LVL114-.Ltext0
	.word	0x1
	.byte	0x5a
	.quad	.LVL115-.Ltext0
	.quad	.LVL116-.Ltext0
	.word	0x6
	.byte	0x7a
	.sleb128 0
	.byte	0x71
	.sleb128 0
	.byte	0x1c
	.byte	0x9f
	.quad	.LVL116-.Ltext0
	.quad	.LFE19-.Ltext0
	.word	0x1
	.byte	0x5a
	.quad	0
	.quad	0
.LLST43:
	.quad	.LVL97-.Ltext0
	.quad	.LVL104-.Ltext0
	.word	0x2
	.byte	0x30
	.byte	0x9f
	.quad	.LVL104-.Ltext0
	.quad	.LVL107-.Ltext0
	.word	0x1
	.byte	0x52
	.quad	.LVL109-.Ltext0
	.quad	.LVL112-.Ltext0
	.word	0x1
	.byte	0x52
	.quad	.LVL114-.Ltext0
	.quad	.LVL128-.Ltext0
	.word	0x2
	.byte	0x30
	.byte	0x9f
	.quad	.LVL128-.Ltext0
	.quad	.LVL130-.Ltext0
	.word	0x1
	.byte	0x51
	.quad	.LVL133-.Ltext0
	.quad	.LVL137-.Ltext0
	.word	0x1
	.byte	0x51
	.quad	.LVL137-.Ltext0
	.quad	.LVL142-.Ltext0
	.word	0x2
	.byte	0x30
	.byte	0x9f
	.quad	.LVL142-.Ltext0
	.quad	.LVL144-.Ltext0
	.word	0x1
	.byte	0x51
	.quad	.LVL147-.Ltext0
	.quad	.LVL151-.Ltext0
	.word	0x1
	.byte	0x51
	.quad	.LVL151-.Ltext0
	.quad	.LVL154-.Ltext0
	.word	0x2
	.byte	0x30
	.byte	0x9f
	.quad	.LVL154-.Ltext0
	.quad	.LVL157-.Ltext0
	.word	0x1
	.byte	0x59
	.quad	.LVL159-.Ltext0
	.quad	.LVL165-.Ltext0
	.word	0x1
	.byte	0x59
	.quad	.LVL165-.Ltext0
	.quad	.LFE19-.Ltext0
	.word	0x2
	.byte	0x30
	.byte	0x9f
	.quad	0
	.quad	0
.LLST44:
	.quad	.LVL104-.Ltext0
	.quad	.LVL105-.Ltext0
	.word	0x6
	.byte	0x5b
	.byte	0x93
	.uleb128 0x1
	.byte	0x53
	.byte	0x93
	.uleb128 0x1
	.quad	.LVL105-.Ltext0
	.quad	.LVL112-.Ltext0
	.word	0x6
	.byte	0x5b
	.byte	0x93
	.uleb128 0x1
	.byte	0x53
	.byte	0x93
	.uleb128 0x1
	.quad	0
	.quad	0
.LLST45:
	.quad	.LVL105-.Ltext0
	.quad	.LVL106-.Ltext0
	.word	0x9
	.byte	0x79
	.sleb128 0
	.byte	0x8
	.byte	0x20
	.byte	0x24
	.byte	0x8
	.byte	0x20
	.byte	0x26
	.byte	0x9f
	.quad	.LVL106-.Ltext0
	.quad	.LVL108-.Ltext0
	.word	0x1
	.byte	0x55
	.quad	.LVL108-.Ltext0
	.quad	.LVL109-.Ltext0
	.word	0x9
	.byte	0x79
	.sleb128 0
	.byte	0x8
	.byte	0x20
	.byte	0x24
	.byte	0x8
	.byte	0x20
	.byte	0x26
	.byte	0x9f
	.quad	0
	.quad	0
.LLST46:
	.quad	.LVL105-.Ltext0
	.quad	.LVL109-.Ltext0
	.word	0x1
	.byte	0x5c
	.quad	0
	.quad	0
.LLST47:
	.quad	.LVL128-.Ltext0
	.quad	.LVL136-.Ltext0
	.word	0x6
	.byte	0x5b
	.byte	0x93
	.uleb128 0x1
	.byte	0x53
	.byte	0x93
	.uleb128 0x1
	.quad	.LVL136-.Ltext0
	.quad	.LVL137-.Ltext0
	.word	0x7
	.byte	0x5b
	.byte	0x93
	.uleb128 0x1
	.byte	0x79
	.sleb128 1
	.byte	0x93
	.uleb128 0x1
	.quad	0
	.quad	0
.LLST48:
	.quad	.LVL128-.Ltext0
	.quad	.LVL129-.Ltext0
	.word	0x9
	.byte	0x78
	.sleb128 0
	.byte	0x8
	.byte	0x20
	.byte	0x24
	.byte	0x8
	.byte	0x20
	.byte	0x26
	.byte	0x9f
	.quad	.LVL129-.Ltext0
	.quad	.LVL131-.Ltext0
	.word	0x1
	.byte	0x59
	.quad	.LVL131-.Ltext0
	.quad	.LVL133-.Ltext0
	.word	0x9
	.byte	0x78
	.sleb128 0
	.byte	0x8
	.byte	0x20
	.byte	0x24
	.byte	0x8
	.byte	0x20
	.byte	0x26
	.byte	0x9f
	.quad	0
	.quad	0
.LLST49:
	.quad	.LVL142-.Ltext0
	.quad	.LVL150-.Ltext0
	.word	0x6
	.byte	0x5b
	.byte	0x93
	.uleb128 0x1
	.byte	0x53
	.byte	0x93
	.uleb128 0x1
	.quad	.LVL150-.Ltext0
	.quad	.LVL151-.Ltext0
	.word	0x7
	.byte	0x5b
	.byte	0x93
	.uleb128 0x1
	.byte	0x79
	.sleb128 1
	.byte	0x93
	.uleb128 0x1
	.quad	0
	.quad	0
.LLST50:
	.quad	.LVL142-.Ltext0
	.quad	.LVL143-.Ltext0
	.word	0x9
	.byte	0x78
	.sleb128 0
	.byte	0x8
	.byte	0x20
	.byte	0x24
	.byte	0x8
	.byte	0x20
	.byte	0x26
	.byte	0x9f
	.quad	.LVL143-.Ltext0
	.quad	.LVL145-.Ltext0
	.word	0x1
	.byte	0x59
	.quad	.LVL145-.Ltext0
	.quad	.LVL147-.Ltext0
	.word	0x9
	.byte	0x78
	.sleb128 0
	.byte	0x8
	.byte	0x20
	.byte	0x24
	.byte	0x8
	.byte	0x20
	.byte	0x26
	.byte	0x9f
	.quad	0
	.quad	0
.LLST51:
	.quad	.LVL154-.Ltext0
	.quad	.LVL155-.Ltext0
	.word	0x6
	.byte	0x5b
	.byte	0x93
	.uleb128 0x1
	.byte	0x53
	.byte	0x93
	.uleb128 0x1
	.quad	.LVL155-.Ltext0
	.quad	.LVL162-.Ltext0
	.word	0x6
	.byte	0x5b
	.byte	0x93
	.uleb128 0x1
	.byte	0x53
	.byte	0x93
	.uleb128 0x1
	.quad	.LVL162-.Ltext0
	.quad	.LVL165-.Ltext0
	.word	0x7
	.byte	0x5b
	.byte	0x93
	.uleb128 0x1
	.byte	0x72
	.sleb128 1
	.byte	0x93
	.uleb128 0x1
	.quad	0
	.quad	0
.LLST52:
	.quad	.LVL155-.Ltext0
	.quad	.LVL156-.Ltext0
	.word	0x9
	.byte	0x71
	.sleb128 0
	.byte	0x8
	.byte	0x20
	.byte	0x24
	.byte	0x8
	.byte	0x20
	.byte	0x26
	.byte	0x9f
	.quad	.LVL156-.Ltext0
	.quad	.LVL158-.Ltext0
	.word	0x1
	.byte	0x52
	.quad	.LVL158-.Ltext0
	.quad	.LVL159-.Ltext0
	.word	0x9
	.byte	0x71
	.sleb128 0
	.byte	0x8
	.byte	0x20
	.byte	0x24
	.byte	0x8
	.byte	0x20
	.byte	0x26
	.byte	0x9f
	.quad	0
	.quad	0
.LLST53:
	.quad	.LVL155-.Ltext0
	.quad	.LVL159-.Ltext0
	.word	0x1
	.byte	0x5c
	.quad	0
	.quad	0
.LLST28:
	.quad	.LVL88-.Ltext0
	.quad	.LVL90-.Ltext0
	.word	0x1
	.byte	0x52
	.quad	.LVL90-.Ltext0
	.quad	.LFE18-.Ltext0
	.word	0x4
	.byte	0xf3
	.uleb128 0x1
	.byte	0x52
	.byte	0x9f
	.quad	0
	.quad	0
.LLST29:
	.quad	.LVL88-.Ltext0
	.quad	.LVL91-.Ltext0
	.word	0x1
	.byte	0x51
	.quad	.LVL91-.Ltext0
	.quad	.LFE18-.Ltext0
	.word	0x4
	.byte	0xf3
	.uleb128 0x1
	.byte	0x51
	.byte	0x9f
	.quad	0
	.quad	0
.LLST30:
	.quad	.LVL89-.Ltext0
	.quad	.LVL90-.Ltext0
	.word	0xa
	.byte	0x71
	.sleb128 0
	.byte	0xa
	.word	0x320
	.byte	0x1e
	.byte	0x72
	.sleb128 0
	.byte	0x22
	.byte	0x9f
	.quad	.LVL90-.Ltext0
	.quad	.LVL91-.Ltext0
	.word	0xb
	.byte	0x71
	.sleb128 0
	.byte	0xa
	.word	0x320
	.byte	0x1e
	.byte	0xf3
	.uleb128 0x1
	.byte	0x52
	.byte	0x22
	.byte	0x9f
	.quad	.LVL91-.Ltext0
	.quad	.LFE18-.Ltext0
	.word	0xc
	.byte	0xf3
	.uleb128 0x1
	.byte	0x51
	.byte	0xa
	.word	0x320
	.byte	0x1e
	.byte	0xf3
	.uleb128 0x1
	.byte	0x52
	.byte	0x22
	.byte	0x9f
	.quad	0
	.quad	0
.LLST31:
	.quad	.LVL91-.Ltext0
	.quad	.LVL92-.Ltext0
	.word	0x6
	.byte	0x71
	.sleb128 0
	.byte	0x93
	.uleb128 0x1
	.byte	0x93
	.uleb128 0x1
	.quad	.LVL92-.Ltext0
	.quad	.LVL93-.Ltext0
	.word	0x7
	.byte	0x71
	.sleb128 0
	.byte	0x93
	.uleb128 0x1
	.byte	0x52
	.byte	0x93
	.uleb128 0x1
	.quad	0
	.quad	0
.LLST25:
	.quad	.LVL83-.Ltext0
	.quad	.LVL84-.Ltext0
	.word	0x1
	.byte	0x51
	.quad	.LVL84-.Ltext0
	.quad	.LFE16-.Ltext0
	.word	0x1
	.byte	0x50
	.quad	0
	.quad	0
.LLST24:
	.quad	.LVL81-.Ltext0
	.quad	.LVL82-.Ltext0
	.word	0x1
	.byte	0x51
	.quad	.LVL82-.Ltext0
	.quad	.LFE15-.Ltext0
	.word	0x4
	.byte	0xf3
	.uleb128 0x1
	.byte	0x51
	.byte	0x9f
	.quad	0
	.quad	0
.LLST23:
	.quad	.LVL79-.Ltext0
	.quad	.LVL80-.Ltext0
	.word	0x1
	.byte	0x51
	.quad	.LVL80-.Ltext0
	.quad	.LFE14-.Ltext0
	.word	0x4
	.byte	0xf3
	.uleb128 0x1
	.byte	0x51
	.byte	0x9f
	.quad	0
	.quad	0
.LLST20:
	.quad	.LVL57-.Ltext0
	.quad	.LVL58-.Ltext0
	.word	0x2
	.byte	0x30
	.byte	0x9f
	.quad	.LVL58-.Ltext0
	.quad	.LVL59-.Ltext0
	.word	0x3
	.byte	0x71
	.sleb128 1
	.byte	0x9f
	.quad	.LVL60-.Ltext0
	.quad	.LVL61-.Ltext0
	.word	0x1
	.byte	0x51
	.quad	.LVL61-.Ltext0
	.quad	.LVL64-.Ltext0
	.word	0x1
	.byte	0x58
	.quad	.LVL66-.Ltext0
	.quad	.LVL67-.Ltext0
	.word	0x1
	.byte	0x58
	.quad	.LVL70-.Ltext0
	.quad	.LFE10-.Ltext0
	.word	0x1
	.byte	0x58
	.quad	0
	.quad	0
.LLST21:
	.quad	.LVL57-.Ltext0
	.quad	.LVL62-.Ltext0
	.word	0x2
	.byte	0x30
	.byte	0x9f
	.quad	.LVL62-.Ltext0
	.quad	.LVL72-.Ltext0
	.word	0x1
	.byte	0x50
	.quad	.LVL72-.Ltext0
	.quad	.LFE10-.Ltext0
	.word	0x2
	.byte	0x30
	.byte	0x9f
	.quad	0
	.quad	0
.LLST22:
	.quad	.LVL57-.Ltext0
	.quad	.LVL62-.Ltext0
	.word	0x2
	.byte	0x31
	.byte	0x9f
	.quad	.LVL62-.Ltext0
	.quad	.LVL68-.Ltext0
	.word	0x1
	.byte	0x59
	.quad	.LVL69-.Ltext0
	.quad	.LVL72-.Ltext0
	.word	0x1
	.byte	0x59
	.quad	.LVL72-.Ltext0
	.quad	.LFE10-.Ltext0
	.word	0x2
	.byte	0x31
	.byte	0x9f
	.quad	0
	.quad	0
.LLST17:
	.quad	.LVL47-.Ltext0
	.quad	.LVL48-.Ltext0
	.word	0x2
	.byte	0x30
	.byte	0x9f
	.quad	.LVL49-.Ltext0
	.quad	.LVL50-.Ltext0
	.word	0x3
	.byte	0x70
	.sleb128 1
	.byte	0x9f
	.quad	.LVL50-.Ltext0
	.quad	.LVL51-.Ltext0
	.word	0x3
	.byte	0x79
	.sleb128 1
	.byte	0x9f
	.quad	.LVL51-.Ltext0
	.quad	.LVL52-.Ltext0
	.word	0x1
	.byte	0x59
	.quad	.LVL55-.Ltext0
	.quad	.LFE9-.Ltext0
	.word	0x2
	.byte	0x30
	.byte	0x9f
	.quad	0
	.quad	0
.LLST18:
	.quad	.LVL47-.Ltext0
	.quad	.LVL51-.Ltext0
	.word	0x2
	.byte	0x30
	.byte	0x9f
	.quad	.LVL51-.Ltext0
	.quad	.LVL55-.Ltext0
	.word	0x1
	.byte	0x50
	.quad	.LVL55-.Ltext0
	.quad	.LFE9-.Ltext0
	.word	0x2
	.byte	0x30
	.byte	0x9f
	.quad	0
	.quad	0
.LLST19:
	.quad	.LVL47-.Ltext0
	.quad	.LVL51-.Ltext0
	.word	0x2
	.byte	0x31
	.byte	0x9f
	.quad	.LVL51-.Ltext0
	.quad	.LVL53-.Ltext0
	.word	0x1
	.byte	0x58
	.quad	.LVL55-.Ltext0
	.quad	.LFE9-.Ltext0
	.word	0x2
	.byte	0x31
	.byte	0x9f
	.quad	0
	.quad	0
.LLST15:
	.quad	.LVL41-.Ltext0
	.quad	.LVL42-.Ltext0
	.word	0x1
	.byte	0x52
	.quad	.LVL42-.Ltext0
	.quad	.LVL43-.Ltext0
	.word	0x3
	.byte	0x72
	.sleb128 1
	.byte	0x9f
	.quad	.LVL43-.Ltext0
	.quad	.LVL45-.Ltext0
	.word	0x8
	.byte	0x70
	.sleb128 0
	.byte	0x72
	.sleb128 0
	.byte	0x22
	.byte	0x23
	.uleb128 0x1
	.byte	0x9f
	.quad	.LVL45-.Ltext0
	.quad	.LFE8-.Ltext0
	.word	0x3
	.byte	0x72
	.sleb128 1
	.byte	0x9f
	.quad	0
	.quad	0
.LLST16:
	.quad	.LVL42-.Ltext0
	.quad	.LVL43-.Ltext0
	.word	0x2
	.byte	0x30
	.byte	0x9f
	.quad	.LVL43-.Ltext0
	.quad	.LVL45-.Ltext0
	.word	0x1
	.byte	0x50
	.quad	.LVL45-.Ltext0
	.quad	.LFE8-.Ltext0
	.word	0x2
	.byte	0x30
	.byte	0x9f
	.quad	0
	.quad	0
.LLST13:
	.quad	.LVL35-.Ltext0
	.quad	.LVL37-.Ltext0
	.word	0x1
	.byte	0x51
	.quad	.LVL37-.Ltext0
	.quad	.LFE7-.Ltext0
	.word	0x1
	.byte	0x58
	.quad	0
	.quad	0
.LLST14:
	.quad	.LVL36-.Ltext0
	.quad	.LVL37-.Ltext0
	.word	0x2
	.byte	0x30
	.byte	0x9f
	.quad	.LVL37-.Ltext0
	.quad	.LVL40-.Ltext0
	.word	0x1
	.byte	0x50
	.quad	0
	.quad	0
.LLST11:
	.quad	.LVL30-.Ltext0
	.quad	.LVL31-.Ltext0
	.word	0x1
	.byte	0x52
	.quad	.LVL31-.Ltext0
	.quad	.LFE6-.Ltext0
	.word	0x1
	.byte	0x50
	.quad	0
	.quad	0
.LLST12:
	.quad	.LVL30-.Ltext0
	.quad	.LVL34-.Ltext0
	.word	0x1
	.byte	0x51
	.quad	.LVL34-.Ltext0
	.quad	.LFE6-.Ltext0
	.word	0x1
	.byte	0x51
	.quad	0
	.quad	0
.LLST9:
	.quad	.LVL25-.Ltext0
	.quad	.LVL26-.Ltext0
	.word	0x1
	.byte	0x58
	.quad	.LVL26-.Ltext0
	.quad	.LFE5-.Ltext0
	.word	0x4
	.byte	0xf3
	.uleb128 0x1
	.byte	0x58
	.byte	0x9f
	.quad	0
	.quad	0
.LLST10:
	.quad	.LVL26-.Ltext0
	.quad	.LVL27-.Ltext0
	.word	0x1
	.byte	0x58
	.quad	.LVL27-.Ltext0
	.quad	.LVL28-.Ltext0
	.word	0x1
	.byte	0x50
	.quad	.LVL28-.Ltext0
	.quad	.LVL29-.Ltext0
	.word	0x3
	.byte	0x70
	.sleb128 -1
	.byte	0x9f
	.quad	0
	.quad	0
.LLST7:
	.quad	.LVL21-.Ltext0
	.quad	.LVL22-.Ltext0
	.word	0x1
	.byte	0x52
	.quad	.LVL22-.Ltext0
	.quad	.LVL24-.Ltext0
	.word	0x1
	.byte	0x52
	.quad	.LVL24-.Ltext0
	.quad	.LFE4-.Ltext0
	.word	0x3
	.byte	0x72
	.sleb128 2
	.byte	0x9f
	.quad	0
	.quad	0
.LLST8:
	.quad	.LVL21-.Ltext0
	.quad	.LVL23-.Ltext0
	.word	0x1
	.byte	0x51
	.quad	.LVL23-.Ltext0
	.quad	.LFE4-.Ltext0
	.word	0x1
	.byte	0x51
	.quad	0
	.quad	0
.LLST5:
	.quad	.LVL14-.Ltext0
	.quad	.LVL15-.Ltext0
	.word	0x2
	.byte	0x30
	.byte	0x9f
	.quad	.LVL15-.Ltext0
	.quad	.LVL18-.Ltext0
	.word	0x1
	.byte	0x50
	.quad	.LVL20-.Ltext0
	.quad	.LFE3-.Ltext0
	.word	0x2
	.byte	0x30
	.byte	0x9f
	.quad	0
	.quad	0
.LLST6:
	.quad	.LVL14-.Ltext0
	.quad	.LVL19-.Ltext0
	.word	0x2
	.byte	0x30
	.byte	0x9f
	.quad	.LVL19-.Ltext0
	.quad	.LVL20-.Ltext0
	.word	0x2
	.byte	0x31
	.byte	0x9f
	.quad	.LVL20-.Ltext0
	.quad	.LFE3-.Ltext0
	.word	0x2
	.byte	0x30
	.byte	0x9f
	.quad	0
	.quad	0
.LLST0:
	.quad	.LVL2-.Ltext0
	.quad	.LVL3-.Ltext0
	.word	0x1
	.byte	0x58
	.quad	.LVL3-.Ltext0
	.quad	.LVL4-.Ltext0
	.word	0x3
	.byte	0x78
	.sleb128 -1
	.byte	0x9f
	.quad	.LVL4-.Ltext0
	.quad	.LVL5-.Ltext0
	.word	0x7
	.byte	0x70
	.sleb128 0
	.byte	0x20
	.byte	0x78
	.sleb128 0
	.byte	0x22
	.byte	0x9f
	.quad	.LVL5-.Ltext0
	.quad	.LVL6-.Ltext0
	.word	0x8
	.byte	0x78
	.sleb128 0
	.byte	0x70
	.sleb128 0
	.byte	0x1c
	.byte	0x32
	.byte	0x1c
	.byte	0x9f
	.quad	.LVL6-.Ltext0
	.quad	.LVL7-.Ltext0
	.word	0x7
	.byte	0x70
	.sleb128 0
	.byte	0x20
	.byte	0x78
	.sleb128 0
	.byte	0x22
	.byte	0x9f
	.quad	0
	.quad	0
.LLST1:
	.quad	.LVL3-.Ltext0
	.quad	.LVL4-.Ltext0
	.word	0x1
	.byte	0x52
	.quad	.LVL4-.Ltext0
	.quad	.LVL6-.Ltext0
	.word	0x8
	.byte	0x70
	.sleb128 0
	.byte	0x72
	.sleb128 0
	.byte	0x22
	.byte	0x23
	.uleb128 0x1
	.byte	0x9f
	.quad	.LVL6-.Ltext0
	.quad	.LVL7-.Ltext0
	.word	0x6
	.byte	0x70
	.sleb128 0
	.byte	0x72
	.sleb128 0
	.byte	0x22
	.byte	0x9f
	.quad	0
	.quad	0
.LLST2:
	.quad	.LVL3-.Ltext0
	.quad	.LVL4-.Ltext0
	.word	0x1
	.byte	0x51
	.quad	.LVL4-.Ltext0
	.quad	.LVL6-.Ltext0
	.word	0x8
	.byte	0x70
	.sleb128 0
	.byte	0x71
	.sleb128 0
	.byte	0x22
	.byte	0x23
	.uleb128 0x1
	.byte	0x9f
	.quad	.LVL6-.Ltext0
	.quad	.LVL7-.Ltext0
	.word	0x6
	.byte	0x70
	.sleb128 0
	.byte	0x71
	.sleb128 0
	.byte	0x22
	.byte	0x9f
	.quad	0
	.quad	0
.LLST3:
	.quad	.LVL8-.Ltext0
	.quad	.LVL10-.Ltext0
	.word	0x1
	.byte	0x52
	.quad	.LVL10-.Ltext0
	.quad	.LFE2-.Ltext0
	.word	0x4
	.byte	0xf3
	.uleb128 0x1
	.byte	0x52
	.byte	0x9f
	.quad	0
	.quad	0
.LLST4:
	.quad	.LVL8-.Ltext0
	.quad	.LVL9-.Ltext0
	.word	0x1
	.byte	0x58
	.quad	.LVL9-.Ltext0
	.quad	.LVL10-.Ltext0
	.word	0x3
	.byte	0x78
	.sleb128 -1
	.byte	0x9f
	.quad	.LVL10-.Ltext0
	.quad	.LVL12-.Ltext0
	.word	0xa
	.byte	0x72
	.sleb128 0
	.byte	0x20
	.byte	0x72
	.sleb128 0
	.byte	0x22
	.byte	0x78
	.sleb128 0
	.byte	0x22
	.byte	0x9f
	.quad	0
	.quad	0
.LLST26:
	.quad	.LVL85-.Ltext0
	.quad	.LVL87-.Ltext0
	.word	0x1
	.byte	0x52
	.quad	.LVL87-.Ltext0
	.quad	.LFE17-.Ltext0
	.word	0x4
	.byte	0xf3
	.uleb128 0x1
	.byte	0x52
	.byte	0x9f
	.quad	0
	.quad	0
.LLST27:
	.quad	.LVL86-.Ltext0
	.quad	.LVL87-.Ltext0
	.word	0xa
	.byte	0x71
	.sleb128 0
	.byte	0xa
	.word	0x320
	.byte	0x1e
	.byte	0x72
	.sleb128 0
	.byte	0x22
	.byte	0x9f
	.quad	.LVL87-.Ltext0
	.quad	.LFE17-.Ltext0
	.word	0xb
	.byte	0x71
	.sleb128 0
	.byte	0xa
	.word	0x320
	.byte	0x1e
	.byte	0xf3
	.uleb128 0x1
	.byte	0x52
	.byte	0x22
	.byte	0x9f
	.quad	0
	.quad	0
	.section	.debug_aranges,"dr"
	.long	0x2c
	.word	0x2
	.secrel32	.Ldebug_info0
	.byte	0x8
	.byte	0
	.word	0
	.word	0
	.quad	.Ltext0
	.quad	.Letext0-.Ltext0
	.quad	0
	.quad	0
	.section	.debug_ranges,"dr"
.Ldebug_ranges0:
	.quad	.LBB92-.Ltext0
	.quad	.LBE92-.Ltext0
	.quad	.LBB95-.Ltext0
	.quad	.LBE95-.Ltext0
	.quad	0
	.quad	0
	.quad	.LBB96-.Ltext0
	.quad	.LBE96-.Ltext0
	.quad	.LBB99-.Ltext0
	.quad	.LBE99-.Ltext0
	.quad	0
	.quad	0
	.quad	.LBB100-.Ltext0
	.quad	.LBE100-.Ltext0
	.quad	.LBB103-.Ltext0
	.quad	.LBE103-.Ltext0
	.quad	0
	.quad	0
	.quad	.LBB104-.Ltext0
	.quad	.LBE104-.Ltext0
	.quad	.LBB107-.Ltext0
	.quad	.LBE107-.Ltext0
	.quad	0
	.quad	0
	.quad	.LBB108-.Ltext0
	.quad	.LBE108-.Ltext0
	.quad	.LBB111-.Ltext0
	.quad	.LBE111-.Ltext0
	.quad	0
	.quad	0
	.quad	.LBB112-.Ltext0
	.quad	.LBE112-.Ltext0
	.quad	.LBB116-.Ltext0
	.quad	.LBE116-.Ltext0
	.quad	.LBB117-.Ltext0
	.quad	.LBE117-.Ltext0
	.quad	0
	.quad	0
	.quad	.LBB122-.Ltext0
	.quad	.LBE122-.Ltext0
	.quad	.LBB126-.Ltext0
	.quad	.LBE126-.Ltext0
	.quad	.LBB130-.Ltext0
	.quad	.LBE130-.Ltext0
	.quad	0
	.quad	0
	.quad	.LBB127-.Ltext0
	.quad	.LBE127-.Ltext0
	.quad	.LBB131-.Ltext0
	.quad	.LBE131-.Ltext0
	.quad	0
	.quad	0
	.quad	.LBB134-.Ltext0
	.quad	.LBE134-.Ltext0
	.quad	.LBB141-.Ltext0
	.quad	.LBE141-.Ltext0
	.quad	0
	.quad	0
	.quad	.LBB137-.Ltext0
	.quad	.LBE137-.Ltext0
	.quad	.LBB142-.Ltext0
	.quad	.LBE142-.Ltext0
	.quad	.LBB146-.Ltext0
	.quad	.LBE146-.Ltext0
	.quad	0
	.quad	0
	.quad	.LBB143-.Ltext0
	.quad	.LBE143-.Ltext0
	.quad	.LBB147-.Ltext0
	.quad	.LBE147-.Ltext0
	.quad	0
	.quad	0
	.quad	.LBB154-.Ltext0
	.quad	.LBE154-.Ltext0
	.quad	.LBB161-.Ltext0
	.quad	.LBE161-.Ltext0
	.quad	0
	.quad	0
	.quad	.LBB157-.Ltext0
	.quad	.LBE157-.Ltext0
	.quad	.LBB162-.Ltext0
	.quad	.LBE162-.Ltext0
	.quad	.LBB166-.Ltext0
	.quad	.LBE166-.Ltext0
	.quad	0
	.quad	0
	.quad	.LBB163-.Ltext0
	.quad	.LBE163-.Ltext0
	.quad	.LBB167-.Ltext0
	.quad	.LBE167-.Ltext0
	.quad	0
	.quad	0
	.quad	.LBB170-.Ltext0
	.quad	.LBE170-.Ltext0
	.quad	.LBB173-.Ltext0
	.quad	.LBE173-.Ltext0
	.quad	0
	.quad	0
	.quad	.LBB174-.Ltext0
	.quad	.LBE174-.Ltext0
	.quad	.LBB177-.Ltext0
	.quad	.LBE177-.Ltext0
	.quad	0
	.quad	0
	.quad	.LBB178-.Ltext0
	.quad	.LBE178-.Ltext0
	.quad	.LBB184-.Ltext0
	.quad	.LBE184-.Ltext0
	.quad	0
	.quad	0
	.quad	.LBB181-.Ltext0
	.quad	.LBE181-.Ltext0
	.quad	.LBB185-.Ltext0
	.quad	.LBE185-.Ltext0
	.quad	0
	.quad	0
	.quad	.LBB188-.Ltext0
	.quad	.LBE188-.Ltext0
	.quad	.LBB191-.Ltext0
	.quad	.LBE191-.Ltext0
	.quad	0
	.quad	0
	.quad	.LBB194-.Ltext0
	.quad	.LBE194-.Ltext0
	.quad	.LBB198-.Ltext0
	.quad	.LBE198-.Ltext0
	.quad	.LBB199-.Ltext0
	.quad	.LBE199-.Ltext0
	.quad	0
	.quad	0
	.quad	.LBB200-.Ltext0
	.quad	.LBE200-.Ltext0
	.quad	.LBB203-.Ltext0
	.quad	.LBE203-.Ltext0
	.quad	0
	.quad	0
	.quad	.LBB204-.Ltext0
	.quad	.LBE204-.Ltext0
	.quad	.LBB207-.Ltext0
	.quad	.LBE207-.Ltext0
	.quad	0
	.quad	0
	.quad	.LBB214-.Ltext0
	.quad	.LBE214-.Ltext0
	.quad	.LBB220-.Ltext0
	.quad	.LBE220-.Ltext0
	.quad	0
	.quad	0
	.quad	.LBB217-.Ltext0
	.quad	.LBE217-.Ltext0
	.quad	.LBB221-.Ltext0
	.quad	.LBE221-.Ltext0
	.quad	0
	.quad	0
	.quad	.LBB222-.Ltext0
	.quad	.LBE222-.Ltext0
	.quad	.LBB225-.Ltext0
	.quad	.LBE225-.Ltext0
	.quad	0
	.quad	0
	.quad	.LBB226-.Ltext0
	.quad	.LBE226-.Ltext0
	.quad	.LBB230-.Ltext0
	.quad	.LBE230-.Ltext0
	.quad	.LBB234-.Ltext0
	.quad	.LBE234-.Ltext0
	.quad	0
	.quad	0
	.quad	.LBB231-.Ltext0
	.quad	.LBE231-.Ltext0
	.quad	.LBB235-.Ltext0
	.quad	.LBE235-.Ltext0
	.quad	0
	.quad	0
	.quad	.LBB240-.Ltext0
	.quad	.LBE240-.Ltext0
	.quad	.LBB243-.Ltext0
	.quad	.LBE243-.Ltext0
	.quad	0
	.quad	0
	.quad	.LBB244-.Ltext0
	.quad	.LBE244-.Ltext0
	.quad	.LBB248-.Ltext0
	.quad	.LBE248-.Ltext0
	.quad	.LBB249-.Ltext0
	.quad	.LBE249-.Ltext0
	.quad	0
	.quad	0
	.section	.debug_line,"dr"
.Ldebug_line0:
	.section	.debug_str,"dr"
.LASF4:
	.ascii "data\0"
.LASF1:
	.ascii "pointer\0"
.LASF3:
	.ascii "port\0"
.LASF2:
	.ascii "lfb_index\0"
.LASF0:
	.ascii "property\0"
	.ident	"GCC: (x86_64-win32-sjlj-rev1, Built by MinGW-W64 project) 6.3.0"
