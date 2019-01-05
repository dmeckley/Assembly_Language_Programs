; File: w05_6.11.2.4.asm
; Author: Dustin Meckley
; Date Created: 11/22/2015

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
TRUE = 1
FALSE = 0
gradeAvgPrompt BYTE "Please enter the student's GPA: ", 0
gradeAverage WORD 0
creditInvalidInput BYTE "Error: Invalid value input for credits by the user! ", 0
creditValuePrompt BYTE "Please enter the student's completed credit hours: ", 0
credits WORD 0
okToRegisterOutput BYTE "The student can register.", 0
notOkToRegisterOutput BYTE "The student cannot register.", 0
okToRegister BYTE FALSE

;--------------------------------------------------------------------
;                           Code Segment:                           |  
;--------------------------------------------------------------------
.code                           
main proc                       
     ; Prompt the user for GPA:
     mov edx, OFFSET gradeAvgPrompt
     call WriteString  
     call ReadInt
     mov gradeAverage, ax

     ; gradeAverage > 350:
     cmp ax, 350   
          ja SETREGISTER

     ; gradeAverage > 250:
     cmp ax, 250
          ja L1
          jbe L2
L1:
     ; Prompt the user for Credits Earned:
     call creditPrompt

     ; credits <= 16
     cmp ax, 16
          jbe SETREGISTER
     jmp LAST

L2:
     ; Prompt the user for Credits Earned:
     call creditPrompt

     ; credits <= 12:
      cmp ax, 12
          jbe SETREGISTER      
     jmp LAST

SETREGISTER:
      mov okToRegister, TRUE

LAST:
     call isOkToRegister
     invoke ExitProcess, 0       

main endp                       

;--------------------------------------------------------------------
;                         Procedure Segments:                       |  
;--------------------------------------------------------------------
creditPrompt proc
;--------------------------------------------------------------------
; creditPrompt Procedure
;
; The creditPrompt procedure produces the string output message for 
; the user to enter credit hours earned into credits data location.
; The procedure also does error checking of input values within the 
; range of 1 to 30 displaying error message and exiting execution if
; a input entry is invalid.
; -------------------------------------------------------------------
     ; Prompt the user for Credits Earned:
     mov edx, OFFSET creditValuePrompt
     call WriteString  
     call ReadInt

     ; credits < 1
     cmp ax, 1
          jb QUIT

     ; credits > 30
     cmp ax, 30 
          ja QUIT

     mov credits, ax
     ret
QUIT:
     ; Prompt the user with error message and exit program execution:
     mov edx, OFFSET creditInvalidInput
     call WriteString
     call Crlf
     exit

creditPrompt endp

isOkToRegister proc
;--------------------------------------------------------------------
; isOkToRegister Procedure
;
; The isOkToRegister procedure determines whether the okToRegister 
; data location stores true or false.  If it does store true, then we
; display a message to the user saying that the student can register;
; otherwise, if it stores a false, then we display a message to the 
; user indicating that the student cannot register at this time.
; -------------------------------------------------------------------
     ; Compare Equality of okToRegister:
     mov al, okToRegister
     cmp al, TRUE
     ; if okToRegister == TRUE jump to OKAYTOREGISTER:
          je OKAYTOREGISTER
     ; else if okToRegister == FALSE print student cannot register.
     mov edx, OFFSET notOkToRegisterOutput
     call WriteString 
     call Crlf
     ret

; if okToRegister == TRUE print student can register:   
OKAYTOREGISTER:
     mov edx, OFFSET okToRegisterOutput
     call WriteString 
     call Crlf
     ret

isOkToRegister endp

end main                        