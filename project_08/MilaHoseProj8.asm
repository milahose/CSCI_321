; Project 8
; Mila Hoses
; 4/12/2020

  
Include Irvine32.inc


GCD PROTO x:SDWORD, y:SDWORD
recursiveGCD PROTO x:SDWORD, y:SDWORD

.data
	gcdString BYTE "Greatest common divisor of (", 0
	loopString BYTE ") calculated by loop is: ", 0
	recursionString BYTE "calculated by recursion is: ", 0
	val1 SDWORD 5,24,11,432,26
	val2 SDWORD 20,18,7,226,13

.CODE
main PROC
		mov edx, OFFSET gcdString
		call WriteString
		mov eax,[val1]
		call WriteDec
		mov al,','
		call WriteChar
		mov eax,[val2]
		call WriteDec
		mov edx, OFFSET loopString
		call WriteString
		INVOKE GCD, [val1], [val2]
		call WriteDec
		call Crlf
		mov edx, OFFSET recursionString
		call WriteString
		INVOKE recursiveGCD, [val1], [val2]
		call WriteDec
		call Crlf

		mov edx, OFFSET gcdString
		call WriteString
		mov eax,[val1]+4
		call WriteDec
		mov al,','
		call WriteChar
		mov eax,[val2]+4
		call WriteDec
		mov edx, OFFSET loopString
		call WriteString
		INVOKE GCD, [val1]+4, [val2]+4
		call WriteDec
		call Crlf
		mov edx, OFFSET recursionString
		call WriteString
		INVOKE recursiveGCD, [val1]+4, [val2]+4
		call WriteDec
		call Crlf

		mov edx, OFFSET gcdString
		call WriteString
		mov eax,[val1]+8
		call WriteDec
		mov al,','
		call WriteChar
		mov eax,[val2]+8
		call WriteDec
		mov edx, OFFSET loopString
		call WriteString
		INVOKE GCD, [val1]+8, [val2]+8
		call WriteDec
		call Crlf
		mov edx, OFFSET recursionString
		call WriteString
		INVOKE recursiveGCD, [val1]+8, [val2]+8
		call WriteDec
		call Crlf

		mov edx, OFFSET gcdString
		call WriteString
		mov eax,[val1]+12
		call WriteDec
		mov al,','
		call WriteChar
		mov eax,[val2]+12
		call WriteDec
		mov edx, OFFSET loopString
		call WriteString
		INVOKE GCD, [val1]+12, [val2]+12
		call WriteDec
		call Crlf
		mov edx, OFFSET recursionString
		call WriteString
		INVOKE recursiveGCD, [val1]+12, [val2]+12
		call WriteDec
		call Crlf

		mov edx, OFFSET gcdString
		call WriteString
		mov eax,[val1]+16
		call WriteDec
		mov al,','
		call WriteChar
		mov eax,[val2]+16
		call WriteDec
		mov edx, OFFSET loopString
		call WriteString
		INVOKE GCD, [val1]+16, [val2]+16
		call WriteDec
		call Crlf
		mov edx, OFFSET recursionString
		call WriteString
		INVOKE recursiveGCD, [val1]+16, [val2]+16
		call WriteDec
		call Crlf


		exit
main ENDP

GCD PROC USES ebx edx,
	x:SDWORD,
	y:SDWORD

; Calculates the GCD of two 32-bit integers.
; Returns: EAX = GCD(x,y)
;-----------------------------------------------------
LoopStart:		; do {
	mov	edx,0
	mov	eax,x
	mov	ebx,y
	div	ebx		; EDX = x % y
	mov	x,ebx	; x = y
	mov	y,edx	; y = EDX
	cmp	y,0
	jle	Done
	jmp LoopStart	; } while (y > 0)
Done:
	mov	eax,x	; return the GCD in EAX
	ret
GCD ENDP

recursiveGCD PROC USES ebx edx,
	x:SDWORD,
	y:SDWORD

; Calculates the GCD of two 32-bit integers.
; Returns: EAX = GCD(x,y)
;-----------------------------------------------------
LoopStart:		; do {
	mov	edx,0
	mov	eax,x
	mov	ebx,y
	div	ebx		; EDX = x % y
	mov	x,ebx	; x = y
	mov	y,edx	; y = EDX
	cmp	y,0
	jle	Done
	jmp LoopStart	; } while (y > 0)
Done:
	mov	eax,x	; return the GCD in EAX
	ret
recursiveGCD ENDP

END main