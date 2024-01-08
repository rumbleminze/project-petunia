; routines related to loading the tiles
load_base_tiles:

    LDA #$80
    STA VMAIN

    LDA #$01
    STA DMAP1

    LDA #$18
    STA BBAD1 

    LDA #<base_tiles
    STA A1T1L

    LDA #>base_tiles
    STA A1T1H

    LDA #^base_tiles
    STA A1B1

    ; 2000 bytes
    LDA #$40
    STA DAS1H
    STZ DAS1L

    STZ VMADDH
    STZ VMADDL

    LDA #$02
    STA MDMAEN
    
    LDA VMAIN_STATUS
    STA VMAIN
:
    RTS

; Sprite Addresses per world index
; for each level 1 address for sprites, next for background tiles
; divide level index by 2 to get look up index.  multiply by 4 to get the starting value
; for the sprites
source_locations:
.byte $00, $00, $00, $00 ; index 0 & 1 - no tiles
.byte .lobyte(world_1_sprites), .hibyte(world_1_sprites), .lobyte(world_1_bg_tiles), .hibyte(world_1_bg_tiles)
.byte .lobyte(world_2_sprites), .hibyte(world_2_sprites), .lobyte(world_2_bg_tiles), .hibyte(world_2_bg_tiles)
.byte .lobyte(world_3_sprites), .hibyte(world_3_sprites), .lobyte(world_3_bg_tiles), .hibyte(world_3_bg_tiles)
.byte .lobyte(world_4_sprites), .hibyte(world_4_sprites), .lobyte(world_4_bg_tiles), .hibyte(world_4_bg_tiles)

load_level_specific_tiles:

    LDA #$80
    STA VMAIN

    LDA #$01
    STA DMAP1
    STA DMAP2

    LDA CURRENT_WORLD_INX
    BEQ :-                  ; early rts if we're in level 0 (title screen)

    CLC
    LSR ; divide by 2 then multiply by 4 to get source location lookup
    CLC
    ASL
    ASL
    TAY

    LDA source_locations, Y
    STA A1T1L
    INY 

    LDA source_locations, Y
    STA A1T1H
    INY

    LDA #^level_specific_tiles
    STA A1B1
    STA A1B2

    LDA source_locations, Y
    STA A1T2L
    INY 

    LDA source_locations, Y
    STA A1T2H
    INY

    LDA #$18
    STA BBAD1 
    STA BBAD2

    ; 800 bytes
    LDA #$08
    STA DAS1H
    STA DAS2H
    STZ DAS1L
    STZ DAS2L

    LDA #$0C
    STA VMADDH
    STZ VMADDL

    LDA #$02
    STA MDMAEN

    LDA #$1C
    STA VMADDH
    STZ VMADDL
    LDA #$04
    STA MDMAEN
    
    LDA VMAIN_STATUS
    STA VMAIN

    RTS

