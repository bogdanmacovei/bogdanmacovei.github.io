.data
    x: .long 0x10000000
    y: .long 32
.text 

.global main 

main: 
    mov x, %eax 
    mull y
    # mov y, %ebx 
    # mul %ebx        # %edx:%eax <- %eax (2^28) * %ebx (2^5)
                    # %edx:%eax <- 2^33 = 10 00...0000
                    #                    edx    eax 
                    #                      2     0 
et_exit:    
    mov $1, %eax 
    mov $0, %ebx 
    int $0x80
