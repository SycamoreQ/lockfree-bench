	.file ""
	.section .debug_info,"",@progbits
.L100:
	.section .debug_abbrev,"",@progbits
.L101:
	.section .debug_aranges,"",@progbits
.L102:
	.section .debug_str,"MS",@progbits,1
.L103:
	.section .debug_line,"",@progbits
.L104:
	.section .debug_loc,"",@progbits
.L105:
	.section .debug_ranges,"",@progbits
.L106:
	.file	1	"none"
	.loc	1	1	1
	.text
	.section .rodata.cst16,"aM",@progbits,16
	.align	16
caml_negf_mask:
	.8byte	0x8000000000000000
	.8byte	0
	.align	16
caml_absf_mask:
	.8byte	0x7fffffffffffffff
	.8byte	-1
caml_negf32_mask:
	.8byte	0x80000000
	.8byte	0
	.align	16
caml_absf32_mask:
	.8byte	0xffffffff7fffffff
	.8byte	-1
	.data
	.globl	camlCounter__data_begin
camlCounter__data_begin:
	.text
	.globl	camlCounter__code_begin
camlCounter__code_begin:
.Lcaml_call_gc_:
	.cfi_startproc
	jmp	caml_call_gc@PLT
	.cfi_endproc
.Lcaml_call_gc_sse_:
	.cfi_startproc
	jmp	caml_call_gc_sse@PLT
	.cfi_endproc
.Lcaml_call_gc_avx_:
	.cfi_startproc
	jmp	caml_call_gc_avx@PLT
	.cfi_endproc
.Lcaml_call_gc_avx512_:
	.cfi_startproc
	jmp	caml_call_gc_avx512@PLT
	.cfi_endproc
	.data
	.align	8
	.globl	camlCounter__gc_roots
camlCounter__gc_roots:
.LcamlCounter__gc_roots:
	.8byte	0
	.data
	.align	8
	.8byte	12032
	.globl	camlCounter
camlCounter:
.LcamlCounter:
	.8byte	camlCounter__make_padded_atomic_0_1
	.8byte	67
	.8byte	33
	.8byte	camlCounter__make_padded_cell_1_2
	.8byte	camlCounter__pause_2_3
	.8byte	camlCounter__Pmakeblock370_8
	.8byte	camlCounter__Pmakeblock415_13
	.8byte	camlCounter__Pmakeblock475_18
	.8byte	camlCounter__Pmakeblock501_22
	.8byte	camlCounter__Pmakeblock596_28
	.8byte	camlCounter__Pmakeblock690_32
	.data
	.align	8
	.8byte	3840
	.globl	camlCounter__Pmakeblock690_32
camlCounter__Pmakeblock690_32:
.LcamlCounter__Pmakeblock690_32:
	.8byte	camlCounter__create_23_29
	.8byte	camlCounter__incr_24_30
	.8byte	camlCounter__get_25_31
	.data
	.align	8
	.8byte	3063
	.globl	camlCounter__get_25_31
camlCounter__get_25_31:
.LcamlCounter__get_25_31:
	.8byte	camlCounter__get_25_51_code
	.8byte	0x180000000000005
	.data
	.align	8
	.8byte	3063
	.globl	camlCounter__incr_24_30
camlCounter__incr_24_30:
.LcamlCounter__incr_24_30:
	.8byte	camlCounter__incr_24_50_code
	.8byte	0x180000000000005
	.data
	.align	8
	.8byte	3063
	.globl	camlCounter__create_23_29
camlCounter__create_23_29:
.LcamlCounter__create_23_29:
	.8byte	camlCounter__create_23_49_code
	.8byte	0x180000000000005
	.data
	.align	8
	.8byte	3840
	.globl	camlCounter__Pmakeblock596_28
camlCounter__Pmakeblock596_28:
.LcamlCounter__Pmakeblock596_28:
	.8byte	camlCounter__create_18_23
	.8byte	camlCounter__incr_21_26
	.8byte	camlCounter__get_22_27
	.data
	.align	8
	.8byte	3063
	.globl	camlCounter__get_22_27
camlCounter__get_22_27:
.LcamlCounter__get_22_27:
	.8byte	camlCounter__get_22_48_code
	.8byte	0x180000000000005
	.data
	.align	8
	.8byte	3063
	.globl	camlCounter__incr_21_26
camlCounter__incr_21_26:
.LcamlCounter__incr_21_26:
	.8byte	camlCounter__incr_21_47_code
	.8byte	0x180000000000005
	.data
	.align	8
	.8byte	4087
.LcamlCounter__acquire_19_24:
	.8byte	caml_curry2L2
	.8byte	0x280000000000007
	.8byte	.LcamlCounter__acquire_19_45_code
	.data
	.align	8
	.8byte	3063
	.globl	camlCounter__create_18_23
camlCounter__create_18_23:
.LcamlCounter__create_18_23:
	.8byte	camlCounter__create_18_44_code
	.8byte	0x180000000000005
	.data
	.align	8
	.8byte	3840
	.globl	camlCounter__Pmakeblock501_22
camlCounter__Pmakeblock501_22:
.LcamlCounter__Pmakeblock501_22:
	.8byte	camlCounter__create_15_19
	.8byte	camlCounter__incr_16_20
	.8byte	camlCounter__get_17_21
	.data
	.align	8
	.8byte	3063
	.globl	camlCounter__get_17_21
camlCounter__get_17_21:
.LcamlCounter__get_17_21:
	.8byte	camlCounter__get_17_43_code
	.8byte	0x180000000000005
	.data
	.align	8
	.8byte	3063
	.globl	camlCounter__incr_16_20
camlCounter__incr_16_20:
.LcamlCounter__incr_16_20:
	.8byte	camlCounter__incr_16_42_code
	.8byte	0x180000000000005
	.data
	.align	8
	.8byte	3063
	.globl	camlCounter__create_15_19
camlCounter__create_15_19:
.LcamlCounter__create_15_19:
	.8byte	camlCounter__create_15_41_code
	.8byte	0x180000000000005
	.data
	.align	8
	.8byte	3840
	.globl	camlCounter__Pmakeblock475_18
camlCounter__Pmakeblock475_18:
.LcamlCounter__Pmakeblock475_18:
	.8byte	camlCounter__create_11_14
	.8byte	camlCounter__incr_13_16
	.8byte	camlCounter__get_14_17
	.data
	.align	8
	.8byte	3063
	.globl	camlCounter__get_14_17
camlCounter__get_14_17:
.LcamlCounter__get_14_17:
	.8byte	camlCounter__get_14_40_code
	.8byte	0x180000000000005
	.data
	.align	8
	.8byte	3063
	.globl	camlCounter__incr_13_16
camlCounter__incr_13_16:
.LcamlCounter__incr_13_16:
	.8byte	camlCounter__incr_13_39_code
	.8byte	0x180000000000005
	.data
	.align	8
	.8byte	4087
	.globl	camlCounter__loop_12_15
camlCounter__loop_12_15:
.LcamlCounter__loop_12_15:
	.8byte	caml_curry3L3
	.8byte	0x380000000000007
	.8byte	camlCounter__loop_12_38_code
	.data
	.align	8
	.8byte	3063
	.globl	camlCounter__create_11_14
camlCounter__create_11_14:
.LcamlCounter__create_11_14:
	.8byte	camlCounter__create_11_37_code
	.8byte	0x180000000000005
	.data
	.align	8
	.8byte	3840
	.globl	camlCounter__Pmakeblock415_13
camlCounter__Pmakeblock415_13:
.LcamlCounter__Pmakeblock415_13:
	.8byte	camlCounter__create_7_9
	.8byte	camlCounter__incr_9_11
	.8byte	camlCounter__get_10_12
	.data
	.align	8
	.8byte	3063
	.globl	camlCounter__get_10_12
camlCounter__get_10_12:
.LcamlCounter__get_10_12:
	.8byte	camlCounter__get_10_36_code
	.8byte	0x180000000000005
	.data
	.align	8
	.8byte	3063
	.globl	camlCounter__incr_9_11
camlCounter__incr_9_11:
.LcamlCounter__incr_9_11:
	.8byte	camlCounter__incr_9_35_code
	.8byte	0x180000000000005
	.data
	.align	8
	.8byte	4087
	.globl	camlCounter__loop_8_10
camlCounter__loop_8_10:
.LcamlCounter__loop_8_10:
	.8byte	caml_curry2L2
	.8byte	0x280000000000007
	.8byte	camlCounter__loop_8_34_code
	.data
	.align	8
	.8byte	3063
	.globl	camlCounter__create_7_9
camlCounter__create_7_9:
.LcamlCounter__create_7_9:
	.8byte	camlCounter__create_7_33_code
	.8byte	0x180000000000005
	.data
	.align	8
	.8byte	3840
	.globl	camlCounter__Pmakeblock370_8
camlCounter__Pmakeblock370_8:
.LcamlCounter__Pmakeblock370_8:
	.8byte	camlCounter__create_3_4
	.8byte	camlCounter__incr_5_6
	.8byte	camlCounter__get_6_7
	.data
	.align	8
	.8byte	3063
	.globl	camlCounter__get_6_7
camlCounter__get_6_7:
.LcamlCounter__get_6_7:
	.8byte	camlCounter__get_6_32_code
	.8byte	0x180000000000005
	.data
	.align	8
	.8byte	3063
	.globl	camlCounter__incr_5_6
camlCounter__incr_5_6:
.LcamlCounter__incr_5_6:
	.8byte	camlCounter__incr_5_31_code
	.8byte	0x180000000000005
	.data
	.align	8
	.8byte	4087
	.globl	camlCounter__loop_4_5
camlCounter__loop_4_5:
.LcamlCounter__loop_4_5:
	.8byte	caml_curry2L2
	.8byte	0x280000000000007
	.8byte	camlCounter__loop_4_30_code
	.data
	.align	8
	.8byte	3063
	.globl	camlCounter__create_3_4
camlCounter__create_3_4:
.LcamlCounter__create_3_4:
	.8byte	camlCounter__create_3_29_code
	.8byte	0x180000000000005
	.data
	.align	8
	.8byte	3063
	.globl	camlCounter__pause_2_3
camlCounter__pause_2_3:
.LcamlCounter__pause_2_3:
	.8byte	camlCounter__pause_2_28_code
	.8byte	0x180000000000005
	.data
	.align	8
	.8byte	3063
	.globl	camlCounter__make_padded_cell_1_2
camlCounter__make_padded_cell_1_2:
.LcamlCounter__make_padded_cell_1_2:
	.8byte	camlCounter__make_padded_cell_1_27_code
	.8byte	0x180000000000005
	.data
	.align	8
	.8byte	3063
	.globl	camlCounter__make_padded_atomic_0_1
camlCounter__make_padded_atomic_0_1:
.LcamlCounter__make_padded_atomic_0_1:
	.8byte	camlCounter__make_padded_atomic_0_26_code
	.8byte	0x180000000000005
	.text
	.align	16
	.globl	camlCounter__make_padded_atomic_0_26_code
camlCounter__make_padded_atomic_0_26_code:
.LcamlCounter__make_padded_atomic_0_26_code:
	.file	2	"counter.ml"
	.loc	2	11	23
	.cfi_startproc
	.cfi_def_cfa_offset 8
	subq	$8, %rsp
	.cfi_adjust_cfa_offset 8
	movq	%rax, %rdi
	.loc	2	11	27
	movq	caml_atomic_make_contended@GOTPCREL(%rip), %rax
	call	caml_c_call@PLT
.L117:
	addq	$8, %rsp
	.cfi_adjust_cfa_offset -8
	ret
	.cfi_adjust_cfa_offset 8
	.cfi_adjust_cfa_offset -8
.L116:
	.cfi_endproc
	.type camlCounter__make_padded_atomic_0_26_code,@function
	.size camlCounter__make_padded_atomic_0_26_code,. - camlCounter__make_padded_atomic_0_26_code
	.text
	.align	16
	.globl	camlCounter__make_padded_cell_1_27_code
camlCounter__make_padded_cell_1_27_code:
.LcamlCounter__make_padded_cell_1_27_code:
	.loc	2	18	21
	.cfi_startproc
	.cfi_def_cfa_offset 8
	subq	$8, %rsp
	.cfi_adjust_cfa_offset 8
	movl	$1, %esi
	movl	$67, %edi
	.loc	2	18	38
	movq	caml_array_make@GOTPCREL(%rip), %rax
	call	caml_c_call@PLT
.L124:
	addq	$8, %rsp
	.cfi_adjust_cfa_offset -8
	ret
	.cfi_adjust_cfa_offset 8
	.cfi_adjust_cfa_offset -8
.L123:
	.cfi_endproc
	.type camlCounter__make_padded_cell_1_27_code,@function
	.size camlCounter__make_padded_cell_1_27_code,. - camlCounter__make_padded_cell_1_27_code
	.text
	.align	16
	.globl	camlCounter__pause_2_28_code
camlCounter__pause_2_28_code:
.LcamlCounter__pause_2_28_code:
	.loc	2	21	14
	.cfi_startproc
	.cfi_def_cfa_offset 8
	subq	$8, %rsp
	.cfi_adjust_cfa_offset 8
	cmpq	$1, %rax
	jle	.L137
.L133:
	.loc	2	23	4
	pause
	.loc	2	24	10
	addq	$-2, %rax
	cmpq	(%r14), %r15
	jbe	.L142
.L143:
	cmpq	$1, %rax
	jg	.L133
.L137:
	movl	$1, %eax
	addq	$8, %rsp
	.cfi_adjust_cfa_offset -8
	ret
	.cfi_adjust_cfa_offset 8
.L142:
	call	.Lcaml_call_gc_
.L144:
	jmp	.L143
	.cfi_adjust_cfa_offset -8
.L141:
	.cfi_endproc
	.type camlCounter__pause_2_28_code,@function
	.size camlCounter__pause_2_28_code,. - camlCounter__pause_2_28_code
	.text
	.align	16
	.globl	camlCounter__create_3_29_code
camlCounter__create_3_29_code:
.LcamlCounter__create_3_29_code:
	.loc	2	31	13
	.cfi_startproc
	movl	$1, %eax
	.loc	2	31	22
	jmp	camlCounter__make_padded_atomic_0_26_code@PLT
.L149:
	.cfi_endproc
	.type camlCounter__create_3_29_code,@function
	.size camlCounter__create_3_29_code,. - camlCounter__create_3_29_code
	.text
	.align	16
	.globl	camlCounter__loop_4_30_code
camlCounter__loop_4_30_code:
.LcamlCounter__loop_4_30_code:
	.loc	2	33	15
	.cfi_startproc
	.cfi_def_cfa_offset 8
	subq	$8, %rsp
	.cfi_adjust_cfa_offset 8
	movq	%rax, %rdi
.L156:
	.loc	2	34	18
	movq	(%rdi), %rax
	.loc	2	35	40
	leaq	2(%rax), %rsi
	.loc	2	35	7
	lock cmpxchgq	%rsi, (%rdi)
	sete	%al
	movzbq	%al, %rax
	.loc	2	35	7
	leaq	1(%rax,%rax), %rax
	cmpq	$1, %rax
	jne	.L165
	.loc	2	36	16
	addq	$2, %rbx
	cmpq	(%r14), %r15
	jbe	.L170
.L171:
	jmp	.L156
	.align	4
.L165:
	movq	%rbx, %rax
	addq	$8, %rsp
	.cfi_adjust_cfa_offset -8
	ret
	.cfi_adjust_cfa_offset 8
.L170:
	call	.Lcaml_call_gc_
.L172:
	jmp	.L171
	.cfi_adjust_cfa_offset -8
.L169:
	.cfi_endproc
	.type camlCounter__loop_4_30_code,@function
	.size camlCounter__loop_4_30_code,. - camlCounter__loop_4_30_code
	.text
	.align	16
	.globl	camlCounter__incr_5_31_code
camlCounter__incr_5_31_code:
.LcamlCounter__incr_5_31_code:
	.loc	2	38	11
	.cfi_startproc
	movl	$1, %ebx
	.loc	2	38	21
	jmp	camlCounter__loop_4_30_code@PLT
.L177:
	.cfi_endproc
	.type camlCounter__incr_5_31_code,@function
	.size camlCounter__incr_5_31_code,. - camlCounter__incr_5_31_code
	.text
	.align	16
	.globl	camlCounter__get_6_32_code
camlCounter__get_6_32_code:
.LcamlCounter__get_6_32_code:
	.loc	2	39	10
	.cfi_startproc
	.loc	2	39	20
	movq	(%rax), %rax
	ret
.L182:
	.cfi_endproc
	.type camlCounter__get_6_32_code,@function
	.size camlCounter__get_6_32_code,. - camlCounter__get_6_32_code
	.text
	.align	16
	.globl	camlCounter__create_7_33_code
camlCounter__create_7_33_code:
.LcamlCounter__create_7_33_code:
	.loc	2	46	13
	.cfi_startproc
	movl	$1, %eax
	.loc	2	46	22
	jmp	camlCounter__make_padded_atomic_0_26_code@PLT
.L187:
	.cfi_endproc
	.type camlCounter__create_7_33_code,@function
	.size camlCounter__create_7_33_code,. - camlCounter__create_7_33_code
	.text
	.align	16
	.globl	camlCounter__loop_8_34_code
camlCounter__loop_8_34_code:
.LcamlCounter__loop_8_34_code:
	.loc	2	48	15
	.cfi_startproc
	.cfi_def_cfa_offset 8
	subq	$8, %rsp
	.cfi_adjust_cfa_offset 8
	movq	%rax, %rdi
.L194:
	.loc	2	49	18
	movq	(%rdi), %rax
	.loc	2	50	40
	leaq	2(%rax), %rsi
	.loc	2	50	7
	lock cmpxchgq	%rsi, (%rdi)
	sete	%al
	movzbq	%al, %rax
	.loc	2	50	7
	leaq	1(%rax,%rax), %rax
	cmpq	$1, %rax
	jne	.L204
	.loc	2	52	6
	pause
	.loc	2	53	13
	addq	$2, %rbx
	cmpq	(%r14), %r15
	jbe	.L209
.L210:
	jmp	.L194
	.align	4
.L204:
	movq	%rbx, %rax
	addq	$8, %rsp
	.cfi_adjust_cfa_offset -8
	ret
	.cfi_adjust_cfa_offset 8
.L209:
	call	.Lcaml_call_gc_
.L211:
	jmp	.L210
	.cfi_adjust_cfa_offset -8
.L208:
	.cfi_endproc
	.type camlCounter__loop_8_34_code,@function
	.size camlCounter__loop_8_34_code,. - camlCounter__loop_8_34_code
	.text
	.align	16
	.globl	camlCounter__incr_9_35_code
camlCounter__incr_9_35_code:
.LcamlCounter__incr_9_35_code:
	.loc	2	56	11
	.cfi_startproc
	movl	$1, %ebx
	.loc	2	56	21
	jmp	camlCounter__loop_8_34_code@PLT
.L216:
	.cfi_endproc
	.type camlCounter__incr_9_35_code,@function
	.size camlCounter__incr_9_35_code,. - camlCounter__incr_9_35_code
	.text
	.align	16
	.globl	camlCounter__get_10_36_code
camlCounter__get_10_36_code:
.LcamlCounter__get_10_36_code:
	.loc	2	57	10
	.cfi_startproc
	.loc	2	57	20
	movq	(%rax), %rax
	ret
.L221:
	.cfi_endproc
	.type camlCounter__get_10_36_code,@function
	.size camlCounter__get_10_36_code,. - camlCounter__get_10_36_code
	.text
	.align	16
	.globl	camlCounter__create_11_37_code
camlCounter__create_11_37_code:
.LcamlCounter__create_11_37_code:
	.loc	2	65	13
	.cfi_startproc
	movl	$1, %eax
	.loc	2	65	22
	jmp	camlCounter__make_padded_atomic_0_26_code@PLT
.L226:
	.cfi_endproc
	.type camlCounter__create_11_37_code,@function
	.size camlCounter__create_11_37_code,. - camlCounter__create_11_37_code
	.text
	.align	16
	.globl	camlCounter__loop_12_38_code
camlCounter__loop_12_38_code:
.LcamlCounter__loop_12_38_code:
	.loc	2	67	15
	.cfi_startproc
	.cfi_def_cfa_offset 8
	subq	$24, %rsp
	.cfi_adjust_cfa_offset 24
	pushq	%r10
	.cfi_adjust_cfa_offset 8
	leaq	-392(%rsp), %r10
	cmpq	40(%r14), %r10
	popq	%r10
	.cfi_adjust_cfa_offset -8
	jb	.L261
.L262:
	movq	%rax, %rsi
	movq	%rsi, (%rsp)
.L233:
	.loc	2	68	18
	movq	(%rsi), %rax
	.loc	2	69	40
	leaq	2(%rax), %rdx
	.loc	2	69	7
	lock cmpxchgq	%rdx, (%rsi)
	sete	%al
	movzbq	%al, %rax
	.loc	2	69	7
	leaq	1(%rax,%rax), %rax
	cmpq	$1, %rax
	jne	.L255
	movq	%rbx, 8(%rsp)
	movq	%rdi, %rax
	movq	%rdi, 16(%rsp)
	.loc	2	71	6
	call	camlCounter__pause_2_28_code@PLT
.L263:
	movq	(%rsp), %rsi
	movq	8(%rsp), %rbx
	movq	16(%rsp), %rdi
	cmpq	$2049, %rdi
	jl	.L247
	movl	$2049, %edi
	jmp	.L251
	.align	4
.L247:
	.loc	2	72	65
	leaq	-1(%rdi,%rdi), %rdi
.L251:
	.loc	2	73	13
	addq	$2, %rbx
	cmpq	(%r14), %r15
	jbe	.L264
.L265:
	jmp	.L233
	.align	4
.L255:
	movq	%rbx, %rax
	addq	$24, %rsp
	.cfi_adjust_cfa_offset -24
	ret
	.cfi_adjust_cfa_offset 24
.L264:
	call	.Lcaml_call_gc_
.L266:
	jmp	.L265
.L261:
	push	$36
	.cfi_adjust_cfa_offset 8
	call	caml_call_realloc_stack@PLT
	addq	$8, %rsp
	.cfi_adjust_cfa_offset -8
	jmp	.L262
	.cfi_adjust_cfa_offset -24
.L260:
	.cfi_endproc
	.type camlCounter__loop_12_38_code,@function
	.size camlCounter__loop_12_38_code,. - camlCounter__loop_12_38_code
	.text
	.align	16
	.globl	camlCounter__incr_13_39_code
camlCounter__incr_13_39_code:
.LcamlCounter__incr_13_39_code:
	.loc	2	76	11
	.cfi_startproc
	movl	$3, %edi
	movl	$1, %ebx
	.loc	2	76	21
	jmp	camlCounter__loop_12_38_code@PLT
.L271:
	.cfi_endproc
	.type camlCounter__incr_13_39_code,@function
	.size camlCounter__incr_13_39_code,. - camlCounter__incr_13_39_code
	.text
	.align	16
	.globl	camlCounter__get_14_40_code
camlCounter__get_14_40_code:
.LcamlCounter__get_14_40_code:
	.loc	2	77	10
	.cfi_startproc
	.loc	2	77	20
	movq	(%rax), %rax
	ret
.L276:
	.cfi_endproc
	.type camlCounter__get_14_40_code,@function
	.size camlCounter__get_14_40_code,. - camlCounter__get_14_40_code
	.text
	.align	16
	.globl	camlCounter__create_15_41_code
camlCounter__create_15_41_code:
.LcamlCounter__create_15_41_code:
	.loc	2	83	13
	.cfi_startproc
	movl	$1, %eax
	.loc	2	83	22
	jmp	camlCounter__make_padded_atomic_0_26_code@PLT
.L281:
	.cfi_endproc
	.type camlCounter__create_15_41_code,@function
	.size camlCounter__create_15_41_code,. - camlCounter__create_15_41_code
	.text
	.align	16
	.globl	camlCounter__incr_16_42_code
camlCounter__incr_16_42_code:
.LcamlCounter__incr_16_42_code:
	.loc	2	88	11
	.cfi_startproc
	movl	$2, %ebx
	.loc	2	89	11
	lock xaddq	%rbx, (%rax)
	movl	$1, %eax
	ret
.L286:
	.cfi_endproc
	.type camlCounter__incr_16_42_code,@function
	.size camlCounter__incr_16_42_code,. - camlCounter__incr_16_42_code
	.text
	.align	16
	.globl	camlCounter__get_17_43_code
camlCounter__get_17_43_code:
.LcamlCounter__get_17_43_code:
	.loc	2	92	10
	.cfi_startproc
	.loc	2	92	20
	movq	(%rax), %rax
	ret
.L291:
	.cfi_endproc
	.type camlCounter__get_17_43_code,@function
	.size camlCounter__get_17_43_code,. - camlCounter__get_17_43_code
	.text
	.align	16
	.globl	camlCounter__create_18_44_code
camlCounter__create_18_44_code:
.LcamlCounter__create_18_44_code:
	.loc	2	102	13
	.cfi_startproc
	.cfi_def_cfa_offset 8
	subq	$8, %rsp
	.cfi_adjust_cfa_offset 8
	pushq	%r10
	.cfi_adjust_cfa_offset 8
	leaq	-376(%rsp), %r10
	cmpq	40(%r14), %r10
	popq	%r10
	.cfi_adjust_cfa_offset -8
	jb	.L301
.L302:
	movl	$1, %eax
	.loc	2	103	46
	call	camlCounter__make_padded_cell_1_27_code@PLT
.L303:
	movq	%rax, (%rsp)
	movl	$1, %eax
	.loc	2	103	13
	call	camlCounter__make_padded_atomic_0_26_code@PLT
.L304:
	movq	%rax, %rbx
	.loc	2	103	4
	subq	$24, %r15
	cmpq	(%r14), %r15
	jb	.L305
.L307:
	leaq	8(%r15), %rax
	.loc	2	103	4
	movq	$2048, -8(%rax)
	.loc	2	103	4
	movq	%rbx, (%rax)
	.loc	2	103	4
	movq	(%rsp), %rbx
	.loc	2	103	4
	movq	%rbx, 8(%rax)
	addq	$8, %rsp
	.cfi_adjust_cfa_offset -8
	ret
	.cfi_adjust_cfa_offset 8
.L305:
	.loc	2	103	4
	call	.Lcaml_call_gc_
.L306:
	jmp	.L307
.L301:
	push	$34
	.cfi_adjust_cfa_offset 8
	call	caml_call_realloc_stack@PLT
	addq	$8, %rsp
	.cfi_adjust_cfa_offset -8
	jmp	.L302
	.cfi_adjust_cfa_offset -8
.L300:
	.cfi_endproc
	.type camlCounter__create_18_44_code,@function
	.size camlCounter__create_18_44_code,. - camlCounter__create_18_44_code
	.text
	.align	16
	.globl	camlCounter__acquire_19_45_code
camlCounter__acquire_19_45_code:
.LcamlCounter__acquire_19_45_code:
	.loc	2	107	18
	.cfi_startproc
	.cfi_def_cfa_offset 8
	subq	$8, %rsp
	.cfi_adjust_cfa_offset 8
	movq	%rax, %rdi
.L314:
	.loc	2	108	7
	movq	(%rdi), %rax
	cmpq	$1, %rax
	jne	.L327
	movl	$3, %esi
	movl	$1, %eax
	.loc	2	112	12
	lock cmpxchgq	%rsi, (%rdi)
	sete	%al
	movzbq	%al, %rax
	.loc	2	112	12
	leaq	1(%rax,%rax), %rax
	cmpq	$1, %rax
	jne	.L324
	.loc	2	113	22
	addq	$2, %rbx
	cmpq	(%r14), %r15
	jbe	.L333
.L334:
	jmp	.L314
	.align	4
.L324:
	movq	%rbx, %rax
	addq	$8, %rsp
	.cfi_adjust_cfa_offset -8
	ret
	.cfi_adjust_cfa_offset 8
	.align	4
.L327:
	.loc	2	109	6
	pause
	cmpq	(%r14), %r15
	jbe	.L336
.L337:
	jmp	.L314
.L336:
	call	.Lcaml_call_gc_
.L338:
	jmp	.L337
.L333:
	call	.Lcaml_call_gc_
.L335:
	jmp	.L334
	.cfi_adjust_cfa_offset -8
.L332:
	.cfi_endproc
	.type camlCounter__acquire_19_45_code,@function
	.size camlCounter__acquire_19_45_code,. - camlCounter__acquire_19_45_code
	.text
	.align	16
	.globl	camlCounter__incr_21_47_code
camlCounter__incr_21_47_code:
.LcamlCounter__incr_21_47_code:
	.loc	2	120	11
	.cfi_startproc
	.cfi_def_cfa_offset 8
	subq	$8, %rsp
	.cfi_adjust_cfa_offset 8
	pushq	%r10
	.cfi_adjust_cfa_offset 8
	leaq	-376(%rsp), %r10
	cmpq	40(%r14), %r10
	popq	%r10
	.cfi_adjust_cfa_offset -8
	jb	.L352
.L353:
	movq	%rax, %rdi
	movl	$1, %ebx
	.loc	2	121	24
	movq	(%rdi), %rax
	.loc	2	121	24
	movq	%rdi, (%rsp)
	.loc	2	121	16
	call	.LcamlCounter__acquire_19_45_code
.L354:
	.loc	2	122	56
	movq	(%rsp), %rsi
	.loc	2	122	56
	movq	8(%rsi), %rbx
	.loc	2	122	39
	movq	128(%rbx), %rdi
	.loc	2	122	38
	addq	$2, %rdi
	.loc	2	122	4
	movq	%rdi, 128(%rbx)
	.loc	2	123	12
	movq	(%rsi), %rdi
	movl	$1, %ebx
	.loc	2	117	39
	xchg	%rbx, (%rdi)
	addq	$8, %rsp
	.cfi_adjust_cfa_offset -8
	ret
	.cfi_adjust_cfa_offset 8
.L352:
	push	$34
	.cfi_adjust_cfa_offset 8
	call	caml_call_realloc_stack@PLT
	addq	$8, %rsp
	.cfi_adjust_cfa_offset -8
	jmp	.L353
	.cfi_adjust_cfa_offset -8
.L351:
	.cfi_endproc
	.type camlCounter__incr_21_47_code,@function
	.size camlCounter__incr_21_47_code,. - camlCounter__incr_21_47_code
	.text
	.align	16
	.globl	camlCounter__get_22_48_code
camlCounter__get_22_48_code:
.LcamlCounter__get_22_48_code:
	.loc	2	127	10
	.cfi_startproc
	.cfi_def_cfa_offset 8
	subq	$8, %rsp
	.cfi_adjust_cfa_offset 8
	pushq	%r10
	.cfi_adjust_cfa_offset 8
	leaq	-376(%rsp), %r10
	cmpq	40(%r14), %r10
	popq	%r10
	.cfi_adjust_cfa_offset -8
	jb	.L366
.L367:
	movq	%rax, %rdi
	movl	$1, %ebx
	.loc	2	128	20
	movq	(%rdi), %rax
	.loc	2	128	20
	movq	%rdi, (%rsp)
	.loc	2	128	11
	call	.LcamlCounter__acquire_19_45_code
.L368:
	.loc	2	129	29
	movq	(%rsp), %rbx
	.loc	2	129	29
	movq	8(%rbx), %rax
	.loc	2	129	12
	movq	128(%rax), %rax
	.loc	2	130	12
	movq	(%rbx), %rdi
	movl	$1, %ebx
	.loc	2	117	39
	xchg	%rbx, (%rdi)
	addq	$8, %rsp
	.cfi_adjust_cfa_offset -8
	ret
	.cfi_adjust_cfa_offset 8
.L366:
	push	$34
	.cfi_adjust_cfa_offset 8
	call	caml_call_realloc_stack@PLT
	addq	$8, %rsp
	.cfi_adjust_cfa_offset -8
	jmp	.L367
	.cfi_adjust_cfa_offset -8
.L365:
	.cfi_endproc
	.type camlCounter__get_22_48_code,@function
	.size camlCounter__get_22_48_code,. - camlCounter__get_22_48_code
	.text
	.align	16
	.globl	camlCounter__create_23_49_code
camlCounter__create_23_49_code:
.LcamlCounter__create_23_49_code:
	.loc	2	143	13
	.cfi_startproc
	.cfi_def_cfa_offset 8
	subq	$8, %rsp
	.cfi_adjust_cfa_offset 8
	pushq	%r10
	.cfi_adjust_cfa_offset 8
	leaq	-376(%rsp), %r10
	cmpq	40(%r14), %r10
	popq	%r10
	.cfi_adjust_cfa_offset -8
	jb	.L378
.L379:
	movl	$1, %eax
	.loc	2	143	52
	call	camlCounter__make_padded_cell_1_27_code@PLT
.L380:
	movq	%rax, (%rsp)
	movl	$1, %edi
	.file	3	"stdlib/stdlib/mutex.ml"
	.loc	3	17	0
	movq	caml_ml_mutex_new@GOTPCREL(%rip), %rax
	call	caml_c_call@PLT
.L381:
	movq	%rax, %rbx
	.loc	2	143	18
	subq	$24, %r15
	cmpq	(%r14), %r15
	jb	.L382
.L384:
	leaq	8(%r15), %rax
	.loc	2	143	18
	movq	$2048, -8(%rax)
	.loc	2	143	18
	movq	%rbx, (%rax)
	.loc	2	143	18
	movq	(%rsp), %rbx
	.loc	2	143	18
	movq	%rbx, 8(%rax)
	addq	$8, %rsp
	.cfi_adjust_cfa_offset -8
	ret
	.cfi_adjust_cfa_offset 8
.L382:
	.loc	2	143	18
	call	.Lcaml_call_gc_
.L383:
	jmp	.L384
.L378:
	push	$34
	.cfi_adjust_cfa_offset 8
	call	caml_call_realloc_stack@PLT
	addq	$8, %rsp
	.cfi_adjust_cfa_offset -8
	jmp	.L379
	.cfi_adjust_cfa_offset -8
.L377:
	.cfi_endproc
	.type camlCounter__create_23_49_code,@function
	.size camlCounter__create_23_49_code,. - camlCounter__create_23_49_code
	.text
	.align	16
	.globl	camlCounter__incr_24_50_code
camlCounter__incr_24_50_code:
.LcamlCounter__incr_24_50_code:
	.loc	2	145	11
	.cfi_startproc
	.cfi_def_cfa_offset 8
	subq	$8, %rsp
	.cfi_adjust_cfa_offset 8
	.loc	2	146	15
	movq	(%rax), %rdi
	.loc	2	146	15
	movq	%rax, (%rsp)
	.loc	3	18	0
	movq	caml_ml_mutex_lock@GOTPCREL(%rip), %rax
	call	caml_c_call@PLT
.L399:
	.loc	2	147	56
	movq	(%rsp), %rdi
	.loc	2	147	56
	movq	8(%rdi), %rax
	.loc	2	147	39
	movq	128(%rax), %rbx
	.loc	2	147	38
	addq	$2, %rbx
	.loc	2	147	4
	movq	%rbx, 128(%rax)
	.loc	2	148	17
	movq	(%rdi), %rdi
	.loc	3	20	0
	movq	caml_ml_mutex_unlock@GOTPCREL(%rip), %rax
	call	caml_c_call@PLT
.L400:
	movl	$1, %eax
	addq	$8, %rsp
	.cfi_adjust_cfa_offset -8
	ret
	.cfi_adjust_cfa_offset 8
	.cfi_adjust_cfa_offset -8
.L398:
	.cfi_endproc
	.type camlCounter__incr_24_50_code,@function
	.size camlCounter__incr_24_50_code,. - camlCounter__incr_24_50_code
	.text
	.align	16
	.globl	camlCounter__get_25_51_code
camlCounter__get_25_51_code:
.LcamlCounter__get_25_51_code:
	.loc	2	151	10
	.cfi_startproc
	.cfi_def_cfa_offset 8
	subq	$8, %rsp
	.cfi_adjust_cfa_offset 8
	.loc	2	152	15
	movq	(%rax), %rdi
	.loc	2	152	15
	movq	%rax, (%rsp)
	.loc	3	18	0
	movq	caml_ml_mutex_lock@GOTPCREL(%rip), %rax
	call	caml_c_call@PLT
.L413:
	.loc	2	153	29
	movq	(%rsp), %rbx
	.loc	2	153	29
	movq	8(%rbx), %rax
	.loc	2	153	12
	movq	128(%rax), %rax
	movq	%rax, (%rsp)
	.loc	2	154	17
	movq	(%rbx), %rdi
	.loc	3	20	0
	movq	caml_ml_mutex_unlock@GOTPCREL(%rip), %rax
	call	caml_c_call@PLT
.L414:
	movq	(%rsp), %rax
	addq	$8, %rsp
	.cfi_adjust_cfa_offset -8
	ret
	.cfi_adjust_cfa_offset 8
	.cfi_adjust_cfa_offset -8
.L412:
	.cfi_endproc
	.type camlCounter__get_25_51_code,@function
	.size camlCounter__get_25_51_code,. - camlCounter__get_25_51_code
	.text
	.align	16
	.globl	camlCounter__entry
camlCounter__entry:
.LcamlCounter__entry:
	.cfi_startproc
	movl	$1, %eax
	ret
.L424:
	.cfi_endproc
	.type camlCounter__entry,@function
	.size camlCounter__entry,. - camlCounter__entry
	.data
	.align	8
	.text
	ud2
	.align	4
	.text
	.globl	camlCounter__code_end
camlCounter__code_end:
	.data
	.align	8
	.data
	.8byte	0
	.globl	camlCounter__data_end
camlCounter__data_end:
	.8byte	0
	.section .rodata
	.align	8
	.globl	camlCounter__frametable
camlCounter__frametable:
	.8byte	21
	.byte	0
	.4byte	(.L117 - .) + 0
	.2byte	17
	.2byte	0
	.4byte	(.L425 - .) + 0
	.uleb128 (.L124 - .L117)
	.byte	5
	.byte	0
	.4byte	(.L426 - .) + 0
	.uleb128 (.L144 - .L124)
	.byte	6
	.byte	0
	.byte	0
	.byte	0
	.uleb128 (.L172 - .L144)
	.byte	6
	.byte	4
	.byte	0
	.byte	0
	.uleb128 (.L211 - .L172)
	.byte	6
	.byte	4
	.byte	0
	.byte	0
	.uleb128 (.L263 - .L211)
	.byte	9
	.byte	1
	.4byte	(.L427 - .) + 0
	.uleb128 (.L266 - .L263)
	.byte	10
	.byte	8
	.byte	0
	.byte	1
	.uleb128 (.L303 - .L266)
	.byte	5
	.byte	0
	.4byte	(.L428 - .) + 0
	.uleb128 (.L304 - .L303)
	.byte	5
	.byte	1
	.4byte	(.L429 - .) + 0
	.uleb128 (.L306 - .L304)
	.byte	7
	.byte	2
	.byte	1
	.byte	1
	.byte	1
	.4byte	(.L430 - .) + 0
	.uleb128 (.L338 - .L306)
	.byte	6
	.byte	4
	.byte	0
	.byte	0
	.uleb128 (.L335 - .L338)
	.byte	6
	.byte	4
	.byte	0
	.byte	0
	.uleb128 (.L354 - .L335)
	.byte	5
	.byte	1
	.4byte	(.L431 - .) + 0
	.uleb128 (.L368 - .L354)
	.byte	5
	.byte	1
	.4byte	(.L432 - .) + 0
	.uleb128 (.L380 - .L368)
	.byte	5
	.byte	0
	.4byte	(.L433 - .) + 0
	.uleb128 (.L381 - .L380)
	.byte	5
	.byte	1
	.4byte	(.L434 - .) + 0
	.uleb128 (.L383 - .L381)
	.byte	7
	.byte	2
	.byte	1
	.byte	1
	.byte	1
	.4byte	(.L435 - .) + 0
	.uleb128 (.L399 - .L383)
	.byte	5
	.byte	1
	.4byte	(.L436 - .) + 0
	.uleb128 (.L400 - .L399)
	.byte	5
	.byte	0
	.4byte	(.L437 - .) + 0
	.uleb128 (.L413 - .L400)
	.byte	5
	.byte	1
	.4byte	(.L438 - .) + 0
	.uleb128 (.L414 - .L413)
	.byte	5
	.byte	0
	.4byte	(.L439 - .) + 0
	.align	4
.L434:
	.4byte	(.L443 - .) + 1
	.4byte	8913376
.L444:
	.4byte	(.L441 - .) + 0
	.4byte	75002200
	.align	4
.L430:
	.4byte	(.L445 - .) + 0
	.4byte	54006296
	.align	4
.L435:
	.4byte	(.L441 - .) + 0
	.4byte	74992200
	.align	4
.L431:
	.4byte	(.L446 - .) + 0
	.4byte	63455488
	.align	4
.L427:
	.4byte	(.L447 - .) + 0
	.4byte	37230744
	.align	4
.L429:
	.4byte	(.L445 - .) + 0
	.4byte	54015272
	.align	4
.L439:
	.4byte	(.L443 - .) + 1
	.4byte	10486328
.L449:
	.4byte	(.L448 - .) + 0
	.4byte	80744640
	.align	4
.L432:
	.4byte	(.L450 - .) + 0
	.4byte	67120360
	.align	4
.L425:
	.4byte	(.L451 - .) + 0
	.4byte	5795272
	.align	4
.L438:
	.4byte	(.L443 - .) + 1
	.4byte	9437720
.L452:
	.4byte	(.L448 - .) + 0
	.4byte	79696048
	.align	4
.L428:
	.4byte	(.L445 - .) + 0
	.4byte	54049288
	.align	4
.L426:
	.4byte	(.L453 - .) + 0
	.4byte	9476600
	.align	4
.L437:
	.4byte	(.L443 - .) + 1
	.4byte	10486328
.L455:
	.4byte	(.L454 - .) + 0
	.4byte	77598912
	.align	4
.L436:
	.4byte	(.L443 - .) + 1
	.4byte	9437720
.L456:
	.4byte	(.L454 - .) + 0
	.4byte	76550320
	.align	4
.L433:
	.4byte	(.L441 - .) + 0
	.4byte	75027000
	.align	4
.L451:
	.4byte	(.L440 - .) + 0
	.4byte	(.L457 - .) + 4
	.align	4
.L446:
	.4byte	(.L440 - .) + 0
	.4byte	(.L458 - .) + 4
	.align	4
.L450:
	.4byte	(.L440 - .) + 0
	.4byte	(.L459 - .) + 4
	.align	4
.L454:
	.4byte	(.L440 - .) + 0
	.4byte	(.L460 - .) + 4
	.align	4
.L441:
	.4byte	(.L440 - .) + 0
	.4byte	(.L461 - .) + 4
	.align	4
.L453:
	.4byte	(.L440 - .) + 0
	.4byte	(.L462 - .) + 4
	.align	4
.L447:
	.4byte	(.L440 - .) + 0
	.4byte	(.L463 - .) + 4
	.align	4
.L443:
	.4byte	(.L442 - .) + 0
	.4byte	(.L464 - .) + 4
	.align	4
.L448:
	.4byte	(.L440 - .) + 0
	.4byte	(.L465 - .) + 4
	.align	4
.L445:
	.4byte	(.L440 - .) + 0
	.4byte	(.L466 - .) + 4
	.align	8
	.section .rodata.str1.1,"aMS",@progbits,1
.L440:
	.ascii	"counter.ml\0"
.L442:
	.ascii	"stdlib/mutex.ml\0"
.L464:
	.ascii	"Stdlib__Mutex.(partial)\0"
.L462:
	.ascii	"Counter.make_padded_cell\0"
.L459:
	.ascii	"Counter.Spin.get\0"
.L461:
	.ascii	"Counter.Std_mutex.create\0"
.L466:
	.ascii	"Counter.Spin.create\0"
.L460:
	.ascii	"Counter.Std_mutex.incr\0"
.L457:
	.ascii	"Counter.make_padded_atomic\0"
.L465:
	.ascii	"Counter.Std_mutex.get\0"
.L458:
	.ascii	"Counter.Spin.incr\0"
.L463:
	.ascii	"Counter.Cas_backoff.loop\0"
	.section .rodata
	.size camlCounter__frametable,. - camlCounter__frametable
	.data
	.section .note.GNU-stack,"",@progbits
	.section .debug_info
.L108:
	.4byte	45
	.2byte	4
	.4byte	.L101
	.byte	8


.L107:
	.uleb128	1
	.4byte	.L467
	.4byte	.L104
	.8byte	camlCounter__code_begin
	.4byte	camlCounter__code_end - camlCounter__code_begin
	.byte	27
	.4byte	.L468
	.4byte	.L469
	.4byte	.L470
	.4byte	.L471
	.section .debug_abbrev

	.uleb128	1
	.uleb128	17
	.byte	0
	.uleb128	3
	.uleb128	14
	.uleb128	16
	.uleb128	23
	.uleb128	17
	.uleb128	1
	.uleb128	18
	.uleb128	6
	.uleb128	19
	.uleb128	11
	.uleb128	27
	.uleb128	14
	.uleb128	37
	.uleb128	14
	.uleb128	12544
	.uleb128	14
	.uleb128	12545
	.uleb128	14
	.uleb128	0
	.uleb128	0
	.uleb128	0
	.section .debug_str
	.section .debug_str
.L468:
	.ascii	"/tmp/asm"
	.byte	0
	.section .debug_str
.L470:
	.ascii	"5.4.0+ox"
	.byte	0
	.section .debug_str
.L471:
	.ascii	"camlCounter"
	.byte	0
	.section .debug_str
.L467:
	.ascii	"counter.ml"
	.byte	0
	.section .debug_str
.L469:
	.ascii	"ocamlopt"
	.byte	0
	.section .debug_str
	.section .debug_loc
	.section .debug_ranges
