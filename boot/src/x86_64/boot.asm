global start

section .text
bits 32
start:
	mov esp, stack_top

	mov ch, 0x2f
	mov ebx, crispOS_str

    ; print `crispOS` to screen
	call output_text

    hlt

crispOS_str db 'crispOS', 0

output_text:
	mov edx, 0xb8000
ot_loop:
	mov cl, [ebx]

	or cl, cl
	je ot_done

	mov [edx], cx

	adc edx, 2
	inc ebx
	jmp ot_loop
ot_done:
	ret

section .bss
	resb 64
stack_top:
	