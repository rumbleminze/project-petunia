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
    REP #$30
    PHA
    PHX
    PHY
    SEP #$30
    JML $A1C866
_rti:
    rti