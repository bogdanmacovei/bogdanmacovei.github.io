# sa se afiseze numerele de la 0 la N-1, pentru un N dat 
.data 
    n: .long 10    
    formatPrintf: .asciz "Numarul este: %ld\n"
.text 

.global main 

main:

# for (int i = 0; i < n; i++) { printf("Numarul este: %ld\n", i); }

    xorl %ecx, %ecx             # i = 0 
et_for:
    cmp n, %ecx 
    je et_exit 

    #mov %ecx, %esi             # prin dummy ne asiguram ca facem o copie lui %ecx 
    push %ecx 

        # printf("Numarul este: %ld\n", i);
        push %ecx 
        push $formatPrintf
        call printf                # instr call strica %eax, %ecx, %edx 
        pop %ebx 
        pop %ebx 

        #mov %esi, %ecx             # recuperez vechea valoare a lui %ecx 
    pop %ecx 

    inc %ecx 
    jmp et_for 

et_exit:
    movl $1, %eax 
    xorl %ebx, %ebx 
    int $0x80 
