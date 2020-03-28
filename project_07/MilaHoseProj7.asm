; Project 7
; Mila Hose
; 3/28/2020

INCLUDE Irvine32.inc

.data
	msgMenu BYTE "Bitwise Multiplication of Unsigned Integers.", 0dh, 0ah, 0
	msgEnterMultiplicand BYTE "Enter the multiplicand: ", 0
	msgEnterMultiplier BYTE "Enter the multiplier: ", 0
	msgProduct BYTE "The product is: ", 0
	msgAnother BYTE "Do you want to do another calculation? y/n (all lower case): ", 0
	msgError BYTE "Error: Integer is out of range.", 0

.code
main PROC

ShowMenu:				
	clc
	call Clrscr
	mov edx, OFFSET msgMenu
	call WriteString
	call Crlf
GetMultiplicand:			; Get the multiplicand and store it in ebx
	mov edx, OFFSET msgEnterMultiplicand
	call WriteString
	call ReadDec
		.IF CARRY?			; Display error if the multiplicand is too large
			mov edx, OFFSET msgError
			call WriteString
			call Crlf
			jmp GetMultiplicand
		.ELSE
			mov ebx, eax
		.ENDIF
GetMultiplier:				; Get the multiplier
	mov edx, OFFSET msgEnterMultiplier
	call WriteString
	call ReadDec
		.IF CARRY?
			mov edx, OFFSET msgError
			call WriteString
			jmp GetMultiplier
		.ENDIF
	; The multiplier is now in eax and the multiplicand is in ebx
	call BitWiseMultiply
	mov edx, OFFSET msgProduct
	call Crlf
	call WriteString
	call WriteDec
Again:						; Repeat based on user input
	mov edx, OFFSET msgAnother
	call Crlf
	call WriteString
	call ReadChar
	.IF (AL == 'y')
		jmp ShowMenu
	.ELSEIF (AL == 'n')
		jmp ExitProgram
	.ELSE
		jmp Again
	.ENDIF
ExitProgram:
main ENDP

BitWiseMultiply PROC
	push edx			
	push ebx
	push ecx

	mov edx, eax		
	mov ecx, 16
	mov eax, 0			
L1:
	test ebx, 00000001h	; Add edx to eax if the last digit is a 1
	jz NO_ADD			; Skip next step to avoid adding if there isn't a 1 in the last digit of ebx
	add eax, edx
NO_ADD:
	shl edx, 1			; Shift multiplicant to the left one bit
	shr ebx, 1			; Shift multiplier to the right one bit
	loop L1

	pop ecx				; Pop saved registers
	pop ebx
	pop edx
	ret
BitWiseMultiply ENDP

END main