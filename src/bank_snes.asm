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
  ; STZ BG12NBA 
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

  STZ STORED_OFFSETS_SET
  STZ UNPAUSE_BG1_VOFS_LB
  STZ UNPAUSE_BG1_VOFS_HB
  STZ UNPAUSE_BG1_HOFS_LB
  STZ UNPAUSE_BG1_HOFS_HB

  setAXY8
  LDA #$00
  LDY #$0F
: STA ATTRIBUTE_DMA, Y
  STA COLUMN_1_DMA, Y
  DEY
  BNE :-

  LDY #$40
: DEY
  STA $0900, y
  BNE :-


  ; lda #0000
	; sta BG12NBA
  JSR clearvm
  JSR zero_oam  
  JSR dma_oam_table
  
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


	lda #%0000000
	sta OBSEL

  JSR zero_attribute_buffer

  STZ ATTR_NES_HAS_VALUES
  STZ ATTR_NES_VM_ADDR_HB
  STZ ATTR_NES_VM_ADDR_LB
  STZ ATTR_NES_VM_ATTR_START
  STZ ATTRIBUTE_DMA
  STZ COL_ATTR_HAS_VALUES
  STZ COLUMN_1_DMA

  JSL upload_sound_emulator_to_spc

  LDA #$A1
  PHA
  PLB 
  JML $A1C000

snes_nmi:
  LDA RDNMI
  JSR dma_oam_table
  JSR disable_attribute_buffer_copy
  JSR check_and_copy_attribute_buffer
  RTL

clearvm:
	setAXY16
  ldx #$2000
  stx VMADDL 
	
	lda #$0012
	
	LDY #$0000
	clear_loop:
		sta VMDATAL
		iny
		CPY #(32*64)
		BNE clear_loop
  
  setAXY8
	RTS

zero_attribute_buffer:
  LDY #$00
  LDA #$00

: STA ATTRIBUTE_CACHE, Y
  STA ATTRIBUTE_CACHE + 256, Y
  STA SOUND_EMULATOR_BUFFER_START, Y
  STA SOUND_EMULATOR_BUFFER_START + 256, Y
  INY
  BNE :-

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
  ; Kid Icarus always writes those first, maybe?  nope.
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

:	NOP
  ;JSR calculate_attributes_from_address

	write_tile_to_vram:
	LDY PPU_TILE_COUNT
	LDA (PPU_SOURCE_LB),Y
	AND #$00FF
	CLC
  ; add #$0100 to use BG tiles instead of sprite tiles
	; ADC #$0100
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
  rts
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
  LDA ATTRIBUTE_HOLDING, Y
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
  CLC
  ; ADC #$0100
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

reset_to_stored_screen_offsets:
  LDA STORED_OFFSETS_SET
  BEQ :+
  LDA UNPAUSE_BG1_HOFS_LB
  STA HOFS_LB
  LDA UNPAUSE_BG1_HOFS_HB
  STA HOFS_HB
  LDA UNPAUSE_BG1_VOFS_LB
  STA VOFS_LB
  LDA UNPAUSE_BG1_VOFS_HB
  STA VOFS_HB

  STZ STORED_OFFSETS_SET
: RTL

no_scroll_screen_enable:
  LDA HOFS_LB
  STA UNPAUSE_BG1_HOFS_LB
  LDA HOFS_HB
  STA UNPAUSE_BG1_HOFS_HB
  LDA VOFS_LB
  STA UNPAUSE_BG1_VOFS_LB
  LDA VOFS_HB
  STA UNPAUSE_BG1_VOFS_HB

  STZ HOFS_LB 
  STZ HOFS_HB 
  STZ VOFS_LB
  STZ VOFS_HB
  INC STORED_OFFSETS_SET

  LDA PPU_CONTROL_STATE               
  AND #$FC                 
  STA PPU_CONTROL_STATE
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
  ; JSR calculate_attributes_from_address
  
  LDA $0483,Y 
  AND #$00FF
  CLC
  ; ADC #$0100
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

veritcal_scroll_attribute_handle:
nes_9537_copy:
         
  JSR nes96c6_copy        
  LDA $00                  
  CLC                      
  ADC #$C0
  STA $01                  
  LDA #$23                 
  STA $02                  
  LDA $1A                  
  AND #$01                 
  BNE :+        
  LDA #$27         
  STA $02        
: LDA $02                  
  STA ATTR_NES_VM_ADDR_HB      
  LDA $01                 
  STA ATTR_NES_VM_ADDR_LB      
  JSR nes96c6_copy              
  TAX                     
  LDY #$00  
: LDA $03B0,X              
  STA ATTR_NES_VM_ATTR_START, Y     
  INX                      
  INY     
  CPY #$08                 
  BNE :-         

  STY ATTR_NES_VM_COUNT

  LDA #$00
  STA ATTR_NES_VM_ATTR_START, Y          
  INC ATTR_NES_HAS_VALUES
  RTL 


nes96c6_copy:
  LDA VOFS_LB          
  AND #$E0                 
  LSR A                    
  LSR A                    
  STA $00                  
  RTS 

nes_03_b689_copy:
  JSR nes_03_b7eb_copy
  LDY #$00
: TYA
  ASL
  ASL
  ASL
  CLC
  ADC $00
  STA $03
  CLC
  ADC #$C0
  PHA
  LDA $1B
  EOR #$01
  AND #$01
  ASL
  ASL
  ORA #$23
  NOP ; LDX $2002
  NOP
  NOP
  STA VMADDH
  PLA
  STA VMADDL
  LDX $03
  LDA $03B0,X
  STA VMDATAL
  INY
  CPY #$08
  BCC :-
  RTS

nes_03_b7eb_copy:
  LDA #$00
  STA $00
  LDA $FE
  AND #$E0
  ASL A
  ROL $00
  ASL A
  ROL $00
  ASL A
  ROL $00
  RTS


; copy of 02:AC47
horizontal_attribute_scroll_handle:
  JSR nes_02_ada9_copy
  LDY #$00
  STZ COL_ATTR_VM_COUNT
  STZ COL_ATTR_LB_SET

: INC COL_ATTR_VM_COUNT
  TYA
  ASL A
  ASL A
  ASL A
  CLC
  ADC $00
  STA $03
  CLC
  ADC #$C0
  PHA
  LDA $1B
  EOR #$01
  AND #$01
  ASL A
  ASL A
  ORA #$23  
  PHA
  LDA COL_ATTR_LB_SET
  BNE :+
  PLA
  STA COL_ATTR_VM_HB
  PLA  
  STA COL_ATTR_VM_LB  
  INC COL_ATTR_LB_SET
  BRA :++
: PLA  
  PLA
: LDX $03
  LDA $03B0,X
  STA COL_ATTR_VM_START, Y
  INY
  CPY #$08
  BCC :---
  LDA #$00

  STA COL_ATTR_VM_START, Y
  INC COL_ATTR_HAS_VALUES
  ; would normall do this during screen but for now just do it in line
  JSR convert_column_of_tiles

  RTL

nes_02_ada9_copy:
  LDA #$00
  STA $00
  LDA $FE
  AND #$E0
  ASL A
  ROL $00
  ASL A
  ROL $00
  ASL A
  ROL $00
  RTS

handle_title_screen_a236_attributes:
  LDA $A0
  PHA
  PLB
  ; PUSH START BUTTON, this whole screen is just $AA
  LDA #$23
  STA ATTR_NES_VM_ADDR_HB
  LDA #$C0
  STA ATTR_NES_VM_ADDR_LB
  
  LDX #$02

: LDY #$00
  LDA #$AA

: STA ATTR_NES_VM_ATTR_START, Y
  INY
  CPY #$20
  BNE :-

  LDA #$00
  STA ATTR_NES_VM_ATTR_START, Y

  LDA #$20
  STA ATTR_NES_VM_COUNT
  
  LDA #$01
  STA ATTR_NES_HAS_VALUES

  PHX
  JSL convert_nes_attributes_and_immediately_dma_them
  PLX

  DEX
  BEQ :+

  LDA #$E0
  STA ATTR_NES_VM_ADDR_LB
  LDA #$23
  STA ATTR_NES_VM_ADDR_HB  
  BRA :--

  ; Now for title graphics
: LDA #$00
  STA $46

  LDA #$27
  STA ATTR_NES_VM_ADDR_HB
  LDA #$C0
  STA ATTR_NES_VM_ADDR_LB
  LDY #$00

: LDX #$00
: LDA title_screen_attributes, Y
  STA ATTR_NES_VM_ATTR_START, X
  INY
  INX
  CPX #$20
  BNE :-

  LDA #$00
  STA ATTR_NES_VM_ATTR_START, X

  LDA #$20
  STA ATTR_NES_VM_COUNT
  
  LDA #$01
  STA ATTR_NES_HAS_VALUES

  PHX
  PHY
  JSL convert_nes_attributes_and_immediately_dma_them
  PLY
  PLX

  CPY #$40
  BEQ :+

  LDA #$E0
  STA ATTR_NES_VM_ADDR_LB
  LDA #$27
  STA ATTR_NES_VM_ADDR_HB  
  BRA :--

: RTL

title_screen_attributes:
.byte $00, $00, $00, $00, $80, $AA, $A2, $A0, $AA, $22, $00, $00, $08, $0A, $0A, $0A
.byte $CE, $FF, $FC, $F0, $55, $55, $55, $00, $CC, $FF, $FF, $FF, $FF, $FF, $FF, $03
.byte $00, $00, $0C, $0F, $0F, $0F, $FF, $33, $80, $A0, $20, $00, $00, $88, $A2, $00
.byte $8A, $AA, $0A, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00


convert_attributes:
  PHY
  PHX

  setAXY16
  LDA #$2000
  LDY #$0000
  STA PPU_CURR_VRAM_ADDR
: JSR calculate_attributes_from_address

  LDA PPU_TILE_ATTR
  AND #$FF00
  LSR
  LSR
  LSR
  LSR
  LSR
  LSR
  LSR
  LSR
  STA ATTRIBUTE_CACHE, Y  

  INC PPU_CURR_VRAM_ADDR
  INY
  CPY #$0200
  BNE :-

  setAXY8
  PLX
  PLY
  RTL

check_and_copy_attribute_buffer:
  LDA ATTRIBUTE_DMA
  BEQ :+
  JSR copy_prepped_attributes_to_vram
: LDA COLUMN_1_DMA
  BEQ :+
  JSR dma_column_attributes
: RTS

copy_prepped_attributes_to_vram:
  STZ ATTRIBUTE_DMA
  LDA #$80
  STA VMAIN
  STZ DMAP0
  LDA #$19
  STA BBAD0
: LDX ATTRIBUTE_DMA + 1
  LDA #$7E
  STA A1B0
  LDA ATTR_DMA_SRC_HB,X
  STA A1T0H
  LDA ATTR_DMA_SRC_DB,X
  STA A1T0L
  LDA ATTR_DMA_SIZE_LB,X
  STA DAS0L
  LDA ATTR_DMA_SIZE_HB,X
  STA DAS0H
  LDA ATTR_DMA_VMADDH,X
  STA VMADDH
  LDA ATTR_DMA_VMADDL,X
  STA VMADDL
  LDA #$01
  STA MDMAEN
  DEC ATTRIBUTE_DMA + 1
  LDA ATTRIBUTE_DMA + 1
  BPL :-
  LDY #$0F
  LDA #$00
: STA ATTRIBUTE_DMA,Y
  DEY
  BPL :-
  LDA #$FF
  STA ATTRIBUTE_DMA + 1
  RTS

disable_attribute_buffer_copy:
  STZ ATTR_NES_VM_ADDR_HB
  STZ ATTR_NES_HAS_VALUES
  ; STZ ATTR_DMA_SIZE_LB
  RTS


attr_lookup_table_1_inf_9450:
.byte $00, $04, $08, $0C, $10, $14, $18, $1C, $80, $84, $88, $8C, $90, $94, $98, $9C

inf_95AE:
.byte $EA, $A1 
inf_95B0:
.byte $00, $D0, $06, $A9, $FF, $8D, $F0, $17, $6B, $4C, $20, $97, $00, $00, $01, $01
attr_lookup_table_2_inf_95C0:
.byte $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $02, $00
.byte $10, $20, $30, $40, $50, $60, $70, $80, $90, $A0, $B0, $C0, $D0, $E0, $F0, $00
.byte $10, $20, $30, $40, $50, $60, $70, $80, $90, $A0, $B0, $C0, $D0, $E0, $F0, $00

; $0C $0D contains address to load 40 attributes
; we always load it as if it's coming from 23C0 - 23FF
load_0x40_attributes_from_ram_for_pause:
  ; 20 at a time
  LDX #$00
  LDY #$00
  LDA #$C0
: STA ATTR_NES_VM_ADDR_LB
  LDA #$23
  STA ATTR_NES_VM_ADDR_HB
  LDA #$20
  STA ATTR_NES_VM_COUNT

: LDA ($0C), Y
  STA ATTR_NES_VM_ATTR_START, X
  INY
  INX
  CPX #$20
  BNE :-

  LDA #$00
  STA ATTR_NES_VM_ATTR_START, X
  LDA #$01
  STA ATTR_NES_HAS_VALUES
  PHY
  JSL convert_nes_attributes_and_immediately_dma_them
  PLY
  LDA #$E0
  LDX #$00
  CPY #$40
  BNE:--

  RTL


load_0x40_attributes_for_lvl3:
  ; 20 at a time
  LDX #$00
  LDY #$00
  LDA $0481
: STA ATTR_NES_VM_ADDR_LB
  LDA $0482
  STA ATTR_NES_VM_ADDR_HB
  LDA #$20
  STA ATTR_NES_VM_COUNT

: LDA $0483, Y
  STA ATTR_NES_VM_ATTR_START, X
  INY
  INX
  CPX #$20
  BNE :-

  LDA #$00
  STA ATTR_NES_VM_ATTR_START, X
  LDA #$01
  STA ATTR_NES_HAS_VALUES
  PHY
  JSL convert_nes_attributes_and_immediately_dma_them
  PLY
  LDA #$E0
  LDX #$00
  CPY #$40
  BNE:--

  RTL



convert_nes_attributes_and_immediately_dma_them:
  JSR check_and_copy_nes_attributes_to_buffer
  JSR check_and_copy_column_attributes_to_buffer
  JSR check_and_copy_attribute_buffer
  RTL

; converts attributes stored at 9A0 - A07 to attribute cache
; When we write to VRAM 23C0 - 23FF or 27C0 - 27FF we also must write it to 9A4 - 9E3 
; and 9e8 - a27
check_and_copy_nes_attributes_to_buffer:
  LDA ATTR_NES_HAS_VALUES
  BNE convert_attributes_inf
  RTS
convert_attributes_inf:
  PHK
  PLB
  LDX #$00
  JSR disable_attribute_hdma
  LDA #$A1
  STA $00
  LDA #$09
  STA $01
  STZ ATTR_DMA_SRC_DB
  STZ ATTR_DMA_SRC_DB + 1
  LDA #$18
  STA ATTR_DMA_SRC_HB
  LDA #$1A
  STA ATTR_DMA_SRC_HB + 1
  LDY #$00  
inf_9497:
  LDA ($00),Y ; $00.w is $09A1 to start
  ; early rtl
  BEQ check_and_copy_nes_attributes_to_buffer + 5
  AND #$03
  CMP #$03
  BEQ :+
  JMP inf_9700
: INY
  LDA ($00),Y
  AND #$F0
  CMP #$C0
  BEQ :+
  CMP #$D0
  BEQ :+
  CMP #$E0
  BEQ :+
  CMP #$F0
  BEQ :+
  JMP inf_9700 + 1
: JSR inc_attribute_hdma_store_to_x
  PHY
  AND #$0F
  TAY
  LDA attr_lookup_table_1_inf_9450,Y
  PLY
  LDA ($00),Y
  AND #$0F
  ASL A
  ASL a
  ASL a
  ASL A
  STA ATTR_DMA_VMADDL,X
  LDA ($00),Y
  AND #$30
  LSR
  LSR
  LSR
  LSR
  ORA #$20
  XBA
  DEY
  LDA ($00),Y
  CMP #$24
  BMI :+
  LDA #$00
  XBA
  INC
  INC
  INC
  INC
  STA ATTR_DMA_VMADDH,X
  BRA :++
: LDA #$00
  XBA
  STA ATTR_DMA_VMADDH,X
: INY
  INY
  LDA ($00),Y
  AND #$3F
  PHX
  TAX
  LDA attr_lookup_table_2_inf_95C0 + 15,X
  PLX
  STA ATTR_DMA_SIZE_LB,X
  LDA ($00),Y
  AND #$3F  
  CMP #$0F
  BPL :+
  LDA #$00
  BRA :++
: PHX
  TAX
  LDA inf_95AE,X
  PLX
: STA ATTR_DMA_SIZE_HB,X
  ; LDA #$80
  ; STA ATTR_DMA_SIZE_LB
  ; STZ ATTR_DMA_SIZE_HB
  LDA ($00),Y
  STA ATTRIBUTE_DMA + 14
  STA ATTRIBUTE_DMA + 15
  LDA ATTRIBUTE_DMA + 2,X
  STA $03
  LDA ATTRIBUTE_DMA + 4,X
  STA $02
  INY
  INY
  TYX
  LDA #$A0
  STA $00
  TYA
  CLC
  ADC $00
  STA $00
  BRA :+
inf_952D:  
  INC $00
: JSR inf_9680
  NOP
  LDA ($00,X)
  PHA
  AND #$03
  TAX
  LDA attr_lookup_table_1_inf_9450,X
  STA ($02),Y
  INY
  STA ($02),Y
  LDY #$20
  STA ($02),Y
  INY
  STA ($02),Y
  LDY #$02
  PLA
  PHA
  AND #$0C
  STA ($02),Y
  INY
  STA ($02),Y
  LDY #$22
  STA ($02),Y
  INY
  STA ($02),Y
  LDY #$40
  PLA
  PHA
  AND #$30
  LSR
  LSR
  LSR
  LSR
  TAX
  LDA attr_lookup_table_1_inf_9450,X
  STA ($02),Y
  INY
  STA ($02),Y
  LDY #$60
  STA ($02),Y
  INY
  STA ($02),Y
  LDY #$42
  PLA
  AND #$C0
  LSR
  LSR
  LSR
  LSR
  STA ($02),Y
  INY
  STA ($02),Y
  LDY #$62
  STA ($02),Y
  INY
  STA ($02),Y
  LDA $02
  CLC
  ADC #$04
  STA $02
  CMP #$20
  BEQ :+
  CMP #$A0
  BNE :++
: CLC
  ADC #$60
  STA $02
  BNE :+
  INC $03
: DEC ATTRIBUTE_DMA + 14
  LDA ATTRIBUTE_DMA + 14
  BEQ :+
  BRA inf_952D
: JSR inf_9690
  NOP
  LDA ($00,X)
  BNE inf_95b9

  STZ ATTR_NES_HAS_VALUES
  LDA #$FF
  STA ATTRIBUTE_DMA
  RTS

inf_95b9:
  ; i can't find this getting called, and 9720 looks non-sensical to me
  JMP inf_9720

inc_attribute_hdma_store_to_x:
  INC ATTRIBUTE_DMA + 1
  LDX ATTRIBUTE_DMA + 1
  RTS


disable_attribute_hdma:
  LDA #$FF
  STA ATTRIBUTE_DMA + 1
  RTS

inf_9680:
  LDA $00
  BNE :+
  INC $01
: LDX #$00
  LDY #$00
  RTS


inf_9690:
  LDA #$FF
  STA ATTRIBUTE_DMA
  INC $00
  LDX #$00
  RTS

inf_9700:
  INY
  INY
  LDA $02
  PHA
  STY $02
  LDA ($00),Y
  AND #$3F
  CLC
  ADC $02
  INC
  TAY
  PLA
  STA $02
  JMP inf_9497

inf_9720:
  LDA $02
  PHA
  STZ $02
: LDA $00
  CMP #$A1
  BEQ :+
  DEC $00
  INC $02
  BRA :-
: LDY $02
  PLA
  STA $02
  JMP inf_9497

; this replaces EB21 in bank 2 so we can do more stuff in the main loop
nes_eb21_replacement:
  LDA $26
  ROR
  ROR
  CLC
  ADC #$03
  CLC
  ADC #$20
  STA $26

  ; do my own stuff now
  ; would like to do this here too, but need to find the right spot everywhere
  ; so for now i'm doing it at the end of NMI
  ; JSR translate_nes_sprites_to_oam
  JSR check_and_copy_nes_attributes_to_buffer

  RTL
  
nes_ef39_load_3b0_to_3ff_to_attributes:
  LDA #$23
  STA FULL_ATTRIBUTE_COPY_HB
  LDA #$B0
  STA FULL_ATTRIBUTE_COPY_SRC_LB
  LDA #$03
  STA FULL_ATTRIBUTE_COPY_SRC_HB
  JSR copy_full_screen_attributes

  LDA #$27
  STA FULL_ATTRIBUTE_COPY_HB
  LDA #$F0
  STA FULL_ATTRIBUTE_COPY_SRC_LB
  LDA #$03
  STA FULL_ATTRIBUTE_COPY_SRC_HB
  JSR copy_full_screen_attributes

  RTL 
  
copy_full_screen_attributes:
  LDX #$00
  LDY #$00
  LDA #$C0
: STA ATTR_NES_VM_ADDR_LB
  LDA FULL_ATTRIBUTE_COPY_HB
  STA ATTR_NES_VM_ADDR_HB

  LDA #$20
  STA ATTR_NES_VM_COUNT

: LDA (FULL_ATTRIBUTE_COPY_SRC_LB), Y
  STA ATTR_NES_VM_ATTR_START, X
  INY
  INX
  CPX #$20
  BNE :-

  LDA #$00
  STA ATTR_NES_VM_ATTR_START, X
  LDA #$01
  STA ATTR_NES_HAS_VALUES
  PHY
  JSL convert_nes_attributes_and_immediately_dma_them
  PLY
  LDA #$E0
  LDX #$00
  CPY #$40
  BNE:--
  RTS

check_and_copy_column_attributes_to_buffer:
  LDA COL_ATTR_HAS_VALUES
  BNE convert_column_of_tiles
  RTS

convert_column_of_tiles:
  LDA COL_ATTR_VM_HB
  ; early rtl
  BNE :+
  RTL
: LDA COL_ATTR_VM_LB
  AND #$F0
  CMP #$C0
  BEQ :+
  CMP #$D0
  BEQ :+
  CMP #$E0
  BEQ :+
  CMP #$F0
  BEQ :+
  RTL
: 
  ; LDA COL_ATTR_VM_LB
  ; PHY
  ; AND #$0F
  ; TAY
  ; LDA attr_lookup_table_1_inf_9450,Y
  ; PLY
  LDA COL_ATTR_VM_LB
  AND #$0F
  ASL A
  ASL a

  ; ASL a
  ; ASL A  
  STA C1_ATTR_DMA_VMADDL
  LDA COL_ATTR_VM_HB
  AND #$24
  STA C1_ATTR_DMA_VMADDH

  LDA #$20
  STA C1_ATTR_DMA_SIZE_LB
  STZ C1_ATTR_DMA_SIZE_HB

  LDY #$00
  LDX #$00
: LDA COL_ATTR_VM_START, Y

  ; convert magic!
  ; each attribute value gives us 4 attribute values
  ; in a grid of:
  ; 
  ; A A B B
  ; A A B B
  ; C C D D
  ; C C D D
  ;
  ; we'll store them in 4 batches to be DMA'd
  ; and store them in columns, but as rows, get it?
  ; 
  ; column1:  A A C C
  ; column2:  A A C C
  ; column3:  B B D D
  ; column4:  B B D D

  ; magic convert, for now just set it to 8
  ; NES attribues will be in 1 byte, for the above description in this way:
  ; 0xDDCCBBAA
  ; The only thing we care about with Kid icarus is the palette
  ; 
  ; palattes for SNES are put in bits 4, 8 & 16 of the high byte:
  ; we're only useing 4 palattes, so we'll shift things to byte 4, 8 of the low nibble
  ; ___0 00___

  ; get A (TL)
  AND #$03
  ASL
  ASL
  STA C1_ATTRIBUTE_CACHE, X
  STA C1_ATTRIBUTE_CACHE + 1, X
  ; store in UR and LR row
  STA C1_ATTRIBUTE_CACHE + $20, X
  STA C1_ATTRIBUTE_CACHE + $20 + 1, X

  ; get B (TR), write them as dma lines 3 and 4.
  LDA COL_ATTR_VM_START, Y
  CLC
  AND #$0C
  STA C1_ATTRIBUTE_CACHE + $40, X
  STA C1_ATTRIBUTE_CACHE + $40 + 1, X
  STA C1_ATTRIBUTE_CACHE + $60, X
  STA C1_ATTRIBUTE_CACHE + $60 + 1, X

  ; get C (BL)
  LDA COL_ATTR_VM_START, Y
  CLC
  AND #$30
  LSR A
  LSR A
  STA C1_ATTRIBUTE_CACHE + 2, X
  STA C1_ATTRIBUTE_CACHE + 3, X
  STA C1_ATTRIBUTE_CACHE + $20 + 2, X
  STA C1_ATTRIBUTE_CACHE + $20 + 3, X

  ; get D (BR)
  LDA COL_ATTR_VM_START, Y
  AND #$C0
  LSR A
  LSR A
  LSR A
  LSR A
  STA C1_ATTRIBUTE_CACHE + $40 + 2, X
  STA C1_ATTRIBUTE_CACHE + $40 + 3, X
  STA C1_ATTRIBUTE_CACHE + $60 + 2, X
  STA C1_ATTRIBUTE_CACHE + $60 + 3, X

  INX
  INX
  INX
  INX

  INY
  CPY #$08
  BNE :-

  INC COLUMN_1_DMA

  RTS

; uses DMA channel 2 to copy a buffer of column attributes
dma_column_attributes:
  STZ COLUMN_1_DMA

  ; write vertically for columns
  LDA #$81
  STA VMAIN

  LDX #$04

  LDA #.hibyte(C1_ATTRIBUTE_CACHE)
  STA C1_ATTR_DMA_SRC_HB
  LDA #.lobyte(C1_ATTRIBUTE_CACHE)
  STA C1_ATTR_DMA_SRC_LB

: STZ DMAP2

  LDA #$19
  STA BBAD2

  LDA #$7E
  STA A1B2

  LDA C1_ATTR_DMA_SRC_HB
  STA A1T2H
  LDA C1_ATTR_DMA_SRC_LB
  STA A1T2L

  LDA C1_ATTR_DMA_SIZE_LB
  STA DAS2L
  LDA C1_ATTR_DMA_SIZE_HB
  STA DAS2H

  LDA C1_ATTR_DMA_VMADDH
  STA VMADDH
  LDA C1_ATTR_DMA_VMADDL
  STA VMADDL

  LDA #$04
  STA MDMAEN

  INC C1_ATTR_DMA_VMADDL
  LDA C1_ATTR_DMA_SRC_LB
  CLC
  ADC #$20
  STA C1_ATTR_DMA_SRC_LB
  DEX
  BNE :-

  LDY #$0F
  LDA #$00
: STA COLUMN_1_DMA,Y
  DEY
  BPL :-
  LDA #$FF
  STA COLUMN_1_DMA + 1

  LDA #$80
  STA VMAIN

  RTS

palette_lookup:
.byte $8C, $31 ; $00 dark grey
.byte $A0, $44 ; $01 
.byte $42, $50 ; $02 dark blue
.byte $07, $50 ; $03 dark purple blue
.byte $0B, $3C ; $04 dark purple
.byte $0D, $20 ; $05 maroon
.byte $0D, $00 ; $06 burgandy
.byte $6A, $00 ; $07 dark brown
.byte $C6, $00 ; $08 mud green
.byte $21, $01 ; $09 green
.byte $40, $01 ; $0A dark green
.byte $20, $05 ; $0B another dark green
.byte $00, $25 ; $0C dark teal
.byte $00, $00 ; $0D Black
.byte $00, $00 ; $0E Black
.byte $00, $00 ; $0F Black

.byte $B5, $56 ; $10 light grey
.byte $62, $6D ; $11 blue
.byte $08, $7D ; $12 light dark blue
.byte $8E, $7C ; $13 purple
.byte $74, $64 ; $14 
.byte $76, $3C ; $15 dark pink
.byte $D6, $10 ; $16 red
.byte $33, $01 ; $17 Brown 0133
.byte $AD, $01 ; $18 yellow brown
.byte $07, $02 ; $19 
.byte $41, $02 ; $1A green
.byte $20, $1A ; $1B green
.byte $E0, $45 ; $1C teal
.byte $00, $00 ; $1D Black
.byte $00, $00 ; $1E Black
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
.byte $71, $03 ; $29 neon green
.byte $8B, $1B ; $2A bright green
.byte $88, $43 ; $2B bright teal green
.byte $29, $6F ; $2C bright light blue
.byte $29, $25 ; $2D dark grey
.byte $00, $00 ; $2E Black
.byte $00, $00 ; $2F Black

.byte $FF, $7F ; $30 white
.byte $78, $7F ; $31 light blue
.byte $5A, $7F ; $32 pink grey
.byte $3D, $7F ; $33 pink
.byte $1F, $7F ; $34 
.byte $1F, $77 ; $35 another pink
.byte $3F, $63 ; $36 
.byte $7E, $53 ; $37 
.byte $9C, $4B ; $38 nyi
.byte $B9, $4B ; $39 nyi
.byte $00, $00 ; $3A nyi
.byte $D6, $67 ; $3B light greenish blue
.byte $B6, $7B ; $3C nyi
.byte $00, $00 ; $3D nyi
.byte $00, $00 ; $3E Black
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