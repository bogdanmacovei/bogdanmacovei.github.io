.data 
    n: .long 5 
    sum: .space 4 
    format: .asciz "Suma numerelor de la 0 la %ld este %ld\n" 
.text 

.global main 

main:

    xorl %ecx, %ecx             # %ecx = 0 (pe post de "i")
    xorl %eax, %eax             # %eax = 0 (sum = 0 initial) 
et_for:
    cmp n, %ecx                 # comparam %ecx(=i) [] n
    je et_exit                  # daca sunt egale, am negat conditia de a ramane in structura 
                                # si ma duc la et_exit 

    add %ecx, %eax              # %eax += %ecx   (sum += i)

    inc %ecx                    # i++ 
    jmp et_for  

et_exit:
    movl %eax, sum              # sum <- %eax

    # printf("Suma numerelor de la 0 la %ld este %ld\n", n, sum);
    dec %ecx 

    push sum 
    push %ecx 
    push $format 
    call printf 
    pop %ebx 
    pop %ebx 
    pop %ebx 

    movl $1, %eax
    xorl %ebx, %ebx 
    int $0x80 

# for (int i = 0; i < n; i++) { sum += i; }
