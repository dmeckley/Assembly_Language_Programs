;// File: a02_3.10.2.asm
;// Author: Dustin Meckley
;// Date Created: 11/01/2015

    .386
    .model flat, stdcall
    .stack 4096
    ExitProcess proto, dwExitCode:dword

    ;// Declared Variables:
    .data
         dataTypeBYTE BYTE 255                         ;// Range = 0 to 2^8 - 1
         dataTypeSBYTE SBYTE 127                       ;// Range = -128 to +127
         dataTypeWORD WORD 65535                       ;// Range = 0 to 2^16 - 1
         dataTypeSWORD SWORD 32767                     ;// Range = -32768 to +32767
         dataTypeDWORD DWORD 4294967295                ;// Range = 0 to 2^32 - 1
         dataTypeSDWORD SDWORD 2147483647              ;// Range = -2147483648 to +2147483647
         dataTypeFWORD FWORD 2.8147e14                 ;// Range = 0 to 2^48 - 1
         dataTypeQWORD QWORD 1.8446e19                 ;// Range = 0 to 2^64 - 1
         dataTypeTBYTE TBYTE 800000000000001234h       ;// Range = -999999999999999999 to +999999999999999999 
         dataTypeREAL4 REAL4 -2.5                      ;// Range = -1.7e38 to +1.7e38 w/6 significant digits
         dataTypeREAL8 REAL8 1.3e-203                  ;// Range = -1.0e308 to +1.0e308 w/14 significant digits
         dataTypeREAL10 REAL10 3.5e4102                ;// Range = -1.0e4932 to +1.0e4932 w/18 significant digits

    ;// Declared Code: 
    .code
    main proc
       
        invoke ExitProcess, 0
    main endp
    end main