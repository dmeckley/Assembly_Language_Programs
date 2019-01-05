;// File: a04_5.9.6.asm
;// Author: Dustin Meckley
;// Date Created: 11/18/2015

include Irvine32.inc

.386
.model flat, stdcall
.stack 4096
ExitProcess proto, dwExitCode:dword

;// Constant Segment:
L = 5                             ;// Length of the string - Counter for the inner loop.
alphaNum = 26                      ;// Range of Alphanumeric Random Letters for Uppercase.

;// Data Segment:
.data
string BYTE L DUP (0), 0           ;// memory location that will hold the string in.
counter DWORD 20                   ;// Length of the columns - Counter for the outer loop.

;// Code Segment: 
.code
main proc
     mov ecx, counter              ;// moving the contents of counter = 20 into ecx to be used as loop counter.
L1:
     call createRandStr            ;// Call createRandStr - Creates the random string strucure.
     call displayRandStr           ;// call displayRandString - Displays the strings to the console window.
     loop L1                       ;// Loops through L1 as long as ecx != 0.
   
     invoke ExitProcess, 0         ;// Exit the main process.
main endp
;//--------------------------------------------------
;// createRandStr
;//
;// Creates a random string of 10 upper-letter cased
;// characters for each iteration of the loop.
;//--------------------------------------------------
createRandStr proc
     mov esi, OFFSET string        ;// Set-up the index of the string to be at the offset location of string.
     mov eax, L                    ;// Move L = 10 into eax as an inner loop counter for length of string. 
     push ecx                      ;// Push ecx = 20 onto the stack for later use as the outer loop counter.
     mov ecx, eax                  ;// Move eax = 10 into ecx to be used as the inner loop counter for length of string.
L2:
     mov eax, alphaNum             ;// Put alphaNum = 26 in for eax as to be used as parameter to RandomRange procedure.
     call RandomRange              ;// Call the RandomRange procedure for producing a random integer between 0 and eax = 26.
     add eax, 'A'                  ;// Add the ASCII code for the letter A to what is stored in the eax register from the RandomRange procedure.
     mov [esi], eax                ;// Store the random character from eax to the string.
     inc esi                       ;// Increment the esi indexer
     loop L2                       ;// Loops through L2 as long as ecx != 0
     pop ecx                       ;// Pop ecx = 20 off of the stack for outer loop counter use.
     ret                           ;// Return to the CreateRandStr caller from main.
createRandStr endp
;//--------------------------------------------------
;// disRandStr
;//
;// Displays the random strings out to the user via
;// console window.
;//--------------------------------------------------
displayRandStr proc
     mov edx, OFFSET string        ;// Set-up the index of the string to be at the offset location of string.
     call WriteString              ;// Call the WriteString procedure to write the strings to console window.
     call Crlf                     ;// Call the Crlf procedure to advance the cursor to the next row of the console window.
     ret                           ;// Return to the displayRandStr caller from main.
displayRandStr endp

end main  ;// End of execution of main.