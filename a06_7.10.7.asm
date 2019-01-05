; File: a06_7.10.7.asm
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
header BYTE "Bitwise Multiplication", 0dh, 0ah, 0dh, 0ah, 0
dashes BYTE "-", 0
dashCounter = 22
xString BYTE "Multiplicand X: ", 0
yString BYTE "Multiplier Y: ", 0
prodString BYTE "X * Y = ", 0
;--------------------------------------------------------------------
;                           Code Segment:                           |  
;--------------------------------------------------------------------
.code                           
main proc                     ; Start of the main procedure.                    
    call displayTitle         ; Call programmer defined displayTitle procedure.
    call getX                 ; Call programmer defined getX procedure.
    call getY                 ; Call programmer defined getY procedure.
    call setProduct           ; Call programmer defined setProduct procedure.
    call displayProduct       ; Call programmer defined displayProduct procedure.

    invoke ExitProcess, 0     ; Exit execution of the main procedure.     
main endp                     ; End of the main procedure.                    

;--------------------------------------------------------------------
;                         Procedure Segments:                       |  
;--------------------------------------------------------------------
displayTitle proc             ; Start of the displayTitle procedure.
;--------------------------------------------------------------------
; displayTitle Procedure
;
; The displayTitle procedure displays a title bar underneath the title  
; of Bitwise Multiplication for the purpose of the program's execution.  
; -------------------------------------------------------------------
     ; Write title to the console window:
     mov edx, OFFSET header   ; Move the starting memory location of header string to the edx register.
     call WriteString         ; Call the WriteString procedure to write the title heading to the console window.
     
     ; Write dashes underneath the title to the console window:
     mov ecx, dashCounter     ; Move the dashCounter = 22 to ecx counter register for writing of dashes under header title.    
L0:
     mov edx, OFFSET dashes   ; Move the starting memory location of dashes string to the edx register.
     call WriteString         ; Call the WriteString procedure to write the dashes underneath the title heading to the console window.
     loop L0                  ; Loop L0 as long as ecx != 0 -> 22 times for all of the dashes for title heading.
     call Crlf                ; Advance the cursor on the cosole window to the next line.
     ret                      ; Return control to the procedure caller back in the main procedure.
displayTitle endp             ; End of the displayTitle procedure.

getX proc                     ; Start of the getX procedure.
;--------------------------------------------------------------------
; getX Procedure
;
; The getX procedure gets the multiplicand x for x * y = product 
; calculations.
; -------------------------------------------------------------------
    ; Get the multiplicand x value and store in ebx register:
     mov edx, OFFSET xString   ; Move the starting memory location of xString to the edx register.
     call WriteString          ; Call the WriteString procedure to write the xString to the console window.
     call ReadDec              ; Call the ReadDec procedure to read a decimal input from the user and store in eax register.
     mov ebx, eax              ; Move the decimal input from the user from the eax register to the ebx register.
     ret                       ; Return control to the procedure caller back in the main procedure.                    
getX endp                     ; End of the getX procedure.

getY proc                     ; Start of the getY procedure.
;--------------------------------------------------------------------
; getY Procedure
;
; The getY procedure gets the multiplier y for x * y = product 
; calculations.
; -------------------------------------------------------------------
    ; Get the multiplier y value and store in edx register:
     mov edx, OFFSET yString   ; Move the starting memory location of yString to the edx register.
     call WriteString          ; Call the WriteString procedure to write the yString to the console window.
     call ReadDec              ; Call the ReadDec procedure to read a decimal input from the user and store in eax register.
     mov edx, eax              ; Move the decimal input from the user from the eax register to the ebx register.
     ret                       ; Return control to the procedure caller back in the main procedure.
getY endp                     ; End of the getY procedure.

setProduct proc          ; Start of the setProduct procedure.
;--------------------------------------------------------------------
; setProduct Procedure
;
; The setProduct procedure calculates the product for x * y = product.
; -------------------------------------------------------------------
     ; Calculate the product and store in eax register:
     mov eax, 0          ; Move 0 into the eax register for accumulator.
     mov cl, 0           ; Move 0 into the cl register 
L1:
     shr edx, 1          ; Shift multiplier y to the right.
     jnc L2              ; Jump to L2 if not carry (CF = 0).

     mov esi, ebx        ; Move ebx register = multiplicand x to the esi register.  
     shl esi, cl         ; Shift mutliplicand x to the left.
     add eax, esi        ; Add esi register multiplicand x to the eax register.
L2:
     inc cl              ; Increment cl register by 1.
     cmp cl, 32          ; Compare cl register to 32.
     jb L1               ; Jump to L1 if cl < 32.

     ret                 ; Return control to the procedure caller back in the main procedure.
setProduct endp          ; End of the setProduct procedure.

displayProduct proc                ; Start of the displayProduct procedure.
;--------------------------------------------------------------------
; displayProduct Procedure
;
; The displayProduct procedure displays the product of x * y = product
; to the console window for the user to view.
; -------------------------------------------------------------------
     ; Display the product to the end user via console window:
     mov edx, OFFSET prodString     ; Move the starting memory location of prodString to the edx register.
     call WriteString               ; Call the WriteString procedure to write the prodString to the console window.
     call WriteDec                  ; Call the WriteDec procedure to write the products value to the console window.
     call Crlf                      ; Advance the cursor on the cosole window to the next line.
     ret                            ; Return control to the procedure caller back in the main procedure.
displayProduct endp                 ; End of the displayProduct procedure.
    
end main                            ; End of the whole program.

;                             MLA:
; https://media.pearsoncmg.com/ph/esm/ecs_irvine_x86_6/videos/ch7_5.html