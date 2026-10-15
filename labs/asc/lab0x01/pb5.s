.data
    y: .long 4
.text

.global main 

main: 
    # impartim x / y 
    mov $16, %edx 
    mov $0, %eax 
    divl y

et_exit:
    mov $1, %eax 
    mov $0, %ebx 
    int $0x80 
