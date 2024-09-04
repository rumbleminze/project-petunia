; enemies
ENEMY_TOTEM     =     $04
ENEMY_MOILA     =     $06
ENEMY_SYREN     =     $08
ENEMY_DAPHNE    =     $0A
ENEMY_ZUREE     =     $07
ENEMY_ERINUS    =     $09


W4_SCREENS:
.byte $ee, $ba
.byte $1e, $bb
.byte $51, $bb
.byte $51, $bb
.byte $78, $bb
.byte $78, $bb
.byte $ab, $bb
.byte $7c, $ba
.byte $af, $ba
.byte $ff, $ff ; End of Level room

W4_ENEMIES:
.byte ENEMY_TOTEM, ENEMY_TOTEM, ENEMY_TOTEM, ENEMY_TOTEM
.byte ENEMY_MOILA, ENEMY_MOILA, ENEMY_MOILA, ENEMY_MOILA 
.byte ENEMY_SYREN, ENEMY_SYREN, ENEMY_SYREN, ENEMY_SYREN  
.byte ENEMY_DAPHNE, ENEMY_DAPHNE
.byte ENEMY_ZUREE, ENEMY_ZUREE
