; Options Screen, shown if Select is hit on the intro screen
;
; Palette           > NES      FCEUX    ????
; 3DS BGs           > Yes      No
; QoL In Vanilla    > No       Yes
;
; Audio             > 2A03            MSU-1 (or MSU-1 not detected)
; 
; MSU Per Track 
;       World 1       2A03          > MSU-1
;       World 2       2A03          > MSU-1
;       World 3       2A03          (track not found)
;       World 4       2A03          > MSU-1
;       Fortress      2A03          > MSU-1
;       Boss          2A03          > MSU-1
;       Medusa        2A03          > MSU-1
;       Grim Reaper   2A03          > MSU-1
;       Stage Clear   2A03          > MSU-1
;       Ending        2A03          > MSU-1
;       Title         2A03          > MSU-1
;       Game Over     2A03          > MSU-1
;
;
;   [Pit graphic]

; layout:
; address, # tiles, tile values.  
option_tiles:
.byte  $2B, $20, $08, P0, $24, P0, $3F, P0, $43, P0, $38, P0, $3E, P0, $3D, P0, $42, P0, $0F    ; Options-
.byte  $62, $20, $07, P0, $25, P0, $30, P0, $3B, P0, $34, P0, $43, P0, $43, P0, $34             ; Palette
.byte  $70, $20, $03, P0, $23, P0, $1A, P0, $28                                                 ; NES
.byte  $78, $20, $05, P0, $1B, P0, $18, P0, $1A, P0, $2A, P0, $2D                               ; FCEUX

.byte  $82, $20, $07, P0, $03, P0, $19, P0, $28, P0, $12, P0, $17, P0, $1C, P0, $28             ; 3DS BGS
.byte  $90, $20, $03, P0, $2E, P0, $1A, P0, $28                                                 ; YES
.byte  $98, $20, $02, P0, $23, P0, $24                                                          ; NO

.byte  $A2, $20, $04, P0, $22, P0, $28, P0, $2A, P0, $01                                        ; MSU1
.byte  $B0, $20, $03, P0, $2E, P0, $1A, P0, $28                                                 ; YES
.byte  $B8, $20, $02, P0, $23, P0, $24                                                          ; NO

.byte $04, $21, $0B, P0, $3f, P0, $41, P0, $34, P0, $42, P0, $42, P0, $12, P0, $42, P0, $43, P0, $30, P0, $41, P0, $43

P0 = $00
P1 = $04
P2 = $08
P3 = $0C

P0_3 = $12
P1_3 = $16
P2_3 = $1A
P3_3 = $1E

; fun 8 x 8 BG
.byte $6C, $22, $08, P0, $12, P0, $12, P2, $8f, P2, $90, P0, $12, P0, $12, P0, $12, P0, $12
.byte $8C, $22, $08, P0, $12, P0, $12, P2, $91, P2, $92, P0, $12, P0, $12, P0, $12, P0, $12 
.byte $AC, $22, $08, P1, $69, P1, $6a, P2, $91, P2, $92, P0, $12, P0, $12, P0, $12, P0, $12 
.byte $CC, $22, $08, P1, $6b, P1, $6c, P2, $91, P2, $92, P0, $12, P0, $12, P0, $12, P0, $12 
.byte $EC, $22, $08, P1, $a5, P1, $a6, P2, $91, P2, $92, P2, $70, P2, $71, P2, $70, P2, $71
.byte $0C, $23, $08, P1, $a7, P1, $a8, P2, $6d, P2, $6e, P2, $72, P2, $73, P2, $72, P2, $73
.byte $2C, $23, $08, P0, $79, P0, $79, P0, $79, P0, $79, P0, $79, P0, $79, P0, $79, P0, $79 
.byte $4C, $23, $08, P0, $79, P0, $79, P0, $79, P0, $79, P0, $79, P0, $79, P0, $79, P0, $79 

; full palette preview
.byte $A3, $21, $10, P0_3, $00, P0_3, $01, P0_3, $02, P0_3, $03, P0_3, $04, P0_3, $05, P0_3, $06, P0_3, $07, P0_3, $08, P0_3, $09, P0_3, $0A, P0_3, $0B, P0_3, $0C, P0_3, $0D, P0_3, $0E, P0_3, $0F
.byte $C3, $21, $10, P1_3, $00, P1_3, $01, P1_3, $02, P1_3, $03, P1_3, $04, P1_3, $05, P1_3, $06, P1_3, $07, P1_3, $08, P1_3, $09, P1_3, $0A, P1_3, $0B, P1_3, $0C, P1_3, $0D, P1_3, $0E, P1_3, $0F
.byte $E3, $21, $10, P2_3, $00, P2_3, $01, P2_3, $02, P2_3, $03, P2_3, $04, P2_3, $05, P2_3, $06, P2_3, $07, P2_3, $08, P2_3, $09, P2_3, $0A, P2_3, $0B, P2_3, $0C, P2_3, $0D, P2_3, $0E, P2_3, $0F
.byte $03, $22, $10, P3_3, $00, P3_3, $01, P3_3, $02, P3_3, $03, P3_3, $04, P3_3, $05, P3_3, $06, P3_3, $07, P3_3, $08, P3_3, $09, P3_3, $0A, P3_3, $0B, P3_3, $0C, P3_3, $0D, P3_3, $0E, P3_3, $0F

.byte $FF

msu_unavailable_tiles:
.byte $AB, $20, $44, $3d, $30, $45, $30, $38, $3B, $30, $31, $3B, $34

show_options_screen:
    STZ CURR_OPTION

    LDA VMAIN_STATE
    AND #$0F
    STA VMAIN
    LDA #$80
    STA INIDISP
    JSR clearvm_to_12

    ; if MSU starts here at 0 then it's not available at all
    LDA MSU_SELECTED
    BNE :+
    INC MSU_UNAVAILABLE
:   
    JSR write_option_tiles
    JSR write_option_palette
    JSR write_option_palette_from_indexes
    JSR load_options_sprites
    jsr write_single_color_tiles_to_3000
    JSR dma_oam_table
    LDA #$0F
    STA INIDISP
    LDX #$FF


    ; check for input
NEEDS_OAM_DMA = $11
input_loop:
    LDA RDNMI
    BPL :+
    LDA NEEDS_OAM_DMA
    BEQ :+
    JSR dma_oam_table
    STZ NEEDS_OAM_DMA
:   
    jsr read_input
    LDA JOYTRIGGER1

    CMP #DOWN_BUTTON
    BNE :+
    jsr next_option
    bra input_loop

:   CMP #UP_BUTTON
    BNE :+
    jsr prev_option
    bra input_loop

:   CMP #RIGHT_BUTTON
    BNE :+
    jsr toggle_current_option
    bra input_loop

:   CMP #LEFT_BUTTON
    BNE :+
    jsr toggle_current_option
    bra input_loop

:   CMP #START_BUTTON
    BEQ exit_options
    BRA input_loop

exit_options:
    jsr clear_extra_palattes
    STZ CURR_OPTION
    LDA INIDISP_STATE
    STA INIDISP

    RTS

clear_extra_palattes:
    LDA RDNMI
:   LDA RDNMI
    BPL :-
    LDA #$40
    STA CGADD
:   STZ CGDATA
    DEC
    BNE :-
    rts

NUM_OPTIONS = $03
CURR_OPTION = $10
MSU_UNAVAILABLE = $12

option_sprite_y_pos:
.byte $16, $1D, $26

next_option:
    LDA CURR_OPTION
    INC
    STA CURR_OPTION
    CMP #NUM_OPTIONS
    BNE :+
    STZ CURR_OPTION
:   jsr update_option_pos
    RTS

prev_option:
    LDA CURR_OPTION
    BNE :+
    LDA #NUM_OPTIONS    
:   DEC 
    STA CURR_OPTION
    jsr update_option_pos
    RTS

update_option_pos:
    LDA CURR_OPTION
    TAY
    LDA option_sprite_y_pos, Y
    STA SNES_OAM_START + 12 + 1
    LDA #$01
    sta NEEDS_OAM_DMA
    rts

toggle_current_option:
    LDA #$01
    sta NEEDS_OAM_DMA
    LDA CURR_OPTION
    BNE :+
        jsr toggle_palette
        rts
:   CMP #$01
    BNE :+
        jsr toggle_new_bgs
        rts
:   CMP #$02
    BNE :+
        jsr toggle_msu1
        rts
:   ; should never get here but whatever
    RTS

FIRST_OPTION  = $77
SECOND_OPTION = $B7 

PAL_OPTION = SNES_OAM_START
BGS_OPTION = SNES_OAM_START + 4
MSU_OPTION = SNES_OAM_START + (2 * 4)


toggle_new_bgs:
    LDA NEW_BG2S_ENABLED
    BEQ :+
        STZ NEW_BG2S_ENABLED
        LDA #SECOND_OPTION
        BRA :++
:   
        INC NEW_BG2S_ENABLED
        LDA #FIRST_OPTION
:   STA BGS_OPTION

    rts


disable_msu_option:
    LDY #$00
    LDA msu_unavailable_tiles, Y
    STA VMADDL
    INY
    LDA msu_unavailable_tiles, Y
    STA VMADDH
    INY

:   LDA msu_unavailable_tiles, Y
    STA VMDATAL
    INY
    CPY #$0D
    BNE :-
    rts

toggle_msu1:
    LDA MSU_SELECTED
    BEQ :+
        STZ MSU_SELECTED
        LDA #SECOND_OPTION
        BRA :+++
:   
        LDA MSU_UNAVAILABLE
        BEQ :+
            rts 
:       INC MSU_SELECTED
        LDA #FIRST_OPTION
:   STA MSU_OPTION

    rts

toggle_palette:
    LDA PALETTE_OPTION
    EOR #$01
    STA PALETTE_OPTION
    BNE :+
    jsr write_option_palette
    LDA #FIRST_OPTION
    bra :++
:   jsr write_alt_option_palette
    LDA #SECOND_OPTION
:   STA PAL_OPTION
    jsr write_option_palette_from_indexes
    rts



write_option_palette:
    LDA RDNMI
:   LDA RDNMI
    BPL :-

    LDA #$41
    STA CGADD
    LDX #$80
    LDY #$00

:   LDA palette_lookup, Y
    STA CGDATA
    INY
    DEX
    BNE :-

    RTS

write_alt_option_palette:
    LDA RDNMI
:   LDA RDNMI
    BPL :-

    LDA #$41
    STA CGADD
    LDX #$80
    LDY #$00

:   LDA alt_palette, Y
    STA CGDATA
    INY
    DEX
    BNE :-

    RTS

write_option_palette_from_indexes:
    LDA RDNMI
:   LDA RDNMI
    BPL :-

    STZ CGADD
    LDY #$00
    LDX #$00

option_palette_loop:
    LDA default_options_bg_palette_indexes, Y
    ASL A
    TAX

    LDA PALETTE_OPTION
    BNE :+  
        LDA palette_lookup, X
        STA CGDATA
        LDA palette_lookup + 1, X
        STA CGDATA
        bra :++
    : 
        LDA alt_palette, X
        STA CGDATA
        LDA alt_palette + 1, X
        STA CGDATA
    :
    INY
    ; every 4 we need to write a bunch of empty palette entries
    TYA
    AND #$03
    BNE :+

    CLC
    LDA CURR_PALETTE_ADDR
    ADC #$10
    STA CGADD
    STA CURR_PALETTE_ADDR

:
    TYA
    AND #$0F
    CMP #$00
    BNE :+
    ; after 16 entries we write an empty set of palettes
    CLC
    LDA CURR_PALETTE_ADDR
    ADC #$40
    STA CGADD
    STA CURR_PALETTE_ADDR 

:
    CPY #$20
    BNE option_palette_loop
    rts    

write_option_tiles:
    setXY16
    LDY #$0000

next_option_bg_line:
    ; get starting address
    LDA option_tiles, Y
    CMP #$FF
    BEQ exit_options_write

    PHA
    INY    
    LDA option_tiles, Y
    STA VMADDH
    PLA
    STA VMADDL
    INY
    LDA option_tiles, Y
    TAX
    INY

:   LDA option_tiles, Y
    STA VMDATAH
    INY
    LDA option_tiles, Y
    STA VMDATAL
    INY
    DEX
    BEQ next_option_bg_line
    BRA :-

exit_options_write:
    setAXY8
    RTS



load_options_sprites:
    LDY #$00
:   LDA options_sprites, Y
    CMP #$FF
    BEQ :+
    STA SNES_OAM_START, Y
    INY
    BRA :-
:   
    LDA MSU_UNAVAILABLE
    BEQ :+
        STZ MSU_SELECTED
        LDA #SECOND_OPTION
        STA MSU_OPTION
        jsr disable_msu_option
:   RTS

read_input:
    lda #$01
    STA JOYSER0
    STA buttons
    LSR A
    sta JOYSER0
@loop:
    lda JOYSER0
    lsr a
    rol buttons
    bcc @loop

    lda buttons
    ldy JOYPAD1
    sta JOYPAD1
    tya
    eor JOYPAD1
    and JOYPAD1
    sta JOYTRIGGER1
    beq :+ 

    tya
    and JOYPAD1
    sta JOYHELD1
:   rts


write_single_color_tiles_to_3000:
    LDA #$30
    STA VMADDH
    LDA #$00
    STA VMADDL

    LDY #$00
    LDX #$02

:   
    LDA single_color_tiles + 1, Y
    STA VMDATAH
    LDA single_color_tiles, Y
    STA VMDATAL
    INY
    INY

    BNE :-

:   LDA single_color_tiles + $100 + 1, Y
    STA VMDATAH
    LDA single_color_tiles + $100, Y
    STA VMDATAL
    INY
    INY
    
    BNE :-

    rts


; X, Y, Tile, attributes
options_sprites:
.byte  $77, $18, $09, $00   ; Palette Selection
.byte  $77, $20, $09, $00   ; BGS selection
.byte  $77, $28, $09, $00   ; MSU selection
.byte  $04, $16, $3C, $40   ; Option Selection

.byte 120, 176, $00, $30 ; pit sprite 1/6
.byte 128, 176, $01, $30 ; pit sprite 2/6
.byte 120, 184, $10, $30 ; pit sprite 3/6
.byte 128, 184, $11, $30 ; pit sprite 4/6
.byte 120, 192, $20, $30 ; pit sprite 5/6
.byte 128, 192, $21, $30 ; pit sprite 6/6

.byte $FF

default_options_bg_palette_indexes:
.byte $0F, $30, $14, $02, $0F, $28, $17, $07, $0F, $2C, $19, $01, $0F, $25, $00, $15

default_options_sprite_palette_indexes:
.byte $0F, $20, $26, $07, $0F, $31, $02, $15, $0F, $12, $23, $31, $0F, $06, $16, $38


default_options_palette:
.byte $00, $00, $FF, $7F, $74, $64, $42, $50, $00, $00, $00, $00, $00, $00, $00, $00
.byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
.byte $00, $00, $F7, $02, $33, $01, $6A, $00, $00, $00, $00, $00, $00, $00, $00, $00
.byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
.byte $00, $00, $29, $6F, $07, $02, $A0, $44, $00, $00, $00, $00, $00, $00, $00, $00
.byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
.byte $00, $00, $BF, $65, $8C, $31, $76, $3C, $00, $00, $00, $00, $00, $00, $00, $00
.byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00

options_sprite_palette:
.byte $00, $00, $FF, $7F, $1F, $3A, $6A, $00, $00, $00, $00, $00, $00, $00, $00, $00
.byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
.byte $00, $00, $78, $7F, $42, $50, $76, $3C, $00, $00, $00, $00, $00, $00, $00, $00
.byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
.byte $00, $00, $08, $7D, $D8, $7D, $78, $7F, $00, $00, $00, $00, $00, $00, $00, $00
.byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
.byte $00, $00, $0D, $00, $D6, $10, $9C, $4B, $00, $00, $00, $00, $00, $00, $00, $00
.byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00

; 16 4bpp tiles that use all of a single color
; used to show the full NES palette we're currently using
single_color_tiles:
.byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
.byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
.byte $FF, $00, $FF, $00, $FF, $00, $FF, $00, $FF, $00, $FF, $00, $FF, $00, $FF, $00
.byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
.byte $00, $FF, $00, $FF, $00, $FF, $00, $FF, $00, $FF, $00, $FF, $00, $FF, $00, $FF
.byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
.byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
.byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00

.byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
.byte $FF, $00, $FF, $00, $FF, $00, $FF, $00, $FF, $00, $FF, $00, $FF, $00, $FF, $00
.byte $FF, $00, $FF, $00, $FF, $00, $FF, $00, $FF, $00, $FF, $00, $FF, $00, $FF, $00
.byte $FF, $00, $FF, $00, $FF, $00, $FF, $00, $FF, $00, $FF, $00, $FF, $00, $FF, $00
.byte $00, $FF, $00, $FF, $00, $FF, $00, $FF, $00, $FF, $00, $FF, $00, $FF, $00, $FF
.byte $FF, $00, $FF, $00, $FF, $00, $FF, $00, $FF, $00, $FF, $00, $FF, $00, $FF, $00
.byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
.byte $FF, $00, $FF, $00, $FF, $00, $FF, $00, $FF, $00, $FF, $00, $FF, $00, $FF, $00

.byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
.byte $00, $FF, $00, $FF, $00, $FF, $00, $FF, $00, $FF, $00, $FF, $00, $FF, $00, $FF
.byte $FF, $00, $FF, $00, $FF, $00, $FF, $00, $FF, $00, $FF, $00, $FF, $00, $FF, $00
.byte $00, $FF, $00, $FF, $00, $FF, $00, $FF, $00, $FF, $00, $FF, $00, $FF, $00, $FF
.byte $00, $FF, $00, $FF, $00, $FF, $00, $FF, $00, $FF, $00, $FF, $00, $FF, $00, $FF
.byte $00, $FF, $00, $FF, $00, $FF, $00, $FF, $00, $FF, $00, $FF, $00, $FF, $00, $FF
.byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
.byte $00, $FF, $00, $FF, $00, $FF, $00, $FF, $00, $FF, $00, $FF, $00, $FF, $00, $FF

.byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
.byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
.byte $FF, $00, $FF, $00, $FF, $00, $FF, $00, $FF, $00, $FF, $00, $FF, $00, $FF, $00
.byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
.byte $00, $FF, $00, $FF, $00, $FF, $00, $FF, $00, $FF, $00, $FF, $00, $FF, $00, $FF
.byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
.byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
.byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF