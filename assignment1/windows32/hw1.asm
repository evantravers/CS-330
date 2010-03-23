; Author:  E. Travers
; Date:    3/2010

.586
.MODEL FLAT

INCLUDE io.h                             ; header file for input/output

.STACK 4096

.DATA
number1   DWORD   ?
number2   DWORD   ?
prompt1   BYTE    "Enter first number", 0
prompt2   BYTE    "Enter second number", 0
string    BYTE    40 DUP (?)
resultLbl BYTE    "The sum is", 0
suberrlbl BYTE    "Numbers subtracted are zero",0
ovrflwlbl BYTE    "Numbers are too big to be multiplied",0
errorm    BYTE    "ERROR!",0
sum       BYTE    11 DUP (?), 0

.CODE
_MainProc PROC
        ; description of problem: read in two ints, compute following expression: A*B-(A+B)/(A-B)+=
        ; I converted to reverse polish, then coded.
        
        input   prompt1, string, 40      ; read ASCII characters
        atod    string                   ; convert to integer
        mov     number1, eax             ; store in memory

        input   prompt2, string, 40      ; repeat for second number
        atod    string
        mov     number2, eax
        
        mov     eax,number1              ; move the A to eax
        imul    number2                  ; multiply A and B
        jo      ovrflowerror             ; if the numbers are too big, throw an error
        push    eax                      ; push A*B to stack
        
        mov     eax,number1              ; move A to eax in prep for subtraction
        sub     eax,number2              ; subtract A and B
        jz      suberrorx                ; the numbers subtracted less than zero
        push    eax                      ; push A-B to stack
        
        mov     eax,number1              ; move A to eax in prep for addition
        add     eax,number2              ; add A and B
        push    eax                      ; push A+B to stack
        
        pop     eax                      ; popping A+B in order to divide it by A-B
        pop     ebx                      ; popping divisor A-B to EBX
        cdq                              ; "spreading" it out over eax/edx for idiv
        idiv    ebx                      ; divide A+B in eax:edx by A-B in EBX
        push    eax                      ; push (A+B)/(A-B) to stack
        
        pop     ebx                      ; pop (A+B)/(A-B) from stack
        pop     eax                      ; pop A*B from stack
        sub     eax,ebx                  ; A*B-(A+B)/(A-B)
        
        dtoa    sum, eax                 ; convert to ASCII characters
        output  resultLbl, sum           ; output label and sum

        endx:
        mov     eax, 0                   ; exit with return code 0
        ret
        
        suberrorx:
        pop eax                          ; clear the stack
        output  errorm, suberrlbl        ; output error message
        jmp endx                         ; end the program  
        
        ovrflowerror:
        output  errorm, ovrflwlbl        ; output error message
        jmp endx
        
        
_MainProc ENDP
END                                      ; end of source code