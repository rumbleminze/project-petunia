intro_screen_data:
.byte $C8, $20, $E7, $12, $01, $09, $08, $06, $12                       ; (c) 1986 
.byte $23, $38, $3d, $43, $34, $3d, $33, $3e                         ; Nintendo
.byte $ff                                                               ; 

.byte $A3, $22, $25, $3e, $41, $43, $34, $33, $12                       ; Ported 
.byte $31, $48, $12                                                     ; by 
.byte $27, $44, $3c, $31, $3b, $34, $3c, $38, $3d, $49, $34, $12        ; Rumbleminze, 
.byte $02, $00, $02, $04, $ff                                           ; 2023

.byte $05, $23, $02, $16, $00, $03, $12                                 ; 2A03
.byte $28, $3e, $44, $3d, $33, $12                                      ; SOUND 
.byte $1a, $3c, $44, $3b, $30, $43, $3e, $41, $12                       ; EMULATOR
.byte $31, $48, $12, $FF                                                ; BY

.byte $4C, $23, $22, $34, $3c, $31, $3b, $34, $41, $42, $ff             ; MEMBLERS

.byte $7B, $23, $41, $34, $45, $0f, $1A, $ff ; Version (REV-E)
.byte $ff, $ff

write_intro_palette:
    STZ CGADD
    LDA #$00
    STA CGDATA
    STA CGDATA

    LDA #$FF
    STA CGDATA
    STA CGDATA
    
    STA CGDATA
    STA CGDATA
    
    STA CGDATA
    STA CGDATA
    RTS

write_intro_tiles:
    LDY #$00

next_line:
    ; get starting address
    LDA intro_screen_data, Y
    CMP #$FF
    BEQ exit_intro_write

    PHA
    INY    
    LDA intro_screen_data, Y
    STA VMADDH
    PLA
    STA VMADDL
    INY

next_tile:
    LDA intro_screen_data, Y
    INY

    CMP #$FF
    BEQ next_line

    STA VMDATAL
    BRA next_tile

exit_intro_write:
    RTS

do_intro:
    LDA VMAIN_STATE
    AND #$0F
    STA VMAIN

    JSR clearvm_to_12
    JSR write_intro_palette
    JSR write_intro_tiles
    LDA #$0F
    STA INIDISP
    LDX #$FF

  : LDA RDNMI
  : LDA RDNMI
    AND #$80
    BEQ :-
    DEX
    BNE :--

    LDA INIDISP_STATE
    STA INIDISP

    RTS