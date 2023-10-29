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
    LDA PPU_MASK_STATE
    AND #$10
    BEQ :+
    
    LDA #$11
    STA TM
    BRA :++
 :  STZ TM

 :  JSL setup_hdma    
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