;// File: a01_3.10.1.asm
;// Author: Dustin Meckley
;// Date Created: 11/01/2015

    .386
    .model flat, stdcall
    .stack 4096
    ExitProcess proto, dwExitCode:dword

    ;// Declared Variables:
    .data
    varA SDWORD 10   ;// varA = 10
    varB SDWORD 16   ;// varB = 16
    varC SDWORD 2    ;// varC = 2
    varD SDWORD 3    ;// varD = 3
    
    ;// Declared Code: 
    .code
    main proc
        mov eax, varA    ;// eax = varA.
        add eax, varB    ;// eax = eax + varB = varA + varB.
        sub eax, varC    ;// eax = eax - varC = varA + varB - varC.
        sub eax, varD    ;// eax = eax - varD = varA + varB - varC - varD.
        mov varA, eax    ;// varA = eax = VarA + varB - varC - varD.

        invoke ExitProcess, 0      ;// Exit the process.
    main endp
    end main