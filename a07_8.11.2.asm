; File: a07_8.11.2.asm
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
setColor proto foreGround:BYTE, backGround:BYTE
writeSquares proto char:BYTE, foreGround:BYTE, backGround:BYTE
displayOddRows proto color:BYTE
displayEvenRows proto color:BYTE
;--------------------------------------------------------------------
;                           Data Segment:                           |  
;--------------------------------------------------------------------
.data  
ROWS = 8
COLS = 8
Squares = 2
;--------------------------------------------------------------------
;                           Code Segment:                           |  
;--------------------------------------------------------------------
.code                           
main proc                               ; The beginning of the main procedure.

     mov ecx, ROWS / Squares            ; Move ecx = ROWS / Squares = 8 / 2
L0:
     invoke displayOddRows, gray        ; Call displayOddRows procedure.
     call Crlf                          ; Call Crlf procedure.
     invoke displayEvenRows, gray       ; Call displayEvenRows procedure.
     call Crlf                          ; Call Crlf procedure.
     loop L0                            ; Loop L0 while ecx != 0.
     invoke setColor, lightGray, black  ; Call or Invoke setColor procedure.
     call Crlf                          ; Call Crlf procedure.

     invoke ExitProcess, 0              ; Call or Invoke ExitProcess procedure.   
main endp                               ; The end of the main procedure.                     
;--------------------------------------------------------------------
;                         Procedure Segments:                       |  
;--------------------------------------------------------------------
writeSquares proc USES eax, char:BYTE, foreGround:BYTE, backGround:BYTE
; writeSquares procedure initiates the creation of the squares on the 
; chess board.

     invoke setColor, foreGround, backGround      ; Call or Invoke the setColor procedure.
     mov al, char                                 ; Move al = char
     call WriteChar                               ; Call the WriteChar procedure from the Irvine library.

     ret                                          ; Return control back to procedure caller.
writeSquares endp                                 ; The end of the writeSquares procedure. 
;--------------------------------------------------------------------
setColor proc, foreGround:BYTE, backGround:BYTE
; setColor procedure sets the colors of the squares on the 
; chess board.

     movzx eax, backGround         ; Move Zero Extended eax = backGround
     shl eax, 4                    ; Shift Left eax four places.
     or al, foreGround             ; Logical OR al with foreGround.
     call SetTextColor             ; Call the SetTextColor procedure from the Irvine library.

     ret                           ; Return control back to procedure caller.
setColor endp                      ; The end of the setColor procedure. 
;--------------------------------------------------------------------
displayOddRows proc USES ecx, color:BYTE
; displayOddRows prints the odd rows of the chess board onto the 
; console window.

     mov ecx, COLS / Squares                 ; Move ecx = COLS / Squares = 8 / 2.
L1:
     invoke writeSquares, ' ', color, color  ; Call or Invoke writeSquares procedure.
     invoke writeSquares, ' ', color, color  ; Call or Invoke writeSquares procedure.
     invoke writeSquares, ' ', white, white  ; Call or Invoke writeSquares procedure.
     invoke writeSquares, ' ', white, white  ; Call or Invoke writeSquares procedure.
     loop L1                                 ; Loop L1 at long as ecx != 0.

     ret                                     ; Return control back to procedure caller.
displayOddRows endp                          ; The end of the displayOddRows procedure. 
;--------------------------------------------------------------------
displayEvenRows proc USES ecx, color:BYTE
; displayEvenRows prints the even rows of the chess board onto the 
; console window.

     mov ecx, COLS / Squares                 ; Move ecx = COLS / Squares = 8 / 2.
L1:
     invoke writeSquares, ' ', white, white  ; Call or Invoke writeSquares procedure.
     invoke writeSquares, ' ', white, white  ; Call or Invoke writeSquares procedure.
     invoke writeSquares, ' ', color, color  ; Call or Invoke writeSquares procedure.
     invoke writeSquares, ' ', color, color  ; Call or Invoke writeSquares procedure.
     loop L1                                 ; Loop L1 at long as ecx != 0.

     ret                                     ; Return control back to procedure caller.
displayEvenRows endp                         ; The end of the displayEvenRows procedure. 
;--------------------------------------------------------------------
end main    

;                                MLA:
; https://media.pearsoncmg.com/ph/esm/ecs_irvine_x86_6/videos/Chapt8_Exercise9/index.html