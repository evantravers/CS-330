; Author:  E. Travers
; Date:    4/2010

.586
.MODEL FLAT

INCLUDE io.h				 ; header file for input/output

.STACK 4096

.DATA
prompt1    BYTE    "Enter a base 10 number to test: ", 0
string     BYTE    20 DUP (?)
theNum     DWORD   ?
result     BYTE    "The MSB is ",0
result2    BYTE    "The LSB is ",0
result3    BYTE    "Total number of set bits: ",0
lstBit     DWORD   ?
fstBit     DWORD   ?
setBits    DWORD   ?
                   

.CODE
_MainProc PROC
; Given a 32 bit integer, find the rightmost, the leftmost,
; and the number of on bits in the number

input      prompt1, string, 40	 ; read ASCII characters
atod       string

; now the famous number is in eax

; find the MSB order bit
BSF        ebx, eax
dtoa       lstBit, ebx
output     result2, lstBit

; time to find the LSB bit

BSR        ebx, eax
dtoa       fstBit, ebx
output     result, fstBit

; find the number of bits

; set the loop counter
mov        ecx,32

; make the bit detector
mov        edx,1

; keep the number of set bits
mov        ebx,0

bitCntr:
   test    edx, eax
   jz      skipx
      inc  ebx
   skipx:
   shl     edx,1
loop bitCntr

dtoa       setBits, ebx
output     result3, setBits

ret

_MainProc ENDP
END					 ; end of source code