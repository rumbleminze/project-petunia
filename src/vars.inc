; Value determines where we're at
; 00 - title screen
; 01 - Start/Continue
; 02 - World 1-1 to 1-3
; 03 - Level 1-4
; 04 - 2-1 to 2-3
; 05 - 2-4
; 06 - 3-1 to 3-3
; 07 - 3-4
; 08 - 4-1
CURRENT_WORLD_INX   = $A0

PPU_MASK_STATE      = $FF
PPU_CONTROL_STATE   = $100
VMAIN_CONTROL_STATE = $102

; SNES Register Value storage
.define NMITIMEN_STATUS  $1706
.define VMAIN_STATUS     $1705
.define INIDISP_STATE    $1704
.define BANK_SWITCH_JMP  $0800

HOFS_LB             = $FE
HOFS_HB             = $0804

VOFS_LB             = $FD
VOFS_HB             = $0805

REUSABLE_CALC_BYTE  = $0808
CURRENT_ATTRIBUTES  = $03B0

; mostly actual nes stuff above
; all my stuff below

LAST_ATTRIB_LOC_LB  = $E0
LAST_ATTRIB_LOC_HB  = $E1
SPRITE_LOOP_JUNK    = $E2
tmp_dat             = $E2

JMP_REDIRECT_LB     = $d0

FULL_ATTRIBUTE_COPY_SRC_LB = $7D
FULL_ATTRIBUTE_COPY_SRC_HB = $7E
FULL_ATTRIBUTE_COPY_HB = $7F

PPU_CURR_VRAM_ADDR  = $0912
PPU_TILE_COUNT      = $0914
PPU_TILE_ATTR       = $0916
PPU_COL_OFFSET      = $0918
PPU_ROW_OFFSET      = $091A
TILES_TO_WRITE      = $091C
TILES_TO_WRITE_HB   = $091D
JML_BANK_STORE      = $0920

FULL_ATTRIBUTE_QUARTER_COUNTER = $0930
FAQ_OFFSET = $0931

STORED_OFFSETS_SET  = $0940
UNPAUSE_BG1_VOFS_LB = $0941
UNPAUSE_BG1_VOFS_HB = $0942
UNPAUSE_BG1_HOFS_LB = $0943
UNPAUSE_BG1_HOFS_HB = $0944

VRAM_UPDATE_ADDR_LB = $0970
VRAM_UPDATE_ADDR_HB = $0971
VRAM_UPDATE_DATA    = $0972
EXTRA_VRAM_UPDATE   = $0980


SNES_OAM_TRANSLATE_NEEDED = $12F0
SNES_OAM_START      = $1300

ATTRIBUTE_HOLDING   = $6600

ATTR_NES_HAS_VALUES = $09A0
ATTR_NES_VM_ADDR_HB = $09A1
ATTR_NES_VM_ADDR_LB = $09A2
ATTR_NES_VM_COUNT   = $09A3
ATTR_NES_VM_ATTR_START = $09A4

CURR_PALETTE_ADDR   = $17E0
ATTRIBUTE_DMA       = $17F0
ATTR_DMA_SRC_HB     = $17F2
ATTR_DMA_SRC_DB     = $17F4
ATTR_DMA_SIZE_LB    = $17F6
ATTR_DMA_SIZE_HB    = $17F8
ATTR_DMA_VMADDH     = $17FA
ATTR_DMA_VMADDL     = $17FC
ATTRIBUTE_CACHE     = $1800

; this will store 8 values that contain the 8 attributes
; each attribute value is used for 2 adjacent attribute pairs
; and each pair is for 2 tiles, resulting in 32 values
COL_ATTR_HAS_VALUES = $1A00
COL_ATTR_VM_HB      = $1A01
COL_ATTR_VM_LB      = $1A02
COL_ATTR_VM_COUNT   = $1A03 ; will always be 8 but whatevs
COL_ATTR_LB_SET     = $1A04
COL_ATTR_VM_START   = $1A05

COLUMN_1_DMA        = $1A10
C1_ATTR_DMA_SRC_HB  = $1A12
C1_ATTR_DMA_SRC_LB  = $1A14
C1_ATTR_DMA_SIZE_LB = $1A16
C1_ATTR_DMA_SIZE_HB = $1A18
C1_ATTR_DMA_VMADDH  = $1A1A
C1_ATTR_DMA_VMADDL  = $1A1C
C1_ATTRIBUTE_CACHE  = $1A20