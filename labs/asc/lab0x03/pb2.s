# scriem un program papagal 
.data
    x: .space 4 
    formatScanf: .asciz "%ld"
    formatPrintf: .asciz "Numarul citit este: %ld\n" 
.text

.global main 


main: 
    # scanf("%ld", &x)
    push $x                         # adresa de memorie
    push $formatScanf 
    call scanf 
    pop %ebx 
    pop %ebx 

    # printf("Numarul citit este: %ld\n", x);
    push x                          # valoarea efectiva 
    push $formatPrintf 
    call printf 
    pop %ebx 
    pop %ebx 


et_exit:
    movl $1, %eax 
    xorl %ebx, %ebx 
    int $0x80 
