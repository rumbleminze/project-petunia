start:
SEI
CLC
XCE

REP #$10
LDX #$01FF
TXS
LDA #$A0
PHA
PLB
JML $A08000

nmi:
    php
    setAXY16
    PHA
    PHX
    PHY

    setAXY8 
    STZ RESUABLE_CALC_BYTE
    ; we only care about bits 10 (sprites and 08 bg)
    LDA PPU_MASK_STATE
    AND #$10
    BEQ :+
    STA RESUABLE_CALC_BYTE
:   LDA PPU_MASK_STATE
    AND #$08
    BEQ :+
    LDA #$01
    ORA RESUABLE_CALC_BYTE
    STA RESUABLE_CALC_BYTE
:   LDA RESUABLE_CALC_BYTE
    STA TM


    JSL setup_hdma    
    LDA #$7E
    STA A1B1
    LDA #$09
    STA A1T1H
    STZ A1T1L
    LDA #$0D
    STA BBAD1
    LDA #$03
    STA DMAP1

    LDA #$02
    STA HDMAEN

    JSL snes_nmi
    
    JML $A1C866
_rti:
    rti