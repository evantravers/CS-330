; Author:  E. Travers
; Date:    3/2010

.586
.MODEL FLAT

INCLUDE io.h                             ; header file for input/output

.STACK 4096

.DATA
     prompt1   BYTE    "Enter a number to add to the average: ", 0
     string    BYTE    40 DUP (?)
     number1   DWORD   ?
     resultLbl BYTE    "The average is", 0
     errorMsg  BYTE    "You entered no numbers!", 0
     sum       BYTE    11 DUP (?), 0

.CODE
_MainProc PROC
     ; Problem: Compute the average of numbers,
     ; possible number of inputs going up to 100.
     ; Solution: As each one comes in, increment a counter, 
     ; and keep adding the numbers together.
     ; At the end, divide the sum of all the 
     ; numbers by the counter, output result.   
     
     ; eax handles input, ebx handles the sum, ecx handles counter
     
     mov       ebx, 0                    ; put zero in eax and ecx
     mov       ecx, 0
     mov       eax, 0
     
inputLoopx:
     ; for each input
     input     prompt1, string, 40       ; read ASCII characters
     atod      string                    ; convert to integer
     cmp       eax, 0                    ; see if it's zero
     je        outLoopx                  ; get out of the loop
     add       ebx, eax                  ; add the new number to eax's sum
     inc       ecx
     jmp       inputLoopx
outLoopx:
     cmp       ecx, 0                    ; make sure that numbers have been entered
     je        noneEntered
     ; now move the sum to eax, the divisor to ebx, and divide
     mov       eax, ebx
     cdq
     idiv      ecx
     
     ; output result
     dtoa      sum, eax
     output    resultLbl, sum            ; output label and sum
     jmp endx
     
noneEntered:
     output    errorMsg, errorMsg
endx:
     ret
_MainProc ENDP
END                                      ; end of source code