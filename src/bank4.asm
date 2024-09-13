.segment "PRGA5"; Bank 4


; 8000 - bank 4
.byte $4C, $5A, $80, $4C, $0E, $88, $4C, $91, $94, $4C, $40, $DF, $4C, $91, $94, $4C
.byte $91, $94, $4C, $91, $94, $4C, $91, $94, $4C, $91, $94, $4C, $91, $94, $4C, $91
.byte $94, $4C, $91, $94, $4C, $91, $94, $4C, $91, $94, $4C, $91, $94, $4C, $91, $94
.byte $4C, $91, $94, $4C, $91, $94, $4C, $91, $94, $4C, $91, $94, $4C, $91, $94, $4C
.byte $91, $94, $67, $C5, $E7, $C5, $91, $94, $91, $94, $91, $94, $91, $94, $91, $94
.byte $91, $94, $91, $94, $91, $94, $91, $94, $91, $94, $20, $07, $EB, $20, $F0, $EE
.byte $20, $83, $EF, $A9, $00, $8D, $4C, $07, $8D, $4D, $07, $85, $FE, $85, $FD, $85
.byte $83, $85, $82, $A9, $01, $85, $1A, $20, $89, $81, $86, $4B, $20, $8A, $86, $A9
.byte $01, $20, $CA, $87, $A9, $00, $20, $E6, $87, $A9, $00, $85, $14, $85, $15, $A9
.byte $01, $85, $81, $A9, $67, $85, $37, $A9, $88, $85, $38, $A9, $00, $85, $3A, $8D
.byte $34, $07, $8D, $3A, $07, $8D, $40, $07, $8D, $46, $07, $A9, $77, $85, $3D, $A9
.byte $E8, $85, $3E, $A9, $FF, $85, $3F, $20, $F9, $E3

: LDA RDNMI ; LDA $2002
  BPL :- 

.byte $20
.byte $87, $EF, $20, $01, $EF, $A5, $81, $C9, $07, $D0, $FA, $20, $F0, $EE, $20, $83
.byte $EF, $20, $E0, $82, $20, $87, $EF, $20, $01, $EF, $A5, $81, $C9, $08, $D0, $FA
.byte $20, $F0, $EE, $20, $83, $EF, $A9, $8A, $85, $30, $A9, $23, $85, $31, $20, $77
.byte $EF, $20, $F9, $E3, $20, $6B, $86, $A9, $00, $85, $FE, $85, $1A, $85, $83, $85


; 8100 - bank 4
.byte $82, $20, $0C, $87, $20, $D0, $86, $A9, $01, $20, $0C, $87, $20, $D0, $86, $A9
.byte $CF, $85, $FD, $A9, $04, $20, $CA, $87, $20, $87, $EF, $20, $01, $EF, $A5, $81
.byte $C9, $09, $D0, $FA, $A5, $F6, $29, $10, $F0, $FA, $20, $F0, $EE, $A9, $00, $AA
.byte $9D, $00, $02, $9D, $00, $03, $9D, $00, $04, $9D, $00, $05, $9D, $00, $06, $9D
.byte $00, $07, $E8, $D0, $EB, $A5, $AA, $48, $A5, $A6, $48, $A9, $F0, $20, $3D, $C2
.byte $68, $85, $A6, $68, $85, $AA, $A9, $02, $85, $A0, $A9, $03, $8D, $FA, $6F, $A9
.byte $7F, $8D, $FB, $6F, $20, $07, $EB, $A9, $00, $8D, $53, $01, $8D, $54, $01, $8D
.byte $55, $01, $8D, $4E, $01, $8D, $51, $01, $8D, $4F, $01, $8D, $50, $01, $A9, $01
.byte $8D, $2A, $60, $20, $89, $EA, $4C, $6D, $C0, $A2, $00, $20, $98, $81, $20, $A7
.byte $81, $20, $AF, $81, $20, $B8, $81, $60, $AD, $4A, $01, $38, $E9, $E7, $AD, $4B
.byte $01, $E9, $03, $90, $01, $E8, $60, $A5, $AA, $C9, $04, $90, $01, $E8, $60, $AD
.byte $52, $01, $C9, $04, $90, $01, $E8, $60, $A9, $02, $2D, $3E, $01, $F0, $0B, $2D
.byte $3F, $01, $F0, $06, $2D, $40, $01, $F0, $01, $E8, $60, $A5, $86, $D0, $03, $4C
.byte $42, $EE, $4C, $BD, $86, $A5, $81, $0A, $AA, $BD, $E6, $81, $85, $00, $BD, $E7
.byte $81, $85, $01, $6C, $00, $00, $FA, $81, $56, $83, $A5, $83, $BB, $83, $49, $84
.byte $68, $84, $C2, $84, $FF, $82, $2E, $83, $55, $83, $60

; 81FB
nops 3 ;  LDA $2002

.byte $A2, $00

; 8200 - bank 4
.byte $20, $1C, $82, $E8, $20, $1C, $82, $E8, $20, $1C, $82, $E8, $20, $1C, $82, $E8
.byte $20, $1C, $82, $E8, $20, $1C, $82, $E8, $20, $1C, $82, $60

; 821c - ending message
  TXA
  ASL
  TAY
  LDA $8244,Y
  STA $00
  LDA $8245,Y
  STA $01
  LDY #$00
  LDA ($00),Y
  STA VMADDH
  INY
  LDA ($00),Y
  STA VMADDL
  INY
  LDA ($00),Y
  CMP #$FF
  BEQ :+
  STA VMDATAL
  JMP $8236
: RTS

.byte $52, $82, $69, $82, $82, $82, $9C, $82, $AE, $82, $BF, $82
.byte $D0, $82, $21, $04, $22, $1A, $19, $2A, $28, $16, $12, $2C, $16, $28, $12, $19
.byte $1A, $28, $29, $27, $24, $2E, $1A, $19, $FF, $21, $44, $16, $23, $19, $12, $29
.byte $1D, $1A, $12, $21, $1E, $1C, $1D, $29, $12, $24, $1B, $12, $25, $1A, $16, $18
.byte $1A, $FF, $21, $84, $27, $1A, $29, $2A, $27, $23, $1A, $19, $12, $29, $24, $12
.byte $16, $23, $1C, $1A, $21, $12, $21, $16, $23, $19, $0D, $FF, $21, $C4, $17, $2A
.byte $29, $12, $1E, $23, $12, $24, $27, $19, $1A, $27, $12, $29, $24, $FF, $22, $04
.byte $22, $16, $1E, $23, $29, $16, $1E, $23, $12, $25, $1A, $16, $18, $1A, $FF, $22
.byte $44, $25, $1E, $29, $10, $28, $12, $28, $29, $27, $2A, $1C, $1C, $21, $1A, $FF
.byte $22, $84, $18, $24, $23, $29, $1E, $23, $2A, $1A, $28, $0D, $0D, $0D, $0D, $FF
.byte $A9, $00, $85, $14, $85, $15, $A2, $00, $A9, $F8, $9D, $00, $02, $E8, $D0, $F8
.byte $20, $73, $EF, $20, $FB, $81, $20, $C9, $EB, $A9, $0F, $8D, $91, $03, $60, $A5


; 8300 - bank 4
.byte $15, $F0, $09, $C9, $01, $F0, $17, $C9, $02, $B0, $1A, $60, $A5, $14, $4A, $4A
.byte $4A, $4A, $C9, $04, $B0, $07, $A8, $B9, $2A, $83, $8D, $91, $03, $60, $A5, $14
.byte $49, $FF, $4C, $0E, $83, $A9, $08, $85, $81, $60, $0F, $00, $10, $20

  LDA $14
  AND #$01
  BNE :+++
  INC $FD
  LDA $FD
  CMP #$F0
  BCC :+
;   INC $1A
;   LDA #$00
;   STA $FD
  jslb credits_scroll_rollover, $a0
  nops 2
: AND #$07
  BNE :++
  LDA $83
  CMP #$F2
  BCS :+
  JMP $871C
: LDA #$09
  STA $81
: RTS

.byte $60, $60, $20, $4B, $85, $A5, $3D, $85, $8D, $A5, $3E, $18
.byte $69, $01, $85, $3E, $85, $8E, $A5, $3F, $69, $00, $85, $3F, $85, $8B, $A5, $3E
.byte $C9, $68, $90, $1C, $A5, $8B, $D0, $18, $A9, $68, $85, $8E, $85, $3E, $A9, $03
.byte $A6, $14, $E0, $C0, $90, $1A, $20, $6B, $86, $E6, $81, $A9, $03, $4C, $A0, $83
.byte $A5, $14, $29, $03, $D0, $0C, $E6, $40, $A5, $40, $C9, $03, $90, $04, $A9, $00
.byte $85, $40, $4C, $2F, $85, $A5, $14, $F0, $0C, $C9, $40, $F0, $03, $4C, $14, $85
.byte $E6, $81, $20, $6B, $86, $20, $5F, $86, $4C, $0F, $85, $A5, $15, $D0, $1F, $A5
.byte $14, $F0, $07, $C9, $80, $B0, $08, $4C, $14, $85, $A9, $80, $85, $14, $60, $A2
.byte $04, $A5, $14, $29, $20, $F0, $02, $A2, $03, $86, $40, $4C, $14, $85, $C9, $02
.byte $90, $03, $4C, $2C, $84, $A2, $01, $A5, $14, $C9, $C0, $90, $02, $A2, $00, $86
.byte $3A, $A2, $03, $A5, $14, $C9, $80, $90, $0D, $C9, $C0, $B0, $04, $29, $04, $F0


; 8400 - bank 4
.byte $05, $A4, $4B, $BE, $DE, $91, $86, $40, $A5, $14, $C9, $C0, $B0, $11, $29, $01
.byte $D0, $0D, $A9, $05, $20, $CA, $87, $A9, $01, $20, $E6, $87, $4C, $14, $85, $A9
.byte $01, $20, $CA, $87, $A9, $00, $20, $E6, $87, $4C, $14, $85, $A5, $15, $C9, $03
.byte $B0, $25, $A5, $14, $C9, $C0, $90, $2D, $A2, $04, $A5, $4B, $C9, $03, $90, $17
.byte $F0, $02, $A2, $05, $86, $81, $4C, $6B, $86, $A9, $09, $85, $40, $A5, $15, $D0
.byte $06, $A5, $14, $C9, $C0, $90, $0E, $AD, $4D, $07, $C9, $06, $90, $07, $A9, $07
.byte $85, $81, $20, $6B, $86, $4C, $14, $85, $A5, $15, $D0, $26, $A5, $14, $C9, $40
.byte $B0, $03, $4C, $14, $85, $A0, $0A, $A2, $02, $A9, $70, $C5, $38, $B0, $0C, $A0
.byte $08, $A2, $03, $A5, $14, $29, $03, $D0, $02, $C6, $38, $86, $3A, $84, $40, $4C
.byte $14, $85, $A5, $14, $C9, $04, $B0, $03, $4C, $14, $85, $D0, $06, $20, $72, $86
.byte $4C, $0F, $85, $A9, $09, $85, $40, $A9, $78, $85, $38, $A9, $03, $85, $3A, $A9
.byte $06, $85, $81, $A2, $18, $A9, $00, $9D, $34, $07, $95, $4C, $CA, $D0, $F8, $4C
.byte $6B, $86, $A5, $15, $D0, $35, $A2, $00, $A5, $14, $C9, $40, $B0, $2D, $29, $3F
.byte $F0, $0F, $E8, $C9, $10, $F0, $0A, $E8, $C9, $20, $F0, $05, $E8, $C9, $30, $D0
.byte $1A, $8A, $48, $E8, $8A, $20, $CA, $87, $68, $85, $00, $F0, $09, $A9, $00, $18
.byte $69, $06, $C6, $00, $D0, $F9, $AA, $A9, $01, $95, $4C, $20, $AF, $85, $20, $EF


; 8500 - bank 4
.byte $85, $AD, $4D, $07, $C9, $06, $90, $04, $A9, $07, $85, $81, $4C, $14, $85, $A9
.byte $00, $20, $EE, $86, $20, $4B, $85, $A5, $81, $C9, $06, $90, $06, $20, $26, $86
.byte $20, $77, $85, $A5, $3D, $85, $8D, $A5, $3E, $85, $8E, $A9, $00, $85, $8B, $A5
.byte $40, $0A, $AA, $BD, $EF, $91, $85, $89, $BD, $F0, $91, $85, $8A, $A6, $40, $BD
.byte $E4, $91, $85, $8C, $A9, $00, $85, $8F, $4C, $6E, $87, $A5, $37, $85, $8D, $A5
.byte $38, $85, $8E, $A5, $3A, $0A, $AA, $BD, $61, $93, $85, $89, $BD, $62, $93, $85
.byte $8A, $A2, $0E, $A5, $3A, $C9, $03, $D0, $01, $CA, $86, $8C, $A9, $00, $85, $8B
.byte $A9, $03, $85, $8F, $4C, $63, $87, $A2, $00, $20, $88, $85, $A2, $06, $20, $88
.byte $85, $A2, $0C, $20, $88, $85, $A2, $12, $BD, $34, $07, $D0, $01, $60, $BD, $36
.byte $07, $85, $8D, $BD, $37, $07, $85, $8E, $A9, $8D, $85, $89, $A9, $94, $85, $8A
.byte $A9, $01, $85, $8C, $A9, $00, $85, $8B, $A9, $01, $85, $8F, $4C, $6E, $87, $A2
.byte $00, $20, $C0, $85, $A2, $06, $20, $C0, $85, $A2, $0C, $20, $C0, $85, $A2, $12
.byte $B5, $4C, $F0, $2A, $B4, $4D, $B9, $19, $89, $95, $4E, $B9, $41, $88, $95, $4F
.byte $A5, $14, $29, $03, $D0, $06, $B5, $51, $49, $01, $95, $51, $A5, $14, $29, $01
.byte $D0, $0C, $F6, $4D, $B5, $4D, $C9, $D8, $D0, $04, $A9, $18, $95, $4D, $60, $A2
.byte $00, $20, $00, $86, $A2, $06, $20, $00, $86, $A2, $0C, $20, $00, $86, $A2, $12


; 8600 - bank 4
.byte $A5, $15, $D0, $06, $A5, $14, $C9, $40, $90, $1B, $A5, $14, $29, $3F, $D0, $12
.byte $B5, $4E, $18, $69, $10, $9D, $36, $07, $B5, $4F, $9D, $37, $07, $A9, $01, $9D
.byte $34, $07, $FE, $36, $07, $60, $A2, $00, $20, $37, $86, $A2, $06, $20, $37, $86
.byte $A2, $0C, $20, $37, $86, $A2, $12, $B5, $4C, $D0, $01, $60, $B5, $4E, $85, $8D
.byte $B5, $4F, $85, $8E, $B5, $51, $0A, $A8, $B9, $45, $94, $85, $89, $B9, $46, $94
.byte $85, $8A, $A9, $04, $85, $8C, $A9, $00, $85, $8B, $85, $8F, $4C, $6E, $87, $A9
.byte $14, $85, $00, $A9, $8E, $85, $01, $20, $7D, $86, $60, $A9, $FF, $85, $14, $85
.byte $15, $60, $A9, $12, $A2, $1F, $9D, $0C, $07, $CA, $10, $FA, $60, $A0, $00, $B1
.byte $00, $99, $0C, $07, $C8, $C0, $20, $D0, $F6, $60 

; 868a
  nops 3 ; LDA $2002
  LDA #$20
  STA VMADDH
  LDA #$00
  STA VMADDL
  TAX
: LDA $89F1,X
  STA VMDATAL
  INX
  BNE :-
: LDA $8AF1,X
  STA VMDATAL
  INX
  BNE :-
: LDA $8BF1,X
  STA VMDATAL
  INX
  BNE :-

  jsr do_last_100_bytes_of_ending_graphics
  nops 6
;   LDA $8CF1,X
;   STA VMDATAL
;   INX
;   BNE $A586B3

  RTS

.byte $20, $D0, $86
.byte $A5, $81, $C9, $07, $90, $01, $60, $A2, $04, $B5, $46, $95, $41, $CA, $10, $F9

; 86d0
  NOP ; LDA $2002
  NOP
  NOP
  LDA $42
  STA VMADDH
  LDA $41
  STA VMADDL
  LDY #$00
: LDA ($43),Y
  STA VMDATAL
  INY
  CPY $45
  BNE :-
  LDA #$00
  STA $86
  RTS

.byte $0A, $85
.byte $00, $0A, $0A, $18, $65, $00, $AA, $A9, $0A, $85, $01, $A0, $00, $BD, $F1, $8D


; 8700 - bank 4
.byte $99, $41, $00, $E8, $C8, $C6, $01, $D0, $F4, $E6, $86, $60, $85, $00, $0A, $0A
.byte $18, $65, $00, $18, $69, $0A, $AA, $A9, $05, $4C, $F9, $86, $A6, $83, $BD, $34
.byte $8E, $0A, $AA, $BD, $26, $8F, $85, $43, $BD, $27, $8F, $85, $44, $A9, $0C, $85
.byte $45, $A5, $30, $85, $41, $A5, $31, $85, $42, $A5, $30, $18, $69, $20, $85, $30
.byte $A5, $31, $69, $00, $85, $31, $29, $03, $C9, $03, $D0, $12, $A5, $30, $C9, $C0
.byte $90, $0C

  LDA #$0A
  STA $30
  LDA $31
  AND #$24 ; #$28
  EOR #$04 ; #$04
  STA $31

.byte $E6, $86
.byte $E6, $83, $60, $20, $F9, $E3, $A9, $00, $85, $87, $A9, $02, $85, $88, $A0, $00
.byte $B1, $89, $18, $65, $8D, $91, $87, $C8, $B1, $89, $91, $87, $C8, $B1, $89, $05
.byte $8F, $91, $87, $C8, $B1, $89, $30, $0B, $18, $65, $8E, $AA, $A5, $8B, $69, $00
.byte $4C, $9B, $87, $18, $65, $8E, $AA, $A5, $8B, $69, $FF, $D0, $0F, $8A, $91, $87
.byte $C8, $C6, $8C, $D0, $CB, $98, $18, $65, $87, $85, $87, $60, $88, $88, $88, $A9
.byte $F0, $91, $87, $C8, $C8, $C8, $4C, $A0, $87, $A2, $00, $86, $21, $0A, $26, $21
.byte $0A, $26, $21, $0A, $26, $21, $0A, $26, $21, $60, $20, $B9, $87, $18, $69, $5E
.byte $85, $20, $A9, $91, $65, $21, $85, $21, $A0, $00, $A2, $10, $B1, $20, $99, $90
.byte $03, $C8, $CA, $D0, $F7, $60, $20, $B9, $87, $18, $69, $BE, $85, $20, $A9, $91
.byte $65, $21, $85, $21, $A0, $00, $A2, $10, $B1, $20, $99, $A0, $03, $C8, $CA, $D0


; 8800 - bank 4
.byte $F7, $60, $01, $00, $00, $02, $00, $00, $03, $00, $00, $04, $00, $00, $8A, $48
.byte $98, $48

 nops 3 ; LDA $2002
  JSR $EB2E
  LDA #$00
  STA TM ; PPU Mask $2001
  JSR $81CB
  jslb reset_tm_state, $a0
  nops 1
;   LDA $FF
;   STA $2001

.byte $20, $C9, $EB, $20, $6A, $EE, $20, $56, $C8, $20, $94
.byte $EE, $EE, $4C, $07, $D0, $03, $EE, $4D, $07, $20, $D5, $81, $68, $A8, $68, $AA
.byte $60, $80, $7E, $7C, $7A, $78, $76, $74, $72, $70, $6E, $6C, $6A, $68, $66, $64
.byte $62, $60, $5E, $5C, $5A, $58, $56, $54, $52, $50, $4E, $4C, $4A, $48, $46, $44
.byte $44, $40, $3E, $3C, $3A, $38, $36, $34, $32, $30, $2F, $2E, $2D, $2C, $2B, $2A
.byte $29, $28, $29, $2A, $2B, $2C, $2D, $2E, $2F, $30, $32, $34, $36, $38, $3A, $3C
.byte $3E, $40, $42, $44, $46, $48, $4A, $4C, $4E, $50, $52, $54, $56, $58, $5A, $5C
.byte $5E, $60, $62, $64, $66, $68, $6A, $6C, $6E, $70, $72, $74, $76, $78, $7A, $7C
.byte $7E, $80, $82, $84, $86, $88, $8A, $8C, $8E, $90, $92, $94, $96, $98, $9A, $9C
.byte $9E, $A0, $A2, $A4, $A6, $A8, $AA, $AC, $AE, $B0, $B2, $B4, $B6, $B8, $BA, $BC
.byte $BE, $C0, $C2, $C4, $C6, $C8, $CA, $CC, $CE, $D0, $D1, $D2, $D3, $D4, $D5, $D6
.byte $D7, $D8, $D7, $D6, $D5, $D4, $D3, $D2, $D1, $D0, $CE, $CC, $CA, $C8, $C6, $C4
.byte $C2, $C0, $BE, $BC, $BA, $B8, $B6, $B4, $B2, $B0, $AE, $AC, $AA, $A8, $A6, $A4
.byte $A2, $A0, $9E, $9C, $9A, $98, $96, $94, $92, $90, $8E, $8C, $8A, $88, $86, $84


; 8900 - bank 4
.byte $82, $80, $7E, $7C, $7A, $78, $76, $74, $72, $70, $6E, $6C, $6A, $68, $66, $64
.byte $62, $60, $5E, $5C, $5A, $58, $56, $54, $52, $00, $01, $03, $04, $06, $07, $09
.byte $0A, $0C, $0D, $0F, $10, $12, $13, $15, $16, $17, $18, $19, $1A, $1B, $1C, $1E
.byte $1F, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20
.byte $20, $20, $22, $24, $26, $28, $2A, $2C, $2E, $30, $32, $34, $36, $38, $3A, $3C
.byte $3E, $40, $40, $40, $40, $40, $40, $40, $40, $40, $40, $40, $40, $40, $40, $40
.byte $40, $40, $3F, $3E, $3D, $3C, $3B, $3A, $39, $38, $38, $37, $37, $36, $36, $35
.byte $35, $34, $34, $33, $33, $32, $32, $31, $31, $30, $30, $2F, $2F, $2E, $2E, $2D
.byte $2D, $2C, $2C, $2B, $2B, $2A, $2A, $29, $29, $28, $27, $26, $25, $24, $23, $22
.byte $21, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20
.byte $20, $20, $22, $24, $26, $28, $2A, $2C, $2E, $30, $32, $34, $36, $38, $3A, $3C
.byte $3E, $40, $40, $40, $40, $40, $40, $40, $40, $40, $40, $40, $40, $40, $40, $40
.byte $40, $40, $40, $3F, $3F, $3E, $3E, $3D, $3D, $3C, $3C, $3B, $3B, $3A, $3A, $39
.byte $39, $38, $37, $36, $35, $34, $33, $32, $31, $30, $2F, $2E, $2D, $2C, $2B, $2A
.byte $29, $28, $28, $27, $27, $26, $26, $25, $25, $24, $24, $23, $23, $22, $22, $21
.byte $21, $C0, $C1, $C1, $C1, $12, $4F, $4E, $4F, $4E, $4F, $4E, $4F, $4E, $4F, $4E


; 8A00 - bank 4
.byte $4F, $4E, $4F, $4E, $4F, $4E, $4F, $4E, $4F, $4E, $4F, $4E, $12, $CD, $CD, $CD
.byte $CD, $C0, $C1, $C1, $C1, $12, $4E, $4F, $4E, $4F, $4E, $4F, $4E, $4F, $4E, $4F
.byte $4E, $4F, $4E, $4F, $4E, $4F, $4E, $4F, $4E, $4F, $4E, $4F, $12, $CD, $CD, $CD
.byte $CD, $C0, $C1, $C1, $C1, $4E, $4F, $4E, $4F, $4E, $4F, $4E, $4F, $4E, $4F, $4E
.byte $4F, $4E, $4F, $4E, $4F, $4E, $4F, $4E, $4F, $4E, $4F, $4E, $4F, $CD, $CD, $CD
.byte $CD, $C0, $C1, $C1, $C1, $4F, $4E, $4F, $4E, $4F, $4E, $4F, $4E, $4F, $4E, $4F
.byte $4E, $4F, $4E, $4F, $4E, $4F, $4E, $4F, $4E, $4F, $4E, $4F, $4F, $CD, $CD, $CD
.byte $CD, $C0, $C1, $C1, $C1, $8B, $8C, $12, $12, $12, $12, $12, $12, $12, $12, $12
.byte $12, $12, $12, $12, $12, $12, $12, $12, $12, $12, $12, $8B, $8C, $CD, $CD, $CD
.byte $CD, $C0, $C1, $C1, $C1, $8D, $8E, $12, $12, $12, $12, $12, $12, $12, $12, $12
.byte $12, $12, $12, $12, $12, $12, $12, $12, $12, $12, $12, $8D, $8E, $CD, $CD, $CD
.byte $CD, $C0, $C1, $C1, $C1, $8F, $90, $12, $E0, $12, $12, $12, $12, $12, $12, $12
.byte $12, $12, $12, $12, $12, $12, $12, $12, $12, $E0, $12, $8F, $90, $CD, $CD, $CD
.byte $CD, $C0, $C1, $C1, $C5, $6D, $6E, $12, $E1, $12, $12, $12, $12, $12, $12, $12
.byte $12, $12, $12, $12, $12, $12, $12, $12, $12, $E1, $12, $6D, $6E, $CE, $CD, $CD
.byte $CD, $C0, $C1, $C1, $12, $91, $92, $12, $E1, $12, $E0, $12, $12, $12, $12, $12


; 8B00 - bank 4
.byte $12, $12, $12, $12, $12, $12, $12, $E0, $12, $E1, $12, $91, $92, $12, $CD, $CD
.byte $CD, $C0, $C1, $C5, $12, $91, $92, $12, $E2, $12, $E1, $12, $12, $12, $12, $12
.byte $12, $12, $12, $12, $12, $12, $12, $E1, $12, $E2, $12, $91, $92, $12, $CE, $CD
.byte $CD, $C0, $C5, $12, $12, $91, $92, $12, $E2, $12, $E1, $E4, $12, $12, $12, $12
.byte $12, $12, $12, $12, $12, $12, $E4, $E1, $12, $E2, $12, $91, $92, $12, $12, $CE
.byte $CD, $C6, $C7, $12, $12, $91, $92, $12, $E2, $12, $E2, $E5, $E4, $12, $12, $12
.byte $12, $12, $12, $12, $12, $E4, $E5, $E2, $12, $E2, $12, $91, $92, $12, $12, $C8
.byte $C9, $C2, $C3, $12, $12, $91, $92, $12, $E2, $12, $E2, $E5, $E5, $12, $12, $12
.byte $12, $12, $12, $12, $12, $E5, $E5, $E2, $12, $E2, $12, $91, $92, $12, $12, $CA
.byte $CB, $C0, $C4, $12, $12, $91, $92, $12, $E2, $12, $E2, $E5, $E5, $12, $12, $12
.byte $12, $12, $12, $12, $12, $E5, $E5, $E2, $12, $E2, $12, $91, $92, $12, $12, $CC
.byte $C0, $C0, $C1, $12, $12, $91, $92, $12, $E2, $12, $E2, $E5, $E5, $12, $12, $12
.byte $12, $12, $12, $12, $12, $E5, $E5, $E2, $12, $E2, $12, $91, $92, $12, $12, $CD
.byte $C0, $C0, $C1, $12, $12, $91, $92, $12, $E2, $12, $E2, $E5, $E5, $12, $12, $12
.byte $12, $12, $12, $12, $12, $E5, $E5, $E2, $12, $E2, $12, $91, $92, $12, $12, $CD
.byte $C0, $C0, $C1, $12, $12, $8F, $90, $12, $E3, $12, $E3, $E5, $E5, $12, $12, $12


; 8C00 - bank 4
.byte $12, $12, $12, $12, $12, $E5, $E5, $E3, $12, $E3, $12, $8F, $90, $12, $12, $CD
.byte $C0, $C0, $C1, $12, $12, $6D, $6E, $12, $E3, $12, $E3, $E6, $E6, $12, $12, $12
.byte $12, $12, $12, $12, $12, $E6, $E6, $E3, $12, $E3, $12, $6D, $6E, $12, $12, $CD
.byte $C0, $4E, $4F, $79, $79, $79, $79, $79, $79, $79, $79, $60, $61, $60, $61, $60
.byte $61, $60, $61, $60, $61, $60, $61, $79, $79, $79, $79, $79, $79, $79, $79, $4E
.byte $4F, $4F, $4E, $4F, $12, $12, $12, $12, $12, $12, $12, $4F, $4E, $4F, $4E, $4F
.byte $4E, $4F, $4E, $4F, $4E, $4F, $4E, $12, $12, $12, $12, $12, $12, $12, $12, $4F
.byte $4E, $4E, $4F, $4E, $4F, $12, $6F, $6F, $6F, $75, $76, $4E, $4F, $12, $12, $12
.byte $12, $12, $12, $12, $12, $4E, $4F, $75, $76, $6F, $6F, $6F, $6F, $6F, $6F, $4E
.byte $4F, $4F, $4E, $4F, $4E, $12, $6F, $6F, $6F, $77, $78, $4F, $4E, $12, $12, $12
.byte $12, $12, $12, $12, $12, $4F, $4E, $77, $78, $6F, $6F, $6F, $6F, $6F, $6F, $4F
.byte $4E, $4E, $4F, $4E, $4F, $12, $6F, $6F, $6F, $60, $61, $60, $61, $12, $12, $12
.byte $12, $12, $12, $12, $12, $60, $61, $60, $61, $12, $6F, $6F, $6F, $6F, $6F, $4E
.byte $4F, $4F, $4E, $12, $6F, $6F, $6F, $6F, $6F, $4E, $4F, $4F, $4E, $12, $12, $12
.byte $12, $12, $12, $12, $12, $4F, $4E, $4F, $4E, $12, $6F, $6F, $6F, $6F, $6F, $4F
.byte $4E, $4E, $4F, $12, $6F, $6F, $6F, $75, $76, $4F, $4E, $12, $12, $12, $12, $12


; 8D00 - bank 4
.byte $12, $12, $12, $12, $12, $12, $12, $4E, $4F, $75, $76, $6F, $6F, $6F, $6F, $4E
.byte $4F, $4F, $4E, $12, $6F, $6F, $6F, $77, $78, $4E, $4F, $12, $12, $12, $12, $12
.byte $12, $12, $12, $12, $12, $12, $12, $4F, $4E, $77, $78, $6F, $6F, $6F, $6F, $4F
.byte $4E, $4E, $4F, $12, $6F, $6F, $6F, $60, $61, $60, $61, $12, $12, $12, $12, $12
.byte $12, $12, $12, $12, $12, $12, $12, $60, $61, $60, $61, $12, $6F, $6F, $6F, $4E
.byte $4F, $4F, $4E, $12, $6F, $6F, $6F, $4E, $4F, $4E, $4F, $12, $12, $12, $12, $12
.byte $12, $12, $12, $12, $12, $12, $12, $4F, $4E, $4F, $4E, $12, $6F, $6F, $6F, $4F
.byte $4E, $4E, $4F, $12, $6F, $6F, $6F, $4F, $4E, $12, $12, $12, $12, $12, $12, $12
.byte $12, $12, $12, $12, $12, $12, $12, $12, $12, $4E, $4F, $12, $6F, $6F, $6F, $4E
.byte $4F, $4F, $4E, $12, $6F, $6F, $6F, $4E, $4F, $12, $12, $12, $12, $12, $12, $12
.byte $12, $12, $12, $12, $12, $12, $12, $12, $12, $4F, $4E, $12, $6F, $6F, $6F, $4F
.byte $4E, $FF, $00, $00, $00, $00, $00, $00, $FF, $FF, $A2, $00, $00, $00, $00, $A8
.byte $FF, $3F, $AA, $A2, $00, $00, $A8, $AA, $CF, $33, $AA, $AA, $00, $00, $AA, $AA
.byte $CC, $03, $0A, $0A, $00, $00, $0A, $0A, $0C, $00, $00, $01, $00, $00, $04, $00
.byte $00, $00, $04, $00, $00, $00, $00, $01, $00, $00, $00, $00, $00, $00, $00, $00
.byte $00, $A8, $20, $0C, $07, $10, $E8, $20, $1C, $07, $10, $C0, $23, $1E, $91, $40


; 8E00 - bank 4
.byte $C0, $27, $1E, $91, $40, $67, $37, $24, $46, $12, $23, $42, $29, $21, $28, $1D
.byte $25, $10, $20, $17, $12, $29, $1D, $16, $23, $20, $0F, $2E, $24, $2A, $0C, $25
.byte $1E, $29, $12, $12, $12, $12, $12, $12, $12, $12, $12, $12, $12, $12, $12, $12
.byte $12, $12, $12, $12

; ending credits
; ending credits, index for which address to load from the table after this
.byte $01, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
.byte $02, $00, $00, $00, $03, $00, $00, $00, $00, $00, $00, $00
.byte $04, $00, $00, $00, $05, $00, $00, $00, $00, $00, $00, $00
.byte $06, $00, $00, $00, $07, $00, $00, $00, $00, $00, $00, $00
.byte $08, $00, $00, $00, $09, $00, $00, $00, $00, $00, $00, $00
.byte $0A, $00, $00, $00, $0B, $00, $00, $0C, $00, $00, $0D, $00, $00, $00, $00, $00, $00, $00
.byte $0E, $00, $00, $00, $0F, $00, $00, $00, $00, $00, $00, $00
.byte $10, $00, $00, $00, $11, $00, $00, $12, $00, $00, $13, $00, $00, $14, $00, $00, $15, $00, $00, $16, $00, $00, $00, $00, $00, $00, $00
.byte $19, $00, $00, $00, $1A, $00, $00, $00, $00, $00, $00, $00
; new credits
.byte $24, $00, $00, $00, $25, $00, $00, $00, $00, $00, $00, $00
.byte $2A, $00, $00, $00, $2B, $00, $00, $00, $00, $00, $00, $00
.byte $26, $00, $00, $00, $27, $00, $00, $28, $00, $00, $29, $00, $00, $00, $00, $00, $00, $00

.byte $00, $00
.byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
.byte $00

.byte $1B, $00, $00, $00
.byte $00, $00, $00, $00, $00, $00, $00, $00, $1C, $00, $00, $1D, $00, $00, $00, $00
.byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $1E, $00, $1F
.byte $00, $00, $00, $00, $00, $00, $20, $21, $00, $00, $00, $22, $00, $23, $00, $00
.byte $00, $00, $00, $00, $00, $00

; location of what to display for each index
; .byte $6E, $8F ; 00 ; empty line
.byte $A0, $94 ; 00 empty line
.byte $F4, $94 ; 01 ; STAFF
.byte $86, $8F ; 02 ; STORY
.byte $92, $8F ; 03 ; INUSAWA
.byte $9E, $8F ; 04 ; CHARACTER 
.byte $AA, $8F ; 05 ; TARO
.byte $B6, $8F ; 06 ; ART DESIGN
.byte $C2, $8F ; 07 ; MR.HAIGO
.byte $CE, $8F ; 08 ; TITLE DESIGN
.byte $DA, $8F ; 09 ; MAKORIN
.byte $E6, $8F ; 0A ; PROGRAMMERS
.byte $F2, $8F ; 0B ; BAN BAN
.byte $FE, $8F ; 0C ; YOSHIKAWA
.byte $0A, $90 ; 0D ; TOGAWA
.byte $16, $90 ; 0E ; SOUND
.byte $22, $90 ; 0F ; HIP TANAKA
.byte $2E, $90 ; 10 ; ASSISTANTS
.byte $3A, $90 ; 11 ; MASSAO.Y
.byte $46, $90 ; 12 ; SHIKAO.S
.byte $52, $90 ; 13 ; HATABO
.byte $5E, $90 ; 14 ; KENJI
.byte $6A, $90 ; 15 ; HYAKKAN
.byte $76, $90 ; 16 ; KEHIROJI
.byte $82, $90 ; 17 ; DIRECTOR
.byte $8E, $90 ; 18 ; S.OKADA
.byte $9A, $90 ; 19 ; PRODUCER
.byte $A6, $90 ; 1A ; G.YOKOI
.byte $B2, $90 ; 1B ; AND....
.byte $BE, $90 ; 1C ; THE HERO!
.byte $CA, $90 ; 1D ; YOU
.byte $D6, $90 ; 1E ; COPYRIGHT
.byte $E2, $90 ; 1F ; 1986NINTENDO
.byte $EE, $90 ; 20  ; THE (TOP OF END) 
.byte $FA, $90 ; 21  ;     (BOTTOM OF END)
.byte $06, $91 ; 22  ; PUSH
.byte $12, $91 ; 23  ; START BUTTON

.byte $AC, $94 ; 24    SNES PORT 
.byte $B8, $94 ; 25  RUMBLEMINZE
.byte $C4, $94 ; 26  THANKS  TO 
.byte $D0, $94 ; 27  INFIDELITY
.byte $DC, $94 ; 28 FBS  BETTY
.byte $E8, $94 ; 29 NINA MAGNUS

.byte $00, $95 ; 2A 2A03 SOUND
.byte $0C, $95 ; 2B MEMBLERS
.byte $FF, $FF ; 2C <unused>
.byte $FF, $FF ; 2D <unused>
.byte $FF, $FF ; 2E <unused>
.byte $FF, $FF ; 2F <unused>

; 8F6E messages for each index, these are all 12 characters long
; .byte $12, $12, $12, $12, $12, $12, $12, $12, $12, $12, $12, $12    ; empty line
; .byte $12, $12, $12, $28, $29, $16, $1B, $1B, $12, $12, $12, $12    ; STAFF
.byte $12, $12, $12, $28, $29, $24, $27, $2E, $12, $12, $12, $12    ; STORY
.byte $12, $12, $1E, $23, $2A, $28, $16, $2C, $16, $12, $12, $12    ; INUSAWA
.byte $12, $18, $1D, $16, $27, $16, $18, $29, $1A, $27, $12, $12    ; CHARACTER 
.byte $12, $12, $12, $12, $29, $16, $27, $24, $12, $12, $12, $12    ; TARO
.byte $12, $16, $27, $29, $12, $19, $1A, $28, $1E, $1C, $23, $12    ; ART DESIGN
.byte $12, $12, $22, $27, $0D, $1D, $16, $1E, $1C, $24, $12, $12    ; MR.HAIGO
.byte $29, $1E, $29, $21, $1A, $12, $19, $1A, $28, $1E, $1C, $23    ; TITLE DESIGN
.byte $12, $12, $22, $16, $20, $24, $27, $1E, $23, $12, $12, $12    ; MAKORIN
.byte $12, $25, $27, $24, $1C, $27, $16, $22, $22, $1A, $27, $28    ; PROGRAMMERS
.byte $12, $12, $17, $16, $23, $12, $17, $16, $23, $12, $12, $12    ; BAN BAN
.byte $12, $2E, $24, $28, $1D, $1E, $20, $16, $2C, $16, $12, $12    ; YOSHIKAWA
.byte $12, $12, $29, $24, $1C, $16, $2C, $16, $12, $12, $12, $12    ; TOGAWA
.byte $12, $12, $12, $28, $24, $2A, $23, $19, $12, $12, $12, $12    ; SOUND
.byte $12, $1D, $1E, $25, $12, $29, $16, $23, $16, $20, $16, $12    ; HIP TANAKA

.byte $12, $16, $28, $28, $1E, $28, $29, $16, $23, $29, $28, $12    ; ASSISTANTS
.byte $12, $12, $22, $16, $28, $28, $16, $24, $0D, $2E, $12, $12    ; MASSAO.Y
.byte $12, $12, $28, $1D, $1E, $20, $16, $24, $0D, $28, $12, $12    ; SHIKAO.S
.byte $12, $12, $12, $1D, $16, $29, $16, $17, $24, $12, $12, $12    ; HATABO
.byte $12, $12, $12, $20, $1A, $23, $1F, $1E, $12, $12, $12, $12    ; KENJI
.byte $12, $12, $1D, $2E, $16, $20, $20, $16, $23, $12, $12, $12    ; HYAKKAN
.byte $12, $12, $20, $1A, $1D, $1E, $27, $24, $1F, $1E, $12, $12    ; KEHIROJI
.byte $12, $12, $19, $1E, $27, $1A, $18, $29, $24, $27, $12, $12    ; DIRECTOR
.byte $12, $12, $28, $0D, $24, $20, $16, $19, $16, $12, $12, $12    ; S.OKADA
.byte $12, $12, $25, $27, $24, $19, $2A, $18, $1A, $27, $12, $12    ; PRODUCER
.byte $12, $12, $1C, $0D, $2E, $24, $20, $24, $1E, $12, $12, $12    ; G.YOKOI
.byte $12, $12, $12, $12, $16, $23, $19, $0D, $0D, $0D, $0D, $12    ; AND....
.byte $12, $29, $1D, $1A, $12, $1D, $1A, $27, $24, $0E, $12, $12    ; THE HERO!
.byte $12, $12, $12, $12, $2E, $24, $2A, $12, $12, $12, $12, $12    ; YOU
.byte $12, $18, $24, $25, $2E, $27, $1E, $1C, $1D, $29, $12, $12    ; COPYRIGHT
.byte $01, $09, $08, $06, $23, $1E, $23, $29, $1A, $23, $19, $24    ; 1986NINTENDO

.byte $29, $1D, $1A, $D0, $D1, $D2, $D3, $D4, $D5, $12, $12, $12    ; THE (TOP OF END)
.byte $12, $12, $12, $D6, $D7, $D8, $D9, $DA, $DB, $12, $12, $12    ;     (BOTTOME OF END)
.byte $12, $12, $12, $12, $25, $2A, $28, $1D, $12, $12, $12, $12    ; PUSH
.byte $28, $29, $16, $27, $29, $12, $17, $2A, $29, $29, $24, $23    ; START BUTTON
.byte $F0, $F0

.byte $F0, $F0, $F0, $F0, $F0, $F0, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
.byte $00, $00, $00, $00, $00, $00, $50, $50, $50, $50, $50, $50, $50, $50, $0F, $0F
.byte $0F, $0F, $0F, $0F, $0F, $0F, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
.byte $00, $00, $00, $00, $00, $00, $05, $05, $05, $05, $05, $05, $05, $05, $0F, $30
.byte $30, $30, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $20
.byte $22, $02, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $20
.byte $22, $02, $0F, $06, $07, $0F, $0F, $00, $0F, $0F, $0F, $01, $08, $0F, $0F, $20
.byte $22, $02, $0F, $16, $05, $07, $0F, $10, $00, $0F, $0F, $11, $17, $0B, $0F, $20
.byte $22, $02, $0F, $24, $25, $06, $0F, $37, $10, $00, $0F, $2C, $27, $1A, $10, $20
.byte $22, $02, $10, $10, $10, $10, $10, $10, $10, $10, $10, $10, $10, $10, $0F, $20
.byte $26, $07, $0F, $31, $02, $15, $0F, $11, $24, $31, $0F, $2A, $36, $26, $10, $30
.byte $30, $30, $10, $31, $02, $15, $10, $11, $24, $31, $10, $2A, $36, $26, $05, $06
.byte $07, $08, $08, $03, $06, $06, $06, $06, $06, $06, $06, $08, $0D, $0D, $0B, $05
.byte $92, $1D, $92, $35, $92, $4D, $92, $65, $92, $7D, $92, $95, $92, $AD, $92, $CD


; 9200 - bank 4
.byte $92, $01, $93, $35, $93, $00, $01, $40, $01, $00, $00, $40, $09, $08, $11, $40
.byte $01, $08, $10, $40, $09, $10, $21, $40, $00, $10, $20, $40, $08, $01, $01, $40
.byte $00, $01, $00, $40, $08, $09, $11, $40, $00, $09, $10, $40, $08, $10, $23, $40
.byte $00, $10, $22, $40, $08, $00, $01, $40, $00, $00, $00, $40, $08, $08, $11, $40
.byte $00, $08, $10, $40, $08, $10, $25, $40, $00, $10, $24, $40, $08, $00, $E5, $00
.byte $00, $00, $E5, $40, $08, $08, $E6, $00, $00, $08, $E6, $40, $08, $10, $E7, $00
.byte $00, $10, $E7, $40, $08, $00, $E8, $00, $00, $00, $E8, $40, $08, $08, $E9, $00
.byte $00, $08, $E9, $40, $08, $10, $E7, $00, $00, $10, $E7, $40, $08, $00, $DC, $00
.byte $00, $00, $DD, $00, $08, $08, $DE, $00, $00, $08, $E6, $40, $08, $10, $E7, $00
.byte $00, $10, $E7, $40, $08, $00, $C0, $00, $00, $00, $C1, $00, $08, $08, $DE, $00
.byte $00, $08, $E6, $40, $08, $10, $E7, $00, $00, $10, $E7, $40, $08, $F8, $C2, $01
.byte $00, $F8, $C3, $01, $08, $00, $C0, $00, $00, $00, $C1, $00, $08, $08, $DE, $00
.byte $00, $08, $E6, $40, $08, $10, $E7, $00, $00, $10, $E7, $40, $08, $F0, $EA, $00
.byte $00, $F0, $EB, $00, $08, $F0, $EC, $00, $10, $F8, $ED, $00, $00, $F8, $EE, $00
.byte $08, $F8, $EF, $00, $10, $00, $D0, $00, $00, $00, $D1, $00, $08, $08, $D2, $00
.byte $00, $08, $D3, $00, $08, $10, $D4, $00, $00, $10, $D5, $00, $08, $10, $D6, $00


; 9300 - bank 4
.byte $10, $F0, $EA, $00, $00, $F0, $EB, $00, $08, $F0, $EC, $00, $10, $F8, $ED, $00
.byte $00, $F8, $FB, $00, $08, $F8, $EF, $00, $10, $00, $D0, $00, $00, $00, $D1, $00
.byte $08, $08, $D2, $00, $00, $08, $D3, $00, $08, $10, $D4, $00, $00, $10, $D5, $00
.byte $08, $10, $D6, $00, $10, $F0, $EA, $00, $00, $F0, $EB, $00, $08, $F8, $ED, $00
.byte $00, $F8, $FB, $00, $08, $00, $D0, $00, $00, $00, $D1, $00, $08, $08, $D2, $00
.byte $00, $08, $D3, $00, $08, $10, $D4, $00, $00, $10, $D5, $00, $08, $10, $D6, $00
.byte $10, $69, $93, $A1, $93, $D9, $93, $11, $94, $00, $E0, $00, $00, $00, $F1, $00
.byte $08, $00, $F2, $00, $10, $08, $E1, $00, $00, $08, $F4, $00, $08, $08, $F5, $00
.byte $10, $10, $E2, $00, $00, $10, $F7, $00, $08, $10, $F8, $00, $10, $18, $E3, $00
.byte $00, $18, $FA, $00, $08, $20, $E4, $00, $00, $20, $FD, $00, $08, $20, $FE, $00
.byte $10, $00, $F0, $00, $00, $00, $F1, $00, $08, $00, $F2, $00, $10, $08, $F3, $00
.byte $00, $08, $F4, $00, $08, $08, $F5, $00, $10, $10, $F6, $00, $00, $10, $F7, $00
.byte $08, $10, $F8, $00, $10, $18, $F9, $00, $00, $18, $FA, $00, $08, $20, $FC, $00
.byte $00, $20, $FD, $00, $08, $20, $FE, $00, $10, $00, $C4, $00, $00, $00, $C5, $00
.byte $08, $00, $C6, $00, $10, $08, $C7, $00, $00, $08, $C8, $00, $08, $08, $F5, $00
.byte $10, $10, $C9, $00, $00, $10, $F7, $00, $08, $10, $F8, $00, $10, $18, $CA, $00


; 9400 - bank 4
.byte $00, $18, $FA, $00, $08, $20, $FC, $00, $00, $20, $FD, $00, $08, $20, $FE, $00
.byte $10, $00, $E0, $00, $00, $00, $F1, $00, $08, $00, $F2, $00, $10, $08, $F4, $00
.byte $08, $08, $F5, $00, $10, $10, $C9, $00, $00, $10, $F7, $00, $08, $10, $F8, $00
.byte $10, $18, $CA, $00, $00, $18, $FA, $00, $08, $20, $FC, $00, $00, $20, $FD, $00
.byte $08, $20, $FE, $00, $10, $4D, $94, $5D, $94, $6D, $94, $7D, $94, $00, $D7, $00
.byte $00, $00, $D8, $00, $08, $08, $DA, $00, $00, $08, $DB, $00, $08, $00, $D7, $00
.byte $00, $00, $D9, $00, $08, $08, $DA, $00, $00, $08, $DB, $00, $08, $00, $D7, $40
.byte $08, $00, $D8, $40, $00, $08, $DA, $40, $08, $08, $DB, $40, $00, $00, $D7, $40
.byte $08, $00, $D8, $40, $00, $08, $DA, $40, $08, $08, $DB, $40, $00, $00, $FF, $00
.byte $00, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
; a5:94A0 - using this for my credits entries
.byte $12, $12, $12, $12, $12, $12, $12, $12, $12, $12, $12, $12  ; empty row, moved from 8F6E 
.byte $12, $28, $23, $1A, $28, $12, $12, $25, $24, $27, $29, $12  ;   SNES PORT 
.byte $12, $27, $2A, $22, $17, $21, $1A, $22, $1E, $23, $2F, $1A  ;  RUMBLEMINZE
.byte $12, $12, $29, $1D, $16, $23, $20, $28, $12, $29, $24, $12  ;  THANKS  TO 
.byte $12, $1E, $23, $1B, $1E, $19, $1A, $21, $1E, $29, $2E, $12  ;  INFIDELITY
.byte $1B, $17, $28, $12, $12, $12, $12, $17, $1A, $29, $29, $2E  ; FBS  BETTY
.byte $23, $1E, $23, $16, $FF, $FF, $22, $16, $1C, $23, $2A, $28  ; NINA MAGNUS

; a5:94f4
.byte $12, $12, $12, $28, $29, $16, $1B, $1B, $12, $12, $12, $12  ; STAFF, moved from 8F7A
; 9500
.byte $12, $02, $16, $00, $03, $12, $28, $24, $2A, $23, $19, $12  ; 2A03 SOUND
.byte $12, $12, $22, $1A, $22, $17, $21, $1A, $27, $28, $12, $12  ; MEMBLERS

; A5:9518ish - Free until almost A5:A000
; Our new Sound Engine
a003_sound_engine_hijack:
  PHP
  PHB
  PHK
  PLB
  JSR $A003
  BRA :+  

a006_sound_engine_hijack:
  PHP
  PHB
  PHK
  PLB
  JSR $A006
  BRA :+  

new_sound_engine_hijack:
  PHP
  PHB
  PHK
  PLB
  JSR $A000
  
: JSR convert_audio
ca_d9d3:
  PLB
  PLP
  RTS

convert_audio:
  PHX
  PHY
  JSR detect_changes
  JSR emulate_length_counter
  JSR backup_regs
  JSR update_dsp
  LDA SNDTMP4016
  AND #$20
  STA SNDTMP4016
  PLY
  PLX
  RTS


detect_changes:
	sep #$30 ; All 8b
        lda SNDSQR1CTRL4000
        and #%00100000
        bne decay_disabled0

        lda SNDSQR1LENPH4003
        beq :+
        sta SNDTMP4003
        lda #0
        sta SNDSQR1LENPH4003

        lda SNDTMP4016
        ora #%00000001
        sta SNDTMP4016
        bra end_square0
:
        lda SNDTMP4016
        and #%11111110
        sta SNDTMP4016
        bra end_square0

decay_disabled0:
        lda SNDSQR1LENPH4003
        sta SNDTMP4003

end_square0:

        lda SNDSQR2CTRL4004
        and #%00100000
        bne decay_disabled1

        lda SNDSQR2LENPH4007
        beq :+
        sta SNDTMP4007
        lda #0
        sta SNDSQR2LENPH4007

        lda SNDTMP4016
        ora #00000010
        sta SNDTMP4016
        bra end_square1
:
        lda SNDTMP4016
        and #%11111101
        sta SNDTMP4016
        bra end_square1

decay_disabled1:
        lda SNDSQR2LENPH4007
        sta SNDTMP4007
end_square1:
                        ;       triangle wave
        lda SNDTRIACTRL4008
        and #%10000000
        bne disabled3

        lda SNDNOISECTRL400B
        beq :+
        sta SNDTMP400B
        lda #0
        sta SNDNOISECTRL400B
        lda SNDTMP4016
        ora #%00000100
        sta SNDTMP4016
        bra end_tri
:
        lda SNDTMP4016
        and #%11111011
        sta SNDTMP4016
        bra end_tri

disabled3:
        lda SNDNOISECTRL400B
        sta SNDTMP400B
end_tri:

        lda SNDNOISESHM400C
        and #%00100000
        bne decay_disabled2

        lda SNDDMCDAC400F
        beq :+
        sta SNDTMP400F
        lda #0
        sta SNDDMCDAC400F

        lda SNDTMP4016
        ora #%00001000
        sta SNDTMP4016
        bra end_noise
:
        lda SNDTMP4016
        and #%11110111
        sta SNDTMP4016
        bra end_noise

decay_disabled2:
        lda SNDDMCDAC400F
        sta SNDTMP400F
end_noise:
        ; check freq for sweeps
        lda SNDSQR1E4001
        and #%10000000
        beq sqsw1

        lda SNDSQR1E4001
        and #%00000111
        beq sqsw1x
        lda SNDSQR1PERIOD4002
        beq sqsw1
        sta SNDTMP4002
        lda #0
        sta SNDSQR1PERIOD4002
        lda SNDTMP4016
        ora #%01000000
        sta SNDTMP4016
        bra :+


sqsw1:
        lda SNDSQR1PERIOD4002
        sta SNDTMP4002
:
        bra nextcheck
sqsw1x:
        lda SNDTMP4016
        and #%10111111
        sta SNDTMP4016
        bra sqsw1

nextcheck:

        ; check freq for sweeps
        lda SNDSQR2E4005
        and #%10000000
        beq sqsw12

        lda SNDSQR2E4005
        and #%00000111
        beq sqsw1x2
        lda SNDSQR2PERIOD4006
        beq sqsw12
        sta SNDTMP4006
        lda #0
        sta SNDSQR2PERIOD4006
        lda SNDTMP4016
        ora #%10000000
        sta SNDTMP4016
        bra :+


sqsw12:
        lda SNDSQR2PERIOD4006
        sta SNDTMP4006
:
        bra nextcheck2
sqsw1x2:
        lda SNDTMP4016
        and #%01111111
        sta SNDTMP4016
        bra sqsw12

nextcheck2:

        rts

length_d3_0:
        .byte $06,$0B,$15,$29,$51,$1F,$08,$0F
        .byte $07,$0D,$19,$31,$61,$25,$09,$11

length_d3_1:
        .byte $80,$02,$03,$04,$05,$06,$07,$08
        .byte $09,$0A,$0B,$0C,$0D,$0E,$0F,$10

.byte $EA
emulate_length_counter:
  setAXY8
  lda #0
  sta SNDTMP4015
  ; square 0
  lda SNDTMP4016
  and #%00000001
  beq sq0_not_changed

  lda SNDTMP4013        
  pha
  and #%00001000
  beq sq0_d3_0

  pla
  lsr a
  lsr a
  lsr a
  lsr a

  xba
  lda #0
  xba

  tay
  lda length_d3_1, Y
  sta square0_length
  bra sq0_load_end

sq0_d3_0:
  pla
  lsr a
  lsr a
  lsr a
  lsr a

  tay
  lda length_d3_0, Y
  sta square0_length        

sq0_load_end:

;        lda #0
;        sta $7F4003

sq0_not_changed:

  lda SNDTMP4015
  ora #%00000001
  sta SNDTMP4015

  lda SNDSQR1CTRL4000
  and #%00100000
  bne sq0_counter_disabled


  lda square0_length
  beq blahsq
  dec square0_length
  bra sq0_counter_disabled

blahsq:
  lda SNDTMP4015
  and #%11111110
  sta SNDTMP4015

sq0_counter_disabled:
  ; square 1
  lda SNDTMP4016
  and #%00000010
  beq sq1_not_changed

  lda SNDTMP4007
  pha
  and #%00001000
  beq sq1_d3_0

  pla
  lsr a
  lsr a
  lsr a
  lsr a

  xba
  lda #0
  xba

  tay
  lda length_d3_1, Y
  sta square1_length
  bra sq1_load_end

sq1_d3_0:
  pla
  lsr a
  lsr a
  lsr a
  lsr a

  tay
  lda length_d3_0, Y
  sta square1_length        

sq1_load_end:

;        lda #0
;        sta $7F4007

sq1_not_changed:

  lda SNDTMP4015
  ora #%00000010
  sta SNDTMP4015

  lda SNDSQR2CTRL4004
  and #%00100000
  bne sq1_counter_disabled

  lda square1_length
  beq sqblah
  dec square1_length
  bra sq1_counter_disabled
sqblah:
  lda SNDTMP4015
  and #%11111101
  sta SNDTMP4015

sq1_counter_disabled:

  ; triangle channel
  lda SNDTMP4016
  and #%00000100
  beq tri_not_changed

  lda SNDTMP400B
  pha
  and #%00001000
  beq tri_d3_0

  pla
  lsr a
  lsr a
  lsr a
  lsr a

  xba
  lda #0
  xba

  tay
  lda length_d3_1, Y
  sta triangle_length
  bra tri_load_end

tri_d3_0:
  pla
  lsr a
  lsr a
  lsr a
  lsr a

  tay
  lda length_d3_0, Y
  sta triangle_length        

tri_load_end:

;        lda #0
;        sta $7F400B

tri_not_changed:

  lda SNDTMP4015
  ora #%00000100
  sta SNDTMP4015

  lda SNDTRIACTRL4008
  and #%10000000
  bne tri_counter_disabled

  lda triangle_length
  beq blah
  dec triangle_length
  bra tri_counter_disabled
blah:
  lda SNDTMP4015
  and #%11111011
  sta SNDTMP4015

tri_counter_disabled:

                          ; noise channel
  lda SNDTMP4016
  and #%00001000          ; get length value (0 if unchanged)
  beq unchanged

  lda SNDTMP400F
  pha
  and #%00001000
  beq d3_0

  pla
  lsr a
  lsr a
  lsr a
  lsr a

  xba
  lda #0
  xba

  tay
  lda length_d3_1, Y
  sta noise_length

  bra load_end

d3_0:
  pla
  lsr a
  lsr a
  lsr a
  lsr a

  tay
  lda length_d3_0, Y
  sta noise_length

load_end:
;        lda #0
;        sta $7F400F

unchanged:

  lda SNDTMP4015
  ora #%00001000
  sta SNDTMP4015

  lda SNDNOISESHM400C
  and #%00100000
  bne noise_counter_disabled

  lda noise_length
  beq pleh

  dec noise_length
  bra noise_counter_disabled

pleh:
  lda SNDTMP4015
  and #%11110111
  sta SNDTMP4015

noise_counter_disabled:

  lda SNDTMP4015
  and SNDCHANSW4015
  sta SNDTMP4015

  rts
  
sound_lookup_table_1:
.byte $06, $0B, $15, $29, $51, $1F, $08, $0F, $07, $0D, $19, $31, $61, $25, $09, $11
sound_lookup_table_2:
.byte $80, $02, $03, $04, $05, $06, $07, $08, $09, $0A, $0B, $0C, $0D, $0E, $0F, $10
.byte $FF


backup_regs:
  lda SNDSQR1CTRL4000
  sta SNDTMP4000
  lda SNDSQR1E4001
  sta SNDTMP4001
  lda SNDSQR2CTRL4004
  sta SNDTMP4004
  lda SNDSQR2E4005
  sta SNDTMP4005
  lda SNDTRIACTRL4008
  sta SNDTMP4008
  lda SNDTRIAPERIOD4009
  sta SNDTMP4009
  lda SNDTRIALENPH400A
  sta SNDTMP400A
  lda SNDNOISESHM400C
  sta SNDTMP400C
  lda SNDNOISELEN400D
  sta SNDTMP400D
  lda SNDDMCCTRL400E
  sta SNDTMP400E
  lda SNDDMCSLEN4011
  sta SNDTMP4011
  rts

update_dsp:
  lda APUInit
  bne ContinueAPUUpdate
  rts
ContinueAPUUpdate:
  php
  setAXY8
  phx
WaitSPC700Ready:
  lda APUIO0
  cmp #$7D                ; wait for SPC ready
  bne WaitSPC700Ready

  lda #$D7
  sta APUIO0               ; tell SPC that CPU is ready
WSPC700Reply:
  cmp APUIO0               ; wait for reply
  bne WSPC700Reply

  ldx #0
  stx APUIO0               ; clear port 0
xfer:
  lda SNDTMP4000, X
  ;lda SNDSQR1CTRL4000, X
  sta APUIO1               ; send data to port 1
WSPC700Reply2:
  cpx APUIO0               ; wait for reply on port 0
  bne WSPC700Reply2
  inx
  cpx #$17
  beq NesRegLoadEnds
  stx APUIO0
  bra xfer
NesRegLoadEnds:
  plx
  plp
  rts

; end audio stuff

; 987F - bank 4
.byte $FF
.byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
.byte $FF, $FF, $FF, $FF, $FF, $FF, $7F, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
.byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
.byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
.byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $EF
.byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
.byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
.byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF


; 9900 - bank 4
.byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
.byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
.byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
.byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
.byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
.byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
.byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
.byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
.byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
.byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
.byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
.byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
.byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
.byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
.byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
.byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00


; 9A00 - bank 4
.byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
.byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
.byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
.byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
.byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
.byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
.byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
.byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
.byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
.byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
.byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
.byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
.byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
.byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
.byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
.byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF


; 9B00 - bank 4
.byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
.byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
.byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
.byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
.byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
.byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
.byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
.byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
.byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
.byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
.byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
.byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
.byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
.byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
.byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
.byte $00, $00, $00, $00, $00, $00, $00, $00, $04, $02, $00, $89, $00, $10, $00, $80


; 9C00 - bank 4
.byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
.byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
.byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
.byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
.byte $FF, $FF, $FF, $FF, $FF, $FF, $DF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
.byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
.byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
.byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
.byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
.byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
.byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
.byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
.byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
.byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
.byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
.byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF


; 9D00 - bank 4
.byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
.byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
.byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
.byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
.byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
.byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
.byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
.byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
.byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
.byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
.byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
.byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
.byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
.byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $04, $00, $00, $00, $00, $00, $00
.byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
.byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00


; 9E00 - bank 4
.byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
.byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
.byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
.byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
.byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
.byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
.byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
.byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
.byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
.byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
.byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
.byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
.byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
.byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
.byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
.byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF


; 9F00 - bank 4
.byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
.byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
.byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
.byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
.byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
.byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
.byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
.byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
.byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
.byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
.byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
.byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
.byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
.byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
.byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
.byte $00, $00, $00, $00, $00, $00, $00, $00, $22, $08, $40, $61, $00, $00, $10, $40


; A000 - bank 4
JMP $A006 ; a006_sound_engine_hijack
JMP $A0FD

; sound stuff, I've changed the writes from $40__ to $0A__
LDA #$00
STA NES_APU_DMC_TIMER
STA NES_APU_DMC_MEMRDR
LDA #$0F
STA NES_APU_CHAN_ENABLE
LDA #$C0
STA NES_APU_FRAME_CTR
LDA #$10
STA NES_APU_P1_TIMER
STA NES_APU_P2_TIMER
STA NES_APU_NOISE_TIMER
LDA #$00
STA NES_APU_TRI_TIMER

; zero out 0300 - 03FF
LDA #$00
TAX
:STA $0300, X
INX
BNE :-

STA $DF
LDA #$AA
STA $EF
RTS

a038:
.byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
.byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
.byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
.byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $7F, $FF
.byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
.byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
.byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
.byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
.byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
.byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
.byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
.byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
.byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $BF, $FF, $FF, $FF, $FF, $FF, $4C, $CD, $A2


; A100 - bank 4
.byte $00, $10, $00, $18, $06, $02, $18, $02, $03, $40, $1D, $7F, $0F, $A0, $06, $7F
.byte $00, $40, $1A, $7F, $0B, $18, $19, $7F, $00, $40, $09, $7F, $02, $40, $DA, $A5
.byte $B1, $41, $1A, $A5, $F9, $41, $DA, $BC, $49, $C0, $DA, $BC, $A5, $C0, $DA, $86
.byte $30, $42, $DB, $86, $40, $41, $5A, $7F, $50, $8A, $5A, $7F, $12, $8A, $1B, $9E
.byte $73, $58, $1B, $8E, $72, $69, $D5, $83, $10, $68, $93, $8D, $27, $F9, $98, $89
.byte $F0, $18, $1F, $7F, $7C, $F9, $9D, $DB, $20, $88, $9E, $7F, $22, $18, $D8, $A6
.byte $4B, $F8, $D6, $A6, $60, $F8, $D9, $97, $56, $F8, $7F, $7F, $20, $88, $7F, $7F
.byte $68, $F8, $09, $7F, $20, $38, $04, $7F, $A9, $28, $07, $7F, $20, $28, $B0, $A1
.byte $17, $A2, $00, $C0, $A1, $04, $A4, $00, $D0, $A1, $25, $A2, $01, $E0, $A1, $04
.byte $A4, $01, $F0, $A1, $3A, $A2, $03, $00, $A2, $04, $A4, $03, $B7, $AB, $53, $A2
.byte $04, $C7, $AB, $5B, $A2, $04, $D7, $AB, $FC, $AB, $00, $D7, $AB, $EE, $AB, $00
.byte $84, $A4, $7E, $A4, $5D, $A4, $A9, $A4, $B8, $A4, $BE, $A4, $23, $A4, $04, $A4
.byte $91, $A4, $6C, $A4, $64, $A4, $9B, $A4, $9B, $A4, $C4, $A4, $2A, $A4, $04, $A4
.byte $FF, $A5, $5E, $A6, $7A, $A6, $9C, $A6, $F5, $A6, $E7, $A6, $8E, $A6, $B0, $A6
.byte $06, $A6, $4A, $A6, $85, $A6, $A7, $A6, $03, $A7, $64, $A6, $64, $A6, $BD, $A6
.byte $7A, $A7, $08, $A8, $04, $A4, $04, $A4, $D6, $A7, $04, $A4, $4A, $A7, $C2, $A7


; A200 - bank 4
.byte $84, $A7, $0F, $A8, $04, $A4, $04, $A4, $E7, $A7, $04, $A4, $58, $A7, $9E, $A7
.byte $AD, $80, $03, $A2, $7E, $D0, $15, $AD, $88, $03, $A2, $83, $D0, $0E, $AD, $81
.byte $03, $A2, $88, $D0, $07, $AD, $89, $03, $A2, $8D, $D0, $00, $20, $D7, $A3, $6C
.byte $EB, $00, $AD, $83, $03, $A2, $92, $4C, $2C, $A2, $AD, $8B, $03, $A2, $97, $4C
.byte $2C, $A2, $AD, $84, $03, $A2, $9C, $20, $D7, $A3, $20, $0D, $AC, $20, $1D, $AC
.byte $6C, $EB, $00, $AD, $8C, $03, $A2, $A1, $4C, $2C, $A2, $20, $1E, $A2, $60, $A5
.byte $EF, $29, $02, $8D, $1F, $03, $A5, $F0, $29, $02, $4D, $1F, $03, $18, $F0, $01
.byte $38, $66, $EF, $66, $F0, $60

; a276
  LDA #$00
  BEQ :+
  LDA #$08
  BNE :+
  LDA #$0C
  BNE :+
  LDA #$04
: STA $E9
  LDA #$0A
  STA $EA
  STY $EB
  LDA #$A1
  STA $EC
  LDY #$00
: LDA ($EB),Y
  STA ($E9),Y
  INY
  TYA
  CMP #$04
  BNE :-
  RTS


.byte $EE, $02, $03
.byte $20, $5A, $A3, $8D, $03, $03, $60, $AD, $02, $03, $F0, $F1, $AD, $03, $03, $F0
; A2BF 8d 01 40 -> 8d 01 0a
.byte $13, $C9, $12, $F0, $17, $29, $02, $F0, $04, $A9, $84, $D0, $02, $A9, $8B, $8D
.byte $01, $0a, $D0, $05, $A0, $4A, $20, $76, $A2, $EE, $03, $03, $60, $A9, $C0, $8D
.byte $17, $40, $20, $5F, $A2, $AD, $80, $03, $4A, $B0, $2A, $A5, $DF, $D0, $C8, $A9
.byte $00, $8D, $02, $03, $20, $10, $A2, $20, $42, $A2, $20, $32, $A2, $20, $E7, $AB
.byte $A9, $00, $8D, $80, $03, $8D, $81, $03, $8D, $82, $03, $8D, $83, $03, $8D, $84


; A300 - bank 4
.byte $03, $8D, $85, $03, $60, $20, $1D, $A3, $F0, $E6, $AD, $2C, $03, $F0, $0E, $AD
.byte $8D, $03, $8D, $4F, $03, $60, $AD, $8D, $03, $C5, $E8, $F0, $06, $20, $36, $A3
.byte $20, $5A, $A3, $20, $27, $A3, $60, $A9, $00, $8D, $2D, $03, $8D, $02, $03, $8D
.byte $4F, $03, $8D, $2C, $03, $60, $A9, $00, $8D, $4A, $03, $8D, $4B, $03, $8D, $4C
.byte $03, $8D, $4D, $03, $8D, $07, $03, $8D, $88, $03, $8D, $89, $03, $8D, $8A, $03
.byte $8D, $8B, $03, $8D, $8C, $03, $8D, $8D, $03, $60

; A35A - sound stuff, I've changed the writes from $40__ to $0A__
; needs to mute MSU if it's playing
  LDA #$10
  STA $0A00
  STA $0A04
  STA $0A0C
  LDA #$00
  STA $0A08
  STA $0A11
  RTS

.byte $AE, $4E
.byte $03, $9D, $51, $03, $8A, $F0, $1C, $C9, $01, $F0, $09, $C9, $02, $F0, $0B, $C9
.byte $03, $F0, $0A, $60, $20, $76, $A2, $4C, $96, $A3, $4C, $96, $A3, $20, $7A, $A2
.byte $4C, $96, $A3, $20, $7E, $A2, $20, $AF, $A3, $8A, $9D, $49, $03, $A9, $00, $9D
.byte $56, $03, $9D, $60, $03, $9D, $64, $03, $9D, $68, $03, $8D, $07, $03, $60, $AE
.byte $4E, $03, $BD, $88, $03, $29, $00, $05, $E8, $9D, $88, $03, $60, $A9, $00, $85
.byte $E8, $F0, $EC, $AE, $4E, $03, $FE, $56, $03, $BD, $56, $03, $DD, $51, $03, $D0
.byte $05, $A9, $00, $9D, $56, $03, $60, $85, $E8, $86, $ED, $A0, $A1, $84, $EE, $A0
.byte $00, $B1, $ED, $99, $E9, $00, $C8, $98, $C9, $04, $D0, $F5, $B1, $ED, $8D, $4E
.byte $03, $A0, $00, $A5, $E8, $48, $06, $E8, $B0, $0B, $C8, $C8, $98, $C9, $10, $D0


; A400 - bank 4
.byte $F5, $68, $85, $E8, $60, $B1, $E9, $85, $EB, $C8, $B1, $E9, $85, $EC, $4C, $01
.byte $A4, $0D, $09, $00, $01, $02, $03, $04, $05, $06, $07, $08, $07, $06, $05, $04
.byte $03, $03, $02, $A9, $10, $A0, $1A, $4C, $6E, $A3, $20, $C3, $A3, $D0, $03, $4C
; A438 = 8D0E40 -> 8D 0E 0A
.byte $A0, $A4, $AC, $60, $03, $B9, $11, $A4, $8D, $0E, $0A, $EE, $60, $03, $60, $60
.byte $0F, $09, $0B, $0F, $0E, $03, $0F, $0D, $0F, $08, $07, $06, $05, $03, $02, $02
; A459 = 8D0E40	-> 8D 0E 0A
.byte $EE, $60, $03, $AC, $60, $03, $B9, $40, $A4, $8D, $0E, $0A, $60, $A9, $11, $A0
.byte $0A, $4C, $B5, $A4, $20, $C3, $A3, $D0, $E7, $4C, $A0, $A4, $20, $C3, $A3, $D0
.byte $EB, $EE, $60, $03, $AD, $60, $03, $C9, $10, $F0, $EE, $4C, $59, $A4, $A9, $02
.byte $A0, $16, $D0, $DD, $A9, $06, $A0, $0A, $20, $6E, $A3, $A9, $09, $8D, $60, $03
.byte $60, $20, $C3, $A3, $F0, $0A, $EE, $60, $03, $D0, $2E, $20, $C3, $A3, $D0, $08
; A4A5 = 8D0C40	-> 8D 0C 0A, 
.byte $20, $BD, $A3, $A9, $10, $8D, $0C, $0A, $60, $AD, $81, $03, $09, $04, $8D, $81
.byte $03, $A9, $16, $A0, $0E, $4C, $6E, $A3, $A9, $02, $A0, $12, $D0, $F7, $A9, $04
; A4CF = 8D0E40 -> 8D 0E 0A
.byte $A0, $16, $D0, $F1, $20, $C3, $A3, $F0, $D7, $EE, $60, $03, $AD, $60, $03, $8D
.byte $0E, $0A, $60, $A0, $36, $20, $76, $A2, $A9, $0F, $A0, $3A, $4C, $17, $A5, $20
.byte $C3, $A3, $D0, $C4, $A0, $36, $20, $76, $A2, $A0, $3A, $20, $82, $A2, $EE, $61
.byte $03, $AD, $61, $03, $C9, $03, $D0, $B0, $4C, $3F, $A5, $A0, $2E, $20, $76, $A2


; A500 - bank 4
.byte $A9, $0F, $A0, $32, $4C, $17, $A5, $20, $C3, $A3, $F0, $33, $A5, $EF, $09, $80
; A510 = 8D0240 -> 8D 02 0A, 
; A513 = 8D0640 -> 8D 06 0A
.byte $8D, $02, $0A, $8D, $06, $0A, $60, $8D, $55, $03, $20, $82, $A2, $20, $AF, $A3
.byte $A9, $01, $8D, $4A, $03, $A9, $02, $8D, $4B, $03, $A9, $00, $8D, $89, $03, $8D
.byte $61, $03, $8D, $65, $03, $8D, $69, $03, $8D, $5A, $03, $8D, $07, $03, $60, $A9
; A541 = 8D0040 -> 8D 00 0A
; A544 = 8D0440 -> 8D 04 0A
; A549 = 8D0140 -> 8D 01 0A
; A54C = 8D0540 -> 8D 05 0A
.byte $10, $8D, $00, $0A, $8D, $04, $0A, $A9, $7F, $8D, $01, $0A, $8D, $05, $0A, $20
.byte $BD, $A3, $A9, $00, $8D, $4A, $03, $8D, $4B, $03, $EE, $07, $03, $60, $AD, $89
.byte $03, $29, $80, $D0, $F8, $A0, $1E, $20, $76, $A2, $A5, $EF, $29, $03, $09, $41
; A570 = 8D0340 -> 8D 03 0A
.byte $8D, $03, $0A, $A9, $02, $A0, $22, $20, $17, $A5, $A5, $EF, $4A, $4A, $4A, $29
; A583 = 8D0740 -> 8D 07 0A
.byte $03, $09, $41, $8D, $07, $0A, $60, $20, $C3, $A3, $D0, $D1, $AD, $65, $03, $D0
; A595 = 8D0240 -> 8D 02 0A
; A59A = 8D0640 -> 8D 06 0A
.byte $0C, $A5, $EF, $09, $C0, $8D, $02, $0A, $E9, $28, $8D, $06, $0A, $EE, $61, $03
.byte $AD, $61, $03, $C9, $05, $F0, $07, $C9, $0B, $D0, $06, $4C, $3F, $A5, $EE, $65
.byte $03, $60, $A0, $26, $20, $76, $A2, $A9, $02, $A0, $2A, $4C, $17, $A5, $20, $C3
; A5CB = 8D0140 -> 8D 01 0A
; A5CE = 8D0540 -> 8D 05 0A
.byte $A3, $D0, $EE, $AC, $61, $03, $B9, $D5, $A5, $F0, $E0, $8D, $01, $0A, $8D, $05
.byte $0A, $EE, $61, $03, $60, $A4, $AC, $A4, $AC, $A3, $AC, $A3, $AC, $A3, $AC, $00
.byte $9B, $97, $95, $94, $93, $00, $19, $22, $19, $22, $19, $22, $40, $48, $40, $48
.byte $40, $48, $0C, $1C, $93, $AB, $2D, $3F, $60, $A4, $AC, $A3, $AC, $A4, $AC, $A9


; A600 - bank 4
.byte $08, $A0, $5E, $4C, $6E, $A3, $20, $C3, $A3, $F0, $1D, $AD, $69, $03, $C9, $02
.byte $D0, $12, $A9, $00, $8D, $69, $03, $AC, $65, $03, $EE, $65, $03, $B9, $F9, $A5
; A620 = 8D0140 -> 8D 01 0A
.byte $8D, $01, $0A, $60, $EE, $69, $03, $60, $A9, $00, $8D, $65, $03, $AD, $61, $03
.byte $F0, $0B, $C9, $01, $F0, $0B, $C9, $02, $D0, $3F, $4C, $69, $A6, $A0, $62, $D0
.byte $02, $A0, $66, $20, $76, $A2, $EE, $61, $03, $60, $20, $C3, $A3, $D0, $A9, $EE
.byte $61, $03, $AD, $61, $03, $C9, $02, $F0, $10, $A0, $3E, $4C, $76, $A2, $A9, $0A
; A66B = 8D0040 -> 8D 00 0A
.byte $A0, $42, $D0, $35, $20, $C3, $A3, $D0, $8F, $A9, $10, $8D, $00, $0A, $A9, $00
.byte $8D, $4A, $03, $20, $BD, $A3, $EE, $07, $03, $60, $A9, $05, $A0, $52, $20, $99
.byte $A6, $A9, $0D, $D0, $34, $20, $C3, $A3, $D0, $EF, $A0, $52, $D0, $36, $AD, $89
.byte $03, $29, $18, $D0, $27, $A9, $07, $A0, $4A, $4C, $6E, $A3, $A9, $08, $A0, $56
.byte $20, $99, $A6, $A9, $06, $D0, $12, $20, $C3, $A3, $D0, $CD, $A0, $56, $D0, $14
.byte $A9, $04, $A0, $5A, $20, $99, $A6, $A9, $00, $8D, $65, $03, $60, $20, $C3, $A3
.byte $D0, $FA, $A0, $5A, $20, $76, $A2, $18, $AD, $65, $03, $6D, $61, $03, $A8, $B9
; A6D2 = 8D0240 -> 8D 02 0A
; A6DB = 8D0040 -> 8D 00 0A
.byte $E6, $A5, $8D, $02, $0A, $AC, $61, $03, $B9, $E0, $A5, $8D, $00, $0A, $D0, $03
.byte $4C, $69, $A6, $EE, $61, $03, $60, $AD, $89, $03, $29, $18, $D0, $F8, $A9, $05
.byte $A0, $46, $4C, $6E, $A3, $A9, $02, $A0, $4E, $20, $6E, $A3, $AD, $50, $A1, $8D


; A700 - bank 4
.byte $61, $03, $60, $20, $C3, $A3, $D0, $DE, $EE, $65, $03, $AD, $65, $03, $C9, $09
.byte $D0, $03, $4C, $69, $A6, $AD, $61, $03, $4A, $4A, $4A, $8D, $69, $03, $AD, $61
; A728 = 8D0240 -> 8D 02 0A
; A72D = 8D0240 -> 8D 03 0A
.byte $03, $18, $ED, $69, $03, $8D, $61, $03, $8D, $02, $0A, $A9, $18, $8D, $03, $0A
.byte $60, $4A, $7E, $4A, $7E, $46, $70, $46, $70, $42, $69, $42, $69, $3E, $63, $3E
.byte $63, $3E, $63, $3E, $63, $3E, $63, $3E, $63, $00, $A9, $0A, $A0, $6E, $20, $6E
.byte $A3, $AD, $70, $A1, $8D, $63, $03, $60, $20, $C3, $A3, $F0, $59, $AD, $63, $03
.byte $E9, $06, $8D, $63, $03, $A5, $EF, $29, $3F, $09, $10, $8D, $67, $03, $AD, $63
; A776 = 8D0A40 -> 8D 0A 0A
.byte $03, $29, $C0, $0D, $67, $03, $8D, $0A, $0A, $60, $A9, $03, $A0, $72, $20, $6E
.byte $A3, $4C, $89, $A7, $20, $C3, $A3, $D0, $38, $AC, $63, $03, $B9, $31, $A7, $F0
; A791 = 8D0A40 -> 8D 0A 0A
; A797 = 8D0B40 -> 8D 0B 0A
.byte $25, $8D, $0A, $0A, $AD, $75, $A1, $8D, $0B, $0A, $EE, $63, $03, $60, $20, $C3
.byte $A3, $F0, $13, $CE, $63, $03, $CE, $63, $03, $CE, $63, $03, $CE, $63, $03, $AD
; A7B2 = 8D0A40 -> 8D 0A 0A
; A7B8 = 8D0840 -> 8D 08 0A
.byte $63, $03, $8D, $0A, $0A, $60, $A9, $00, $8D, $08, $0A, $8D, $4C, $03, $20, $BD
; A7CF = 8D0A40 -> 8D 0A 0A
.byte $A3, $60, $A9, $03, $A0, $6A, $20, $6E, $A3, $A5, $EF, $29, $3F, $09, $60, $8D
.byte $0A, $0A, $8D, $63, $03, $60, $A9, $03, $A0, $76, $20, $6E, $A3, $A5, $EF, $29
.byte $0F, $09, $06, $8D, $6B, $03, $60, $20, $C3, $A3, $D0, $D5, $A5, $EF, $09, $90
; A7F0 = 8D0A40 -> 8D 0A 0A
; A7F6 = 8D0B40 -> 8D 0B 40
.byte $8D, $0A, $0A, $AD, $79, $A1, $8D, $0B, $0A, $EE, $63, $03, $AD, $63, $03, $CD


; A800 - bank 4
.byte $6B, $03, $D0, $BD, $4C, $B6, $A7, $60, $A9, $05, $A0, $7A, $4C, $6E, $A3, $20
.byte $C3, $A3, $F0, $01, $60, $A0, $7A, $20, $7A, $A2, $EE, $63, $03, $AD, $63, $03
.byte $C9, $02, $D0, $F0, $4C, $B6, $A7, $18, $AD, $10, $03, $6D, $12, $03, $8D, $10
.byte $03, $AD, $11, $03, $6D, $13, $03, $8D, $11, $03, $60, $38, $AD, $10, $03, $ED
.byte $12, $03, $8D, $10, $03, $AD, $11, $03, $ED, $13, $03, $8D, $11, $03, $60, $AD
.byte $10, $03, $48, $AD, $11, $03, $48, $A9, $00, $8D, $17, $03, $A2, $10, $2E, $10
.byte $03, $2E, $11, $03, $2E, $17, $03, $AD, $17, $03, $CD, $16, $03, $90, $06, $ED
.byte $16, $03, $8D, $17, $03, $2E, $10, $03, $2E, $11, $03, $CA, $D0, $E6, $AD, $10
.byte $03, $8D, $14, $03, $AD, $11, $03, $8D, $15, $03, $68, $8D, $11, $03, $68, $8D
.byte $10, $03, $60

; MSU-1 check
  JSR $A316
  LDA $E8
  STA $038D
  LDA $0350
  TAY
  LDA $ABAB,Y

  jsr queue_track
  nops 13

  LDA #$01
  STA $0340
  STA $0341
  STA $0342
  STA $0343
  LDA #$00
  STA $0338
  STA $0339
  STA $033A
  STA $033B
  RTS

.byte $A9
.byte $7F, $8D, $44, $03, $8D, $45, $03, $8E, $28, $03, $8C, $29, $03, $60, $AD, $40
.byte $03, $C9, $01, $D0, $03, $8D, $5B, $03, $AD, $41, $03, $C9, $01, $D0, $03, $8D
.byte $5C, $03, $60

; A8F3
  LDA $0307
  BEQ :+
  LDA #$00
  STA $0307
  LDA $0344
  STA NES_APU_P1_LENGTH
  LDA $0300
  STA NES_APU_P1_ENV
  LDA $0301
  STA NES_APU_P1_SWEEP
  LDA $0345
  STA NES_APU_P2_LENGTH
  LDA $0304
  STA NES_APU_P2_ENV
  LDA $0305
  STA NES_APU_P2_SWEEP
: RTS


; A900 - bank 4
.byte $A2, $00, $20, $2C, $A9, $E8, $20, $2C, $A9, $60, $BD, $2E, $03, $F0
.byte $45, $85, $E1, $20, $F3, $A8, $BD, $5D, $03, $C9, $10, $F0, $47, $A0, $00, $C6
.byte $E1, $F0, $04, $C8, $C8, $D0, $F8, $B9, $64, $AC, $85, $E2, $B9, $65, $AC, $85
.byte $E3, $BC, $5B, $03, $B1, $E2, $85, $E0, $C9, $FF, $F0, $1F, $C9, $F0, $F0, $20
.byte $BD, $28, $03, $29, $F0, $05, $E0, $A8, $FE, $5B, $03, $BD, $4A, $03, $D0, $06
.byte $8A, $F0, $04

; a973 sound stuff
  STY NES_APU_P2_TIMER
  RTS
  STY NES_APU_P1_TIMER
  RTS

.byte $BC, $28, $03, $D0, $EB
.byte $A0, $10, $D0, $E7, $A0, $10, $D0, $E0, $BC, $38, $03, $FE, $38, $03, $D0, $14
.byte $8A, $0A, $AA, $FE, $31, $03, $8A, $4A, $AA, $B1, $E6, $85, $E9, $E6, $E7, $A5
.byte $E9, $4C, $A6, $A9, $B1, $E6, $60, $20, $0A, $A3, $60, $20, $22, $A9, $60, $20
.byte $DE, $A8, $A9, $00, $AA, $8D, $47, $03, $F0, $12, $8A, $4A, $AA, $E8, $8A, $C9
.byte $04, $F0, $E8, $AD, $47, $03, $18, $69, $04, $8D, $47, $03, $8A, $0A, $AA, $BD
.byte $30, $03, $85, $E6, $BD, $31, $03, $85, $E7, $BD, $31, $03, $F0, $DC, $8A, $4A
.byte $AA, $DE, $40, $03, $D0, $D7, $20, $88, $A9, $F0, $BC, $A8, $C9, $FF, $F0, $09
.byte $29, $C0, $C9, $C0, $F0, $13, $4C, $21, $AA, $BD, $24, $03, $F0, $1A, $DE, $24


; AA00 - bank 4
.byte $03, $BD, $3C, $03, $9D, $38, $03, $D0, $0F, $98, $29, $3F, $9D, $24, $03, $DE
.byte $24, $03, $BD, $38, $03, $9D, $3C, $03, $4C, $E6, $A9, $4C, $DE, $AA, $4C, $B7
.byte $AA, $98, $29, $B0, $C9, $B0, $D0, $18, $98, $29, $0F, $18, $6D, $2B, $03, $A8
.byte $B9, $86, $AB, $9D, $20, $03, $A8, $8A, $C9, $02, $F0, $E2, $20, $88, $A9, $A8
.byte $8A, $C9, $03, $F0, $D6, $48, $AE, $47, $03, $B9, $FB, $AA, $F0, $0B, $9D, $00
.byte $03, $B9, $FA, $AA, $09, $08, $9D, $01, $03, $A8, $68, $AA, $98, $D0, $0F, $A9
.byte $00, $85, $E0, $8A, $C9, $02, $F0, $0B, $A9, $10, $85, $E0, $D0, $05, $BD, $28
.byte $03, $85, $E0, $8A, $DE, $4A, $03, $DD, $4A, $03, $F0, $35, $FE, $4A, $03, $AC
.byte $47, $03, $8A, $C9, $02, $F0, $05, $BD, $2E, $03, $D0, $05, $A5, $E0

; AA8E - sound stuff
  STA NES_APU_P1_TIMER,Y
  LDA $E0
  STA $035D,X
  LDA $0300,Y
  STA NES_APU_P1_ENV,Y
  LDA $0301,Y
  STA NES_APU_P1_SWEEP,Y
  LDA $0344,X
  STA NES_APU_P1_LENGTH,Y

.byte $BD, $20, $03, $9D, $40, $03, $4C, $BD
.byte $A9, $FE, $4A, $03, $4C, $A8, $AA, $AD, $2D, $03, $29, $0F, $D0, $1A, $AD, $2D
.byte $03, $29, $F0, $D0, $04, $98, $4C, $CD, $AA, $A9, $FF, $D0, $0B, $18, $69, $FF
.byte $0A, $0A, $C9, $3C, $90, $02, $A9, $3C, $8D, $2A, $03, $4C, $3C, $AA, $AD, $88
.byte $03, $29, $FE, $D0, $12, $B9, $00, $A1

;aae8 - sound stuff
  STA NES_APU_NOISE_TIMER
  LDA $A101,Y
  STA NES_APU_NOISE_ENV
  LDA $A102,Y
  STA NES_APU_NOISE_SWEEP

.byte $4C, $A8, $AA, $07, $F0, $00, $00, $06, $AE


; AB00 - bank 4
.byte $06, $4E, $05, $F3, $05, $9E, $05, $4D, $05, $01, $04, $B9, $04, $75, $04, $35
.byte $03, $F8, $03, $BF, $03, $89, $03, $57, $03, $27, $02, $F9, $02, $CF, $02, $A6
.byte $02, $80, $02, $5C, $02, $3A, $02, $1A, $01, $FC, $01, $DF, $01, $C4, $01, $AB
.byte $01, $93, $01, $7C, $01, $67, $01, $52, $01, $3F, $01, $2D, $01, $1C, $01, $0C
.byte $00, $FD, $00, $EE, $00, $E1, $00, $D4, $00, $C8, $00, $BD, $00, $B2, $00, $A8
.byte $00, $9F, $00, $96, $00, $8D, $00, $85, $00, $7E, $00, $76, $00, $70, $00, $69
.byte $00, $63, $00, $5E, $00, $58, $00, $53, $00, $4F, $00, $4A, $00, $46, $00, $42
.byte $00, $3E, $00, $3A, $00, $37, $00, $34, $00, $31, $00, $2E, $00, $2B, $00, $29
.byte $00, $27, $00, $24, $00, $22, $03, $06, $0C, $18, $30, $12, $24, $09, $08, $04
.byte $01, $10, $04, $08, $10, $20, $40, $18, $30, $0C, $0B, $05, $02, $01, $06, $0C
.byte $18, $30, $60, $24, $48, $12, $10, $08, $03, $10, $02, $41, $27, $00, $1A, $34
.byte $0D, $8F, $82, $68, $75, $4E, $5B, $3C, $AC, $30, $AC, $27, $AC, $2A, $AC, $D3
.byte $A4, $FB, $A4, $B2, $A5, $5E, $A5, $04, $A4, $04, $A4, $04, $A4, $04, $A4, $DF
.byte $A4, $07, $A5, $BE, $A5, $87, $A5, $39, $AC, $2D, $AC, $36, $AC, $2D, $AC, $33
.byte $AC, $36, $AC, $36, $AC, $36, $AC, $AD, $4F, $03, $A2, $AB, $D0, $05, $AD, $85
.byte $03, $A2, $A6, $20, $D7, $A3, $20, $0D, $AC, $6C, $EB, $00, $AD, $8D, $03, $F0


; AC00 - bank 4
.byte $0B, $4C, $AF, $A9, $AD, $8D, $03, $09, $F0, $8D, $8D, $03, $60, $A9, $FF, $8D
.byte $50, $03, $A5, $E8, $F0, $06, $EE, $50, $03, $0A, $90, $FA, $60, $AD, $50, $03
.byte $18, $69, $08, $8D, $50, $03, $60, $4C, $3F, $AC, $4C, $4C, $AC, $4C, $5E, $AC
.byte $4C, $52, $AC, $4C, $58, $AC, $4C, $3F, $AC, $4C, $52, $AC, $4C, $52, $AC, $A9
.byte $B4, $AA, $A8, $20, $CF, $A8, $20, $93, $A8, $4C, $AF, $A9, $A2, $F6, $A0, $F8
.byte $D0, $F1, $A2, $F5, $A0, $F6, $D0, $EB, $A2, $B3, $A0, $B1, $D0, $E5, $A2, $93
.byte $A0, $96, $D0, $DF, $6A, $AC, $73, $AC, $7E, $AC, $03, $05, $07, $08, $07, $06
.byte $05, $04, $FF, $01, $01, $02, $02, $03, $03, $04, $04, $05, $05, $FF, $02, $04
.byte $05, $06, $07, $08, $07, $06, $05, $FF, $18, $FF, $F0, $01, $02, $7C, $AD, $70
.byte $AD, $94, $AD, $00, $00, $0C, $FF, $00, $02, $03, $10, $B2, $70, $B1, $8B, $B2
.byte $02, $B3, $18, $FF, $F0, $00, $00, $E7, $B4, $E9, $B4, $04, $B5, $1C, $B5, $0C
.byte $FF, $0A, $00, $00, $09, $B3, $0B, $B3, $72, $B3, $79, $B3, $18, $FF, $00, $03
.byte $01, $E2, $B3, $5E, $B4, $83, $B3, $DC, $B4, $18, $FF, $00, $02, $02, $24, $AD
.byte $3E, $AD, $57, $AD, $6B, $AD, $18, $00, $F0, $01, $01, $98, $B7, $A0, $B8, $CA
.byte $B9, $D5, $BA, $18, $00, $F0, $03, $03, $23, $B5, $21, $B6, $F0, $B6, $7E, $B7
.byte $18, $00, $00, $01, $01, $C7, $AD, $D8, $AD, $E8, $AD, $00, $00, $18, $00, $F0


; AD00 - bank 4
.byte $01, $01, $AA, $AD, $BC, $AD, $B6, $AD, $00, $00, $18, $FF, $00, $02, $03, $7F
.byte $AE, $FB, $AD, $12, $AF, $80, $AF, $00, $FF, $F0, $03, $03, $6E, $B0, $9C, $AF
.byte $E3, $B0, $58, $B1, $B9, $52, $02, $52, $5C, $02, $52, $5C, $02, $64, $B2, $5C
.byte $B9, $5C, $02, $5C, $64, $02, $5C, $6A, $02, $02, $6A, $02, $02, $00, $B9, $54
.byte $02, $54, $5E, $02, $54, $5E, $02, $66, $B2, $5E, $B9, $5E, $02, $5E, $66, $02
.byte $5E, $6C, $02, $02, $6C, $02, $02, $B2, $02, $C2, $B2, $46, $B9, $5E, $02, $5E
.byte $B1, $02, $B0, $5E, $5E, $B9, $5E, $02, $5E, $FF, $00, $B2, $01, $D0, $04, $FF
.byte $D0, $B0, $46, $48, $46, $48, $4C, $4E, $4C, $4E, $FF, $00, $BA, $02, $C2, $B6
.byte $24, $B1, $20, $24, $B3, $26, $B2, $2A, $26, $B4, $24, $B3, $1A, $B2, $1C, $14
.byte $B4, $16, $22, $FF, $C2, $B6, $2E, $B1, $2A, $2E, $B3, $30, $B2, $34, $30, $B4
.byte $2E, $B3, $24, $B2, $26, $1E, $B4, $20, $2C, $FF, $B9, $58, $58, $58, $60, $02
.byte $4E, $B2, $52, $B6, $4A, $00, $B2, $28, $24, $1A, $B4, $2C, $B9, $4E, $4E, $4E
.byte $58, $02, $48, $B2, $40, $B4, $3A, $B2, $54, $B9, $5E, $02, $5E, $B2, $5E, $02
.byte $36, $38, $B1, $36, $02, $B2, $16, $00, $B2, $52, $B9, $5C, $02, $5C, $B2, $5C
.byte $02, $2E, $30, $B1, $2E, $02, $B2, $24, $C2, $B1, $46, $B0, $5E, $5E, $B9, $5E
.byte $02, $5E, $FF, $B2, $24, $30, $B1, $2E, $02, $B2, $16, $B4, $02, $02, $C2, $B9


; AE00 - bank 4
.byte $2C, $2C, $2C, $34, $02, $22, $B2, $2C, $B9, $2C, $34, $3A, $B3, $42, $3E, $B9
.byte $3A, $3A, $3A, $44, $02, $34, $B2, $3A, $B9, $3A, $44, $34, $B3, $48, $4E, $FF
.byte $B9, $44, $02, $44, $B2, $48, $4C, $4E, $B6, $52, $B9, $52, $4A, $52, $B6, $4C
.byte $B2, $02, $B9, $44, $02, $44, $B2, $48, $4C, $4E, $B6, $52, $B9, $52, $4A, $52
.byte $B6, $4C, $B9, $44, $4C, $4E, $B6, $52, $B7, $4E, $B0, $4C, $B3, $4E, $B2, $44
.byte $48, $4C, $B7, $4E, $B0, $4C, $B2, $48, $44, $44, $42, $3E, $42, $B9, $44, $3A
.byte $44, $4C, $44, $4C, $52, $02, $02, $4C, $02, $44, $B2, $4E, $B7, $4C, $B0, $48
.byte $B2, $44, $48, $B4, $44, $44, $44, $B3, $36, $B9, $3A, $36, $3A, $B2, $3E, $E0
.byte $B0, $02, $FF, $C2, $B9, $22, $22, $22, $2C, $02, $1C, $B2, $22, $B9, $22, $2C
.byte $34, $B2, $38, $32, $38, $32, $B9, $34, $34, $34, $3A, $02, $2C, $B2, $34, $B9
.byte $34, $3A, $44, $B2, $40, $B9, $28, $30, $36, $3E, $36, $2C, $26, $2C, $36, $FF
.byte $C2, $B4, $02, $B2, $44, $B7, $32, $B0, $44, $B9, $48, $40, $48, $4A, $44, $4A
.byte $3A, $3A, $3E, $B7, $42, $B0, $3E, $B2, $3A, $02, $FF, $B3, $48, $B2, $4C, $48
.byte $B3, $44, $36, $B2, $44, $B7, $48, $B0, $44, $B2, $3E, $3E, $3E, $3A, $36, $3A
.byte $B3, $3A, $48, $B2, $44, $B9, $3A, $02, $36, $B2, $34, $36, $B9, $26, $2C, $36
.byte $3A, $36, $3A, $B3, $3E, $B9, $22, $2C, $30, $3A, $44, $4E, $B3, $4C, $B2, $36


; AF00 - bank 4
.byte $B9, $34, $36, $3A, $B2, $3E, $42, $44, $B9, $48, $44, $48, $4C, $48, $4C, $B2
.byte $4E, $00, $D4, $B9, $2C, $2C, $2C, $B2, $2C, $FF, $C2, $B9, $44, $02, $44, $B2
.byte $42, $40, $3E, $24, $B9, $24, $24, $24, $B2, $24, $B9, $24, $24, $24, $B2, $2C
.byte $B9, $2C, $2C, $2C, $B2, $2C, $02, $FF, $C2, $B2, $28, $B9, $28, $02, $28, $FF
.byte $C2, $B2, $26, $B9, $26, $02, $26, $FF, $C2, $22, $02, $22, $FF, $C2, $20, $02
.byte $20, $FF, $C2, $1E, $02, $1E, $FF, $C2, $22, $22, $22, $FF, $B2, $2C, $2C, $28
.byte $28, $26, $26, $22, $22, $C2, $B2, $36, $B9, $36, $36, $36, $FF, $C2, $B2, $34
.byte $B9, $34, $34, $34, $FF, $B2, $30, $34, $36, $38, $22, $22, $C6, $B9, $22, $FF
.byte $D0, $B2, $04, $04, $04, $B9, $04, $04, $04, $FF, $C8, $B9, $04, $01, $04, $B2
.byte $07, $FF, $E0, $B2, $04, $04, $07, $B9, $04, $04, $04, $FF, $C4, $B4, $02, $FF
.byte $B6, $5E, $B9, $5E, $5C, $5A, $B4, $58, $5A, $B3, $60, $B5, $5E, $B1, $5A, $B4
.byte $5E, $B6, $2E, $B2, $28, $B4, $2A, $B3, $30, $B5, $2E, $B1, $2A, $B6, $5E, $B9
.byte $5E, $5C, $5A, $B4, $58, $5A, $B3, $60, $B5, $5E, $B1, $5A, $B4, $5E, $46, $BB
.byte $3A, $42, $46, $48, $50, $52, $C2, $B6, $58, $B2, $50, $B6, $46, $B2, $40, $B1
.byte $42, $3A, $42, $48, $52, $48, $52, $5A, $60, $5A, $60, $6A, $B2, $72, $6A, $B4
.byte $68, $B3, $50, $46, $B1, $2E, $30, $38, $3A, $42, $46, $48, $50, $50, $52, $5A


; B000 - bank 4
.byte $5E, $60, $02, $02, $02, $FF, $C2, $B1, $58, $02, $58, $5A, $5E, $02, $58, $02
.byte $58, $5A, $5E, $02, $58, $02, $5E, $02, $5A, $02, $5A, $5E, $60, $02, $5A, $02
.byte $60, $5E, $60, $02, $6A, $02, $60, $02, $FF, $B4, $02, $B6, $02, $B1, $68, $66
.byte $B2, $62, $5E, $58, $50, $B1, $54, $58, $54, $50, $B2, $4A, $46, $50, $50, $B1
.byte $50, $54, $58, $5A, $B2, $5E, $02, $58, $B1, $68, $66, $B2, $62, $5E, $58, $50
.byte $B1, $54, $58, $54, $50, $B2, $4A, $46, $50, $5A, $54, $4E, $B4, $50, $02, $02
.byte $E0, $B1, $38, $02, $FF, $E0, $34, $02, $FF, $E0, $34, $02, $FF, $00, $BA, $02
.byte $E0, $B2, $02, $FF, $B6, $40, $B1, $3C, $38, $B4, $02, $02, $02, $40, $38, $30
.byte $B3, $2A, $B5, $28, $B1, $24, $B4, $28, $02, $BB, $2A, $30, $34, $38, $3E, $42
.byte $C2, $B6, $46, $B2, $40, $B6, $38, $B2, $2E, $B3, $3A, $42, $48, $5A, $40, $46
.byte $B4, $02, $02, $02, $FF, $C2, $B1, $38, $02, $38, $3C, $40, $02, $38, $02, $38
.byte $3C, $40, $02, $38, $02, $40, $02, $3A, $02, $3A, $3E, $42, $02, $3A, $02, $42
.byte $3E, $42, $02, $48, $02, $42, $02, $FF, $CC, $B6, $08, $B2, $02, $FF, $E0, $B1
.byte $34, $02, $FF, $D8, $30, $02, $FF, $C8, $2E, $02, $FF, $D0, $30, $02, $FF, $D0
.byte $2E, $02, $FF, $C8, $B1, $38, $02, $46, $02, $FF, $C4, $38, $02, $46, $02, $38
.byte $02, $46, $02, $38, $02, $46, $02, $38, $02, $46, $02, $3A, $02, $48, $02, $3A


; B100 - bank 4
.byte $02, $48, $02, $3A, $02, $48, $02, $3A, $02, $48, $02, $FF, $C6, $B5, $20, $B1
.byte $2E, $B2, $38, $2E, $B0, $20, $02, $20, $02, $B1, $02, $2E, $B2, $38, $2E, $B5
.byte $22, $B1, $30, $B2, $3A, $30, $B1, $3E, $22, $02, $22, $B2, $3A, $30, $FF, $D8
.byte $B0, $38, $B7, $02, $B0, $46, $B7, $02, $FF, $B4, $30, $30, $B6, $34, $38, $B3
.byte $30, $C4, $B4, $2E, $FF, $28, $28, $B6, $30, $2C, $B3, $28, $C4, $B4, $26, $FF
.byte $22, $22, $2A, $30, $26, $22, $1E, $1C, $CA, $B2, $04, $01, $04, $04, $04, $04
.byte $04, $01, $FF, $E0, $B1, $04, $01, $04, $04, $FF, $FC, $B2, $04, $04, $04, $FF
.byte $C2, $B1, $76, $6C, $02, $66, $02, $6C, $02, $66, $FF, $B1, $44, $46, $48, $4A
.byte $4E, $50, $52, $54, $B0, $5C, $5E, $60, $62, $64, $66, $68, $6A, $6C, $02, $02
.byte $02, $B2, $44, $C2, $B1, $4E, $50, $02, $54, $02, $B0, $62, $54, $62, $54, $62
.byte $54, $5E, $50, $5E, $50, $5E, $50, $5E, $50, $B3, $02, $B0, $46, $38, $46, $38
.byte $B2, $58, $54, $B0, $4E, $46, $4E, $46, $4A, $42, $4A, $42, $4A, $42, $4A, $42
.byte $B3, $02, $FF, $B1, $58, $58, $54, $58, $02, $5C, $02, $02, $5E, $02, $02, $02
.byte $54, $02, $02, $02, $C3, $B0, $58, $38, $FF, $C3, $5E, $58, $FF, $C2, $68, $5E
.byte $FF, $C4, $66, $5E, $FF, $C4, $54, $4E, $FF, $B1, $58, $58, $54, $58, $02, $5C
.byte $02, $02, $5E, $02, $02, $02, $B3, $66, $B6, $5E, $B2, $02, $B4, $54, $B1, $5E


; B200 - bank 4
.byte $5E, $5E, $5E, $02, $5E, $02, $5E, $5E, $02, $02, $02, $02, $02, $02, $02, $00
.byte $C2, $B1, $66, $62, $02, $54, $02, $62, $02, $5E, $FF, $B1, $02, $02, $02, $02
.byte $02, $02, $02, $02, $B0, $4A, $02, $02, $02, $54, $02, $02, $02, $62, $02, $02
.byte $02, $B2, $24, $C2, $B2, $02, $3C, $02, $3C, $02, $40, $02, $44, $02, $46, $02
.byte $46, $02, $38, $02, $38, $FF, $B1, $46, $46, $46, $46, $02, $4A, $02, $02, $4E
.byte $02, $02, $02, $46, $02, $02, $02, $B2, $02, $58, $02, $58, $02, $4E, $02, $4E
.byte $B1, $46, $46, $46, $46, $02, $4A, $02, $02, $4E, $02, $02, $02, $5E, $54, $4E
.byte $46, $C4, $B1, $3C, $40, $FF, $C4, $46, $4A, $FF, $B1, $58, $58, $58, $58, $02
.byte $58, $02, $58, $58, $02, $02, $02, $02, $02, $02, $02, $B4, $2E, $2A, $B1, $6C
.byte $70, $72, $74, $76, $7A, $7C, $7E, $B0, $6C, $70, $72, $6C, $76, $78, $7A, $7C
.byte $84, $02, $02, $02, $B2, $24, $C2, $B2, $2E, $66, $1E, $5E, $1A, $68, $24, $68
.byte $20, $68, $1E, $6C, $2A, $62, $24, $5C, $FF, $B1, $20, $20, $1E, $20, $02, $24
.byte $02, $02, $28, $02, $02, $02, $1E, $02, $02, $02, $B2, $20, $5E, $20, $5E, $2E
.byte $54, $2E, $54, $B1, $20, $20, $1E, $20, $02, $24, $02, $02, $28, $02, $02, $02
.byte $2A, $2A, $2A, $2A, $C2, $B2, $20, $B1, $38, $38, $FF, $C2, $B2, $1E, $B1, $36
.byte $36, $FF, $24, $24, $24, $24, $02, $24, $02, $24, $24, $02, $02, $02, $02, $02


; B300 - bank 4
.byte $02, $02, $F0, $B2, $01, $B1, $04, $04, $FF, $B8, $02, $C4, $B4, $02, $FF, $C8
.byte $B1, $3C, $3E, $FF, $C8, $44, $3E, $FF, $B4, $3C, $02, $02, $02, $C8, $B1, $3C
.byte $3E, $FF, $C8, $44, $3E, $FF, $B4, $3C, $02, $02, $02, $B6, $30, $B0, $36, $38
.byte $3A, $3C, $B3, $3E, $B5, $38, $B0, $38, $3A, $B4, $3C, $02, $C2, $02, $FF, $B6
.byte $30, $B0, $36, $38, $3A, $3C, $B3, $3E, $B5, $38, $B0, $38, $3A, $B4, $3C, $02
.byte $C2, $02, $FF, $C2, $B4, $46, $B5, $44, $B0, $42, $40, $B3, $3E, $B4, $3C, $02
.byte $FF, $B0, $38, $3A, $B1, $3C, $3E, $02, $B5, $3C, $B0, $3A, $38, $B3, $34, $38
.byte $30, $00, $E8, $B2, $2E, $3C, $2E, $3C, $FF, $E0, $B3, $04, $04, $B2, $04, $04
.byte $B3, $04, $FF, $B6, $2A, $B9, $20, $22, $24, $B6, $26, $B9, $22, $20, $1C, $B6
.byte $18, $B9, $18, $18, $18, $16, $02, $16, $16, $16, $16, $20, $20, $20, $20, $02
.byte $20, $C2, $B2, $2A, $2A, $2A, $2A, $26, $26, $2A, $26, $24, $24, $24, $24, $20
.byte $20, $20, $20, $1C, $1C, $1C, $1C, $1A, $1A, $1A, $1A, $16, $1A, $1C, $1E, $20
.byte $20, $B9, $20, $20, $20, $20, $20, $20, $FF, $C4, $B2, $22, $FF, $C4, $26, $FF
.byte $C4, $2C, $FF, $C4, $2A, $FF, $C4, $30, $FF, $C4, $1C, $FF, $C4, $22, $FF, $C4
.byte $20, $FF, $C4, $B4, $02, $FF, $C2, $B9, $38, $38, $38, $B7, $42, $B0, $32, $B2
.byte $38, $B9, $32, $34, $38, $B6, $34, $B9, $32, $34, $38, $B3, $2A, $34, $32, $B2


; B400 - bank 4
.byte $34, $38, $B6, $24, $B9, $3C, $2A, $3C, $B6, $38, $B9, $38, $2A, $38, $B6, $34
.byte $B9, $34, $2A, $34, $B2, $3C, $38, $34, $2E, $FF, $B2, $42, $B9, $30, $3A, $42
.byte $B2, $50, $B7, $4C, $B0, $48, $B2, $3A, $B9, $3A, $38, $36, $B3, $34, $B9, $3A
.byte $3E, $42, $42, $44, $48, $B2, $3A, $B9, $34, $3A, $44, $B5, $38, $B1, $44, $B9
.byte $42, $3E, $3A, $38, $34, $32, $B3, $26, $B2, $34, $B7, $30, $B0, $26, $B2, $38
.byte $B9, $38, $38, $3E, $B3, $3C, $B3, $3E, $30, $B2, $34, $28, $24, $28, $C2, $B9
.byte $42, $42, $42, $B7, $4A, $B0, $38, $B3, $42, $FF, $B9, $42, $42, $42, $B7, $48
.byte $B0, $38, $B3, $42, $B2, $42, $36, $40, $34, $C2, $B9, $42, $42, $42, $B7, $4A
.byte $B0, $38, $B3, $42, $B9, $42, $42, $42, $B7, $4A, $B0, $38, $B3, $42, $B2, $4C
.byte $4A, $46, $42, $B9, $42, $42, $42, $B7, $4A, $B0, $38, $B3, $42, $B9, $42, $42
.byte $42, $B7, $4A, $B0, $38, $B3, $42, $B9, $42, $42, $42, $B7, $4A, $B0, $38, $B3
.byte $42, $B2, $46, $42, $40, $3C, $42, $40, $3C, $40, $FF, $B6, $48, $B9, $3A, $42
.byte $44, $B4, $46, $B6, $4C, $B9, $3A, $44, $4C, $B4, $4A, $B6, $50, $B7, $48, $B0
.byte $3E, $B4, $42, $B3, $48, $42, $B2, $40, $38, $34, $2E, $00, $E0, $B2, $04, $B9
.byte $04, $04, $04, $B2, $04, $04, $FF, $B8, $02, $F0, $B0, $0C, $12, $0C, $12, $18
.byte $12, $18, $12, $1E, $18, $1E, $18, $1C, $16, $1C, $16, $10, $16, $10, $16, $0A


; B500 - bank 4
.byte $10, $0A, $10, $FF, $B3, $24, $2A, $28, $26, $B2, $24, $30, $3A, $46, $22, $2E
.byte $38, $44, $B3, $2E, $3A, $38, $2C, $2A, $36, $34, $28, $00, $F0, $B1, $04, $04
.byte $B2, $07, $FF, $B9, $7C, $72, $7C, $84, $7C, $84, $8A, $02, $02, $84, $02, $7C
.byte $86, $02, $02, $84, $02, $7C, $B2, $76, $7A, $B9, $7C, $72, $7C, $84, $7C, $84
.byte $8A, $02, $02, $8A, $02, $7C, $B2, $76, $7A, $7C, $80, $F0, $B9, $72, $FF, $B2
.byte $1C, $02, $02, $02, $42, $B9, $42, $02, $42, $B2, $3E, $46, $1C, $02, $02, $02
.byte $3E, $42, $44, $44, $C4, $B3, $4C, $FF, $B4, $4C, $02, $C2, $B9, $5A, $42, $4A
.byte $50, $4A, $50, $B2, $5A, $50, $B9, $5A, $5A, $02, $50, $02, $4A, $B2, $50, $4A
.byte $B9, $56, $3E, $46, $4C, $46, $4C, $B2, $56, $4C, $46, $B9, $4A, $02, $4C, $B2
.byte $56, $4C, $FF, $C2, $B9, $76, $68, $6E, $64, $68, $5E, $4C, $56, $5E, $50, $56
.byte $4C, $FF, $C2, $6E, $60, $66, $5A, $60, $56, $5A, $4E, $56, $48, $4E, $42, $FF
.byte $C2, $B9, $3C, $3C, $3C, $42, $02, $34, $B2, $3C, $02, $FF, $B9, $40, $40, $40
.byte $46, $02, $34, $B2, $40, $02, $40, $3E, $3C, $3A, $B2, $48, $B9, $46, $02, $42
.byte $B2, $46, $42, $48, $4C, $50, $54, $50, $B9, $4C, $02, $48, $B2, $4C, $B9, $48
.byte $02, $46, $B2, $48, $46, $B9, $48, $4A, $4C, $B2, $4E, $C4, $B9, $76, $5E, $6E
.byte $5E, $64, $5E, $5E, $46, $56, $46, $4C, $46, $6C, $60, $66, $60, $66, $72, $54


; B600 - bank 4
.byte $48, $4E, $48, $4E, $5A, $FF, $C2, $34, $3E, $46, $56, $4C, $46, $FF, $C2, $3A
.byte $42, $48, $4C, $48, $44, $FF, $C2, $3E, $48, $4C, $50, $4C, $48, $FF, $B2, $2E
.byte $00, $BC, $02, $B4, $02, $02, $B9, $6C, $64, $6C, $72, $6C, $72, $7C, $02, $02
.byte $72, $02, $6C, $6E, $64, $6E, $72, $6E, $72, $74, $6E, $74, $74, $6E, $74, $C4
.byte $6E, $6E, $6E, $6C, $6C, $6C, $68, $68, $68, $6C, $6C, $6C, $FF, $B9, $4C, $42
.byte $4C, $54, $4C, $54, $5A, $02, $02, $54, $02, $4C, $B2, $56, $B9, $54, $02, $50
.byte $B2, $4C, $50, $B9, $42, $38, $5A, $4A, $42, $4A, $50, $02, $02, $4A, $02, $42
.byte $B2, $46, $4A, $50, $54, $B9, $34, $3C, $42, $34, $42, $3C, $3A, $42, $48, $34
.byte $48, $42, $3E, $46, $34, $46, $3E, $38, $36, $3E, $42, $44, $42, $3E, $B4, $3C
.byte $04, $C2, $B4, $32, $B2, $20, $2A, $B2, $32, $34, $B4, $2E, $B2, $3E, $B9, $42
.byte $02, $46, $B2, $4C, $46, $FF, $B4, $2E, $B3, $02, $B2, $2E, $30, $B4, $2A, $B3
.byte $02, $B2, $26, $1E, $B4, $34, $B3, $02, $B2, $2E, $3C, $B4, $38, $B3, $02, $2A
.byte $B4, $26, $B2, $20, $24, $26, $2A, $B4, $26, $B3, $26, $2A, $C2, $B3, $26, $B2
.byte $16, $1C, $B3, $1E, $B2, $24, $2A, $FF, $B3, $2E, $B2, $26, $2E, $2A, $2E, $30
.byte $2A, $B3, $2E, $B2, $26, $2E, $2A, $36, $3C, $42, $C3, $B4, $3E, $FF, $B4, $0E
.byte $C4, $B4, $02, $FF, $7C, $78, $76, $74, $B2, $1C, $02, $02, $02, $26, $24, $20


; B700 - bank 4
.byte $2A, $1C, $02, $02, $02, $B9, $3E, $02, $3E, $B2, $26, $B9, $44, $3E, $34, $B2
.byte $2C, $B2, $1C, $B9, $02, $02, $1C, $B2, $22, $B9, $02, $02, $22, $B2, $20, $B9
.byte $02, $02, $20, $B2, $1E, $B9, $02, $02, $1E, $D4, $B2, $1C, $B9, $1C, $02, $B0
.byte $1C, $BC, $02, $FF, $C8, $B2, $18, $B9, $18, $02, $B0, $18, $BC, $02, $FF, $C4
.byte $B2, $2E, $B9, $2E, $02, $B0, $2E, $BC, $02, $FF, $C4, $B2, $20, $B9, $20, $02
.byte $B0, $20, $BC, $02, $FF, $C4, $B2, $2A, $B9, $2A, $02, $B0, $2A, $BC, $02, $FF
.byte $C4, $B2, $1C, $B9, $1C, $02, $B0, $1C, $BC, $02, $FF, $D0, $B2, $26, $B9, $3E
.byte $02, $34, $FF, $E0, $B2, $26, $B9, $3E, $02, $B0, $26, $BC, $02, $FF, $CA, $B2
.byte $04, $B9, $01, $01, $04, $B3, $04, $FF, $F0, $B2, $04, $B9, $04, $04, $04, $FF
.byte $F0, $B2, $04, $B9, $04, $04, $04, $FF, $CC, $B1, $72, $76, $FF, $CC, $B9, $72
.byte $FF, $02, $02, $02, $60, $60, $60, $5E, $5E, $5E, $5C, $5C, $5C, $CC, $72, $FF
.byte $02, $02, $02, $60, $60, $60, $5E, $5E, $5E, $5C, $5C, $5C, $C4, $54, $54, $54
.byte $4C, $4C, $4C, $50, $50, $50, $56, $56, $56, $FF, $CC, $54, $56, $FF, $B4, $54
.byte $02, $B4, $3C, $3A, $3C, $B6, $3E, $B9, $38, $3E, $48, $B6, $3A, $B9, $3A, $44
.byte $4C, $B3, $48, $3E, $3A, $40, $B6, $46, $B9, $2E, $34, $3E, $C2, $B6, $30, $B9
.byte $30, $02, $30, $B4, $2E, $FF, $C2, $B3, $30, $B2, $2E, $B9, $26, $2E, $34, $FF


; B800 - bank 4
.byte $CC, $B9, $30, $2E, $FF, $C2, $B9, $42, $02, $42, $B2, $42, $42, $42, $B3, $42
.byte $B2, $5A, $B7, $5A, $B0, $5E, $B4, $50, $B2, $46, $4A, $4C, $44, $FF, $C2, $B4
.byte $34, $38, $3C, $B3, $3E, $B2, $34, $38, $FF, $B3, $3C, $B2, $42, $4C, $B3, $46
.byte $B2, $4A, $46, $B3, $3C, $B2, $42, $4C, $B3, $50, $B2, $4A, $B9, $4A, $4C, $50
.byte $B2, $4C, $54, $5A, $B9, $4C, $54, $5A, $B2, $58, $54, $50, $4C, $32, $34, $38
.byte $34, $46, $3E, $4A, $44, $C2, $B9, $72, $68, $6A, $60, $64, $5A, $60, $52, $5A
.byte $4C, $50, $48, $7A, $6C, $72, $68, $6C, $62, $68, $5E, $62, $54, $5A, $50, $FF
.byte $72, $68, $6A, $60, $64, $5A, $60, $52, $5A, $4C, $50, $48, $2A, $2A, $2A, $34
.byte $02, $24, $34, $34, $34, $3C, $02, $2A, $3C, $3C, $3C, $42, $02, $3C, $B2, $4C
.byte $02, $4C, $02, $4C, $02, $B4, $1C, $B2, $02, $B1, $12, $12, $12, $B2, $12, $00
.byte $CC, $B1, $6C, $6E, $FF, $C2, $B9, $02, $02, $02, $6E, $6E, $6E, $6C, $6C, $6C
.byte $68, $68, $68, $64, $64, $64, $68, $68, $68, $6C, $6C, $6C, $6E, $6E, $6E, $FF
.byte $C4, $42, $42, $42, $42, $42, $42, $44, $44, $44, $44, $44, $44, $FF, $CC, $42
.byte $44, $FF, $B4, $42, $2A, $B9, $1C, $1C, $1C, $24, $02, $12, $B2, $1C, $B9, $1C
.byte $24, $2A, $B4, $28, $B9, $24, $24, $24, $2A, $02, $1C, $B2, $24, $B9, $24, $2A
.byte $34, $B4, $30, $B9, $2C, $2C, $2C, $34, $02, $22, $B2, $2C, $B9, $2C, $34, $3A


; B900 - bank 4
.byte $B4, $38, $B9, $32, $32, $32, $3A, $02, $28, $B2, $32, $B9, $32, $3A, $40, $B4
.byte $3E, $C2, $B6, $40, $B9, $40, $02, $40, $B4, $3E, $FF, $C2, $B3, $40, $B2, $3E
.byte $B9, $2E, $34, $3E, $FF, $CC, $B9, $40, $3E, $FF, $C2, $B9, $4C, $02, $4C, $B2
.byte $50, $54, $56, $B3, $5A, $B2, $64, $B7, $62, $B0, $64, $B3, $5A, $B7, $02, $B0
.byte $56, $B7, $54, $B0, $4C, $B3, $4C, $50, $FF, $C2, $B6, $42, $B7, $4C, $B0, $42
.byte $B4, $46, $B6, $4C, $B7, $42, $B0, $4C, $B3, $4C, $B2, $3E, $3E, $FF, $B9, $2A
.byte $2A, $2A, $34, $02, $24, $B2, $2A, $B9, $2A, $34, $3C, $B4, $38, $B9, $34, $34
.byte $34, $3C, $02, $2A, $B2, $34, $B9, $34, $3C, $42, $B4, $3E, $B9, $3C, $3C, $3C
.byte $42, $02, $34, $B2, $3C, $B9, $3C, $42, $4C, $B3, $46, $B2, $4A, $46, $B3, $42
.byte $B2, $3E, $3C, $B3, $4C, $50, $B4, $4C, $B3, $38, $B2, $3C, $42, $B4, $34, $B3
.byte $38, $B2, $42, $4C, $B4, $48, $B9, $1C, $1C, $1C, $24, $02, $2A, $24, $24, $24
.byte $2A, $02, $1C, $2A, $2A, $2A, $34, $02, $2A, $B2, $3C, $02, $3C, $02, $3C, $02
.byte $B4, $2A, $B2, $02, $B1, $04, $04, $04, $B2, $04, $C7, $B4, $02, $FF, $B2, $42
.byte $34, $38, $B7, $3C, $B0, $3E, $B2, $42, $4C, $50, $B7, $54, $B0, $56, $C2, $B2
.byte $5A, $64, $68, $B7, $6C, $B0, $6E, $FF, $B4, $72, $1C, $1C, $1C, $E0, $B2, $1C
.byte $B9, $34, $02, $B0, $1C, $BC, $02, $FF, $C2, $B2, $34, $32, $2E, $2A, $B4, $26


; BA00 - bank 4
.byte $24, $2A, $FF, $C2, $B1, $3C, $02, $3C, $02, $3C, $02, $B0, $3C, $BC, $02, $B0
.byte $3C, $BC, $02, $B0, $3C, $BC, $02, $B1, $3E, $02, $3E, $02, $3E, $02, $B0, $3E
.byte $BC, $02, $B0, $3E, $BC, $02, $B0, $3E, $BC, $02, $B1, $42, $02, $42, $02, $42
.byte $02, $B0, $42, $BC, $02, $B0, $42, $BC, $02, $B0, $42, $BC, $02, $B1, $48, $02
.byte $B9, $48, $30, $48, $B1, $46, $02, $44, $02, $FF, $C2, $B2, $24, $B9, $24, $02
.byte $B0, $24, $BC, $02, $FF, $C2, $B2, $26, $B9, $26, $02, $B0, $26, $BC, $02, $FF
.byte $C2, $B2, $2A, $B9, $2A, $02, $B0, $2A, $BC, $02, $FF, $C2, $B2, $2C, $B9, $2C
.byte $02, $B0, $2C, $BC, $02, $FF, $B2, $2E, $B9, $2E, $02, $2E, $B2, $2E, $B9, $2E
.byte $3C, $2E, $B2, $20, $34, $32, $2E, $C4, $B7, $2A, $B0, $02, $B9, $2A, $02, $B0
.byte $2A, $BC, $02, $FF, $C2, $B2, $30, $B9, $18, $02, $22, $FF, $C2, $B2, $34, $B9
.byte $1C, $02, $2A, $FF, $C2, $B2, $30, $B9, $18, $02, $22, $FF, $C2, $B2, $34, $B9
.byte $1C, $02, $2A, $FF, $C2, $B2, $30, $B9, $18, $02, $22, $FF, $D2, $B0, $1C, $BC
.byte $02, $FF, $B2, $1C, $02, $1C, $02, $1C, $02, $B4, $1C, $B2, $02, $1C, $02, $1C
.byte $02, $1C, $02, $B3, $1C, $C3, $B4, $01, $FF, $F0, $B2, $04, $FF, $DC, $B2, $04
.byte $B9, $04, $04, $04, $FF, $D8, $04, $FF, $D0, $B3, $04, $FF, $C7, $B2, $04, $04
.byte $04, $B9, $04, $04, $04, $FF, $CC, $B9, $04, $FF, $D0, $B9, $04, $01, $04, $B2


; BB00 - bank 4
.byte $07, $FF, $CA, $B9, $04, $04, $04, $B2, $04, $FF, $C3, $B9, $04, $04, $04, $07
.byte $01, $07, $FF, $C3, $B2, $07, $01, $FF, $D0, $B0, $04, $FF, $B2, $01, $C4, $B1
.byte $04, $FF, $B4, $01, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
.byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
.byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
.byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
.byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
.byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
.byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
.byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
.byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
.byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
.byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
.byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
.byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
.byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $04, $08, $01, $40, $00, $20, $00


; BC00 - bank 4
do_last_100_bytes_of_ending_graphics:
    : LDA $8CF1,X
    STA VMDATAL
    INX
    BNE :-
    JSR load_0x40_attributes_from_ram_for_ending
    RTS

load_0x40_attributes_from_ram_for_ending:
  ; 20 at a time
  LDX #$00
  LDY #$00
  LDA #$C0
: STA ATTR_NES_VM_ADDR_LB
  LDA #$23
  STA ATTR_NES_VM_ADDR_HB
  LDA #$20
  STA ATTR_NES_VM_COUNT

  ; attributes start at $8CB1
: LDA $8DB1, Y
  STA ATTR_NES_VM_ATTR_START, X
  INY
  INX
  CPX #$20
  BNE :-

  LDA #$00
  STA ATTR_NES_VM_ATTR_START, X
  LDA #$01
  STA ATTR_NES_HAS_VALUES
  PHY
  jslb convert_nes_attributes_and_immediately_dma_them, $a0
  LDA #$A5
  PHA
  PLB
  PLY
  LDA #$E0
  LDX #$00
  CPY #$40
  BNE:--  

  LDA #$A5
  PHA
  PLB

  RTS  

local_msu_check:
  jslb msu_check, $b2
  rts

local_mute_nsf:
  jslb mute_nsf, $b2
  rts

queue_track:

  .if ENABLE_MSU > 0
  
    ; msu_check returns NSF_STOP if we will play MSU for this track
    PHA
    jsr local_msu_check
    CMP #$EE
    BNE fallback
    jsr local_mute_nsf
    PLA
    rts

fallback:
    PLA ; get the original value back
    TAY
    LDX #$00
  : LDA $AC88,Y
    STA $032B,X
    INY
    INX
    TXA
    CMP #$0D
    BNE :-
    rts

  .else
    ; non msu version
    TAY
    LDX #$00
  : LDA $AC88,Y
    STA $032B,X
    INY
    INX
    TXA
    CMP #$0D
    BNE :-
    rts
    
    nops 100 ; not right but needs to be adjusted down
    
  .endif


repeat $FF, 10
repeat $FF, 64
repeat $FF, 64

; BD00 - bank 4
.byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
.byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
.byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
.byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
.byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
.byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
.byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
.byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
.byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
.byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
.byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
.byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
.byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
.byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
.byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
.byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00


; BE00 - bank 4
.byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
.byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
.byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
.byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
.byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
.byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
.byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
.byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
.byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
.byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
.byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
.byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
.byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
.byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
.byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
.byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF


; BF00 - bank 4
.byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
.byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
.byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
.byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
.byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
.byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
.byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
.byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
.byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
.byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
.byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
.byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
.byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
.byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
.byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
.byte $00, $00, $00, $00, $00, $00, $00, $00, $48, $82, $23, $64, $00, $08, $00, $00

.segment "PRGA5C"
; now we include the fixed bank
fixeda5:
.include "bank7.asm"
fixeda5_end: