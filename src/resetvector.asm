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

    JSL $A08000
    JML $A1C866
_rti:
    rti