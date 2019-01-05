;// File: a02_3.10.2.asm
;// Author: Dustin Meckley
;// Date Created: 11/01/2015

    .386
    .model flat, stdcall
    .stack 4096
    ExitProcess proto, dwExitCode:dword

    ;// Declared Constants:
    SUNDAY EQU 1
    MONDAY EQU 2
    TUESDAY EQU 3
    WEDNESDAY EQU 4
    THURSDAY EQU 5
    FRIDAY EQU 6
    SATURDAY EQU 7

    ;// Declared Variables:
    .data
         ;// Declaring an array named array and initilizing the elements of the array 
         ;// with the declared constant day of the week integer values.
         array DWORD SUNDAY, MONDAY, TUESDAY, WEDNESDAY, THURSDAY, FRIDAY, SATURDAY
         arraySize DWORD ($ - array) / 4        ;// Calculating the size of the array.

    ;// Declared Code: 
    .code
    main proc
       
        invoke ExitProcess, 0
    main endp
    end main