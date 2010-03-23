; Author:  E. Travers
; Date:    3/2010

.586
.MODEL FLAT

INCLUDE io.h                             ; header file for input/output

.STACK 4096

.DATA


.CODE
_MainProc PROC
     ; Problem: Compute the average of numbers, possible number of inputs going up to 100.
     ; Solution: As each one comes in, increment a counter, and keep adding the numbers together. At the end, divide the sum of all the numbers by the counter, output result.        
_MainProc ENDP
END                                      ; end of source code