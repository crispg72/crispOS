global long_mode_init

section .text
bits 64
long_mode_init:

	mov ch, 0x2f
	mov rbx, crispOS_str64

    ; print `crispOS` to screen
	call output_text64

    hlt

crispOS_str64 db 'crispOS', 0

output_text64:
	mov rdx, 0xb8000
.ot_loop:
	mov cl, [rbx]

	or cl, cl
	je .ot_done

	mov [rdx], cx

	adc rdx, 2
	inc rbx
	jmp .ot_loop
.ot_done:
	ret
