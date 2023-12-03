NONE	=	$00;	empty
SNAKES	=	$02;	SHEMUN
GROUND	=	$03;	Ground enemy
ROKMAN	=	$04;	Rocks
FROGS	=	$05;	Frogs
THIEVES	=	$07;	Pluton (thief), flying thieves in w3
FLYERS	=	$08;	Flying mouths, monoeyes, and metroids
SNOWMAN	=	$09;	Snowman
RISERS	=	$0A;	Rising faces, commyloose, and octos
COLLIN	=	$0B;	Guards w/3 flys
KEEPAH	=   $0C;	Ridley (this messes up some stuff, and shouldn't be used =/)
REAPER	=   $0D;	reaper

.byte $00

; 32 bytes per world
ENEMY_TABLE:
; World 1 Table 1
.byte FROGS, FROGS, FROGS, FROGS, FROGS
.byte FLYERS, FLYERS, FLYERS, FLYERS, FLYERS, FLYERS
.byte RISERS, RISERS, RISERS, RISERS, RISERS

; World 1 Table 2
.byte REAPER, REAPER, REAPER, REAPER
.byte SNAKES, SNAKES, SNAKES, SNAKES, SNAKES
.byte GROUND, GROUND, GROUND, GROUND
.byte NONE, NONE, NONE

; World 2 Table 1
ENEMY_TABLE_W2:
.byte NONE, NONE
.byte ROKMAN, ROKMAN, ROKMAN, ROKMAN
.byte FROGS, FROGS
.byte THIEVES
.byte FLYERS, FLYERS, FLYERS, FLYERS
.byte RISERS, RISERS, RISERS

; World 2 Table 2
.byte NONE, NONE, NONE, NONE
.byte SNAKES, SNAKES, SNAKES, SNAKES
.byte GROUND, GROUND, GROUND, GROUND
.byte SNOWMAN, SNOWMAN, SNOWMAN, SNOWMAN

; World 3 Table 1
ENEMY_TABLE_W3:
.byte COLLIN, COLLIN, COLLIN, COLLIN
.byte NONE, NONE
.byte THIEVES, THIEVES
.byte FLYERS, FLYERS, FLYERS, FLYERS
.byte RISERS, RISERS, RISERS, RISERS

; 16 spots for table 2, can be NONE, SHEMUN, GIRIN, REAPER, or SNOWMAN
.byte REAPER, REAPER
.byte SNAKES, SNAKES, SNAKES, SNAKES, SNAKES, SNAKES
.byte GROUND, GROUND, GROUND, GROUND
.byte NONE, NONE, NONE, NONE