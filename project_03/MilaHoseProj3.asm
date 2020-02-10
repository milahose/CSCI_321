; Project 3
; Mila Hose
; 2/9/2020

.386
.model flat, stdcall
.stack 4096
ExitProcess proto, dwExitCode:dword

.code
main proc
	; PROBLEM 1
	; Write a program that calculates the  
	; following expression, using registers
	; A = (A + B) ? (C + D)
	; Assign integer values to EAX, EBX, ECX & ECX

	mov	eax, 15		; move 15 to the eax register
	mov ebx, 5		; move 5 to the ebx register
	mov ecx, 3		; move 3 to the ecx register
	mov edx, 7		; move 7 to the edx register

	add eax, ebx	; add the value in ebx (5) to the eax register -- eax register now holds 20
	add ecx, edx	; add the value in edx (7) to the ecx register -- ecx register now holds 10
	sub eax, ecx	; subtract the value in the ecx register (10) from the value in the eax register (20)
					; the eax register now holds a value of 10


	; PROBLEM 2	
	; Write code that defines symbolic constants for all 7 days of the week.
	; Create an array variable that uses the symbols as initializers.

	Mon=0
	Tues=1
	Wed=2
	Thurs=3
	Fri=4
	Sat=5
	Sun=6

	week BYTE Mon, Tues, Wed, Thurs, Fri, Sat, Sun


	; PROBLEM 3
	; The program must contain a definition of each data type listed in Table 3.2, Section 3.4.
	; Initialize each variable to a value that is consistent with its data type.

	val1 BYTE 10
	val2 SBYTE -128
	val3 WORD 65535
	val4 SWORD -32768
	val5 DWORD 12345678h
	val6 SDWORD -2147483648
	val7 FWORD 0
	val8 QWORD 1234567812345678h
	val9 TBYTE 1000000000123456789Ah
	val10 REAL4 -2.1r
	val11 REAL8 3.2E-260r
	val12 REAL10 4.6E+409
	

	; PROBLEM 4
	; Write code that defines symbolic names for several string literals.
	; Use each symbolic name in a variable definition.

	CompSci EQU <"Computer Science!",0> 
	assembly EQU <"x86 Assembly Language",0>
	class EQU <"CSCI 321",0>
	assignment EQU <"Project 3",0>
	
	var1 BYTE CompSci
	var2 BYTE assembly
	var3 BYTE class
	var4 BYTE assignment

	invoke ExitProcess, 0
main endp
end main