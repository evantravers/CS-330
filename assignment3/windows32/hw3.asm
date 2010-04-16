; Author:  E. Travers
; Date:    3/2010

.586
.MODEL FLAT

INCLUDE io.h				 ; header file for input/output

.STACK 4096

.DATA

   thearray   DWORD   200 DUP (?)
   prompt1    BYTE    "Enter a number to add to the sort: ", 0
   resultLbl  BYTE    "One of your results is: ",0
   ovrFlwlbl  BYTE    "Too many values entered!",0
   noItemsx   BYTE    "No data entered!",0
   string     BYTE    20 DUP (?)
   numElem    DWORD   ?

.CODE
_MainProc PROC

; takes in a series of integers, sorts them, and prints them out in ascending order.

   mov        eax, 0
   mov        ebx, 0
   mov        ecx, 0
   mov        edx, 0

inputLoopx:
   ; get input, stop when you see a zero
   input      prompt1, string, 40	 ; read ASCII characters
   atod       string
   cmp	      eax, 0
   je	      outLoopx
   ; if not zero, then add to the array
   mov        thearray[4*ecx], eax
   inc        ecx
   cmp        ecx,200
   je         overFlowx
   jne        inputLoopx
outLoopx:
   cmp ecx, 0
   je  noDatax
   inc        ecx
   mov        numElem, ecx

   ; now sort the array
   ; for every item in the array in reverse order
   
outerLoopx:
   mov        edx, 0
   innerLoopx:
      ; take each item, compare it to 0 increasing, stop when you find it bigger than the previous
      ; take the current item
      mov     eax, thearray[4*ecx]
      ; take the next item (inner loop)
      mov     ebx, thearray[4*edx]
      cmp     eax, ebx
      jl      swapSkipx
      
      ; swap
      mov     thearray[4*edx], eax
      mov     thearray[4*ecx], ebx
   swapSkipx:
   
      inc     edx;
      cmp     ecx, edx
   jnz        innerLoopx
loop outerLoopx  

      mov     ecx, numElem
      dec     ecx
printx:
      dtoa    string, thearray[(4*ecx)-4]                
      output  resultLbl, string
      dec     ecx
      cmp     ecx, 0
      jg      printx
      ret

overFlowx:
      output  ovrFlwlbl,ovrFlwlbl
      ret
noDatax:
      output  noItemsx,noItemsx
      ret
_MainProc ENDP
END					 ; end of source code