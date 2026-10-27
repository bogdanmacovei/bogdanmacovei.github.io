.data 
    str1: .asciz "Sir 1\n"          # (6 caractere + 1 terminator de sir) = 7B 
    str2: .asciz "Sir 2\n"          # 7B
.text 

.global main 

main: 
    jmp afis2 
afis1: 
    movl $4, %eax                   # apelul de sistem WRITE = 4 
    movl $1, %ebx                   # scriem la STDOUT = 1 
    movl $str1, %ecx                # ce vrem sa scriem (adresa din memorie)
    movl $7, %edx                   # cat vrem sa scriem 
    int $0x80                       # syscall-ul 
    jmp et_exit 
afis2:
    movl $4, %eax                   # apelul de sistem WRITE = 4 
    movl $1, %ebx                   # scriem la STDOUT = 1 
    movl $str2, %ecx                # ce vrem sa scriem (adresa din memorie)
    movl $7, %edx                   # cat vrem sa scriem 
    int $0x80                       # syscall-ul 
    jmp afis1 

et_exit:
    movl $1, %eax 
    xorl %ebx, %ebx         # %ebx <- 0 
    int $0x080 
