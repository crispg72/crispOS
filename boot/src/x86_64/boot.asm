global start

section .text
bits 32
start:
    ; print `crispOS` to screen
    mov dword [0xb8000], 0x2f642f72
    mov dword [0xb8004], 0x2f692f73
    mov dword [0xb8008], 0x2f702f4f
    mov dword [0xb800b], 0x2f530000
    hlt
