;// File: a03_4.10.7.asm
;// Author: Dustin Meckley
;// Date Created: 11/09/2015

    .386
    .model flat, stdcall
    .stack 4096
    ExitProcess proto, dwExitCode:dword

    ;// Declared Variables:
    .data
    source BYTE "This is the source string", 0    ;// Source Array-Sequential.
    target BYTE SIZEOF source DUP('#')            ;// Destination Array-Reverse.
    
    ;// Declared Code: 
    .code
    main proc
     mov esi, 0                                   ;// Pointer for the Source Array.
     mov edi, 0                                   ;// Pointer for the Destination Array.
     mov esi, OFFSET source                       ;// Source Array Offset.
     mov edi, OFFSET target + (SIZEOF target - 1) ;// Destination Array Offset.
     mov ecx, SIZEOF source                       ;// Set ECX loop counter to the size of source array.                            

L1: 
     mov al, [esi]                                ;// Move the Source array's 1st memory location element into al.
     mov [edi], al                                ;// Move element from al into the the Destination array's last memory location.
     inc esi                                      ;// Increment the Source array's pointer.
     dec edi                                      ;// Decrement the Destination array's pointer.
     LOOP L1                                      ;// Loops as many times as ECX is not equal to 0.

        invoke ExitProcess, 0                     ;// Exit the process.
    main endp
    end main