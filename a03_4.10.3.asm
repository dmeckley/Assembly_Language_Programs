;// File: a03_4.10.3.asm
;// Author: Dustin Meckley
;// Date Created: 11/09/2015

    .386
    .model flat, stdcall
    .stack 4096
    ExitProcess proto, dwExitCode:dword
    
    ;// Declared Variables:
    .data
    arr DWORD 0d, 2d, 5d, 9d, 10d  ;// Array for decimal element values.
  
    ;// Declared Code: 
    .code
    main proc
     mov esi, OFFSET arr           ;// Move the offset of the array arr to the array pointer.
     mov ecx, LENGTHOF arr         ;// Move the length of the array arr to the ecx register as a counter.
     mov ebx, 0                    ;// Move 0 into the ebx register to be used as the sum of gaps.
     cld                           ;// Clear the Direction Flag (DF). 
     lodsd                         ;// Loads DWORD from esi pointer register and stores it in eax registers.
                                   ;// Increments or decrements esi pointer by 4 based off of Direction Flag. 
     mov edx, eax                  ;// Save the previous element read in edx register.
     dec ecx                       ;// Decrement the ecx loop counter register.

L1:  
     lodsd                         ;// Loads DWORD from esi pointer register and stores it in eax registers.
                                   ;// Increments or decrements esi pointer by 4 based off of Direction Flag.    
     sub ebx, edx                  ;// ebx = ebx + edx = sum - previous element. 
     add ebx, eax                  ;// ebx = ebx + eax = sum + this element.
     mov edx, eax                  ;// edx = eax = previous element.
     loop L1                       ;// Loops as many times as ECX is not equal to 0.
     mov eax, ebx                  ;// eax = ebx = sum.

        invoke ExitProcess, 0      ;// Exit the process.
    main endp
    end main

   