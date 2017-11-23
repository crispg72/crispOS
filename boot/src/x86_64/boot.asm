global start

section .text
bits 32
start:
	mov esp, stack_top

	call check_multiboot

	mov ch, 0x2f
	mov ebx, crispOS_str

    ; print `crispOS` to screen
	call output_text

    hlt

crispOS_str db 'crispOS', 0
error_str   db 'Error:'
error_code  db '0', 0

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

; Output the error code then hlt
error:
	mov [error_code], al
	mov ebx, error_str
	mov ch, 0x2e
	call output_text
	hlt

check_multiboot:
    cmp eax, 0x36d76289
    jne .no_multiboot
    ret
.no_multiboot:
    mov al, "0"
    jmp error

section .bss
	resb 64
stack_top:
	