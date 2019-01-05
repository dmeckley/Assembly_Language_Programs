; File: w05_6.11.2.1.asm
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

; Constant Segment:
ARRAY_SIZE = 100                   ; Static size ARRAY_SIZE constant.
LOOP_COUNTER = 2                   ; LOOP_COUNTER constant for L1 Loop.

; Data Segment:
.data                           
arr DWORD ARRAY_SIZE DUP(?)        ; arr Array for storing the random generated numbers.

N DWORD 0                          ; N data for storing the range of random generated numbers.
j DWORD 0                          ; j data for determining the lowest range inclusive of random generated numbers.
k DWORD 0                          ; k data for determining the highest range inclusive of random generated numbers.                                 
jPrompt BYTE "Please enter the value for j: ", 0
                                   ; Prompt for the user to input lowest range value for j:                                   
kPrompt BYTE "Please enter the value for k: ", 0
                                   ; Prompt for the user to input highest range value for k:

; Code Segment:
.code                           
main proc                          ; Start of main procedure. 
     mov eax, 0                    ; Move 0 into eax register.               
     mov ecx, LOOP_COUNTER         ; Move LOOP_COUTER = 2 into ecx register.
L1:
     call getJandK                 ; Call getJandK procedure to set the low and high values of random number generation.
     call setN                     ; Call setN procedure to set the range of random number generation and length of array.
     call createRandomNumArray     ; Call createRandomNumArray to create the random numbers generation and store them into the array.
     call Crlf                     ; Call Crlf to advance the cursor to the next line in the console window.
     loop L1                       ; Loop through L1 as long as ecx != 0.
     invoke ExitProcess, 0         ; Exit the process.
main endp                          ; End of main procedure.

; Additional Procedures:
;-----------------------------------------------------
; getJandK
;
; Prompts the user for the values of the inclusive j 
; and k values and sets the data j and k to be these 
; values for calculating the random number range.
;-----------------------------------------------------
getJandK proc
     mov edx, OFFSET jPrompt       ; Move the offset of jprompt string to edx to output message to user.
     call WriteString              ; Call the WriteString procedure to print the string to the console window.
     call ReadInt                  ; Call the ReadInt procedure to read the input entered by the user.
     mov j, eax                    ; Move the input read in by ReadInt procedure into the j data location.
    
     mov edx, OFFSET kPrompt       ; Move the offset of kprompt string to edx to output message to user.
     call WriteString              ; Call the WriteString procedure to print the string to the console window.
     call ReadInt                  ; Call the ReadInt procedure to read the input entered by the user.
     mov k, eax                    ; Move the input read in by ReadInt procedure into the k data location.

     ret                           ; Return back to caller in the main procedure.
getJandK endp 
;-----------------------------------------------------
; setN
;
; Sets the value for N which is the length of the array  
; based off of the range of elements allowed by the
; Random Range procedure.
;-----------------------------------------------------
setN proc      
     mov eax, 0                    ; Move 0 into the eax register.
     add eax, k                    ; Add the k (high range) value to the eax register.
     sub eax, j                    ; Subtract j (low range) value from the eax register.
     inc eax                       ; Increment the eax register by 1.
     mov N, eax                    ; Move the final range value from eax to the N data location.
     ;call WriteInt
     call Crlf                     ; Call Crlf to advance the cursor to the next line in the console window.
     ret                           ; Return back to caller in the main procedure.
setN endp
;-----------------------------------------------------
; createRandomNumArray
;
; Creates a random number inclusive of j and k and 
; stores the values at a random interval in the array
; arr.
;-----------------------------------------------------
createRandomNumArray proc
mov esi, OFFSET arr                ; Point to the beginning of the array with esi register.                       
push ecx                           ; Push the ecx counter for L1 loop onto the stack.
mov ecx, eax                       ; Move eax = N into the ecx register for L2 counter.
L2:
     mov eax, N                    ; Move the range value for N into the eax register.
     call RandomRange              ; Call the RandomRange procedure for Random Number Generation between the range.
     add eax, j                    ; Add the lowest range value of j to the Random Generated Number.
     ;call WriteInt
     mov [esi], eax                ; Store the random generated number into the arr[esi] location. 
     add esi, 4                    ; Add 4 to the esi register to increment the DWORD array.
     loop L2                       ; Loop through L2 as long as ecx != 0.                   
     pop ecx                       ; Pop the ecx counter for L1 back off of the stack.
     ret                           ; Return back to caller in the main procedure.
createRandomNumArray endp

end main                           ; End of execution of main.