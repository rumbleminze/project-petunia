; bank 0 - this houses our init routine and setup stuff
.segment "PRGA0"
init_routine:
  PHK 
  PLB 
  BRA initialize_registers

initialize_registers:
  STZ $2000
  STZ $2001
  STZ $2002
  STZ $2003
  STZ $2004
  STZ $2005
  STZ $2006
  STZ $2007
  
  setAXY16
  setA8

  LDA #$80
  STA INIDISP
  STA INIDISP_STATE
  STZ OBSEL
  STZ OAMADDL
  STZ OAMADDH
  STZ BGMODE  
  STZ MOSAIC  
  STZ BG1SC   
  STZ BG2SC   
  STZ BG3SC   
  STZ BG4SC   
  STZ BG12NBA 
  STZ BG34NBA 
  STZ BG1HOFS 
  STZ BG1HOFS
  STZ BG1VOFS
  STZ BG1VOFS
  STZ BG2HOFS
  STZ BG2HOFS
  STZ BG2VOFS
  STZ BG2VOFS
  STZ BG3HOFS
  STZ BG3HOFS
  STZ BG3VOFS
  STZ BG3VOFS
  STZ BG4HOFS
  STZ BG4HOFS
  STZ BG4VOFS
  STZ BG4VOFS

  LDA #$80
  STA VMAIN
  STZ VMADDL
  STZ VMADDH
  STZ M7SEL
  STZ M7A

  LDA #$01
  STA M7A
  STZ M7B
  STZ M7B
  STZ M7C
  STZ M7C
  STZ M7D
  STA M7D
  STZ M7X
  STZ M7X
  STZ M7Y
  STZ M7Y
  STZ CGADD
  STZ W12SEL
  STZ W34SEL
  STZ WOBJSEL
  STZ WH0
  STZ WH1     
  STZ WH2     
  STZ WH3     
  STZ WBGLOG  
  STZ WOBJLOG 
  STZ TM      
  STZ TS      
  STZ TMW     

  LDA #$30
  STA CGWSEL
  STZ CGADSUB

  LDA #$E0
  STA COLDATA
  ; STZ SETINI
  STZ NMITIMEN

  LDA #$FF
  STA WRIO   
  STZ WRMPYA 
  STZ WRMPYB 
  STZ WRDIVL 
  STZ WRDIVH 
  STZ WRDIVB 
  STZ HTIMEL 
  STZ HTIMEH 
  STZ VTIMEL 
  STZ VTIMEH 
  STZ MDMAEN 
  STZ HDMAEN 
  STZ MEMSEL 

  setAXY8
  LDA #$00
  LDY #$40
: DEY
  STA $0900, y
  BNE :-

  LDA #$00
  STA OBSEL
  LDA #$11
  STA BG12NBA
  LDA #$77
  STA BG34NBA
  LDA #$01
  STA BGMODE
  LDA #$22
  STA BG1SC
;   LDA #$32
;   STA BG2SC
;   LDA #$28
;   STA BG3SC
;   LDA #$7C
;   STA BG4SC
  LDA #$80
  STA OAMADDH
  LDA #$11
  STA TMW
  LDA #$02
  STA W12SEL
  STA WOBJSEL
  
  lda #%00010001
  STA TM
  LDA #$01
  STA MEMSEL
  LDA #$00
  STA SETINI

  lda #0000
	sta BG12NBA
  JSR clearvm
  JSR zero_oam

	lda #%0000000
	sta OBSEL

  LDA #$A1
  PHA
  PLB 
  JML $A1C000

snes_nmi:
  LDA RDNMI
  JSR dma_oam_table
  RTL

clearvm:
	setAXY16
  ldx #$2000
  stx VMADDL 
	
	lda #$0112
	
	LDY #$0000
	clear_loop:
		sta VMDATAL
		iny
		CPY #(32*64)
		BNE clear_loop
  
  setAXY8
	RTS

zero_oam:

  setXY16
  ldx #$0000

: stz SNES_OAM_START, x
  lda #$f8
  STA SNES_OAM_START + 1, x
  STZ SNES_OAM_START + 2, x
  STZ SNES_OAM_START + 3, x
  INX
  INX
  INX
  INX
  CPX #$200
  bne :-
: stz SNES_OAM_START, X
  inx
  CPX #$220
  bne :-
  setAXY8
  RTS

translate_nes_sprites_to_oam:
	setXY16
	LDY #$0000

sprite_loop:	
	; byte 1, Tile index
	LDA $201, Y
	STA SNES_OAM_START + 2, y
	; beq empty_sprite

	; byte 0, Tile Y position
	LDA $200,Y
	STA SNES_OAM_START + 1, y

	; byte 3, Tile X Position
	LDA $203, Y
	STA SNES_OAM_START, y 

	; properties
	LDA $202, Y
	PHA
	AND #$03
	ASL A
	STA SPRITE_LOOP_JUNK
	PLA
	AND #$F0
	EOR #%00110000
	ORA SPRITE_LOOP_JUNK
	; LDA #%00010010

	STA SNES_OAM_START + 3, y
	; bra next_sprite

	; empty_sprite:
	; sta SNES_OAM_START, y
	; lda #$f8 
	; sta SNES_OAM_START + 1, y
	; lda #$38
	; sta SNES_OAM_START + 3, y

	next_sprite:
	INY
	INY
	INY
	INY
	CPY #$100
	BNE sprite_loop

  setAXY8
	rtl

dma_oam_table:
  ; setXY16
	; lda #%00000000
	; sta DMAP1
	; lda #<OAMDATA
	; sta BBAD1
	; ldx #.loword(SNES_OAM_START)
	; stx A1T1L
	; lda #^SNES_OAM_START
	; sta A1B1
	; ldx #$220
	; stx DAS1L
	; lda #%00000010
	; sta MDMAEN
  ; setAXY8

  STZ OAMADDL
  STZ OAMADDH
  LDA #<OAMDATA
  STA BBAD0
  LDA #$7E
  STA A1B0

  STZ DMAP0
  LDA #>SNES_OAM_START
  STA A1T0H
  LDA #<SNES_OAM_START
  STA A1T0L
  LDA #$02
  STA DAS0H
  LDA #$20
  STA DAS0L
  LDA #$01
  STA MDMAEN

	RTS

; $45 - number of bytes to copy
; $43 $44 - Source tiles address
; $41 $42 - PPU Target
write_data_to_ppu:
  PHX
  PHY
  PHA

  LDA PPU_CONTROL_STATE
	AND #$7F
	sta NMITIMEN

  LDA VMAIN_CONTROL_STATE
  ORA #$80
  STA VMAIN

  LDA BG_TILE_COUNT
  STA TILES_TO_WRITE
  STZ TILES_TO_WRITE_HB

  ; if this is writing attributes, assume they'll be used by the next group of tiles
  ; Kid Icarus always writes those first, maybe?
  LDA PPU_DEST_LB
  AND #$C0
  CMP #$C0
  ; if we're less than C0 this isn't atributes
  BNE continue_writing

  ; all attributes banks in NES are
  ; 23, 27, 2b, 2f
  LDA PPU_DEST_HB
  AND #$F3
  CMP #$23
  BNE continue_writing

  ; this is attributes, rather than write them store the starting address for use
  LDA PPU_SOURCE_HB
  STA LAST_ATTRIB_LOC_HB
  LDA PPU_SOURCE_LB
  STA LAST_ATTRIB_LOC_LB

  setAXY8
  LDA VMAIN_CONTROL_STATE
  STA VMAIN

  LDA PPU_CONTROL_STATE
  STA NMITIMEN

  PLA
  PLY  
  PLX
   
  RTL 

  ; Not attributes, write tiles as normally
  continue_writing:
  setAXY16

  ldx PPU_DEST_LB
  ; NES tile are 2000-23ff and 2800 - 2Bff, so if we're 2800+ we need to subtract 400
  TXA 
  CMP #$2800
  BMI :+
  SEC
  SBC #$0400
: STA PPU_CURR_VRAM_ADDR
  TAX

  stx VMADDL 
  LDY #$0000     
  STY PPU_TILE_COUNT

  nexttile:            
	; get the attribute data here
	; attribute data depends on which 32x32 square the address is in
	; we actually only care about 1 bits for each quadrant
	; as we only have 2 bytes per tile, and 4 palettes.
	; addresses are always $2000 - $2800, since that's where we were
	; writing tiles.  $2000 - $23FF is the first page, 2400 - 27FF the 2nd
	
	LDA PPU_CURR_VRAM_ADDR
  CMP #$2400
	BPL :+
	; this is just press start, attributes are always AA
	; and attribute data is always 0x0800
	LDA #$0800
	STA PPU_TILE_ATTR
	BRA write_tile_to_vram

:	JSR calculate_attributes_from_address

	write_tile_to_vram:
	LDY PPU_TILE_COUNT
	LDA (PPU_SOURCE_LB),Y
	AND #$00FF
	CLC
  ; add #$0100 to use BG tiles instead of sprite tiles
	ADC #$0100
	ADC PPU_TILE_ATTR
        
	STA VMDATAL
	INY        	
	inc PPU_CURR_VRAM_ADDR      
	STY PPU_TILE_COUNT
	CPY TILES_TO_WRITE
	BNE nexttile    

exit_ppu_copy:

  setAXY8
  
  LDA VMAIN_CONTROL_STATE
  STA VMAIN

  LDA PPU_CONTROL_STATE
  STA NMITIMEN

  PLA
  PLY  
  PLX
   
  RTL

; in mode AXY16
calculate_attributes_from_address:	
  RTS
  PHY
  PHX

  setAXY16
  LDA PPU_CURR_VRAM_ADDR
	; chop off unnecessary address part
	AND #$001F
	LSR A
	LSR A
	; A now has the column
	STA PPU_COL_OFFSET
	LDA PPU_CURR_VRAM_ADDR

	AND #$03E0
	; divide by 32 to get tile row
	LSR A
	LSR A
	LSR A
	LSR A	
	LSR A
	; divide by 4 to get attribute row
	LSR A
	LSR A
	STA PPU_ROW_OFFSET

	; load attribute data row * 8 + column
	ASL A
	ASL A
	ASL A
	ADC PPU_COL_OFFSET
	TAY
  ; LAST_ATTRIB_LOC is where the attributes for the tile are
  LDA (LAST_ATTRIB_LOC_LB), Y
	AND #$00FF
	STA PPU_TILE_ATTR

  ; now figure out which half nibble we need
	; if vram add is odd we want right
	LDA PPU_CURR_VRAM_ADDR
	AND #$007F
	CMP #$0040
	BMI lrcheck
	LSR PPU_TILE_ATTR
	LSR PPU_TILE_ATTR
	LSR PPU_TILE_ATTR
	LSR PPU_TILE_ATTR

	lrcheck:
	LDA PPU_CURR_VRAM_ADDR
	AND #$0002
	
	BEQ done_picking_attributes
	LSR PPU_TILE_ATTR
	LSR PPU_TILE_ATTR

	done_picking_attributes:
	LDA PPU_TILE_ATTR	
	AND #$03
	ASL A
	ASL A
	
	STA PPU_TILE_ATTR	
	ASL A
	ASL A
	ASL A
	ASL A
	ASL A
	ASL A
	ASL A
	ASL A	
	STA PPU_TILE_ATTR
  PLX
  PLY
  RTS

write_palette_data:
  PHX
  PHY
  PHA
  
  

  setAXY8
  LDA #$A0
  
  PHA
  PLB
  LDY #$00
  STZ CGADD
  ; Kid Icarus stores the current palettes at 0x0390
  ; BG is 0390 - 039F
  ; Sprites are 03A0 - 03AF

  ; lookup our 2 byte color from palette_lookup, color * 2
  ; Our palettes are written by writing to CGDATA
palette_entry:
  LDA $0390, Y
  ASL A
  TAX
  LDA palette_lookup, X
  STA CGDATA
  LDA palette_lookup + 1, X
  STA CGDATA
  INY
  ; every 4 we need to write a bunch of empty palette entries
  TYA
  AND #$03
  BNE skip_writing_three_rows
  JSR write_empty_palette_row
  JSR write_empty_palette_row
  JSR write_empty_palette_row
skip_writing_three_rows:
  TYA
  AND #$0F
  CMP #$00
  BNE skip_writing_four_empties
  ; after 16 entries we write an empty set of palettes
  jsr write_empty_palette_set
  jsr write_empty_palette_set
  jsr write_empty_palette_set
  jsr write_empty_palette_set  
skip_writing_four_empties:
  CPY #$20
  BNE palette_entry

  LDA $B6
  INC A
  ORA #$A0
  PHA
  PLB


  PLA
  PLY  
  PLX
  ; done after $20
  RTL

write_empty_palette_set:
  JSR write_empty_palette_row
  JSR write_empty_palette_row
  JSR write_empty_palette_row
  JSR write_empty_palette_row
  RTS

write_empty_palette_row:
  STZ CGDATA
  STZ CGDATA
  STZ CGDATA
  STZ CGDATA
  STZ CGDATA
  STZ CGDATA
  STZ CGDATA
  STZ CGDATA
  RTS


no_scroll_screen_enable:
  STZ BG1VOFS 
  STZ BG1VOFS 
  STZ BG1HOFS
  STZ BG1HOFS
  LDA PPU_CONTROL_STATE               
  AND #$FC                 
  STA PPU_CONTROL_STATE
  LDA #$01
  STA PAUSE_HDMA
  STZ HDMAEN
  RTL 

disable_nmi_force_vblank:
  ; STZ INIDISP
  ; STZ NMITIMEN
  ; STZ PPU_CONTROL_STATE
  
  LDA PPU_CONTROL_STATE
  AND #$7E
  STA PPU_CONTROL_STATE
  STA NMITIMEN

  LDA INIDISP_STATE
  ORA #$80                              
  STA INIDISP                 

  STZ TM
  
  BRA infidelitys_scroll_handling
  
disable_and_store_nmi:
  LDA PPU_CONTROL_STATE
  AND #$7F
  STA NMITIMEN  
  STA PPU_CONTROL_STATE
  BRA infidelitys_scroll_handling


just_disable_nmi:
  LDA PPU_CONTROL_STATE
  AND #$7F
  STA NMITIMEN  
  BRA infidelitys_scroll_handling

enable_and_store_nmi:
  LDA PPU_CONTROL_STATE
  ORA #$80
  STA NMITIMEN
  STA PPU_CONTROL_STATE
  BRA infidelitys_scroll_handling

load_nmitimen_from_state:
  ; for NMITIMEN we only care about bits 7 and 0.
  ; and 0 is always 1.
  LDA PPU_CONTROL_STATE  
  BRA infidelitys_scroll_handling

set_base_name_table_to_2000:
  LDA PPU_CONTROL_STATE
  AND #$FC
  STA PPU_CONTROL_STATE
  RTL

enable_nmi:
  LDA PPU_CONTROL_STATE          
  ORA #$80                 
  STA NMITIMEN      
  STA PPU_CONTROL_STATE       

  LDA INIDISP_STATE
  AND #$7F
  STA INIDISP
  STA INIDISP_STATE

  LDA $FF                  
  AND #$10
  BEQ :+
  
  LDA #$11
  STA TM
  BRA :++
: STZ TM

  ; STA PPU_MASK_STATE  
: BRA infidelitys_scroll_handling


store_to_ppu_control:
  ; A contains a specific value to be set to control state, rather than flipping a few bits
  ; generally NES would do:
  ;     LDA #$10
  ;     STA PPU_CONTROL_STATE
  ;     STA PpuControl_2000
  ; but we need to do a few extra things
  STA PPU_CONTROL_STATE
  ; now fall through to the ppu control handling
  ; this will update the proper NMITIMEN, VMAIN, and V/H OFS

    
infidelitys_scroll_handling:
  LDA PPU_CONTROL_STATE
  PHA 
  AND #$80
  BNE :+
  LDA #$01
  BRA :++
: LDA #$81
: STA NMITIMEN
  PLA        
  PHA 
  AND #$04
  ; A now has the BG table address
  BNE :+
  LDA #$00
  BRA :++
: LDA #$01   
: STA VMAIN 
  PLA 
  AND #$03
  BEQ :+
  CMP #$01
  BEQ :++
  CMP #$02
  BEQ :+++
  CMP #$03
  BEQ :++++
: STZ HOFS_HB
  STZ VOFS_HB
  BRA :++++   ; RTL
: LDA #$01
  STA HOFS_HB
  STZ VOFS_HB
  BRA :+++    ; RTL
: STZ HOFS_HB
  LDA #$01
  STA VOFS_HB
  BRA :++     ; RTL
: LDA #$01
  STA HOFS_HB
  STA VOFS_HB
: RTL 

handle_scroll_values:
  LDA HOFS_LB
  STA BG1HOFS
  LDA HOFS_HB
  STA BG1HOFS
  LDA VOFS_LB
  STA BG1VOFS
  LDA VOFS_HB
  STA BG1VOFS

setup_hdma:
  LDX VOFS_LB
  LDA $A0A080,X
  STA $0900
  LDA $A0A170,X
  STA $0903
  LDA $A0A260,X
  STA $0905
  LDA $A0A350,X
  STA $0908
  LDA $A0A440,X
  STA $090A
  LDA $A0A520,X
  STA $090D
  LDA HOFS_LB
  STA $0901
  STA $0906
  LDA PPU_CONTROL_STATE
  STA $0902
  STA $0907
  STA $090C
  LDX PPU_CONTROL_STATE
  LDA $A0A610,X
  STA $0904
  STA $0909
  STA $090E
  STZ $090B
  STZ $090F

  RTL

nes_951d_copy:
  ; LDA INIDISP_STATE
  ; ORA #$F0
  ; STA INIDISP

  ; LDA VMAIN_CONTROL_STATE
  ; ORA #$F0
  ; STA VMAIN

  setAXY16


  LDA $0481
  STA VMADDL ; STA PpuAddr_2006         
  STA PPU_CURR_VRAM_ADDR
  CMP #$2400
  LDA #(ATTRIBUTE_HOLDING)
  BCC :+
  CLC
  ADC #$0040
: STA LAST_ATTRIB_LOC_LB ; maybe 0x40 if 2nd page
  LDY #$0000                 
: 
  JSR calculate_attributes_from_address
  
  LDA $0483,Y 
  AND #$00FF
  CLC
  ADC #$0100
  ADC PPU_TILE_ATTR
  STA VMDATAL ; PpuData_2007         
  INY       
  INC PPU_CURR_VRAM_ADDR                 
  CPY #$40                 
  BCC :-
    
  setAXY8
  ; LDA INIDISP_STATE
  ; STA INIDISP
  ; LDA VMAIN_CONTROL_STATE
  ; STA VMAIN
  RTL

nes_9537_copy:
         
  LDA #.hibyte(ATTRIBUTE_HOLDING)                 
  STA $02 

  JSR nes96c6_copy              
  LDA $00
  STA $01

  LDA $1A                  
  AND #$01                 
  BNE :+ 
  ; add 40 to the attribute if we're on the 2nd
  ; bg       
  LDA #$40
  ADC $01
  STA $01  
  ; $01.w now contains the address to start 
  ; writing the next 8 attributes                
: JSR nes96c6_copy

  TAX
  LDY #$00
: LDA $03B0,X
  STA ($01),Y
  INX
  INY

  CPY #$08
  BNE :-
          
  RTL 


nes96c6_copy:
  LDA VOFS_LB          
  AND #$E0                 
  LSR A                    
  LSR A                    
  STA $00                  
  RTS 



palette_lookup:
.byte $8C, $31 ; $00 dark grey
.byte $A0, $44 ; $01 nyi
.byte $42, $50 ; $02 dark blue
.byte $00, $00 ; $03 nyi
.byte $00, $00 ; $04 nyi
.byte $0D, $20 ; $05 maroon
.byte $0D, $00 ; $06 burgandy
.byte $6A, $00 ; $07 dark brown
.byte $00, $00 ; $08 nyi
.byte $00, $00 ; $09 nyi
.byte $40, $01 ; $0A dark green
.byte $00, $00 ; $0B nyi
.byte $00, $25 ; $0C dark teal
.byte $00, $00 ; $0D nyi
.byte $00, $00 ; $0E nyi
.byte $00, $00 ; $0F Black

.byte $B5, $56 ; $10 light grey
.byte $62, $6D ; $11 blue
.byte $08, $7D ; $12 light dark blue
.byte $00, $00 ; $13 nyi
.byte $74, $64 ; $14 
.byte $76, $3C ; $15 dark pink
.byte $D6, $10 ; $16 red
.byte $33, $01 ; $17 Brown 0133
.byte $00, $00 ; $18 nyi
.byte $07, $02 ; $19 
.byte $41, $02 ; $1A green
.byte $20, $1A ; $1B green
.byte $E0, $45 ; $1C teal
.byte $00, $00 ; $1D nyi
.byte $00, $00 ; $1E nyi
.byte $00, $00 ; $1F Black

.byte $FF, $7F ; $20 white
.byte $CC, $7E ; $21 sky blue
.byte $52, $7E ; $22 light purple
.byte $D8, $7D ; $23 
.byte $BE, $7D ; $24 pink
.byte $BF, $65 ; $25 
.byte $1F, $3A ; $26 peach
.byte $7D, $12 ; $27 orange
.byte $F7, $02 ; $28 
.byte $00, $00 ; $29 nyi
.byte $8B, $1B ; $2A bright green
.byte $00, $00 ; $2B nyi
.byte $29, $6F ; $2C bright light blue
.byte $00, $00 ; $2D nyi
.byte $00, $00 ; $2E nyi
.byte $00, $00 ; $2F Black

.byte $FF, $7F ; $30 white
.byte $78, $7F ; $31 light blue
.byte $00, $00 ; $32 nyi
.byte $00, $00 ; $33 nyi
.byte $00, $00 ; $34 nyi
.byte $00, $00 ; $35 nyi
.byte $3F, $63 ; $36 
.byte $7E, $53 ; $37 
.byte $9C, $4B ; $38 nyi
.byte $B9, $4B ; $39 nyi
.byte $00, $00 ; $3A nyi
.byte $D6, $67 ; $3B light greenish blue
.byte $00, $00 ; $3C nyi
.byte $00, $00 ; $3D nyi
.byte $00, $00 ; $3E nyi
.byte $00, $00 ; $3F Black

; HDMA Scroll Lookup Tables
; INF addr A0:A0A0
.segment "HDMA_LOOKUP"
; not sure what this is used for, it doesn't seem to be used
.byte $A6, $FC, $BF, $80, $A0, $A0, $8D, $00, $09, $BF, $70, $A1, $A0, $8D, $03, $09
.byte $BF, $60, $A2, $A0, $8D, $05, $09, $BF, $50, $A3, $A0, $8D, $08, $09, $BF, $30
.byte $A4, $A0, $8D, $0A, $09, $BF, $20, $A5, $A0, $8D, $0D, $09, $A5, $FD, $8D, $01
.byte $09, $8D, $06, $09, $A5, $FF, $8D, $02, $09, $8D, $07, $09, $8D, $0C, $09, $A6
.byte $FF, $BF, $10, $A6, $A0, $8D, $04, $09, $8D, $09, $09, $8D, $0E, $09, $9C, $0B
.byte $09, $9C, $0F, $09, $A9, $7E, $8D, $14, $43, $A9, $09, $8D, $13, $43, $9C, $12
.byte $43, $A9, $0D, $8D, $11, $43, $A9, $03, $8D, $10, $43, $A9, $02, $8D, $0C, $42
.byte $6B, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00


scroll_lookup_1:
.byte $6F, $6E, $6D, $6C, $6B, $6A, $69, $68, $67, $66, $65, $64, $63, $62, $61, $60
.byte $5F, $5E, $5D, $5C, $5B, $5A, $59, $58, $57, $56, $55, $54, $53, $52, $51, $50
.byte $4F, $4E, $4D, $4C, $4B, $4A, $49, $48, $47, $46, $45, $44, $43, $42, $41, $40
.byte $3F, $3E, $3D, $3C, $3B, $3A, $39, $38, $37, $36, $35, $34, $33, $32, $31, $30
.byte $2F, $2E, $2D, $2C, $2B, $2A, $29, $28, $27, $26, $25, $24, $23, $22, $21, $20
.byte $1F, $1E, $1D, $1C, $1B, $1A, $19, $18, $17, $16, $15, $14, $13, $12, $11, $10
.byte $0F, $0E, $0D, $0C, $0B, $0A, $09, $08, $07, $06, $05, $04, $03, $02, $01, $80
.byte $7F, $7E, $7D, $7C, $7B, $7A, $79, $78, $77, $76, $75, $74, $73, $72, $71, $70
.byte $6F, $6E, $6D, $6C, $6B, $6A, $69, $68, $67, $66, $65, $64, $63, $62, $61, $60
.byte $5F, $5E, $5D, $5C, $5B, $5A, $59, $58, $57, $56, $55, $54, $53, $52, $51, $50
.byte $4F, $4E, $4D, $4C, $4B, $4A, $49, $48, $47, $46, $45, $44, $43, $42, $41, $40
.byte $3F, $3E, $3D, $3C, $3B, $3A, $39, $38, $37, $36, $35, $34, $33, $32, $31, $30
.byte $2F, $2E, $2D, $2C, $2B, $2A, $29, $28, $27, $26, $25, $24, $23, $22, $21, $20
.byte $1F, $1E, $1D, $1C, $1B, $1A, $19, $18, $17, $16, $15, $14, $13, $12, $11, $10
.byte $0F, $0E, $0D, $0C, $0B, $0A, $09, $08, $07, $06, $05, $04, $03, $02, $01, $6F
scroll_lookup_2:
.byte $00, $01, $02, $03, $04, $05, $06, $07, $08, $09, $0A, $0B, $0C, $0D, $0E, $0F
.byte $10, $11, $12, $13, $14, $15, $16, $17, $18, $19, $1A, $1B, $1C, $1D, $1E, $1F
.byte $20, $21, $22, $23, $24, $25, $26, $27, $28, $29, $2A, $2B, $2C, $2D, $2E, $2F
.byte $30, $31, $32, $33, $34, $35, $36, $37, $38, $39, $3A, $3B, $3C, $3D, $3E, $3F
.byte $40, $41, $42, $43, $44, $45, $46, $47, $48, $49, $4A, $4B, $4C, $4D, $4E, $4F
.byte $50, $51, $52, $53, $54, $55, $56, $57, $58, $59, $5A, $5B, $5C, $5D, $5E, $5F
.byte $60, $61, $62, $63, $64, $65, $66, $67, $68, $69, $6A, $6B, $6C, $6D, $6E, $6F
.byte $70, $71, $72, $73, $74, $75, $76, $77, $78, $79, $7A, $7B, $7C, $7D, $7E, $7F
.byte $80, $81, $82, $83, $84, $85, $86, $87, $88, $89, $8A, $8B, $8C, $8D, $8E, $8F
.byte $90, $91, $92, $93, $94, $95, $96, $97, $98, $99, $9A, $9B, $9C, $9D, $9E, $9F
.byte $A0, $A1, $A2, $A3, $A4, $A5, $A6, $A7, $A8, $A9, $AA, $AB, $AC, $AD, $AE, $AF
.byte $B0, $B1, $B2, $B3, $B4, $B5, $B6, $B7, $B8, $B9, $BA, $BB, $BC, $BD, $BE, $BF
.byte $C0, $C1, $C2, $C3, $C4, $C5, $C6, $C7, $C8, $C9, $CA, $CB, $CC, $CD, $CE, $CF
.byte $D0, $D1, $D2, $D3, $D4, $D5, $D6, $D7, $D8, $D9, $DA, $DB, $DC, $DD, $DE, $DF
.byte $E0, $E1, $E2, $E3, $E4, $E5, $E6, $E7, $E8, $E9, $EA, $EB, $EC, $ED, $EE, $FF
scroll_lookup_3:
.byte $80, $80, $80, $80, $80, $80, $80, $80, $80, $80, $80, $80, $80, $80, $80, $80
.byte $80, $80, $80, $80, $80, $80, $80, $80, $80, $80, $80, $80, $80, $80, $80, $80
.byte $80, $80, $80, $80, $80, $80, $80, $80, $80, $80, $80, $80, $80, $80, $80, $80
.byte $80, $80, $80, $80, $80, $80, $80, $80, $80, $80, $80, $80, $80, $80, $80, $80
.byte $80, $80, $80, $80, $80, $80, $80, $80, $80, $80, $80, $80, $80, $80, $80, $80
.byte $80, $80, $80, $80, $80, $80, $80, $80, $80, $80, $80, $80, $80, $80, $80, $80
.byte $80, $80, $80, $80, $80, $80, $80, $80, $80, $80, $80, $80, $80, $80, $80, $6F
.byte $70, $71, $72, $73, $74, $75, $76, $77, $78, $79, $7A, $7B, $7C, $7D, $7E, $7F
.byte $80, $01, $02, $03, $04, $05, $06, $07, $08, $09, $0A, $0B, $0C, $0D, $0E, $0F
.byte $10, $11, $12, $13, $14, $15, $16, $17, $18, $19, $1A, $1B, $1C, $1D, $1E, $1F
.byte $20, $21, $22, $23, $24, $25, $26, $27, $28, $29, $2A, $2B, $2C, $2D, $2E, $2F
.byte $30, $31, $32, $33, $34, $35, $36, $37, $38, $39, $3A, $3B, $3C, $3D, $3E, $3F
.byte $40, $41, $42, $43, $44, $45, $46, $47, $48, $49, $4A, $4B, $4C, $4D, $4E, $4F
.byte $50, $51, $52, $53, $54, $55, $56, $57, $58, $59, $5A, $5B, $5C, $5D, $5E, $5F
.byte $60, $61, $62, $63, $64, $65, $66, $67, $68, $69, $6A, $6B, $6C, $6D, $6E, $80
scroll_lookup_4:
.byte $00, $01, $02, $03, $04, $05, $06, $07, $08, $09, $0A, $0B, $0C, $0D, $0E, $0F
.byte $10, $11, $12, $13, $14, $15, $16, $17, $18, $19, $1A, $1B, $1C, $1D, $1E, $1F
.byte $20, $21, $22, $23, $24, $25, $26, $27, $28, $29, $2A, $2B, $2C, $2D, $2E, $2F
.byte $30, $31, $32, $33, $34, $35, $36, $37, $38, $39, $3A, $3B, $3C, $3D, $3E, $3F
.byte $40, $41, $42, $43, $44, $45, $46, $47, $48, $49, $4A, $4B, $4C, $4D, $4E, $4F
.byte $50, $51, $52, $53, $54, $55, $56, $57, $58, $59, $5A, $5B, $5C, $5D, $5E, $5F
.byte $60, $61, $62, $63, $64, $65, $66, $67, $68, $69, $6A, $6B, $6C, $6D, $6E, $7F
.byte $80, $81, $82, $83, $84, $85, $86, $87, $88, $89, $8A, $8B, $8C, $8D, $8E, $8F
.byte $90, $91, $92, $93, $94, $95, $96, $97, $98, $99, $9A, $9B, $9C, $9D, $9E, $9F
.byte $A0, $A1, $A2, $A3, $A4, $A5, $A6, $A7, $A8, $A9, $AA, $AB, $AC, $AD, $AE, $AF
.byte $B0, $B1, $B2, $B3, $B4, $B5, $B6, $B7, $B8, $B9, $BA, $BB, $BC, $BD, $BE, $BF
.byte $C0, $C1, $C2, $C3, $C4, $C5, $C6, $C7, $C8, $C9, $CA, $CB, $CC, $CD, $CE, $CF
.byte $D0, $D1, $D2, $D3, $D4, $D5, $D6, $D7, $D8, $D9, $DA, $DB, $DC, $DD, $DE, $DF
.byte $E0, $E1, $E2, $E3, $E4, $E5, $E6, $E7, $E8, $E9, $EA, $EB, $EC, $ED, $EE, $EF
.byte $F0, $F1, $F2, $F3, $F4, $F5, $F6, $F7, $F8, $F9, $FA, $FB, $FC, $FD, $FE, $FF
scroll_lookup_5:
.byte $10, $11, $12, $13, $14, $15, $16, $17, $18, $19, $1A, $1B, $1C, $1D, $1E, $1F
.byte $20, $21, $22, $23, $24, $25, $26, $27, $28, $29, $2A, $2B, $2C, $2D, $2E, $2F
.byte $30, $31, $32, $33, $34, $35, $36, $37, $38, $39, $3A, $3B, $3C, $3D, $3E, $3F
.byte $40, $41, $42, $43, $44, $45, $46, $47, $48, $49, $4A, $4B, $4C, $4D, $4E, $4F
.byte $50, $51, $52, $53, $54, $55, $56, $57, $58, $59, $5A, $5B, $5C, $5D, $5E, $5F
.byte $60, $61, $62, $63, $64, $65, $66, $67, $68, $69, $6A, $6B, $6C, $6D, $6E, $80
.byte $80, $80, $80, $80, $80, $80, $80, $80, $80, $80, $80, $80, $80, $80, $80, $80
.byte $80, $80, $80, $80, $80, $80, $80, $80, $80, $80, $80, $80, $80, $80, $80, $80
.byte $80, $80, $80, $80, $80, $80, $80, $80, $80, $80, $80, $80, $80, $80, $80, $80
.byte $80, $80, $80, $80, $80, $80, $80, $80, $80, $80, $80, $80, $80, $80, $80, $80
.byte $80, $80, $80, $80, $80, $80, $80, $80, $80, $80, $80, $80, $80, $80, $80, $80
.byte $80, $80, $80, $80, $80, $80, $80, $80, $80, $80, $80, $80, $80, $80, $80, $80
.byte $80, $80, $80, $80, $80, $80, $80, $80, $80, $80, $80, $80, $80, $80, $80, $80
.byte $80, $80, $80, $80, $80, $80, $80, $80, $80, $80, $80, $80, $80, $80, $80, $00
scroll_lookup_6:
.byte $00, $11, $12, $13, $14, $15, $16, $17, $18, $19, $1A, $1B, $1C, $1D, $1E, $1F
.byte $20, $21, $22, $23, $24, $25, $26, $27, $28, $29, $2A, $2B, $2C, $2D, $2E, $2F
.byte $30, $31, $32, $33, $34, $35, $36, $37, $38, $39, $3A, $3B, $3C, $3D, $3E, $3F
.byte $40, $41, $42, $43, $44, $45, $46, $47, $48, $49, $4A, $4B, $4C, $4D, $4E, $4F
.byte $50, $51, $52, $53, $54, $55, $56, $57, $58, $59, $5A, $5B, $5C, $5D, $5E, $5F
.byte $60, $61, $62, $63, $64, $65, $66, $67, $68, $69, $6A, $6B, $6C, $6D, $6E, $6F
.byte $70, $71, $72, $73, $74, $75, $76, $77, $78, $79, $7A, $7B, $7C, $7D, $7E, $7E
.byte $7E, $7E, $7E, $7E, $7E, $7E, $7E, $7E, $7E, $7E, $7E, $7E, $7E, $7E, $7E, $7E
.byte $7E, $91, $92, $93, $94, $95, $96, $97, $98, $99, $9A, $9B, $9C, $9D, $9E, $9F
.byte $A0, $A1, $A2, $A3, $A4, $A5, $A6, $A7, $A8, $A9, $AA, $AB, $AC, $AD, $AE, $AF
.byte $B0, $B1, $B2, $B3, $B4, $B5, $B6, $B7, $B8, $B9, $BA, $BB, $BC, $BD, $BE, $BF
.byte $C0, $C1, $C2, $C3, $C4, $C5, $C6, $C7, $C8, $C9, $CA, $CB, $CC, $CD, $CE, $CF
.byte $D0, $D1, $D2, $D3, $D4, $D5, $D6, $D7, $D8, $D9, $DA, $DB, $DC, $DD, $DE, $DF
.byte $E0, $E1, $E2, $E3, $E4, $E5, $E6, $E7, $E8, $E9, $EA, $EB, $EC, $ED, $EE, $EF
.byte $F0, $F1, $F2, $F3, $F4, $F5, $F6, $F7, $F8, $F9, $FA, $FB, $FC, $FD, $FE, $FE
scroll_lookup_7:
.byte $80, $80, $81, $81, $82, $82, $83, $83, $84, $84, $85, $85, $86, $86, $87, $87
.byte $88, $88, $89, $89, $8A, $8A, $8B, $8B, $8C, $8C, $8D, $8D, $8E, $8E, $8F, $8F
.byte $90, $90, $91, $91, $92, $92, $93, $93, $94, $94, $95, $95, $96, $96, $97, $97
.byte $98, $98, $99, $99, $9A, $9A, $9B, $9B, $9C, $9C, $9D, $9D, $9E, $9E, $9F, $9F
.byte $A0, $A0, $A1, $A1, $A2, $A2, $A3, $A3, $A4, $A4, $A5, $A5, $A6, $A6, $A7, $A7
.byte $A8, $A8, $A9, $A9, $AA, $AA, $AB, $AB, $AC, $AC, $AD, $AD, $AE, $AE, $AF, $AF
.byte $B0, $B0, $B1, $B1, $B2, $B2, $B3, $B3, $B4, $B4, $B5, $B5, $B6, $B6, $B7, $B7
.byte $B8, $B8, $B9, $B9, $BA, $BA, $BB, $BB, $BC, $BC, $BD, $BD, $BE, $BE, $BF, $BF
.byte $C0, $C0, $C1, $C1, $C2, $C2, $C3, $C3, $C4, $C4, $C5, $C5, $C6, $C6, $C7, $C7
.byte $C8, $C8, $C9, $C9, $CA, $CA, $CB, $CB, $CC, $CC, $CD, $CD, $CE, $CE, $CF, $CF
.byte $D0, $D0, $D1, $D1, $D2, $D2, $D3, $D3, $D4, $D4, $D5, $D5, $D6, $D6, $D7, $D7
.byte $D8, $D8, $D9, $D9, $DA, $DA, $DB, $DB, $DC, $DC, $DD, $DD, $DE, $DE, $DF, $DF
.byte $E0, $E0, $E1, $E1, $E2, $E2, $E3, $E3, $E4, $E4, $E5, $E5, $E6, $E6, $E7, $E7
.byte $E8, $E8, $E9, $E9, $EA, $EA, $EB, $EB, $EC, $EC, $ED, $ED, $EE, $EE, $EF, $EF
.byte $F0, $F0, $F1, $F1, $F2, $F2, $F3, $F3, $F4, $F4, $F5, $F5, $F6, $F6, $F7, $F7
.byte $F8, $F8, $F9, $F9, $FA, $FA, $FB, $FB, $FC, $FC, $FD, $FD, $FE, $FE, $FF, $FF


.segment "PRGA0C"
fixeda0:
.include "bank_fixed.asm"
fixeda0_end: