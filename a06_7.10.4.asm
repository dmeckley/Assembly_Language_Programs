; File: a06_7.10.4.asm
; Author: Dustin Meckley
; Date Created: 12/06/2015
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
ExitProcess proto, dwExitCode:dword
;--------------------------------------------------------------------
;                           Data Segment:                           |  
;--------------------------------------------------------------------
.data  
key1 BYTE -2, 4, 1, 0, -3, 5, 2, -4, -4, 6
key2 BYTE -3, -4, 1, 0, -3, 5, 2, -4, -4, 6
keySize = $ - key1
plainText1 BYTE "This is the 1st secret message, which will be encrypted", 0
plainText2 BYTE "This is the 2nd secret message, which will be encrypted", 0
;--------------------------------------------------------------------
;                           Code Segment:                           |  
;--------------------------------------------------------------------
.code                           
main proc                       
     call getMessageOne            ; Call programmer defined messageOne procedure.
     call getMessageTwo            ; Call programmer defined messageTwo procedure.

     invoke ExitProcess, 0         ; Invoke ExitProcess to end execution of the program.    
main endp                          ; The end of the main procedure.                      
;--------------------------------------------------------------------
;                         Procedure Segments:                       |  
;--------------------------------------------------------------------
encrypt proc                       ; The start of the encrypt procedure.
;--------------------------------------------------------------------
; encrypt Procedure
;
; The encrypt procedure encrypts the specified text string message.
; -------------------------------------------------------------------
L1:
     push ecx                      ; Push ecx counter register value onto the stack.
     cmp BYTE PTR[esi], 0          ; Compare Byte Ptr[esi] with 0. 
     je L3                         ; if BYTE PTR[esi] == 0, then jump to L3.
     mov cl, [edi]                 ; Move key value into cl register.
     cmp cl, 0                     ; Compare key value in cl with 0.
     ror BYTE PTR[esi], cl         ; Rotate BYTE PTR[esi] right cl times for positive values and left cl times for negative values.
     jmp L2                        ; Jump to L2.

L2:
     inc esi                       ; Increment esi index register for plainText# string.
     inc edi                       ; Increment edi index register for key# array.
     pop ecx                       ; Pop ecx counter register value off of the stack.
     loop L1                       ; Loop back to L1 while ecx != 0.
     or eax, 1                     ; Or eax register with all 1's to set the zero flag to be 0.
     jmp LAST                      ; Jump to the LAST label.

L3:
     pop ecx                       ; Pop ecx counter register value off of the stack.

LAST:
     ret                           ; Return to the encrypt procedure caller.

encrypt endp                       ; The end of the encrypt procedure.

getMessageOne proc                 ; The start of the getMessageTwo procedure.
;--------------------------------------------------------------------
; getMessageOne Procedure
;
; The getMessageOne initiates the plainText1 message and encryption keys  
; so that the encrypt procedure can encrypt the message for the user.
; -------------------------------------------------------------------
     mov esi, OFFSET plainText1    ; Move the starting memory location of plainText1 string to esi index register.
L1:
     mov edi, OFFSET key1          ; Move the starting memory location of key1 array to edi index register.
     mov ecx, keySize              ; Move keySize = 10 to ecx counter register.
     call encrypt                  ; Call programmer defined encrypt procedure.
     jnz L1                        ; Jump to L1 if the zero flag is not set.                       

     mov edx, OFFSET plainText1    ; Move the starting memory location of plainText1 string to edx register.
     call WriteString              ; Call the WriteString procedure to write the string to the console window.
     call Crlf                     ; Call Crlf procedure to advance the cursor to the next line on the console window. 
    
     ret                           ; Return to the getMessageOne procedure caller.
getMessageOne endp                 ; The end of the getMessageOne procedure.

getMessageTwo proc                 ; The start of the getMessageTwo procedure.
;--------------------------------------------------------------------
; getMessageTwo Procedure
;
; The getMessageTwo initiates the plainText2 message and encryption keys  
; so that the encrypt procedure can encrypt the message for the user.
; -------------------------------------------------------------------
     mov esi, OFFSET plainText2    ; Move the starting memory location of plainText2 string to esi index register.
L1:
     mov edi, OFFSET key2          ; Move the starting memory location of key2 array to edi index register.
     mov ecx, keySize              ; Move keySize = 10 to ecx counter register.
     call encrypt                  ; Call programmer defined encrypt procedure.
     jnz L1                        ; Jump to L1 if the zero flag is not set.                       

     mov edx, OFFSET plainText2    ; Move the starting memory location of plainText2 string to edx register.
     call WriteString              ; Call the WriteString procedure to write the string to the console window.
     call Crlf                     ; Call Crlf procedure to advance the cursor to the next line on the console window. 
    
     ret                           ; Return to the getMessageTwo procedure caller.
getMessageTwo endp                 ; The end of the getMessageTwo procedure.

end main                           ; The end of the whole program.                    

;                                  MLA:  
; <https://media.pearsoncmg.com/ph/esm/ecs_irvine_x86_6/videos/ch7_4.html>7_4.html>