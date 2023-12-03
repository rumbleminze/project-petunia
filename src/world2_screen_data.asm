; Rooms are represented by 8 bytes of data
; The first 5 bytes are binary data that tell us if they connect to the room in that index 1 - 40
; The 6th byte represents the door location to use if a door is in that room
; the 7th and 8th bytes are the memory address of the room's data


; The next two bytes are the address of the room data
world_2_screen_data:
.byte $FF, $FF, $FB, $FF, $E7, $A3, $1B, $B1	
.byte $FF, $FF, $FF, $FF, $E7, $AA, $3F, $B1
.byte $FF, $93, $FF, $FF, $E7, $AB, $63, $B1
.byte $FF, $FF, $FF, $FF, $E7, $A4, $8D, $B1
.byte $FF, $FF, $FB, $FF, $E7, $A9, $BD, $B1
.byte $FF, $FE, $FB, $FF, $E7, $76, $D5, $B1
.byte $FF, $FF, $FB, $FF, $E7, $AD, $08, $B2
.byte $FF, $FF, $FF, $FF, $E7, $A8, $3E, $B2
.byte $FF, $FF, $FF, $FF, $E7, $A5, $65, $B2
.byte $FF, $FF, $FB, $FF, $E7, $1E, $89, $B2
.byte $FF, $FF, $FF, $FF, $E7, $AE, $B3, $B2
.byte $FF, $FF, $FB, $FF, $E7, $AA, $0A, $B3
.byte $FF, $FF, $FB, $FF, $E7, $6A, $28, $B3
.byte $FF, $FF, $FB, $FF, $E7, $AA, $52, $B3
.byte $FF, $FF, $FF, $FF, $E7, $89, $7C, $B3
.byte $FF, $FF, $FF, $FF, $E7, $68, $AC, $B3
.byte $FF, $FF, $FF, $FF, $E7, $8A, $D0, $B3
.byte $FF, $FF, $FF, $FF, $E7, $87, $EE, $B3
.byte $FF, $FF, $FF, $FF, $E7, $7C, $1E, $B4
.byte $FF, $FF, $FF, $FF, $E7, $9A, $45, $B4
.byte $FF, $FF, $FF, $FF, $E7, $5A, $78, $B4
.byte $FF, $FF, $FF, $FF, $E7, $9C, $B7, $B4
.byte $FF, $FF, $FF, $FF, $E7, $96, $DB, $B4
.byte $FF, $FF, $FB, $FF, $E7, $AA, $3E, $B5
.byte $FF, $FF, $FB, $FF, $E7, $A8, $62, $B5
.byte $FF, $FF, $FF, $FF, $E7, $2B, $B0, $B5
.byte $FF, $FF, $FF, $FF, $E3, $00, $0A, $B6
.byte $FF, $FF, $FF, $FF, $E3, $9E, $43, $B6
.byte $FF, $FF, $FF, $FF, $E7, $A6, $9D, $B6
.byte $FF, $FF, $FF, $FF, $E3, $4B, $CD, $B6
.byte $FF, $FF, $FF, $FF, $E7, $A5, $00, $B7
.byte $F7, $81, $7F, $FF, $67, $9A, $27, $B7
.byte $FF, $FF, $FF, $FF, $E7, $00, $A5, $B4	; platforms
.byte $FF, $FF, $FF, $FF, $E7, $00, $6D, $B6	; platforms
.byte $FF, $B3, $FF, $FF, $E7, $00, $86, $B5	; platforms
.byte $00, $00, $00, $00, $00, $00, $00, $00	; non-existant so far
.byte $00, $00, $00, $00, $00, $00, $00, $00	; non-existant so far
.byte $80, $00, $00, $00, $E0, $00, $3A, $B0	; ending room 1
.byte $80, $00, $00, $00, $E0, $00, $70, $B0	; ending room 2
.byte $80, $00, $00, $00, $E0, $00, $AC, $B0	; ending room 3
.byte $FF, $FF, $FB, $FF, $E7, $00, $E5, $B0	; starting room 1
.byte $FF, $FF, $FB, $FF, $E7, $00, $D4, $B2	; starting room 2
.byte $FF, $FF, $FB, $FF, $E7, $00, $05, $B5	; starting room 3
.byte $00, $00, $00, $00, $00, $00, $FF, $FF	; fake "end of level" room

; Binary representation
;1111 1111 1111 1111 1111 1011 1111 1111 1110 0111
;1111 1111 1111 1111 1111 1111 1111 1111 1110 0111
;1111 1111 1001 0011 1111 1111 1111 1111 1110 0111
;1111 1111 1111 1111 1111 1111 1111 1111 1110 0111
;1111 1111 1111 1111 1111 1011 1111 1111 1110 0111
;1111 1111 1111 1110 1111 1011 1111 1111 1110 0111
;1111 1111 1111 1111 1111 1011 1111 1111 1110 0111
;1111 1111 1111 1111 1111 1111 1111 1111 1110 0111
;1111 1111 1111 1111 1111 1111 1111 1111 1110 0111
;1111 1111 1111 1111 1111 1011 1111 1111 1110 0111
;1111 1111 1111 1111 1111 1111 1111 1111 1110 0111
;1111 1111 1111 1111 1111 1011 1111 1111 1110 0111
;1111 1111 1111 1111 1111 1011 1111 1111 1110 0111
;1111 1111 1111 1111 1111 1011 1111 1111 1110 0111
;1111 1111 1111 1111 1111 1111 1111 1111 1110 0111
;1111 1111 1111 1111 1111 1111 1111 1111 1110 0111
;1111 1111 1111 1111 1111 1111 1111 1111 1110 0111
;1111 1111 1111 1111 1111 1111 1111 1111 1110 0111
;1111 1111 1111 1111 1111 1111 1111 1111 1110 0111
;1111 1111 1111 1111 1111 1111 1111 1111 1110 0111
;1111 1111 1111 1111 1111 1111 1111 1111 1110 0111
;1111 1111 1111 1111 1111 1111 1111 1111 1110 0111
;1111 1111 1111 1111 1111 1111 1111 1111 1110 0111
;1111 1111 1111 1111 1111 1011 1111 1111 1110 0111
;1111 1111 1111 1111 1111 1011 1111 1111 1110 0111
;1111 1111 1111 1111 1111 1111 1111 1111 1110 0111
;1111 1111 1111 1111 1111 1111 1111 1111 1110 0011
;1111 1111 1111 1111 1111 1111 1111 1111 1110 0011
;1111 1111 1111 1111 1111 1111 1111 1111 1110 0111
;1111 1111 1111 1111 1111 1111 1111 1111 1110 0011
;1111 1111 1111 1111 1111 1111 1111 1111 1110 0111
;1111 0111 1000 0001 0111 1111 1111 1111 0110 0111
;1111 1111 1111 1111 1111 1111 1111 1111 1110 0111 ; platforms
;1111 1111 1111 1111 1111 1111 1111 1111 1110 0111 ; platforms
;1111 1111 1011 0011 1111 1111 1111 1111 1110 0111 ; platforms
;0000 0000 0000 0000 0000 0000 0000 0000 0000 0000 ; non-existant
;0000 0000 0000 0000 0000 0000 0000 0000 0000 0000 ; non-existant
;1000 0000 0000 0000 0000 0000 0000 0000 1110 0000 ; ending rooms
;1000 0000 0000 0000 0000 0000 0000 0000 1110 0000 ; ending rooms
;1000 0000 0000 0000 0000 0000 0000 0000 1110 0000 ; ending rooms
;1111 1111 1111 1111 1111 1011 1111 1111 1110 0111 ; starting rooms
;1111 1111 1111 1111 1111 1011 1111 1111 1110 0111 ; starting rooms
;1111 1111 1111 1111 1111 1011 1111 1111 1110 0111 ; starting rooms
;0000 0000 0000 0000 0000 0000 0000 0000 0000 0000 ; fake "end of level" room

w2_item_locations:
.byte $92
.byte $63
.byte $95
.byte $92
.byte $94
.byte $52
.byte $9A
.byte $83
.byte $92
.byte $94
.byte $76
.byte $84
.byte $66
.byte $97
.byte $82
.byte $74
.byte $54
.byte $52
.byte $75
.byte $83
.byte $42
.byte $56
.byte $85
.byte $86
.byte $82
.byte $46
.byte $92
.byte $75
.byte $92
.byte $65
.byte $82
.byte $76
.byte $00
.byte $00
.byte $00
.byte $00
.byte $00
.byte $00
.byte $00
.byte $00
.byte $97
.byte $98
.byte $99
.byte $48
.byte $5B
.byte $85