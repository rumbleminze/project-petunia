; tilesets & attributes, the first 2 bytes are where in the VRAM to write it
; the 2nd two bytes are where the group definition lives
; the last two bytes are how many tiles are in the group


background_tilesets:
; 
; E7 21 E8 A2 12 
; C0 2B FA A2 40 
; 35 28 3A A3 04 
; 53 28 3E A3 08 
; 72 28 4B A3 0E 
; 80 28 59 A3 20
; A0 28 79 A3 20 
; C0 28 99 A3 05 
; E0 28 9E A3 04 
; 00 29 A2 A3 80 
; 80 29 22 A4 80 
; 0A 2A A2 A4 13 
; 2A 2A B5 A4 13 
; 58 2A C8 A4 05 
; 79 2A CD A4 03 
; 89 2A D0 A4 0C 
; B7 2A DC A4 03 
; C6 2A DF A4 16 
; E3 2A F5 A4 19
; 01 2B 0E A5 0B 
; 21 2B 19 A5 0B 
; 43 2B 24 A5 05

.byte $E7, $21, $E8, $A2, $12, $00
; .byte $C0, $2B, $FA, $A2, $40, $00  ;attributes
; these addresses have been adjusted from their original values
; since the 2800 - 2B00 VRAM on the NES
; corresponds to 2400-2800 on the SNES
.byte $35, $24, $3A, $A3, $04, $00
.byte $53, $24, $3E, $A3, $08, $00
.byte $72, $24, $4B, $A3, $0E, $00
.byte $80, $24, $59, $A3, $20, $00
.byte $A0, $24, $79, $A3, $20, $00
.byte $C0, $24, $99, $A3, $05, $00
.byte $E0, $24, $9E, $A3, $04, $00
.byte $00, $25, $A2, $A3, $80, $00
.byte $80, $25, $22, $A4, $80, $00
.byte $0A, $26, $A2, $A4, $13, $00
.byte $2A, $26, $B5, $A4, $13, $00
.byte $58, $26, $C8, $A4, $05, $00
.byte $79, $26, $CD, $A4, $03, $00
.byte $89, $26, $D0, $A4, $0C, $00
.byte $B7, $26, $DC, $A4, $03, $00
.byte $C6, $26, $DF, $A4, $16, $00
.byte $E3, $26, $F5, $A4, $19, $00
.byte $01, $27, $0E, $A5, $0B, $00
.byte $21, $27, $19, $A5, $0B, $00
.byte $43, $27, $24, $A5, $05, $00
background_tilesets_end:

; the tile sets point to this, which is just a series of tile indexes.

; for this to line up we want this to be at A2DA
.segment "TITLE_BG_LAYOUTS"

background_tile_group_defintions:
; PRESS START BUTTON
.byte $31, $5D, $C0, $64, $12, $C0, $C3, $A7, $B6, $C3, $12, $65, $5D, $C3, $C3, $B7
.byte $A6, $12 

; attribute data for title screen 2
attribute_data:
.byte $00, $00, $00, $00, $80, $AA, $A2, $A0 
.byte $AA, $22, $00, $00, $08, $0A, $0A, $0A
.byte $CE, $FF, $FC, $F0, $55, $55, $55, $00
.byte $CC, $FF, $FF, $FF, $FF, $FF, $FF, $03
.byte $00, $00, $0C, $0F, $0F, $0F, $FF, $33
.byte $80, $A0, $20, $00, $00, $88, $A2, $00
.byte $8A, $AA, $0A, $00, $00, $00, $00, $00
.byte $00, $00, $00, $00, $00, $00, $00, $00 

; bg2 definitions start
.byte $1A, $1B, $1B, $1C

.byte $1A, $1B, $0F, $0F, $1E, $0F, $1C, $1C

; these get skipped
.byte $12, $12, $12, $12, $12

.byte $1A, $0F, $1D, $1E, $0F, $0F, $0F, $0F, $1E, $1C, $1B, $1C, $1A, $1B, $1A

.byte $1B, $1C, $12, $12, $12, $12, $12, $12, $12, $12, $12, $12, $12, $12, $12
.byte $12, $12, $17, $18, $18, $18, $1D, $1E, $1E, $1E, $19, $17

.byte $18, $18, $1D, $1E, $1E, $0F, $0F, $1C, $1C, $12, $12, $12, $12, $12, $12, $12
.byte $12, $12, $12, $12, $12, $12, $12, $12, $12, $12, $17, $18, $18, $19, $12, $12

.byte $12, $12, $17, $18, $0F

.byte $1D, $1E, $1E, $19

.byte $1E, $0F, $18, $19, $18, $19, $12, $12, $12, $12, $12, $12, $12, $12, $12, $12
.byte $12, $12, $12, $12, $1F, $A7, $A6, $B5, $9F, $7B, $12, $7B, $A7, $A6, $BF, $1F
.byte $12, $12, $12, $12, $12, $12, $12, $30, $0F, $32, $33, $34, $12, $12, $3D, $5E
.byte $12, $12, $12, $12, $1F, $1F, $12, $C0, $C3, $B7, $B6, $AF, $12, $12, $1F, $1F
.byte $12, $12, $12, $12, $12, $12, $12, $35, $36, $37, $38, $39, $12, $12, $5F, $60
.byte $61, $62, $63, $12, $12, $1F, $1F, $1F, $1F, $1F, $1F, $1F, $1F, $1F, $1F, $12
.byte $12, $12, $12, $12, $12, $12, $12, $3A, $3B, $3C, $12, $3D, $3E, $3F, $66, $67
.byte $68, $69, $6A, $12, $12, $12, $12, $12, $12, $12, $12, $12, $12, $12, $12, $12

.byte $0C, $0D, $12, $12, $12, $12, $12, $40, $41, $42, $12, $43, $44, $45, $6D, $12
.byte $6E, $6F, $D0, $D1, $96, $8E, $99, $9A, $9B, $9C, $9D, $9E, $3D, $A0, $CA, $CB
.byte $CC, $12, $12, $12, $12, $12, $46, $47, $48, $49, $4A, $4B, $4C, $4D, $73, $12
.byte $74, $75, $87, $86, $85, $79, $A1, $A2, $A3, $A4, $A5, $70, $5F, $A8, $CD, $CE
.byte $CF, $12, $12, $12, $12, $12, $4E, $4F, $50, $51, $52, $53, $54, $55, $7A, $12
.byte $7C, $80, $7F, $AC, $12, $81, $A9, $AA, $AB, $AC, $AD, $AE, $AD, $B0, $27, $12
.byte $12, $12, $12, $12, $12, $12, $56, $57, $12, $58, $59, $5A, $5B, $5C, $82, $12
.byte $83, $7E, $78, $77, $76, $88, $B1, $B2, $B3, $B4, $6D, $B4, $6D, $B8, $28, $29

.byte $12, $12, $12, $12, $89, $8A, $8B, $8C, $8D, $0F, $8F, $90, $B9, $BA, $BB, $BC
.byte $BD, $BE, $BB, $12, $2A, $2B, $2C, $91, $92, $93, $94, $95, $93, $97, $98, $C1
.byte $C2, $0E, $12, $C4, $C5, $C6, $C7, $12, $2D, $2E, $C8, $C9, $2F, $13, $14, $15
.byte $16, $0E, $0A, $01, $09, $08, $06, $20, $21, $22, $23, $24, $25, $26, $1A, $1B
.byte $1C, $1A, $1C, $1A, $1C, $12, $12, $12, $12, $12, $12, $12, $12, $12, $12, $12
.byte $12, $1A, $1D, $1D, $1E, $1B, $1C, $1A, $1B, $1A, $0F, $0F, $1E, $19, $12, $12
.byte $12, $12, $12, $12, $12, $12, $12, $12, $12, $12, $17, $18, $18, $19, $17, $19
.byte $1A, $1B, $0F, $0F, $1D, $1E, $0F, $0F, $1C, $1B, $1C, $17, $18, $1E, $1D, $1E

.byte $0F, $1E, $19, $17, $18, $19, $17, $18, $19, $17, $19
background_tile_group_defintions_end:

; palatte info is from 2BC5 in PPU and 6312 in ROM
background_tile_palatte_info:
.byte $AA, $22, $00, $00, $08, $0A, $0A, $0A
.byte $CE, $FF, $FC, $F0, $55, $55, $55, $00
.byte $CC, $FF, $FF, $FF, $FF, $FF, $FF, $03
.byte $00, $00, $0C, $0F, $0F, $0F, $FF, $33
.byte $80, $A0, $20, $00, $00, $88, $A2, $00
.byte $8A, $AA, $0A, $00, $00, $00, $00, $00
.byte $00, $00, $00, $00, $00, $00, $00, $00
background_tile_palatte_info_end:

; 0x673B in ROM
nes_bg_palattes:
.byte $0F, $20, $10, $00, $0F, $24, $2A, $0A, $0F, $31, $1C, $0C, $0F, $27, $06, $31

; 0x674B in ROM
; Start / Continue
.byte $0F, $20, $22, $02, $0F, $27, $17, $07, $0F, $2C, $11, $0A, $0F, $02, $27, $15

; 0x675B in ROM
nes_sprite_palattes:
.byte $0F, $20, $26, $07, $0F, $31, $02, $15, $0F, $12, $24, $31, $0F, $05, $16, $38