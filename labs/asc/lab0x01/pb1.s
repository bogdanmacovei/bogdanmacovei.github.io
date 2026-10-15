.data 
    // aici declar datele programului 
    // sectiunea datelor statice ale sistemului de operare 
.text 
    // sub incidenta lui .text avem zona executabila 
    // de aici incepe zona efectiva de instructiuni 
    // in principiu, in aceasta zona declaram procedurile
.global main 

main: 
    // entry-point-ul in program 
    // de aici incepe executarea instructiunilor 
    mov $1, %eax 
    mov $0, %ebx 
    int $0x80 

// pentru a executa programul, obtinem executabilul folosind compilatorul gcc 
// pentru a crea executabilul:
//  gcc -m32 pb1.s -o pb1 -no-pie -Wl,-z,noexecstack
// pentru a executa: 
//  ./pb1

// executabilul default (daca nu specificam -o name) este a.out 
