.p816
.smart

.include "macros.inc"
.include "registers.inc"
.include "vars.inc"
.include "2a03_variables.inc"
.include "2a03_emu_upload.asm"
.include "hiromheader.asm"

.segment "CODE"
.include "resetvector.asm"

.segment "RO_SPACE"
.include "2a03_emulator_first_8000.asm"
.include "2a03_emulator_second_8000.asm"

.include "bank-snes.asm"
.include "bank0.asm"
.include "bank1.asm"
.include "bank2.asm"
.include "bank3.asm"
.include "bank4.asm"
.include "bank5.asm"
.include "bank6.asm"
.include "randomizer.asm"

.include "base_tiles.asm"
.include "title_screen_tiles.asm"
.include "level_specific_tiles.asm"
.include "backgrounds.asm"


.if ENABLE_MSU > 0
     .include "msu.asm"
.endif
.include "background-w1.asm"
.include "background-lvl-1-1-tiles.asm"
.include "background-lvl-1-2-tiles.asm"
.include "background-lvl-1-3-tiles.asm"

.include "background-dungeon-tiles.asm"

.include "background-tilemaps-w2.asm"
.include "background-lvl-2-1-tiles.asm"
.include "background-lvl-2-2-tiles.asm"
.include "background-lvl-2-3-tiles.asm"

.include "background-lvl-3-1-tiles.asm"