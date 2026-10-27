.data 
    x: .long 19 
    y: .long 17 
    str1: .asciz "x > y\n"      # 7B
    str2: .asciz "x <= y\n"     # 8B
.text 

.global main 

main:
    # verificam daca x <= y 
    # cmp y, x si folosim jle 
    movl x, %eax                # %eax <- x 
    cmp y, %eax                 # comparam %eax fata de y 
    jle afis2                   # daca %eax <= y sari la afis2 

afis1: 
    movl $4, %eax               # codificare WRITE = 4
    movl $1, %ebx               # codificare STDOUT = 1 
    movl $str1, %ecx            # ce afisam 
    movl $7, %edx               # cat afisam 
    int $0x80 
    jmp et_exit 

afis2:
    movl $4, %eax               # codificare WRITE = 4 
    movl $1, %ebx               # codificare STDOUT = 1 
    movl $str2, %ecx            # ce afisam
    movl $8, %edx               # cat afisam 
    int $0x80 

et_exit:
    movl $1, %eax 
    xorl %ebx, %ebx 
    int $0x80 
