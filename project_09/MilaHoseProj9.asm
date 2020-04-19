; Project 9
; Mila Hoses
; 4/18/2020

  
Include Irvine32.inc

Str_find PROTO, pTarget:PTR BYTE, pSource:PTR BYTE



.data

source BYTE 32 DUP(0)
target BYTE 32 DUP(0)
userSelection BYTE 32 DUP(0)
yesString1 BYTE "Y",0
yesString2 BYTE "y",0
noString1 BYTE "N",0
noString2 BYTE "n",0

enterSource BYTE "Enter source string (the string to search for): ",0
enterTarget BYTE "Enter target string (the string to search from): ",0
sourceFound BYTE "Source string found at position ",0
inTarget BYTE " in Target string (counting from zero).",0Ah,0Ah,0Dh,0
stringNotFound BYTE "Unable to find Source string in Target string.",0Ah,0Ah,0Dh,0
againString BYTE "Do you want to do another search? y/n: ",0
invalidSelection BYTE "That was not a valid selection, please try again.",0

stop DWORD ?
targetLength DWORD ?
sourceLength DWORD ?
position DWORD ?

.code
main PROC
start:
	call Crlf;
	; get the source string
	mov EDX, OFFSET enterSource
	call WriteString
	mov EDX,OFFSET source
	mov ECX,SIZEOF source
	call ReadString
	
	; get the target string
	mov EDX, OFFSET enterTarget
	call WriteString
	mov EDX,OFFSET target
	mov ECX,SIZEOF target
	call ReadString

	; Call Str_find to look for the source string in the target string
	INVOKE Str_find,ADDR target, ADDR source
	mov position, eax				; store the position value
	jz wasfound						; ZF = 1 indicates string found
	
	mov EDX,OFFSET stringNotFound	; string not found
	call WriteString
	jmp again
	
wasfound:					
	mov EDX,OFFSET sourceFound
	call WriteString
	mov eax,position				; write position value
	call WriteDec
	mov edx,OFFSET inTarget
	call WriteString
	
again:								; Menu for re-running the program
	mov EDX,OFFSET againString
	call WriteString
	mov EDX,OFFSET userSelection
	mov ECX,SIZEOF userSelection
	call ReadString
	INVOKE Str_compare, ADDR yesString1, ADDR userSelection		; Check for "Y"
	je start
	INVOKE Str_compare, ADDR yesString2, ADDR userSelection		; Check for "y"
	je start
	INVOKE Str_compare, ADDR noString1, ADDR userSelection		; Check for "N"
	je quit
	INVOKE Str_compare, ADDR noString2, ADDR userSelection		; Check for "n"
	je quit
	call Crlf
	mov EDX,OFFSET invalidSelection								; Invalid selection response
	call WriteString
	call Crlf
	jmp again

quit:
   exit

main ENDP


; Inputs: pointer to the source and pointer to the target strings
; Outputs:	ZF = 1 if a match is found, and EAX will point to the matching position in the target string.
;			ZF = 0, if no match was found, and eax is undefined.
Str_find PROC,
	pTarget:PTR BYTE,			
	pSource:PTR BYTE
	
	INVOKE Str_length,pTarget	; get length of the target
	mov targetLength,eax
	INVOKE Str_length,pSource	; get length of the source
	mov sourceLength,eax
	
	mov edi,OFFSET target		; point to target
	mov esi,OFFSET source		; point to source
	
	; Compute place in target to stop search
	mov eax,edi					; stop = (offset target)
	add eax,targetLength			; + (length of target)
	sub eax,sourceLength			; - (length of source)
	inc eax						; + 1
	mov stop,eax				; save the stopping position
	
	; Compare source string to current target
	cld
	mov ecx,sourceLength			; length of source string
L1:
	pushad
	repe cmpsb					; compare all bytes
	popad
	je found					; if found, exit
	
	inc edi						; move to next target position
	cmp edi,stop				; if EDI reached stop position, 
	jae notfound				; then exit
	jmp L1						; otherwise, continue the loop
	
notfound:						; string not found
	or eax,1					; ZF = 0 indicates failure
	jmp done
	
found:							; string found
	mov eax,edi					; compute position in target of find
	sub eax,pTarget
	cmp eax,eax					; ZF = 1 indicates success
	
done:
	ret
Str_find ENDP

END main