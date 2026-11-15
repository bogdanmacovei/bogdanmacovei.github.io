# calculam suma elementelor dintr-un array 
.data 
    v: .long 13, 27, 15, 19 
    n: .long 4 
    formatPrintf: .asciz "Suma elementelor este %ld\n" 
.text 

.global main 

main:
    xorl %ecx, %ecx             # pe post de i 
    xorl %eax, %eax             # pe post de sum 

    lea v, %esi                 # echivalent cu mov $v, %esi 
                                # incarcam adresa array-ului in %esi 
et_for:
    cmp n, %ecx 
    je et_exit 

    # sum += v[i] 
    # cine este v[i]? (%esi, %ecx, 4)
    # nu putem face direct add (%esi, %ecx, 4), %eax
    # trebuie sa trecem cu (%esi, %ecx, 4) printr-un registru intermediar 

    movl (%esi, %ecx, 4), %ebx  # %ebx <- %esi[%ecx] = v[i] 
    add %ebx, %eax              # %eax += %ebx 

    inc %ecx 
    jmp et_for 

et_exit:
    # printf("Suma elementelor este %ld\n", %eax)

    push %eax 
    push $formatPrintf
    call printf 
    pop %ebx  
    pop %ebx

    movl $1, %eax 
    xorl %ebx, %ebx 
    int $0x80

# for (int i = 0; i < n; i++) { sum += v[i]; }
