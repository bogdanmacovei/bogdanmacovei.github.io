# vrem sa determinam cifra de paritate a unui ISBN-10 
# consideram un array care are deja cifrele x1, ..., x9 
# sum_{i=1}^{9} (11 - i) * v[i]  + p = 0 (mod 11) 
.data
    v: .space 36
    n: .long 9 
    c11: .long 11 
    dummy: .space 4 
    formatPrintf: .asciz "Cifra de paritate este %d\n" 
    formatScanf: .asciz "%d"
.text

.global main 

main:

    # citim cifrele din codul ISBN-10
    xorl %ecx, %ecx 
    lea v, %esi 

et_loop_read:
    cmp n, %ecx 
    je et_exit_loop_read

    push %ecx 

    push $dummy 
    push $formatScanf 
    call scanf 
    pop %ebx 
    pop %ebx 

    pop %ecx 

    movl dummy, %ebx 
    movl %ebx, (%esi, %ecx, 4)

    inc %ecx 
    jmp et_loop_read 


et_exit_loop_read:

    # ----------------------------------------------


                                    # (b,c,d) -> (%esi, %ecx, 4) -> v[i]
    lea v, %esi                     # echivalent cu mov $v, %esi, folosim %esi pentru array 
    xorl %ecx, %ecx                 # pe post de "i" 
    xorl %ebx, %ebx                 # pe post de suma 
et_loop:
    cmp n, %ecx 
    je et_exit_loop 

    # calculam %ebx += (10-i) * v[i]
    movl (%esi, %ecx, 4), %eax      # %eax = v[i]

    # calculez in %edi = 10 - i 
    movl $10, %edi                  # %edi = 10
    sub %ecx, %edi                  # %edi = 10 - %ecx = 10 - i 

    # avem in %eax = v[i] si in %edi = 10 - i 
    mul %edi                        # %edx:%eax <- %eax * %edi = v[i] * (10-i)
                                    #   0: %eax <- %eax * %edi 

    add %eax, %ebx                  # sum += v[i] * (10 - i)
    inc %ecx 
    jmp et_loop 

et_exit_loop: 
    # avem suma sum_{i=0}^{8} (10 - i) * v[i] in reg. %ebx 
    # verificam restul impartirii lui %ebx la 11 

    # div op =   (%edx, %eax) <- %edx:%eax / op 
    xorl %edx, %edx                 # posibil redundanta in acest punct 
    movl %ebx, %eax                 # %eax are valoarea sumei 
    divl c11 
    # dupa impartire, restul este in %edx 

    # scadem %edx-ul din 11 
    movl $11, %eax 
    sub %edx, %eax 
    # %eax-ul tine rezultatul p 

    cmp $11, %eax 
    je modif_p 
    jmp et_exit 

modif_p:
    xorl %eax, %eax 

et_exit:
    push %eax 
    push $formatPrintf 
    call printf 
    pop %ebx 
    pop %ebx 

    movl $1, %eax 
    xorl %ebx, %ebx 
    int $0x80 
