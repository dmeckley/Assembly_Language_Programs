; File: a07_8.11.1.asm
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

; Procedure Prototype:
FindLargest proto, ptrArray:PTR SDWORD, countArray:DWORD
;--------------------------------------------------------------------
;                           Data Segment:                           |  
;--------------------------------------------------------------------
.data  
Ex1Array SDWORD 1, 9, 3, 7, 5
Ex2Array SDWORD -9, -7, -3, -1, -5
Ex3Array SDWORD -1, -3, -5, -7, -9, 0, 9, 7, 5, 3, 1 
maxValueString BYTE"The largest value of the array is: ", 0
;--------------------------------------------------------------------
;                           Code Segment:                           |  
;--------------------------------------------------------------------
.code                           
main proc
     ; Procedure Call or Invoke Procedure:
     invoke FindLargest, addr Ex1Array, lengthof Ex1Array
     invoke FindLargest, addr Ex2Array, lengthof Ex2Array 
     invoke FindLargest, addr Ex3Array, lengthof Ex3Array

     invoke ExitProcess, 0       
main endp                       

;--------------------------------------------------------------------
;                         Procedure Segments:                       |  
;--------------------------------------------------------------------
; Procedure Definition:
FindLargest proc USES eax ebx ecx esi, ptrArray:PTR SDWORD, countArray:DWORD

; The FindLargest procedure searches through an array with signed word elements
; and searches for the maximum value within the array.

; eax = The current element value of the array.
; ebx = The largest value found so far out of all of the elements of the array.
; ecx = The number of elements within the array.
; esi = Stores the offset of Ex#Array by utilizing ptrArray pointer.
; edx = Stores the offset of maxValueString string.

     ;push eax
     ;push ebx
     ;push ecx
     ;push esi

     mov ecx, countArray      ; Move ecx = countArray = lengthof Ex#Array.
     mov esi, ptrArray        ; Move esi = ptrArray = addr Ex#Array.
     mov ebx, [esi]           ; Move ebx = ptrArray[esi] = Ex#Array[esi].
L0:
     mov eax, [esi]           ; Move eax = ptrArray[esi] = Ex#Array[esi]. 
     add esi, 4               ; Add esi = esi + 4.  DWORD incrementation. 
     cmp eax, ebx             ; Compare eax < ebx = current element < maximum element.
     jl L1                    ; Jump to label L1 if eax < ebx           
     mov ebx, eax             ; Move ebx = eax = maximum element.
L1:
     loop L0                  ; Loop L0 as long as ecx != 0.
   
     mov edx, offset maxValueString     ; Move edx = offset maxValueString = starting location of maxValueString.
     call WriteString                   ; Call WriteString procedure from the Irvine library.
     mov eax, ebx                       ; Move ebx = maximum element = eax for writing to the console window.
     call WriteInt                      ; Call the WriteInt procedure from the Irvine library.
     call Crlf                          ; Call the Crlf procedure from the Irvine library to advance the cursor on the console window.

     ;pop esi
     ;pop ecx
     ;pop ebx
     ;pop eax

     ret
FindLargest endp
;--------------------------------------------------------------------
end main                        