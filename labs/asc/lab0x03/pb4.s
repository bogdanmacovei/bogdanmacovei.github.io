# determinam numarul de spatii dintr-un sir de caractere 
.data
    str: .asciz "Sir de caractere"
    formatPrintf: .asciz "Sunt %ld spatii\n" 
.text

.global main 

main:
    lea str, %esi                   # mov $str, %esi, incarcam adresa sirului in %esi 
    xorl %ecx, %ecx                 # pe post de i 
    xorl %eax, %eax                 # in %eax numaram spatiile 

et_while: 
    movb (%esi, %ecx, 1), %bh       # %bh este str[i] 
    cmpb $0, %bh 
    je et_exit 

    # numaram cate spatii sunt, deci verificam daca %bh este un spatiu 
    cmpb $' ', %bh 
    je is_space  

et_cont:
    inc %ecx 
    jmp et_while 

is_space:
    inc %eax 
    jmp et_cont 

et_exit:
    # printf("Sunt %ld spatii\n", %eax);

    push %eax 
    push $formatPrintf 
    call printf 
    pop %ebx 
    pop %ebx 

    movl $1, %eax
    xorl %ebx, %ebx 
    int $0x80 
