

NES_16              = $16 ; feels like the same as $17?
C1_BUTTON_HELD      = $17
C2_BUTTON_HELD      = $18

C1_BUTTON_PRESS     = $19
C2_BUTTON_PRESS     = $1A

NES_73              = $73
NES_F6              = $F6
C1_BUTTON_MIRROR    = $F8

BUTTON_A            = 80 ; for SNES this is actually B
BUTTON_B            = 40 ; for SNES this is actually Y
BUTTON_START        = 10
BUTTON_SELECT       = 20

BUTTON_UP           = 08
BUTTON_DOWN         = 04
BUTTON_LEFT         = 02
BUTTON_RIGHT        = 01

BG_TILE_COUNT       = $45
PPU_SOURCE_HB       = $44
PPU_SOURCE_LB       = $43
PPU_DEST_HB         = $42
PPU_DEST_LB         = $41

PPU_CONTROL_STATE   = $100

BANK_SWITCH_JMP     = $0800

LAST_ATTRIB_LOC_LB  = $E0
LAST_ATTRIB_LOC_HB  = $E1

; LAST_ATTRIB_LOC_LB  = $0910
; LAST_ATTRIB_LOC_HB  = $0911

; REPLC_

; 7F00 Replacement
REPLC_7F00          = $1000
REPLC_6F00          = $0900
REPLC_6000          = $1100 ; we use 0x100 bytes at a time

PPU_CURR_VRAM_ADDR  = $0912
PPU_TILE_COUNT      = $0914
PPU_TILE_ATTR       = $0916
PPU_COL_OFFSET      = $0918
PPU_ROW_OFFSET      = $091A
TILES_TO_WRITE      = $091C
TILES_TO_WRITE_HB   = $091D
JML_BANK_STORE      = $0920
