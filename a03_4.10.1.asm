;// File: a03_4.10.1.asm
;// Author: Dustin Meckley
;// Date Created: 11/09/2015

    .386
    .model flat, stdcall
    .stack 4096
    ExitProcess proto, dwExitCode:dword

    ;// Declared Variables:
    .data
     bigEndian BYTE 12h, 34h, 56h, 78h       ;// Big Endian Array.
     littleEndian DWORD ?                    ;// Little Endian Array.
    
    
    ;// Declared Code: 
    .code
    main proc
     mov al,byte ptr [bigEndian]             ;// Copy 12 from bigEndian 1st memory location to al.
     mov byte ptr [littleEndian + 3], al     ;// Copy 12 from al to littleEndian last memory location.

     mov al,byte ptr [bigEndian + 1]         ;// Copy 34 from bigEndian 2nd memory location to al.
     mov byte ptr [littleEndian + 2], al     ;// Copy 34 from al to littleEndian 3rd memory location.

     mov al,byte ptr [bigEndian + 2]         ;// Copy 56 from bigEndian 3rd memory location to al.
      mov byte ptr [littleEndian + 1], al    ;// Copy 56 from al to littleEndian 2nd memory location.

     mov al,byte ptr [bigEndian + 3]         ;// Copy 78 from bigEndian last memory location to al.
     mov byte ptr [littleEndian], al         ;// Copy 56 from al to littleEndian 1st memory location.
    
        invoke ExitProcess, 0                ;// Exit the process.
    main endp
    end main