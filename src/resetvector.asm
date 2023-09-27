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
    JSL snes_nmi
    JML $A1C866
    setAXY16
    PLY
    PLX
    PLA
    setAXY8
_rti:
    rti