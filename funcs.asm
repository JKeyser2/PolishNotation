;funcs.asm

section .text

global sum2
global sub2
global mul2
global div2

sum2:

	mov rax,rdi 
	add rax,rsi
	ret


sub2:
	mov rax,rdi
	sub rax,rsi
	ret

div2:
	mov rax, rsi
	idiv rdi
	ret

mul2:
	mov rax, rdi
	imul rax, rsi
	ret



