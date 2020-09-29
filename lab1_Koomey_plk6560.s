.global add32
.global sub64
.global minU16
.global minS32
.global isLessThanU16
.global isLessThanS16
.global shiftLeftU16
.global shiftU32
.global shiftS8
.global isEqualU32
.global isEqualS8

.text


@ uint64_t add32(uint32_t x, uint32_t y)
@	R1:R0			R0			R1
add32:
	ADDS R0, R0, R1
	MOV R1, #0
	ADC R1, R1, #0
	B return
	
	
@ uint64_t sub64(uint64_t x, uint64_t y)
@	R1:R0			R1:R0		R3:R2
sub64:
	SUBS R0, R0, R2
	SBC R1, R1, R3
	B return
	
	
@ minU16(uint16_t x, uint16_t y)
@	R0		R0			R1
minU16:
	CMP R1, R0     @subtract R1 from R0
	MOVCC R0, R1   @if negative (R0 - R1 = -) move R1 into R0
	B return


@ int32_t minS32(int32_t x, int32_t y)
@	R0				R0			R1
minS32:
	CMP R1, R0
	MOVLT R0,R1
	B return
	
@ isLessThanU16(uint16_t x, uint16_t y)
@		R0			R0			R1
@ if x is smaller, return 1, 0 otherwise
isLessThanU16:
	CMP R1, R0    @ subtract 
	MOV R0, #0
	MOVPL R0, #1  
	B return      


@ bool isLessThanS16(int16_t x, int16_t y)
@	R0					R0			R1
isLessThanS16:
	CMP R1, R0    @ subtract 
	MOV R0, #0
	MOVPL R0, #1  
	B return      
	
@ uint16_t shiftLeftU16 (uint16_t x, uint16_t p)
@	R0							R0			R1
shiftLeftU16:
	MOV R0, R0, LSL R1	
	B return
	

@ uint32_t shiftU32(uint32_t x, int32_t p)
@ 	R0					R0			R1
shiftU32:
	CMP R1, #0
	MOVPL R0, R0, LSL R1
	NEG R1, R1
	MOVMI R0, R0, LSR R1
	B return
	
	
shiftS8:
	CMP R1, #0
	MOVPL R0, R0, LSL R1
	NEG R1, R1
	MOVMI R0, R0, LSR R1
	B return
	
	
isEqualU32:
	CMP R1, R0
	MOVNE R0, #0
	MOVEQ R0, #1
	B return
	
	
isEqualS8:
	CMP R1, R0
	MOVNE R0, #0
	MOVEQ R0, #1
	B return

return:
	BX LR
	
