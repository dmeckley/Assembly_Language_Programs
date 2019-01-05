; File: a06_7.10.5.asm
; Author: Dustin Meckley
; Date Created: 11/29/2015
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
FIRSTPRIME = 2
LASTPRIME = 1000
sieve BYTE LASTPRIME DUP(0)
;--------------------------------------------------------------------
;                           Code Segment:                           |  
;--------------------------------------------------------------------
.code                           
main proc                       
     mov esi, FIRSTPRIME      ; Move FIRSTPRIME = 2 into esi register.

BEGINWHILE:
     cmp esi, LASTPRIME       ; Compare esi register with LASTPRIME = 1000
     ja ENDWHILE              ; If esi > LASTPRIME Jump to ENDWHILE.
     cmp sieve[esi], 0        ; Compare sieve[esi] with 0.
     je L1                    ; If sieve[esi] == 0 Jump L1
L1:
     call CrossOutNonPrimes   ; Call programmer defined CrossOutNonPrimes procedure.
     inc esi                  ; Increment esi register.
     loop BEGINWHILE          ; Loop BEGINWHILE as long as esi < LASTPRIME = 1000          
ENDWHILE:
     call displayPrimes       ; Call the programmer defined displayPrimes procedure.
     jmp LAST                 ; Jump to the LAST label for completion of program execution.

LAST:
     call Crlf                ; Advanced the cursor to the next line on the console window.
     invoke ExitProcess, 0    ; Invoke ExitProcess and return 0 for proper program execution. 

main endp                     ; The end of the main procedure.                     

;--------------------------------------------------------------------
;                         Procedure Segments:                       |  
;--------------------------------------------------------------------
CrossOutNonPrimes proc        ; The start of the CrossOutNonPrimes procedure. 
;--------------------------------------------------------------------
; CrossOutNonPrimes Procedure
;
; The CrossOutNonPrimes procedure sets sieve[esi] = 1 if the number is
; an nonprime number and sets sieve[esi] = 0 if the number is a prime
; number.
; -------------------------------------------------------------------
     push esi                 ; Push the esi register value onto the stack.
     mov eax, esi             ; Move the value from the esi register into the eax register.
     add esi, eax             ; Add the value in the eax register to the esi register value and store it in the esi register.

L1:
     cmp esi, LASTPRIME       ; Compare the value in the esi register with the LASTPRIME = 1000
     ja L2                    ; If esi > LASTPRIME = 1000, then Jump to L2.
     mov sieve[esi], 1        ; Else move 1 into sieve[esi] to indicate a crossed out non-prime numbers. 
     add esi, eax             ; Add the value in the eax register to the esi register value and store it in the esi register.
     jmp L1                   ; Jump to L1.

L2:
     pop esi                  ; Pop the esi register value off of the stack.
     ret                      ; Return control to the caller of the CrossOutNonPrimes procedure.

CrossOutNonPrimes endp        ; The end of the CrossOutNonPrimes procedure. 

displayPrimes proc            ; The start of the displayPrimes procedure. 
;--------------------------------------------------------------------
; displayPrimes Procedure
;
; The displayPrimes procedure displays the prime numbers out to the 
; the user via console window.
; -------------------------------------------------------------------
     mov esi, FIRSTPRIME      ; Move FIRSTPRIME = 2 into the esi register.

BEGINWHILE:
     cmp esi, LASTPRIME       ; Compare the value in the esi register with the LASTPRIME = 1000     
     ja ENDWHILE              ; If esi > LASTPRIME, then jump to the ENDWHILE label.            
     cmp sieve[esi], 0        ; Compare sieve[esi] value with 0.    
     je L0                    ; If sieve[esi] == 0, then jump to the L0 label.  
     jne L1                   ; ElseIf sieve[esi] != 0, then jump to the L1 label.
L0:
     mov eax, esi             ; Move the value in the esi register into the eax register.
     call WriteInt            ; Call the WriteInt procedure to write the integer stored in the eax register.
     call Crlf                ; Advance the cursor to the next line on the console window.
     jmp L1                   ; Jump to label L1.
L1:
     inc esi                  ; Increment the esi register by 1.
     loop BEGINWHILE          ; Loop BEGINWHILE as long as esi < LASTPRIME = 1000 
ENDWHILE:
     ret                      ; Return control back to the procedure caller. 

displayPrimes endp            ; The end of the displayPrimes procedure.       

end main                      ; The end of the logic for the whole program.                     