.p816
.smart

.include "macros.inc"
.include "registers.inc"
.include "nes_zp_vars.inc"
.include "2a03_emu_upload.asm"
.include "hiromheader.asm"
; .include "variables.asm"
.segment "CODE"
.include "resetvector.asm"

.include "2a03_emulator_first_8000.asm"
.include "2a03_emulator_second_8000.asm"

.include "bank_snes.asm"
.include "bank0.asm"
.include "bank1.asm"
.include "bank2.asm"
.include "bank3.asm"
.include "bank4.asm"
.include "bank5.asm"
.include "bank6.asm"