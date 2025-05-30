.macro setA8
	sep #$20
.endmacro

.macro setA16
	rep #$20
.endmacro

.macro setAXY8
	sep #$30
.endmacro

.macro setAXY16
	rep #$30
.endmacro

.macro setXY8
	sep #$10
.endmacro

.macro setXY16
	rep #$10
.endmacro

.macro nops num

.if num > 0
    NOP
    nops num -1
.endif

.endmacro

.macro jslb label, bank
	.byte $22, <label, >label, bank
.endmacro

.macro jmlb label, bank
	.byte $5C, <label, >label, bank
.endmacro

.macro repeat value, count

.if count > 0
	.byte value	
	repeat value, (count-1)
.endif

.endmacro