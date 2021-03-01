global long_mode_init
global output_text64

extern kernel_init

section .text
bits 64
long_mode_init:

	mov ch, 0x2f
	mov rdi, crispOS_str64

    ; print `crispOS` to screen
	;call output_text64
	call kernel_init

    hlt

crispOS_str64 db 'crispOS', 0

output_text64:
	mov rdx, 0xb8000
.ot_loop:
	mov cl, [rdi]

	or cl, cl
	je .ot_done

	mov [rdx], cx

	adc rdx, 2
	inc rdi
	jmp .ot_loop
.ot_done:
	ret
