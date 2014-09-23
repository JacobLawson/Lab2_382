;-------------------------------------------------------------------------------
; MSP430 Assembler Code Template for use with TI Code Composer Studio
;
;
;-------------------------------------------------------------------------------
            .cdecls C,LIST,"msp430.h"       ; Include device header file

;-------------------------------------------------------------------------------
            .text                           ; Assemble into program memory
            .retain
            .retainrefs

message:	.byte 0xef,0xc3,0xc2,0xcb,0xde,0xcd,0xd8,0xd9,0xc0,0xcd,0xd8,0xc5,0xc3,0xc2,0xdf,0x8d,0x8c,0x8c,0xf5,0xc3,0xd9,0x8c,0xc8,0xc9,0xcf,0xde,0xd5,0xdc,0xd8,0xc9,0xc8,0x8c,0xd8,0xc4,0xc9,0x8c,0xe9,0xef,0xe9,0x9f,0x94,0x9e,0x8c,0xc4,0xc5,0xc8,0xc8,0xc9,0xc2,0x8c,0xc1,0xc9,0xdf,0xdf,0xcd,0xcb,0xc9,0x8c,0xcd,0xc2,0xc8,0x8c,0xcd,0xcf,0xc4,0xc5,0xc9,0xda,0xc9,0xc8,0x8c,0xde,0xc9,0xdd,0xd9,0xc5,0xde,0xc9,0xc8,0x8c,0xca,0xd9,0xc2,0xcf,0xd8,0xc5,0xc3,0xc2,0xcd,0xc0,0xc5,0xd8,0xd5,0x8f
key:		.byte 0xac
meslength:	.byte 0x5E
decrypt: 	.equ  0x0200
keylength: 	.equ  0x0001

            	                            ; Override ELF conditional linking
                                            ; and retain current section
             			                    ; Additionally retain any sections
                                            ; that have references to current
                                            ; section

;-------------------------------------------------------------------------------
RESET       mov.w   #__STACK_END,SP         ; Initialize stackpointer
StopWDT     mov.w   #WDTPW|WDTHOLD,&WDTCTL  ; Stop watchdog timer

;-------------------------------------------------------------------------------
                                            ; Main loop here
;-------------------------------------------------------------------------------
			mov.w   #0x0400, 		R1
			mov.w   #message, 		R5
			mov.w	#key, 			R6
			mov.w	#decrypt,		R7
			mov.w	#meslength,	 	R8
			mov.w	#keylength,		R9

			call    #decryptMessage

forever:    jmp     forever

;-------------------------------------------------------------------------------
                                            ; Subroutines
;-------------------------------------------------------------------------------

;-------------------------------------------------------------------------------
;Subroutine Name: decryptMessage
;Author: 
;Function: Decrypts a string of bytes and stores the result in memory.  Accepts 
;           the address of the encrypted message, address of the key, and address
;           of the decrypted message (pass-by-reference).  Accepts the length of
;           the message by value.  Uses the decryptCharacter subroutine to decrypt
;           each byte of the message.  Stores theresults to the decrypted message
;           location.
;Inputs:
;Outputs:
;Registers destroyed: 
;-------------------------------------------------------------------------------
decryptMessage:
			tst		R8		; Checks to see if we've decrypted the entire message
			jz		return
			dec 	R8			; Decrement the loop counter/message length

			tst		R9
			jz		resetkey
			dec.b	R9

			mov.b	@R5+, R10	 	;Loads R10 with the byte to decrypt
			mov.b	@R6+, R11	;Loads R11 with the next byte of the key
			call	#decryptCharacter
			mov.b	R11, 0(R7)	;Stores the decypted byte to memory
			inc.w	R7
			jmp		decryptMessage
resetkey:
			mov.w	#keylength, R9
			mov.w	#key, R6
			jmp		decryptMessage
return:
            ret

;-------------------------------------------------------------------------------
;Subroutine Name: decryptCharacter
;Author: 
;Function: Decrypts a byte of data by XORing it with a key byte.  Returns the
;           decrypted byte in the same register the encrypted byte was passed in.
;           Expects both the encrypted data and key to be passed by value.
;Inputs: 
;Outputs: 
;Registers destroyed: 
;-------------------------------------------------------------------------------

decryptCharacter:

			xor.b R10, R11

			ret


;-------------------------------------------------------------------------------
;           Stack Pointer definition
;-------------------------------------------------------------------------------
            .global __STACK_END
            .sect 	.stack

;-------------------------------------------------------------------------------
;           Interrupt Vectors
;-------------------------------------------------------------------------------
            .sect   ".reset"                ; MSP430 RESET Vector
            .short  RESET
