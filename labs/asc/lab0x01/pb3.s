.data 
    x: .long 7 
    y: .long 5 
    sum: .space 4 
    dif: .space 4 
    mult: .space 4 
.text 

.global main 

main: 
    # sum = x + y 
    # add op2, op1 <=> op1 += op2 

    mov x, %eax         # %eax <- x 
    add y, %eax         # %eax <- %eax (=x) + y
    mov %eax, sum       # sum <- %eax  

    mov x, %eax         # %eax <- x
    sub y, %eax         # %eax <- %eax (=x) - y
    mov %eax, dif       # dif <- %eax 

    mov x, %eax         # %eax <- x (sursa implicita la inmultire) 
    mov y, %ebx         # %ebx <- y (cu el vreau sa inmultesc)
    mul %ebx            # %edx:%eax <- %eax (implicit) * %ebx (explicit)
                        #  0    35
    mov %eax, mult      # mult <- %eax  

et_exit:    
    mov $1, %eax 
    mov $0, %ebx 
    int $0x80 
