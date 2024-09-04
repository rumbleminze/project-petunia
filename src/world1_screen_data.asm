; Rooms are represented by 8 bytes of data
; The first 5 bytes are binary data that tell us if they connect to the room in that index 1 - 40
; The 6th byte represents the door location to use if a door is in that room
; the 7th and 8th bytes are the memory address of the room's data


; The next two bytes are the address of the room data
world_1_screen_data:
.byte $6E, $74, $1F, $C8, $01, $ae, $0b, $71; 
.byte $A1, $3B, $F0, $38, $02, $74, $3e, $71; 
.byte $B9, $7F, $B7, $EF, $01, $4b, $80, $71; 
.byte $AB, $7F, $D6, $A8, $00, $93, $a4, $71; 
.byte $2F, $FF, $DE, $AF, $00, $73, $ec, $71; 
.byte $AB, $7B, $F4, $BF, $02, $ab, $3a, $72; 
.byte $01, $02, $00, $08, $00, $75, $73, $72; 
.byte $FF, $FF, $FF, $FF, $02, $55, $a3, $72;
.byte $0F, $1E, $16, $0C, $04, $a9, $d3, $72; 
.byte $3F, $FF, $FF, $ED, $02, $71, $4b, $73; 
.byte $B9, $7F, $B7, $B4, $02, $74, $81, $73; 
.byte $A9, $7B, $F5, $CF, $01, $2e, $a5, $73;
.byte $BF, $FF, $D6, $AF, $06, $99, $cf, $73; 
.byte $B9, $7B, $F2, $1F, $02, $64, $f9, $73; 
.byte $B9, $7F, $B7, $B7, $02, $b1, $23, $74; 
.byte $60, $57, $96, $83, $00, $a7, $56, $74;
.byte $7F, $FF, $FF, $ED, $00, $4c, $7d, $74; 
.byte $33, $FF, $F6, $AF, $02, $2c, $f8, $74; 
.byte $11, $02, $32, $00, $02, $8e, $76, $75; 
.byte $2E, $74, $1F, $C7, $00, $51, $97, $75;
.byte $2A, $75, $9F, $A5, $00, $43, $c4, $75; 
.byte $B9, $76, $3F, $C6, $03, $55, $0c, $76; 
.byte $2F, $DF, $D6, $22, $00, $00, $39, $76; 
.byte $00, $00, $21, $10, $00, $9e, $b1, $76; 
.byte $00, $00, $20, $02, $00, $00, $17, $77;   - platforms
.byte $FF, $FF, $FF, $FD, $02, $46, $4d, $77; 
.byte $23, $9F, $D7, $45, $01, $41, $8c, $77; 
.byte $7F, $7F, $7F, $74, $00, $92, $db, $76;
.byte $BD, $BB, $E3, $08, $06, $00, $a4, $74;   - platforms
.byte $27, $DF, $DE, $27, $00, $00, $c5, $74;   - platforms
.byte $2F, $5F, $56, $87, $00, $00, $e0, $74;   - platforms
.byte $0E, $1C, $16, $60, $00, $00, $81, $76;   - platforms
.byte $00, $00, $00, $00, $00, $00, $00, $00;   - not used yet
.byte $00, $00, $00, $00, $00, $00, $00, $00;   - not used yet
.byte $00, $00, $00, $00, $00, $00, $00, $00;   - not used yet
.byte $00, $00, $00, $00, $00, $00, $00, $00;   - not used yet
.byte $00, $00, $00, $00, $00, $00, $00, $00;   - not used yet
.byte $00, $00, $00, $00, $00, $00, $00, $70;   - end rooms
.byte $00, $00, $00, $00, $00, $00, $39, $70;   - end rooms
.byte $00, $00, $00, $00, $00, $00, $78, $70;   - end rooms
.byte $B3, $7F, $F6, $28, $00, $00, $bd, $70;   - start rooms
.byte $2F, $5F, $D6, $A4, $00, $00, $09, $73;   - start rooms
.byte $63, $7E, $5E, $A4, $00, $00, $2e, $75;   - start rooms
.byte $00, $00, $00, $00, $00, $00, $ff, $ff;   - fake "end of level"

; item locations
w1_item_locations:
.byte $9A
.byte $9A
.byte $99
.byte $C5
.byte $3A
.byte $98
.byte $6A
.byte $98
.byte $9A
.byte $9A
.byte $98
.byte $96
.byte $9D
.byte $9B
.byte $A3
.byte $97
.byte $97
.byte $9B
.byte $84
.byte $AA
.byte $92
.byte $9B
.byte $A4
.byte $96
.byte $9A
.byte $95
.byte $AB
.byte $B9
.byte $AA
.byte $95
.byte $95
.byte $69
