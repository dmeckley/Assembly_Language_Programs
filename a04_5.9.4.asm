;// File: a04_5.9.4.asm
;// Author: Dustin Meckley
;// Date Created: 11/18/2015

include Irvine32.inc

.386
.model flat, stdcall
.stack 4096
ExitProcess proto, dwExitCode:dword

;// Data Segment.
.data                           
   row BYTE 5
   col BYTE 25
   sum SDWORD 0
   intOne SDWORD 0
   intTwo SDWORD 0
   prompt BYTE "Enter an integer: ", 0
   sumPrompt BYTE "Sum = ", 0
  
 ;// Code Segment. 
.code                          
main proc                       ;// Start of main procedure.
     mov ecx, 3                 ;// ecx = 3 so L1 will loop 3 times.
     call Clrscr                ;// call Clrscr as to initially clear the screen.
L1:
     call setCursor             ;// call setCursor to set the location of the cursor.
     call getInts               ;// call getInts to prompt the user and accept integer inputs.
     call calSum                ;// call calSum to calculate the summation of the integer inputs.
     call dispSum               ;// call dispSum as to display a message and the summation values to the user.
     call WaitMsg
     call Clrscr                ;// call Clrscr as to clear the screen at the end of every loop execution.
     loop L1                    ;// loop L1 at to loop through L1 while ecx != 0.

    invoke ExitProcess, 0       ;// Exit the process.
main endp                       ;// End of main procedure. 
;//-------------------------------------------------------
;// setCursor 
;//
;// Puts the cursor in the middle of the console window.
;// I added an incremental functionality as to be able to
;// see all of inputs and outputs on the screen at the 
;// same time.
;//-------------------------------------------------------
setCursor proc
     mov dh, row                   ;// Store the row value into dh register.
     mov dl, col                   ;// Store the col value into the dl register.
     call Gotoxy                   ;// call Gotoxy which inserts cursor at the location given in dh and dl.
     inc row                       ;// increment the row of cursor in order to see execution clearly.
     ret                           ;// return to setCursor caller.
setCursor endp

;//-------------------------------------------------------
;// getInts 
;//
;// Prompts the user for two integers and stores them in 
;// the memory location that intOne and intTwo hold. 
;//-------------------------------------------------------
getInts proc
     mov edx, OFFSET prompt             ;// mov the offset of prompt string to edx register.
     call WriteString                   ;// call WriteString to write the promp message onto the console window.
     call ReadInt                       ;// call ReadInt to read the integer input from the keyboard by the user.
     mov intOne, eax                    ;// move the value read in from the keyboard to intOne memory location.

     call setCursor                     ;// call setCursor to set the location of the cursor.

     mov edx, OFFSET prompt             ;// mov the offset of prompt string to edx register.
     call WriteString                   ;// call WriteString to write the promp message onto the console window.
     call ReadInt                       ;// call ReadInt to read the integer input from the keyboard by the user.
     mov intTwo, eax                    ;// move the value read in from the keyboard to intTwo memory location.

     ret                                ;// return to getInts caller.
getInts endp

;//-------------------------------------------------------
;// calSum 
;//
;// Calculates the summation of the two integer inputs and 
;// stores it in the memory location of sum.
;//-------------------------------------------------------
calSum proc
     mov eax, 0                         ;// move zero into eax to be used to store the sum of each loop.
     add eax, intOne                    ;// add 1st value recieved stored into intOne memory location to eax as the sum.
     add eax, intTwo                    ;// add 2nd value recieved stored into intTwo memory location to eax as the sum.
     mov sum, eax                       ;// move the summation stored in eax register to the memory location for sum variable.
     ret                                ;// return to calSum caller.
calSum endp

;//-------------------------------------------------------
;// dispSum 
;//
;//Displays the the output message and displays the sum 
;// output as indicated by the calSum function.  
;//-------------------------------------------------------
dispSum proc
     call setCursor                     ;// call setCursor to set the location of the cursor.
     mov edx, OFFSET sumPrompt          ;// mov the offset of prompt string to edx register.
     call WriteString                   ;// call WriteString to write the promp message onto the console window.
     mov eax, sum                       ;// mov the summation value from the sum variable memory location to the eax register.
     call WriteInt                      ;// Write the value in the eax register to the console window. 
     ret                                ;// return to dispSum caller.
dispSum endp

end main                        ;// End of execution of main.