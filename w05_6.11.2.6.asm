; File: w05_6.11.2.6.asm
; Author: Dustin Meckley
; Date Created: 11/22/2015
; MLA: ProcTable.asm pg 217 Textbook as a starting point.
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
Case       BYTE   '1'			; lookup value
           DWORD   xANDy		; address of procedure
           BYTE   '2'
           DWORD   xORy
           BYTE   '3'
           DWORD   NOTx
           BYTE   '4'
           DWORD   xXORy
           BYTE   '5'
           DWORD   ExitProgram

LOOP_COUNTER = 5

prompt BYTE "Press enter 1, 2, 3, 4, or 5: ",0
xANDyMessage BYTE "x AND y",0
xORyMessage BYTE "x OR y",0
NOTxMessage BYTE "NOT x",0
xXORyMessage BYTE "x XOR y",0
exitMessage BYTE "Exit Program",0

xPrompt BYTE "Please enter x value in Hex: ",0
xValue DWORD 0h
yPrompt BYTE "Please enter y value in Hex: ",0
yValue DWORD 0h

xANDyDisplay BYTE "x AND y = ",0
xORyDisplay BYTE "x OR y = ",0
notxDisplay BYTE "NOT x = ",0
xXORyDisplay BYTE "x XOR y = ",0
exitDisplay BYTE "Exiting the program... ",0
;--------------------------------------------------------------------
;                           Code Segment:                           |  
;--------------------------------------------------------------------
.code                           
main proc                       
	mov  edx,OFFSET prompt		; Points to the beginning of prompt message string.
	call WriteString            ; Call the WriteString procedure.
	call ReadChar				; Call the ReadChar procedure. 
	mov  ebx,OFFSET Case	    ; Points to the beginning of Case structure.
	mov  ecx, LOOP_COUNTER 	    ; ecx = LOOP_COUNTER = 5. 
L1:
	cmp  al, [ebx]				; Compare Case character with users input for equality. 
	      jne  L2		        ; Jump to L2 if al != [ebx].
	call NEAR PTR [ebx + 1]		; Points to the proper Case procedure.
	call Crlf                   ; Advances the cursor to the next line on the console window.
	jmp  L3					    ; Jump to L3 if al == [ebx].
L2:
	add  ebx, 5				    ; Add 5 to the ebx pointer to increment ebx pointer to the next element location.
	loop L1					    ; Loop L1 while ecx != 0. 
L3:
	invoke ExitProcess, 0  
main endp                       

;--------------------------------------------------------------------
;                         Procedure Segments:                       |  
;--------------------------------------------------------------------
displayOption proc
    call WriteString			; Displays message the option selected by the user.
	call Crlf                   ; Advances the cursor to the next line on the console window.
    ret                         ; Returns to the procedure caller.
displayOption endp

getXHex proc
    mov  edx,OFFSET xPrompt	    ; Points to the beginning of xPrompt message string.	
	call WriteString            ; Writes the xPrompt string to the console window.
	call ReadHex	            ; Read Hex value entered by the user.        
    mov xValue, eax             ; Store the value entered by the user into xValue location.
    ret                         ; Returns to the procedure caller.
getXHex endp

getYHex proc
    mov  edx,OFFSET yPrompt     ; Points to the beginning of yPrompt message string.			
	call WriteString            ; Writes the yPrompt string to the console window.
	call ReadHex		        ; Read Hex value entered by the user. 		
    mov yValue, eax             ; Store the value entered by the user into yValue location.
    ret                         ; Returns to the procedure caller.
getYHex endp

xANDy proc
	mov  edx,OFFSET xANDyMessage   ; Points to the beginning of xANDyMessage string.
    call displayOption             ; Call displayOption procedure.

    call getXHex                   ; Call getXHex procedure.
    mov eax, xValue                ; Store xValue into eax register.
    push eax                       ; Push the eax register value onto the stack.
    call getYHex                   ; Call getYHex procedure.
    pop eax                        ; Pop the eax register value off of the stack.
    and eax, yValue                ; Boolean AND comparison of xValue and yValue.

    mov  edx,OFFSET xANDyDisplay   ; Points to the beginning of xANDyDisplay message string.		
	call displayOutput             ; Call displayOutput procedure.

	ret                            ; Returns to the procedure caller.
xANDy endp

xORy proc
	mov  edx,OFFSET xORyMessage    ; Points to the beginning of xORyMessage string.
    call displayOption             ; Call displayOption procedure.

    call getXHex                   ; Call getXHex procedure.
    mov eax, xValue                ; Store xValue into eax register.
    push eax                       ; Push the eax register value onto the stack.
    call getYHex                   ; Call getYHex procedure.
    pop eax                        ; Pop the eax register value off of the stack.
    or eax, yValue                 ; Boolean OR comparison of xValue and yValue.

    mov  edx,OFFSET xORyDisplay	   ; Points to the beginning of xORyDisplay message string.		
	call displayOutput             ; Call displayOutput procedure.

	ret                            ; Returns to the procedure caller.
xORy endp

NOTx proc
	mov  edx,OFFSET NOTxMessage    ; Points to the beginning of NOTxMessage string.
    call displayOption             ; Call displayOption procedure.

    call getXHex                   ; Call getXHex procedure.
    mov eax, xValue                ; Store xValue into eax register.
    not eax                        ; Boolean NOT comparison of xValue.

    mov  edx,OFFSET notxDisplay	   ; Points to the beginning of notxDisplay message string.			
	call displayOutput             ; Call displayOutput procedure.

	ret                            ; Returns to the procedure caller.
NOTx endp

xXORy proc
	mov  edx,OFFSET xXORyMessage   ; Points to the beginning of xXORyMessage string.
    call displayOption             ; Call displayOption procedure.

    call getXHex                   ; Call getXHex procedure.
    mov eax, xValue                ; Store xValue into eax register.
    push eax                       ; Push the eax register value onto the stack.
    call getYHex                   ; Call getYHex procedure.
    pop eax                        ; Pop the eax register value off of the stack.
    xor eax, yValue                ; Boolean XOR comparison of xValue and yValue.

    mov  edx,OFFSET xXORyDisplay   ; Points to the beginning of xXORyDisplay message string.			
	call displayOutput             ; Call displayOutput procedure.

	ret                            ; Returns to the procedure caller.
xXORy endp

ExitProgram proc
	mov  edx,OFFSET exitMessage    ; Points to the beginning of exitMessage string.
    call displayOption             ; Call displayOption procedure.

    mov  edx,OFFSET exitDisplay	   ; Points to the beginning of exitDisplay message string.			
	call WriteString               ; Displays exitDisplay message to the console window.
    mov eax, 1000                  ; Call Delay procedure which implements the time delay of the console window.
    call Delay                     ; Returns to the procedure caller.

	ret                            ; Returns to the procedure caller.
ExitProgram endp

displayOutput proc
    call WriteString               ; Displays the proper message to the console window.
    call WriteHex                  ; Prints the output of operation to the console window.
    mov eax, 1000                  ; Move 1000 into eax register for a 1 second time delay.
    call Delay                     ; Call Delay procedure which implements the time delay of the console window.
    ret                            ; Returns to the procedure caller.
displayOutput endp

end main                        