; Project 5
; Mila Hose
; 2/29/2020

INCLUDE Irvine32.inc

L = 10

.data
	randomString BYTE L DUP (?)

.code
main PROC
	call Clrscr
	mov	eax, L
	mov	esi, OFFSET randomString
	mov	ecx, 20
GenerateStrings:
	call GenerateRandomString
	mov	edx, OFFSET randomString
	call Writestring
	call Crlf
loop GenerateStrings
	exit
main ENDP

; Generates a random string of length L.
; Receives:	EAX = L (string length)
;			ESI = pointer to array of bytes that will hold the random string
; Returns:	randomString = the randomly generated string

GenerateRandomString PROC USES eax ecx esi
	mov	ecx,eax
GenerateChar:
	mov	eax, 26
	call RandomRange
	add	eax, 65
	mov	[esi], eax
	inc esi
loop GenerateChar
	mov	eax, 0
	mov	[esi], eax
	ret
GenerateRandomString ENDP
END main