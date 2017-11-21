global start

section .text
bits 32
start:
	mov esp, stack_top

    ; print `crispOS` to screen
    mov dword [0xb8000], 0x2f722f63
    mov dword [0xb8004], 0x2f732f69
    mov dword [0xb8008], 0x2f4f2f70
    mov dword [0xb800c], 0x2f53
    hlt

section .bss
	resb 64
stack_top:
