.segment "PRGAB"



.define LAST_SCREEN_SEEN 
.define IS_SCROLLING $0B00
.define UPDATE_DONE $0B01
.define BG2_VOFS_LB $0B02
.define BG2_VOFS_HB $0B03
.define foo $FF01

.define BG_INFO bg_info_table


bg_index:
.byte (lvl11 - bg_info_table), (lvl12 - bg_info_table), (lvl13 - bg_info_table)

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
.byte $28, $FF, <world_1_lvl_1_snes_bg_tilemap_upper, >world_1_lvl_1_snes_bg_tilemap_upper, ^world_1_lvl_1_snes_bg_tilemap_upper
.byte $2C, $FF, <world_1_lvl_1_snes_bg_tilemap_lower, >world_1_lvl_1_snes_bg_tilemap_lower, ^world_1_lvl_1_snes_bg_tilemap_lower
.byte <world1_lvl1_palette, >world1_lvl1_palette
.byte $0F ; every 16 pixels, scroll 1 px
.byte $10, $01 ; start at voffs of $0140
.byte $FF, $FF ; hoffs
.byte $40, $FF ; 0040 max of 40 VOFFS movement NYI

lvl12:
.byte <level_1_2_snes_bg_tiles, >level_1_2_snes_bg_tiles, ^level_1_2_snes_bg_tiles, $80, $FF
.byte $28, $FF, <world_1_lvl_2_snes_bg_tilemap_upper, >world_1_lvl_2_snes_bg_tilemap_upper, ^world_1_lvl_2_snes_bg_tilemap_upper
.byte $2C, $FF, <world_1_lvl_2_snes_bg_tilemap_lower, >world_1_lvl_2_snes_bg_tilemap_lower, ^world_1_lvl_2_snes_bg_tilemap_lower
.byte <world1_lvl2_palette, >world1_lvl2_palette
.byte $0D ; every 16 pixels, scroll 1 px
.byte $10, $01 ; start at voffs of $0140
.byte $FF, $FF ; hoffs
.byte $FF, $FF ; 0040 max of 40 VOFFS movement NYI

lvl13:
.byte <level_1_3_snes_bg_tiles, >level_1_3_snes_bg_tiles, ^level_1_3_snes_bg_tiles, $80, $FF
.byte $28, $FF, <world_1_lvl_3_snes_bg_tilemap_upper, >world_1_lvl_3_snes_bg_tilemap_upper, ^world_1_lvl_3_snes_bg_tilemap_upper
.byte $2C, $FF, <world_1_lvl_3_snes_bg_tilemap_lower, >world_1_lvl_3_snes_bg_tilemap_lower, ^world_1_lvl_3_snes_bg_tilemap_lower
.byte <world1_lvl3_palette, >world1_lvl3_palette
.byte $0D ; every 16 pixels, scroll 1 px
.byte $10, $01 ; start at voffs of $0140
.byte $FF, $FF ; hoffs
.byte $FF, $FF ; 0040 max of 40 VOFFS movement NYI

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
.byte $03, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
.byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
.byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
.byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF


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


handle_bg2_paralax:
    LDA TM_STATE
    AND #$02
    BEQ :++

    LDA VOFS_LB
    AND #$0F
    BNE dont_need_update

    LDA UPDATE_DONE
    BNE :++


increment_parallax:
    LDA #$01
    STA UPDATE_DONE      
    DEC BG2_VOFS_LB
    LDA BG2_VOFS_LB
    CMP #$FF
    BNE :+
    DEC BG2_VOFS_HB
:   LDA BG2_VOFS_LB
    STA BG2VOFS
    LDA BG2_VOFS_HB
    STA BG2VOFS
    BRA :+

dont_need_update:
    STZ UPDATE_DONE

:
    rtl

load_background_a:
    PHA

    TAY
    LDA bg_index, Y
    TAY
    LDA bg_info_table + 18
    STA BG2VOFS
    STA BG2_VOFS_LB
    LDA bg_info_table + 19
    STA BG2VOFS
    STA BG2_VOFS_HB
    STZ UPDATE_DONE
    INC UPDATE_DONE
    STZ IS_SCROLLING
    INC IS_SCROLLING
    
    LDA bg_info_table + 20
    STA BG2HOFS
    LDA bg_info_table + 21
    STA BG2HOFS


    PLA
    PHA
    jsr load_tiles_for_bgy

    PLA
    PHA
    jsr  write_bg_to_bg2
    
    PLA
    PHA
    jsr write_bg_palette_y
    
  

    PLA
    jsl enable_bg2
    rts


setup_bg2:
    ; we need to check if we're horizontal or vertical
    LDA BANK_SWITCH_CTRL_REGS
    AND #$01
    BEQ:+

    
    LDA #($28 + $01)
    STA BG2SC
    rtl

:   
    LDA #($28 + $02)
    STA BG2SC
    rtl

enable_bg2:    
    LDA TM_STATE
    ORA #$02
    STA TM_STATE
    STA TM
    rtl

disable_bg2:
    LDA TM_STATE
    AND #$FD
    STA TM_STATE
    STA TM
    
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

    LDA $FF
    PHA
    LDA $01
    PHA

    LDA bg_info_table + 15, Y
    STA $FF
    LDA bg_info_table + 16, Y
    STA $01

    LDY #$FF
:   LDA ($FF), Y
    STA CGDATA
    iny
    CPY #$20
    BNE :-
    PLA
    STA $01
    PLA 
    STA $FF
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
.byte $03, $FF, $FF, $FF, $FF, $FF, $9F, $10, $96, $0C, $6F, $08, $DA, $10, $4A, $04
.byte $92, $08, $26, $FF, $47, $04, $6C, $04, $DF, $29, $1C, $0D, $5F, $11, $48, $FF
world1_lvl2_palette:
.byte $49, $35, $07, $2D, $CC, $65, $8A, $65, $48, $65, $8B, $35, $70, $6A, $CE, $3D
.byte $AA, $4D, $2F, $52, $2D, $6E, $84, $2C, $B3, $66, $F6, $72, $C3, $44, $26, $51
world1_lvl3_palette:
.byte $06, $15, $86, $08, $C6, $14, $C4, $10, $C8, $10, $49, $19, $C4, $08, $08, $15
.byte $86, $21, $0A, $19, $C8, $29, $8A, $21, $33, $47, $CC, $29, $77, $57, $D0, $3A