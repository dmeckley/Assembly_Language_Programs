; File: a07_8.11.4.asm
; Author: Dustin Meckley
; Date Created: 12/13/2015
;--------------------------------------------------------------------
;                          Library Segment:                         |  
;--------------------------------------------------------------------
include Irvine32.inc
;--------------------------------------------------------------------
;                 Preprocessor Directive Segment:                   |  
;--------------------------------------------------------------------
.386
.model flat, stdcall
.stack 4096
ExitProcess proto, dwExitCode:DWORD

; Procedure Prototypes:
FindThrees proto, ptrArray:PTR DWORD, sizeOfArray:DWORD
;--------------------------------------------------------------------
;                           Data Segment:                           |  
;--------------------------------------------------------------------
.data  
array1 DWORD 1, 2, 2, 3, 3, 3, 4, 4, 4, 4
array2 DWORD 9, 8, 7, 6, 5, 4, 3, 2, 1, 0
array3 DWORD 1, 2, 3, 4, 5
array4 DWORD 3, 3, 3, 5, 3, 3, 3
FALSE = 0
TRUE = 1
NUM = 3
numCount DWORD 0
status BYTE FALSE
;--------------------------------------------------------------------
;                           Code Segment:                           |  
;--------------------------------------------------------------------
.code                           
main proc                          ; The beginning of the main procedure. 

    invoke FindThrees, addr array1, lengthof array1
    invoke FindThrees, addr array2, lengthof array2
    invoke FindThrees, addr array3, lengthof array3
    invoke FindThrees, addr array4, lengthof array4

    invoke ExitProcess, 0       
main endp                           ; The end of the main procedure.                      
;--------------------------------------------------------------------
;                         Procedure Segments:                       |  
;--------------------------------------------------------------------
FindThrees proc USES ebx ecx esi, ptrArray:PTR DWORD, sizeOfArray:DWORD

; FindThrees procedure finds three consecutive 3's in the given array
; and sets the status bit to either TRUE = 1 if three 3's exist in the 
; array or FALSE = 0 if three 3's do not exist in the given array. 

; eax = The current element value within the array.
; ebx = The register used to keep count of the number of 3's in a row.
; ecx = The register used to keep count of the loop with the size of array. 
; esi = The register used to point to the array.
     
     ; Registers to be pushed onto the stack by the USES directive.
     ; push ebx
     ; push ecx
     ; push esi
     
     mov ecx, sizeOfArray          ; Move sizeOfArray = lengthof array# = ecx.                
     mov esi, ptrArray             ; Move ptrArray = addr array# = esi. 
     mov status, FALSE             ; Move FALSE = 0 = status. 
     mov ebx, numCount             ; Move numCount = 0 = ebx.              
L0:
     mov eax, [esi]                ; Move ptrArray[esi] = array#[esi] = eax. 
     add esi, 4                    ; Add esi = esi + 4. Increment DWORD array indexer.
     cmp eax, NUM                  ; Compare eax != NUM = 3.
     jne L1                        ; If eax != NUM = 3, then Jump to label L1.
     inc ebx                       ; Increment ebx = ebx + 1.                     
     cmp ebx, NUM                  ; Compare ebx == NUM = 3.                 
     je L2                         ; If ebx == NUM = 3, then Jump to label L2.
     jmp L3                        ; Jump to label L3.  
L1:
     mov ebx, 0                    ; Move 0 = ebx. Reset Counter if non-three is found in array elements.                  
     jmp L3                        ; Jump to label L3.  
L2:
     mov status, TRUE              ; Move TRUE = 1 = status.              
     jmp L3                        ; Jump to label L3.
L3:
     loop L0                       ; Loop through label L0 as long as ecx != 0.
     cmp status, TRUE              ; Compare status == TRUE = 1.          
     je L4                         ; If status == TRUE = 1, then Jump to label L4.

     ; Registers to be popped off of the stack by the USES directive.
     ; pop esi
     ; pop ecx
     ; pop ebx

     ret FALSE                     ; Return FALSE = 0 to the procedure caller.
L4:
     ret TRUE                      ; Return TRUE = 1 to the procedure caller.
FindThrees endp                    ; The end of the FindTrees procedure.
;--------------------------------------------------------------------
end main                        