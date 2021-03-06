bits 16 ; tell NASM this is 16 bit code

org 0x7c00 ; tell NASM to start outputting stuff at offset 0x7c00

boot:
    mov si,hello ; point si register to hello label memory location

    mov ah,0x0e ; 0x0e means 'Write Character in TTY mode'

.loop:
    lodsb  ;loads the byte addressed by SI into register AL

    or al,al ; asking if the register al == 0

    jz halt  ; js = jump to zero, if (al == 0) jump to halt label

    int 0x10 ; runs BIOS interrupt 0x10 - Video Services

    jmp .loop ; litteratly making it a loop

halt:
    cli ; clear interrupt flag
    hlt ; halt execution
hello: db "Hey, why did you make this bootloader?",0

times 510 - ($-$$) db 0 ; remaining 510 bytes with zeroes

dw 0xaa55 ; magic bootloader magic - marks this 512 byte sector is bootable!
