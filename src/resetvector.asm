start:
SEI
CLC
XCE

REP #$10
LDX #$01FF
TXS
JML init_routine

nmi:
    php
    setAXY16
    PHA
    PHX
    PHY

    setAXY8 
    LDX VOFS_LB
    LDA $A0A080,X
    STA $0900
    LDA $A0A170,X
    STA $0903
    LDA $A0A260,X
    STA $0905
    LDA $A0A350,X
    STA $0908
    LDA $A0A440,X
    STA $090A
    LDA $A0A520,X
    STA $090D
    LDA HOFS_LB
    STA $0901
    STA $0906
    LDA PPU_CONTROL_STATE
    STA $0902
    STA $0907
    STA $090C
    LDX PPU_CONTROL_STATE
    LDA $A0A610,X
    STA $0904
    STA $0909
    STA $090E
    STZ $090B
    STZ $090F
    LDA #$7E
    STA A1B1
    LDA #$09
    STA A1T1H
    STZ A1T1L
    LDA #$0D
    STA BBAD1
    LDA #$03
    STA DMAP1

    LDA PAUSE_HDMA
    BEQ :+
    LDA #$00
    BRA :++
:   LDA #$02
:   STA HDMAEN

    JSL snes_nmi
    JML $A1C866
_rti:
    rti