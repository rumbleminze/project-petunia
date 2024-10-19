.segment "PRGAB"

.define LAST_SCREEN_SEEN 
.define IS_SCROLLING $0B00
.define UPDATE_DONE $0B01
.define BG2_OFS_LB $0B02  ; used for both H and V OFS since we only ever update 1 on BG2
.define BG2_OFS_HB $0B03
.define foo $FF01

.define BG_INFO bg_info_table


bg_index:
.byte (lvl11 - bg_info_table)
.byte (lvl12 - bg_info_table)
.byte (lvl13 - bg_info_table)
.byte (dungeons - bg_info_table)
.byte (lvl21 - bg_info_table)
.byte (lvl22 - bg_info_table)
.byte (lvl23 - bg_info_table)
.byte (lvl31 - bg_info_table)
.byte (lvl32 - bg_info_table)
.byte (lvl33 - bg_info_table)
.byte (lvl41 - bg_info_table)
.byte $FF

bg_info_table:
; contains:
; tile locations, size of tiles to copy
; starting addr, first (upper / left) tilemap location
; starting addr, second (lower / right) tilemap location
; paralax update interval 
; max scroll
; starting VOFFS
; starting HOFFS
lvl11:
.byte <level_1_1_snes_bg_tiles, >level_1_1_snes_bg_tiles, ^level_1_1_snes_bg_tiles, $80, $FF
.byte $28, $00, <world_1_lvl_1_snes_bg_tilemap_upper, >world_1_lvl_1_snes_bg_tilemap_upper, ^world_1_lvl_1_snes_bg_tilemap_upper
.byte $2C, $00, <world_1_lvl_1_snes_bg_tilemap_lower, >world_1_lvl_1_snes_bg_tilemap_lower, ^world_1_lvl_1_snes_bg_tilemap_lower
.byte <world1_lvl1_palette, >world1_lvl1_palette
.byte $0F ; every 16 pixels, scroll 1 px
.byte $10, $01 ; start at voffs of $0140
.byte $00, $00 ; hoffs
.byte $40, $00 ; 0040 max of 40 VOFFS movement NYI

lvl12:
.byte <level_1_2_snes_bg_tiles, >level_1_2_snes_bg_tiles, ^level_1_2_snes_bg_tiles, $80, $FF
.byte $28, $00, <world_1_lvl_2_snes_bg_tilemap_upper, >world_1_lvl_2_snes_bg_tilemap_upper, ^world_1_lvl_2_snes_bg_tilemap_upper
.byte $2C, $00, <world_1_lvl_2_snes_bg_tilemap_lower, >world_1_lvl_2_snes_bg_tilemap_lower, ^world_1_lvl_2_snes_bg_tilemap_lower
.byte <world1_lvl2_palette, >world1_lvl2_palette
.byte $0D ; every 16 pixels, scroll 1 px
.byte $10, $01 ; start at voffs of $0140
.byte $00, $00 ; hoffs
.byte $40, $00 ; 0040 max of 40 VOFFS movement NYI


lvl13:
.byte <level_1_3_snes_bg_tiles, >level_1_3_snes_bg_tiles, ^level_1_3_snes_bg_tiles, $80, $FF
.byte $28, $00, <world_1_lvl_3_snes_bg_tilemap_upper, >world_1_lvl_3_snes_bg_tilemap_upper, ^world_1_lvl_3_snes_bg_tilemap_upper
.byte $2C, $00, <world_1_lvl_3_snes_bg_tilemap_lower, >world_1_lvl_3_snes_bg_tilemap_lower, ^world_1_lvl_3_snes_bg_tilemap_lower
.byte <world1_lvl3_palette, >world1_lvl3_palette
.byte $0D ; every 16 pixels, scroll 1 px
.byte $10, $01 ; start at voffs of $0140
.byte $00, $00 ; hoffs
.byte $40, $00 ; 0040 max of 40 VOFFS movement NYI


dungeons:
.byte <dungeon_snes_bg_tiles, >dungeon_snes_bg_tiles, ^dungeon_snes_bg_tiles, $80, $FF
.byte $28, $00, <dungeon_tilemap_upper, >dungeon_tilemap_upper, ^dungeon_tilemap_upper
.byte $2C, $00, <dungeon_tilemap_lower, >dungeon_tilemap_lower, ^dungeon_tilemap_lower
.byte <dungeon_palette, >dungeon_palette
.byte $FF ; every 16 pixels, scroll 1 px
.byte $00, $01 ; start at voffs of $0100
.byte $00, $00 ; hoffs
.byte $40, $00 ; 0040 max of 40 VOFFS movement NYI

lvl21:
.byte <level_2_1_snes_bg_tiles, >level_2_1_snes_bg_tiles, ^level_2_1_snes_bg_tiles, $80, $FF
.byte $28, $00, <world_2_lvl_1_snes_bg_tilemap_left, >world_2_lvl_1_snes_bg_tilemap_left, ^world_2_lvl_1_snes_bg_tilemap_left
.byte $2C, $00, <world_2_lvl_1_snes_bg_tilemap_right, >world_2_lvl_1_snes_bg_tilemap_right, ^world_2_lvl_1_snes_bg_tilemap_right
.byte <world2_lvl1_palette, >world2_lvl1_palette
.byte $0F ; every 16 pixels, scroll 1 px
.byte $00, $00 ; start at offs of $0000
.byte $00, $00 ; hoffs
.byte $40, $00 ; 0040 max of 40 VOFFS movement NYI

lvl22:
.byte <level_2_2_snes_bg_tiles, >level_2_2_snes_bg_tiles, ^level_2_2_snes_bg_tiles, $80, $FF
.byte $28, $00, <world_2_lvl_2_snes_bg_tilemap_left, >world_2_lvl_2_snes_bg_tilemap_left, ^world_2_lvl_2_snes_bg_tilemap_left
.byte $2C, $00, <world_2_lvl_2_snes_bg_tilemap_right, >world_2_lvl_2_snes_bg_tilemap_right, ^world_2_lvl_2_snes_bg_tilemap_right
.byte <world2_lvl2_palette, >world2_lvl2_palette
.byte $0F ; every 16 pixels, scroll 1 px
.byte $00, $00 ; start at offs of $0000
.byte $00, $00 ; hoffs
.byte $40, $00 ; 0040 max of 40 VOFFS movement NYI

lvl23:
.byte <level_2_3_snes_bg_tiles, >level_2_3_snes_bg_tiles, ^level_2_3_snes_bg_tiles, $80, $FF
.byte $28, $00, <world_2_lvl_3_snes_bg_tilemap_left, >world_2_lvl_3_snes_bg_tilemap_left, ^world_2_lvl_3_snes_bg_tilemap_left
.byte $2C, $00, <world_2_lvl_3_snes_bg_tilemap_right, >world_2_lvl_3_snes_bg_tilemap_right, ^world_2_lvl_3_snes_bg_tilemap_right
.byte <world2_lvl3_palette, >world2_lvl3_palette
.byte $0F ; every 16 pixels, scroll 1 px
.byte $00, $00 ; start at offs of $0000
.byte $00, $00 ; hoffs
.byte $40, $00 ; 0040 max of 40 VOFFS movement NYI

lvl31:
.byte <level_3_1_snes_bg_tiles, >level_3_1_snes_bg_tiles, ^level_3_1_snes_bg_tiles, $80, $FF
.byte $28, $00, <world_3_lvl_1_snes_bg_tilemap_upper, >world_3_lvl_1_snes_bg_tilemap_upper, ^world_3_lvl_1_snes_bg_tilemap_upper
.byte $2C, $00, <world_3_lvl_1_snes_bg_tilemap_lower, >world_3_lvl_1_snes_bg_tilemap_lower, ^world_3_lvl_1_snes_bg_tilemap_lower
.byte <world3_lvl1_palette, >world3_lvl1_palette
.byte $0F ; every 16 pixels, scroll 1 px
.byte $00, $01 ; start at offs of $0000
.byte $00, $00 ; hoffs
.byte $40, $00 ; 0040 max of 40 VOFFS movement NYI

lvl32:
.byte <level_3_2_snes_bg_tiles, >level_3_2_snes_bg_tiles, ^level_3_2_snes_bg_tiles, $80, $FF
.byte $28, $00, <world_3_lvl_2_snes_bg_tilemap_upper, >world_3_lvl_2_snes_bg_tilemap_upper, ^world_3_lvl_2_snes_bg_tilemap_upper
.byte $2C, $00, <world_3_lvl_2_snes_bg_tilemap_lower, >world_3_lvl_2_snes_bg_tilemap_lower, ^world_3_lvl_2_snes_bg_tilemap_lower
.byte <world3_lvl2_palette, >world3_lvl2_palette
.byte $0F ; every 16 pixels, scroll 1 px
.byte $00, $01 ; start at offs of $0000
.byte $00, $00 ; hoffs
.byte $40, $00 ; 0040 max of 40 VOFFS movement NYI

lvl33:
.byte <level_3_3_snes_bg_tiles, >level_3_3_snes_bg_tiles, ^level_3_3_snes_bg_tiles, $80, $FF
.byte $28, $00, <world_3_lvl_3_snes_bg_tilemap_upper, >world_3_lvl_3_snes_bg_tilemap_upper, ^world_3_lvl_3_snes_bg_tilemap_upper
.byte $2C, $00, <world_3_lvl_3_snes_bg_tilemap_lower, >world_3_lvl_3_snes_bg_tilemap_lower, ^world_3_lvl_3_snes_bg_tilemap_lower
.byte <world3_lvl3_palette, >world3_lvl3_palette
.byte $0F ; every 16 pixels, scroll 1 px
.byte $00, $01 ; start at offs of $0000
.byte $00, $00 ; hoffs
.byte $40, $00 ; 0040 max of 40 VOFFS movement NYI

lvl41:
.byte <level_4_1_snes_bg_tiles, >level_4_1_snes_bg_tiles, ^level_4_1_snes_bg_tiles, $80, $FF
.byte $28, $00, <world_4_lvl_1_snes_bg_tilemap_left, >world_4_lvl_1_snes_bg_tilemap_left, ^world_4_lvl_1_snes_bg_tilemap_left
.byte $2C, $00, <world_4_lvl_1_snes_bg_tilemap_right, >world_4_lvl_1_snes_bg_tilemap_right, ^world_4_lvl_1_snes_bg_tilemap_right
.byte <world4_lvl1_palette, >world4_lvl1_palette
.byte $0F ; every 16 pixels, scroll 1 px
.byte $00, $00 ; start at offs of $0000
.byte $00, $00 ; hoffs
.byte $40, $00 ; 0040 max of 40 VOFFS movement NYI

; each world has a different background
; World ($A0) Level ($0130)
;   2           0       - 1-1
;   2           1       - 1-2
;   2           2       - 1-3
;   3           0       - 1-4d

level_bg_lookup:
.byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
.byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
.byte $00, $01, $02, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
.byte $03, $FF, $FF, $03, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
.byte $04, $05, $06, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
.byte $03, $FF, $FF, $03, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
.byte $07, $08, $09, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
.byte $03, $FF, $FF, $03, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
.byte $0A, $FF, $FF, $03, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
.byte $FF, $FF, $FF, $03, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF


load_current_background:

    PHA
    PHY
    PHX
    PHB
    PHK
    PLB
    LDA $A0 ; world 0/1 - title, 2 - 11-13, 3 - 14, etc
    ASL
    ASL
    ASL
    ASL
    ORA $0130
    TAY
    LDA level_bg_lookup, Y
    CMP #$FF
    BEQ no_bg
    jsr load_background_a
    
    PLB
    PLX
    PLY
    PLA
    rtl

no_bg:
    jslb disable_bg2, $ab
        
    PLB
    PLX
    PLY
    PLA
    rtl

handle_bg2_paralax_horizontal:
    LDA HOFS_LB
    AND #$1F
    BNE dont_need_update

    LDA UPDATE_DONE
    BNE hbg2p_early_return

    LDA #$01
    STA UPDATE_DONE
    INC BG2_OFS_LB
    BNE :+
    INC BG2_OFS_HB
:   
    LDA BG2_OFS_LB
    STA BG2HOFS
    LDA BG2_OFS_HB
    STA BG2HOFS

    rtl

handle_bg2_paralax:
    LDA TM_STATE
    AND #$02
    BEQ hbg2p_early_return

    LDA BANK_SWITCH_CTRL_REGS
    AND #$01
    BEQ handle_bg2_paralax_horizontal 

    LDA VOFS_LB
    AND #$0F
    BNE dont_need_update

    LDA UPDATE_DONE
    BNE hbg2p_early_return

increment_parallax:
    LDA #$01
    STA UPDATE_DONE      
    DEC BG2_OFS_LB
    LDA BG2_OFS_LB
    CMP #$FF
    BNE :+
    DEC BG2_OFS_HB
:   
    LDA BG2_OFS_LB
    STA BG2VOFS
    LDA BG2_OFS_HB
    STA BG2VOFS

    BRA hbg2p_early_return


dont_need_update:
    STZ UPDATE_DONE

hbg2p_early_return:
    rtl

load_background_a:
    PHA

    TAY
    LDA bg_index, Y
    TAY
    LDA bg_info_table + 18, y
    STA BG2VOFS
    STA BG2_OFS_LB
    LDA bg_info_table + 19, y
    STA BG2VOFS
    STA BG2_OFS_HB
    STZ UPDATE_DONE
    INC UPDATE_DONE
    STZ IS_SCROLLING
    INC IS_SCROLLING
    
    LDA bg_info_table + 20, y
    STA BG2HOFS
    LDA bg_info_table + 21, y 
    STA BG2HOFS

    PLA
    PHA
    jsr write_bg_palette_y
    

    PLA
    PHA
    jsr load_tiles_for_bgy

    PLA
    PHA
    jsr  write_bg_to_bg2
    
  

    PLA
    jsl enable_bg2
    rts


setup_bg2:
    ; we need to check if we're horizontal or vertical
    LDA BANK_SWITCH_CTRL_REGS
    AND #$01
    BEQ:+

    
    LDA #($28 + $02)
    STA BG2SC
    rtl

:   
    LDA #($28 + $01)
    STA BG2SC
    rtl

enable_bg2:    
    LDA TM_STATE
    ORA #$02
    STA TM_STATE
    STA TM
    rtl

disable_bg2:
    PHA

    LDA TM_STATE
    AND #$FD
    STA TM_STATE
    STA TM
    
    PLA
    rtl

; setup_bg2:
;     ; BG2 will be at
;     ; 2800 (5000) - 2FFF (5FFF)
;     ; tiles at 3000
;     LDA #($28 + $02)
;     STA BG2SC
;     STZ BG2HOFS
;     STZ BG2HOFS
;     STZ BG2VOFS
;     LDA #$01
;     STA BG2VOFS
;     rts

load_tiles_for_bgy:
    TAY
    LDA bg_index, y
    TAY

    LDA #$80
    STA VMAIN

    LDA #$01
    STA DMAP1

    LDA #$18
    STA BBAD1 

    LDA bg_info_table, Y
    STA A1T1L

    LDA bg_info_table + 1, Y
    STA A1T1H

    LDA bg_info_table + 2, Y
    STA A1B1

    LDA bg_info_table + 3, Y
    STA DAS1H
    LDA bg_info_table + 4, Y
    STZ DAS1L

    LDA #$30
    STA VMADDH
    STZ VMADDL

    LDA #$02
    STA MDMAEN

    rts

write_bg_to_bg2:
    TAY
    LDA bg_index, Y
    TAY
    
    LDA bg_info_table + 5, Y
    STA VMADDH
    LDA bg_info_table + 6, y
    STA VMADDL

    LDA bg_info_table + 7, Y
    STA A1T1L

    LDA bg_info_table + 8, Y
    STA A1T1H

    LDA bg_info_table + 9, Y
    STA A1B1

    ; always 0x1000 tiles
    LDA #$08
    STA DAS1H
    STZ DAS1L

    jsr dma_tilemap_screen_to_bg2

    ; 2nd half
    LDA bg_info_table + 10, Y
    STA VMADDH
    LDA bg_info_table + 11, y
    STA VMADDL

    LDA bg_info_table + 12, Y
    STA A1T1L

    LDA bg_info_table + 13, Y
    STA A1T1H

    LDA bg_info_table + 14, Y
    STA A1B1

    ; always 0x1000 tiles
    LDA #$08
    STA DAS1H
    STZ DAS1L

    jsr dma_tilemap_screen_to_bg2

    rts

write_bg_palette_y:
    TAY
    LDA bg_index, Y
    TAY

    LDA #$40
    STA CGADD

    LDA $00
    PHA
    LDA $01
    PHA

    LDA bg_info_table + 15, Y
    STA $00
    LDA bg_info_table + 16, Y
    STA $01

    LDY #$00
:   LDA ($00), Y
    STA CGDATA
    iny
    CPY #$20
    BNE :-
    PLA
    STA $01
    PLA 
    STA $00
    rts


; write_title_screen_to_bg2_top:
;     LDA #$2A
;     STA VMADDH    
;     LDA #$80
;     STA VMADDL

;     LDA #<world_1_lvl_1_snes_bg_tilemap_upper
;     STA A1T1L

;     LDA #>world_1_lvl_1_snes_bg_tilemap_upper
;     STA A1T1H

;     LDA #^world_1_lvl_1_snes_bg_tilemap_upper
;     STA A1B1

;     setAXY16
;     LDA #(world_1_lvl_1_snes_bg_tilemap_upper_end - world_1_lvl_1_snes_bg_tilemap_upper)
;     STA DAS1L
;     setAXY8

;     BRA write_title_screen_to_bg2

; write_title_screen_to_bg2_bottom:
;     LDA #$2C
;     STA VMADDH
;     STZ VMADDL

;     LDA #<world_1_lvl_1_snes_bg_tilemap_lower
;     STA A1T1L

;     LDA #>world_1_lvl_1_snes_bg_tilemap_lower
;     STA A1T1H

;     LDA #^world_1_lvl_1_snes_bg_tilemap_lower
;     STA A1B1

;     setAXY16
;     LDA #(world_1_lvl_1_snes_bg_tilemap_lower_end - world_1_lvl_1_snes_bg_tilemap_lower)
;     STA DAS1L
;     setAXY8

;     BRA write_title_screen_to_bg2

dma_tilemap_screen_to_bg2:
    LDA #$80
    STA VMAIN

    LDA #$01
    STA DMAP1

    LDA #$18
    STA BBAD1 

    LDA #$02
    STA MDMAEN
    rts

; palettes are 11 colors, reserving the first 5 for the NES palettes
palettes:
world1_lvl1_palette:
.byte $00, $00, $03, $00, $25, $04, $69, $0C, $6B, $0C, $4D, $08, $9F, $10, $DA, $10
.byte $96, $08, $92, $08, $47, $04, $8D, $08, $DF, $29, $1D, $0D, $4A, $00, $5F, $11

world1_lvl2_palette:
.byte $49, $35, $07, $2D, $CC, $65, $8A, $65, $48, $65, $8B, $35, $70, $6A, $CE, $3D
.byte $AA, $4D, $2F, $52, $2D, $6E, $84, $2C, $B3, $66, $F6, $72, $C3, $44, $26, $51
world1_lvl3_palette:
.byte $06, $15, $86, $08, $C6, $14, $C4, $10, $C8, $10, $49, $19, $C4, $08, $08, $15
.byte $86, $21, $0A, $19, $C8, $29, $8A, $21, $33, $47, $CC, $29, $77, $57, $D0, $3A
dungeon_palette:
.byte $00, $00, $82, $10, $44, $00, $02, $10, $80, $00, $C6, $00, $04, $00, $06, $11
.byte $84, $10, $FF, $7F, $84, $00, $86, $00, $4C, $29, $C8, $18, $C6, $20, $81, $04
world2_lvl1_palette:
.byte $2A, $7E, $28, $3A, $C8, $39, $C9, $5D, $6C, $7E, $2A, $3A, $C8, $5D, $E9, $5D
.byte $86, $39, $0A, $7E, $4B, $7E, $46, $35, $A7, $39, $E8, $3D, $09, $42, $E8, $4D
world2_lvl2_palette:
.byte $80, $7C, $21, $1C, $8E, $3C, $84, $30, $63, $28, $46, $38, $42, $20, $67, $3C
.byte $2C, $40, $29, $40, $4A, $44, $AF, $40, $62, $14, $12, $21, $97, $0D, $00, $00
world2_lvl3_palette:
.byte $42, $00, $A4, $25, $C5, $29, $C2, $14, $84, $21, $23, $1D, $27, $32, $06, $2E
.byte $02, $19, $E2, $14, $68, $3A, $64, $21, $82, $04, $A9, $3E, $26, $32, $0E, $4F
world3_lvl1_palette:
.byte $00, $00, $A7, $20, $86, $28, $E9, $20, $A7, $1C, $86, $2C, $E7, $28, $08, $31
.byte $29, $35, $6C, $3D, $6B, $3D, $4A, $39, $6A, $3D, $8B, $41, $49, $39, $C8, $20
world3_lvl2_palette:
.byte $00, $00, $88, $20, $57, $5A, $C8, $20, $0A, $29, $57, $7B, $46, $10, $95, $51
.byte $27, $08, $44, $0C, $85, $10, $25, $04, $D4, $58, $67, $14, $AF, $34, $21, $04
world3_lvl3_palette:
.byte $44, $0C, $86, $10, $7B, $6F, $8A, $59, $CD, $4D, $E5, $48, $06, $51, $07, $3D
.byte $0F, $5E, $A4, $40, $08, $25, $4A, $31, $8C, $35, $94, $66, $F7, $6A, $22, $08
world4_lvl1_palette:
.byte $00, $00, $00, $18, $28, $39, $82, $34, $40, $28, $84, $40, $C5, $50, $42, $2C
.byte $CA, $54, $CC, $6D, $C8, $54, $85, $4C, $0A, $59, $0C, $5D, $2C, $7E, $40, $1C
