; File: a08_9.10.2.asm
; Author: Dustin Meckley
; Date Created: 12/12/2015
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
;--------------------------------------------------------------------
;                        Procedure Prototypes:                      |  
;--------------------------------------------------------------------
displayString proto, stringMessagePTR:PTR BYTE, stringPTR:PTR BYTE
Str_concat proto, targetPTR:PTR BYTE, sourcePTR:PTR BYTE 
;--------------------------------------------------------------------
;                           Data Segment:                           |  
;--------------------------------------------------------------------
.data
BYTES_TRANSFERRED = 3
sourceMessage BYTE "Source string = ", 0
source BYTE "FGH", 0
destinationMessage BYTE "Destination string = ", 0
destination BYTE "ABCDE", 8 DUP (0)

;--------------------------------------------------------------------
;                           Code Segment:                           |  
;--------------------------------------------------------------------
.code                           
main proc 

     invoke displayString, addr sourceMessage, addr source
     invoke displayString, addr destinationMessage, addr destination
     invoke Str_concat, addr destination, addr source     
     invoke displayString, addr destinationMessage, addr destination

     invoke ExitProcess, 0       
main endp                       
;--------------------------------------------------------------------
;                         Procedure Segments:                       |  
;--------------------------------------------------------------------
Str_concat proc uses esi edi ecx, destinationPTR:PTR BYTE, sourcePTR:PTR BYTE 
    
     cld                           ; Clear Direction Flag (Forward Direction)
     mov esi, sourcePTR            ; Move sourcePTR = source = esi.              
     mov edi, destinationPTR       ; Move destinationPTR = destination = edi.    
     add edi, 5                    ; Add edi = edi + 5.
     mov ecx, BYTES_TRANSFERRED    ; Move BYTES_TRANSFERRED = 3 = ecx.
     rep movsb                     ; Move from esi to edi repeating 3 times.
          
     ret                           ; Return to the procedure caller.
Str_concat endp                    ; The end of the Str_concat procedure. 
;--------------------------------------------------------------------
displayString proc uses edx, stringMessagePTR:PTR BYTE, stringPTR:PTR BYTE
    
     mov edx, stringMessagePTR     ; Move stringMessagePtr = edx.
     call WriteString              ; Call the WriteString procedure from the Irvine library.

     mov edx, stringPTR            ; Move stringPTR = edx.
     call WriteString              ; Call the WriteString procedure from the Irvine library.
     call Crlf                     ; Call the Crlf procedure from the Irvine library.

     ret                           ; Return to the procedure caller.
displayString endp                 ; The end of the displayString procedure. 
;--------------------------------------------------------------------
end main       