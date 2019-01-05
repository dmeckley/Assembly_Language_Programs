;// File: a04_5.9.8.asm
;// Author: Dustin Meckley
;// Date Created: 11/18/2015

;// Include Libraries:
include Irvine32.inc

;// Preprocessor Directives:
.386
.model flat, stdcall
.stack 4096
ExitProcess proto, dwExitCode:dword

;// Constant Segment:
ROW_COUNTER = 16               ;// Row counter constant = 16.
COL_COUNTER = 16               ;// Column counter constant = 16.

;// Data Segment.
.data
character BYTE 'X'             ;// character X data.

;// Code Segment. 
.code                           
main proc                      ;// Start of the main procedure.

mov eax, 0                     ;// Setting eax to be 0 = Black.
mov ecx, ROW_COUNTER           ;// Moving ROW_COUNTER = 16 into ecx counter for outer loop.

ROW:                           ;// Outer Loop for Row Processing. 
     push ecx                  ;// Push ecx = ROW_COUNTER = 16 onto the stack.
     mov ecx, COL_COUNTER      ;// Move COL_COUNTER = 16 into the ecx counter for inner loop.
     COL:                      ;// Inner Loop for Column Processing.
          call SetTextColor    ;// Call SetTextColor function for the row background colors & col text colors.     
          push eax             ;// Push eax = SetTextColor = 0 onto the stack.
          mov al, character    ;// Move the character X = 88 into al portion of the eax register.
          call WriteChar       ;// Call the WriteChar procedure to write the character to the console window. 
          pop eax              ;// Pop eax = SetTextColor = 0 off of the stack.
          inc al               ;// Increment the al portion of the eax register for next row background color and next col text colors
     loop COL                  ;// Loop through the COL structure while ecx != 0.
     pop ecx                   ;// Pop ecx = ROW_COUNTER = 16 off of the stack.
     call Crlf                 ;// Call Crfl to advance the cursor on the console window after each row of columns are processed. 
loop ROW                       ;// Loop through the ROW structure while ecx != 0.

mov al, 7                      ;// Move 7 into al portion of eax register to reset the color scheme at the end of execution.
call SetTextColor              ;// Call SetTextColor to reset the colors at the end of execution.

    invoke ExitProcess, 0      ;// Exit the process.
main endp                      ;// End of main procedure. 
end main                       ;// End of execution of main.