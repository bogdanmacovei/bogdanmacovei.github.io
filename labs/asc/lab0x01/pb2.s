.data 
    str: .asciz "Hello, world!\n" 
.text 

.global main 

main: 
    mov $4, %eax        # codul pentru WRITE
    mov $1, %ebx        # codul pentru afisare la STDOUT (pe consola)
    mov $str, %ecx      # adresa de memorie a sirului pe care vrem sa-l afisam 
    mov $15, %edx       # cat vrem sa scriem din sirul de afisat 
    int $0x80 

et_exit: 
    mov $1, %eax 
    mov $0, %ebx 
    int $0x80 
