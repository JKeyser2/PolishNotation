SYS_EXIT equ 60
SYS_READ equ 0
SYS_WRITE equ 1
STDIN equ 0
STDOUT equ 1
BUFLEN equ 100

segment .data
	msg1 db "Enter a reverse polish expression ",0
	len1 equ $- msg1

	msg2 db "Result ",0
	len2 equ $- msg2

	format db "Result of %s is %d",10,0
	str1 db "Result is ",0




	




segment .bss
	polish_notation resb BUFLEN

section .text
	global _start

	extern printf

	extern sum2
	extern sub2
	extern mul2
	extern div2

	extern add_c

_start:
	; Setting up the stack
	;push rbp ;push rsp

	


	; Prompt user for their reverse polish notation
	mov rsi, msg1
	mov rdx, len1
	mov rax, SYS_WRITE
	mov rdi, STDOUT
	syscall

	
	; Store the polish notation as a string
	mov rsi, polish_notation
	mov rdx, BUFLEN
	mov rax, SYS_READ
	mov rdi, STDIN
	syscall


	

	xor eax, eax
	xor ebx, ebx
	xor ecx, ecx
	xor edx, edx

	call read

	; Exit
	mov rax, SYS_EXIT
	xor rdi, rdi
	syscall


; Increases index and goes back to read
resume:
	
	inc ecx
	jmp read


; Reads 1 character at a time
read:
	; Checks if newline
	cmp byte[polish_notation + ecx], 0x0A
	jz stop

	; Checks if end of expression
	cmp byte[polish_notation + ecx], 0        
	jz stop


	; Checks if addition
	cmp byte[polish_notation + ecx], '+'     
	jz addition

	; Checks if subtraction
	cmp byte[polish_notation + ecx], '-'     
	jz subtraction

	; Checks if multiplication
	cmp byte[polish_notation + ecx], '*'  
	jz multiplication

	; Checks if division
	cmp byte[polish_notation + ecx], '/' 
	jz division

	; Checks if space
	cmp byte[polish_notation + ecx], ' '
	jz resume    

	; Checks if 0
	cmp byte[polish_notation + ecx], '0'
	jz get_number 

	; Checks if 1
	cmp byte[polish_notation + ecx], '1'
	jz get_number 

	; Checks if 2
	cmp byte[polish_notation + ecx], '2'
	jz get_number

	; Checks if 3
	cmp byte[polish_notation + ecx], '3'
	jz get_number  

	; Checks if 4
	cmp byte[polish_notation + ecx], '4'
	jz get_number

	; Checks if 5
	cmp byte[polish_notation + ecx], '5'
	jz get_number 

	; Checks if 6
	cmp byte[polish_notation + ecx], '6'
	jz get_number

	; Checks if 7
	cmp byte[polish_notation + ecx], '7'
	jz get_number  

	; Checks if 8
	cmp byte[polish_notation + ecx], '8'
	jz get_number

	; Checks if 9
	cmp byte[polish_notation + ecx], '9'
	jz get_number   


; Converts number string to number
get_number:
	; Convert string to number
	mov ebx, 10                    
	mul ebx                        
	mov bl, byte[polish_notation + ecx]     
	sub bl, '0'                   
	add eax, ebx   


	; Checking if there is another digit in the number
	inc ecx
	cmp byte[polish_notation + ecx], '0'
	jz get_number
	cmp byte[polish_notation + ecx], '1'
	jz get_number
	cmp byte[polish_notation + ecx], '2'
	jz get_number
	cmp byte[polish_notation + ecx], '3'
	jz get_number
	cmp byte[polish_notation + ecx], '4'
	jz get_number
	cmp byte[polish_notation + ecx], '5'
	jz get_number
	cmp byte[polish_notation + ecx], '6'
	jz get_number
	cmp byte[polish_notation + ecx], '7'
	jz get_number
	cmp byte[polish_notation + ecx], '8'
	jz get_number
	cmp byte[polish_notation + ecx], '9'
	jz get_number





	; push number onto stack
	push rax

	xor rax,rax

	

	jmp resume





; Prints final result
stop:
	pop rbx

	; print out the number. This is for debugging purposes to make sure the string converted to an int
	mov rdi, format
	mov rsi, polish_notation
	mov rdx,rbx ;mov rdx, [eax]
	mov rax, 0
	call printf

	ret 


addition:
	pop rbx
	pop rax
	mov rdi, rbx
	mov rsi, rax
	call add_c
	push rax
	xor eax, eax
	jmp resume

subtraction:
	pop rbx
	pop rax
	mov rdi, rax
	mov rsi, rbx
	call sub2
	push rax
	xor eax, eax
	jmp resume



multiplication:
	pop rbx
	pop rax
	mov rdi, rbx
	mov rsi, rax
	call mul2
	push rax
	xor eax, eax
	jmp resume

division:
	pop rbx
	pop rax
	mov rdi, rbx
	mov rsi, rax
	call div2
	push rax
	xor eax, eax
	jmp resume