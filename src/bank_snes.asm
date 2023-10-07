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
  STZ SETINI
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
  
  lda #%00000001
  STA TM
  LDA #$01
  STA MEMSEL
  LDA #$04
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
; A should be the address of the NES PpuData we're writing
calculate_attributes_from_address:	
  setAXY16
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
  ; LAST_ATTRIB_LOC is where the attributes for the 
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

disable_nmi_force_vblank:
  ; STZ INIDISP
  ; STZ NMITIMEN
  ; STZ PPU_CONTROL_STATE
  
  LDA PPU_CONTROL_STATE
  AND #$7E
  STA PPU_CONTROL_STATE
  STA NMITIMEN

  LDA #$80                              
  STA INIDISP                  ;STA PpuMask_2001  
  
  BRA infidelitys_scroll_handling
              
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
  RTL 

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
.byte $74, $64 ; $14 nyi
.byte $76, $3C ; $15 dark pink
.byte $D6, $10 ; $16 red
.byte $33, $01 ; $17 Brown 0133
.byte $00, $00 ; $18 nyi
.byte $07, $02 ; $19 nyi
.byte $00, $00 ; $1A nyi
.byte $00, $00 ; $1B nyi
.byte $E0, $45 ; $1C teal
.byte $00, $00 ; $1D nyi
.byte $00, $00 ; $1E nyi
.byte $00, $00 ; $1F Black

.byte $FF, $7F ; $20 white
.byte $00, $00 ; $21 nyi
.byte $52, $7E ; $22 light purple
.byte $D8, $7D ; $23 nyi
.byte $BE, $7D ; $24 pink
.byte $BF, $65 ; $25 nyi
.byte $1F, $3A ; $26 peach
.byte $7D, $12 ; $27 orange
.byte $F7, $02 ; $28 nyi
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
.byte $00, $00 ; $36 nyi
.byte $00, $00 ; $37 nyi
.byte $9C, $4B ; $38 nyi
.byte $00, $00 ; $39 nyi
.byte $00, $00 ; $3A nyi
.byte $00, $00 ; $3B nyi
.byte $00, $00 ; $3C nyi
.byte $00, $00 ; $3D nyi
.byte $00, $00 ; $3E nyi
.byte $00, $00 ; $3F Black

.segment "PRGA0C"
fixeda0:
.include "bank_fixed.asm"
fixeda0_end: