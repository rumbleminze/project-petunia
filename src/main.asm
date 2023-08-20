.p816
.smart

.include "macros.inc"
.include "registers.inc"

.include "header.asm"

.include "variables.asm"

.segment "CODE"

VRAM_CHARS = $0000
VRAM_BG1   = $2000

TILE_START_LB = 		$0041
TILE_START_HB = 		$0042
TILE_TO_WRITE_LB = 		$0043
TILE_TO_WRITE_HB = 		$0044
NUM_TILES_TO_WRITE = 	$0045
TILESET_OFFSET = 		$0050

OLD_TILE_GROUP_OFFSET = $A2E8

start:
	.include "init.asm"
	
	; Set up the color palette
	stz CGADD


	LDX #$0000
	@fill_palette:
		@palette_loop:
			LDA palettes, x
			sta CGDATA
			inx
			CPX #(palettes_end - palettes)
			BNE @palette_loop

		CPX #$00FF
		BEQ fill_palette_done
		@zero_rest:
			STZ CGDATA			
			STZ CGDATA
			inx
			inx
			CPX #$0200
		BNE @zero_rest
	fill_palette_done:

	
	; Set Graphics Mode 0, 8x8 tiles
	; lda #$01
	stz BGMODE
    ; Set BG1 and tile map and character data
	; lda #$20
	lda #$22
	sta BG1SC
	lda #VRAM_CHARS
	sta BG12NBA

	; Load character data into VRAM
	lda #$80
	sta VMAIN
	ldx #VRAM_CHARS
	stx VMADDL

	lda #$04
	sta SETINI
	
	ldx #$00
@charset_loop:

	ldy #$00	
	@charset_row_loop:
		lda tiles,x
		sta VMDATAL
		lda tiles+8,x
		sta VMDATAH
		iny
		inx
		cpy #08
		bne @charset_row_loop
	inx
	inx
	inx
	inx
	inx
	inx
	inx
	inx
	cpx #(tiles_end - tiles)
	bne @charset_loop
 
	jsr clearvm
	; jsr copytilestobackground
	STZ TILESET_OFFSET
	STZ TILESET_OFFSET + 1
	load_all_tilesets:		
		jsr readtileset
		jsr writetileset
		inc TILESET_OFFSET		
		inc TILESET_OFFSET		
		inc TILESET_OFFSET		
		inc TILESET_OFFSET		
		inc TILESET_OFFSET		
		inc TILESET_OFFSET
		lda TILESET_OFFSET
		CMP #(background_tilesets_end - background_tilesets)
		bne load_all_tilesets

	; Write a tile to position (1, 1)
	TILE_X = 0
	TILE_Y = 0
	ldx #(VRAM_BG1 + (TILE_Y * 32) + TILE_X)
	stx VMADDL
	lda #$12 ; tile number
	sta VMDATAL
	stz VMDATAH

	; Show BG1
	lda #%00000001
	sta TM

	lda #$0f
	sta INIDISP

	lda #%10000001
	sta NMITIMEN

mainloop:

	lda nmi_count
@nmi_check:
	wai
	cmp nmi_count
	beq @nmi_check
	php
	jsr count_frames
	jsr scroll_bg1
	plp

	bra mainloop
nmi:
	bit RDNMI
	inc nmi_count
_rti:
	rti

count_frames:
	inc frame_counter_lb
	bne done_counting
	inc frame_counter_hb
	done_counting:
	rts

scroll_bg1:

;   ;Original code:
;	LDA frame_counter_lb                 
;   AND #$01                 
;   BEQ $A210                
;   RTS                               
;   LDA frame_counter_hb                  
;   BNE $A21A                
;   LDA frame_counter_lb                  
;   CMP #$80                 
;   BCC $A235                
;   INC $FD                  
;   JSR $A5CA                
;   LDA $FD                  
;   CMP #$F0                 
;   BNE $A235                
;   LDA #$00                 
;   STA frame_counter_lb                  
;   STA frame_counter_hb                 
;   LDA $1A                  
;   EOR #$01                 
;   STA $1A                  
;   LDA #$00                 
;   STA $FD                  
;   RTS                      

	LDA frame_counter_lb
	AND #$01
	; only scroll every other frame
	BEQ keep_scrolling
	rts

	keep_scrolling:
	LDA frame_counter_hb
	BNE increment_vertical_scroll
	LDA frame_counter_lb
	CMP #$80
	BCC done_scrolling
	increment_vertical_scroll:
	inc bg1_y
	bne done_incrementing_scroll
	inc bg1_y_hb
	
	done_incrementing_scroll:
	jsr move_heart_sprites

	LDA bg1_y
	CMP #$F0
	BNE done_scrolling
	LDA #$00
	STA frame_counter_lb
	STA frame_counter_hb

	LDA $1A
	EOR #$01
	STA $1A
	; LDA #$00
	; STA bg1_y

	done_scrolling:
	lda bg1_y
	sta BG1VOFS

	lda bg1_y_hb
	sta BG1VOFS
	rts

	; my ghetto scroll 
	; inc bg1_y
	; bne scroll

	; inc bg1_y_hb
	; lda bg1_y_hb
	; and #$01
	; sta bg1_y_hb

	; scroll:
	; lda bg1_y
	; sta BG1VOFS

	; lda bg1_y_hb
	; sta BG1VOFS


	rts

unload_heart_sprites:
  LDA #$5F                 
  STA $0281                
  STA $0285                
  STA $0289                
  STA $028D                
  LDA #$F0                 
  STA $0280                
  RTS                      

load_sprite_to_00:       
  LDA #$00                 
  STA title_scroll_state                
  RTS                      


initialize_heart_sprites:  
  ; check current scroll position     
  LDA title_scroll_state  
  ; if title_scroll_state is 0, then initialize sprites              
  BEQ unload_heart_sprites           
  LDA $0280                
  CMP #$F0                 
  BEQ load_sprite_to_00  
  ; top right sprite also 00              
  STA $0284                
  CLC                      
  ; next 2 sprites 8 px below
  ADC #$08                 
  STA $0288                
  STA $028C                

  ; load sprite 1's Y position
  LDA $0283                
  ; store it in sprite 3's
  STA $028B               

  ; move right 8 pixel and store it in sprite 2 and 4's 
  CLC                      
  ADC #$08                 
  STA $0287                
  STA $028F   

  ; #$21 is magic number?  not sure, but every sprite shares it.  maybe palatte?
  LDA #$21                 
  STA $0282                
  STA $0286                
  STA $028A                
  STA $028E   

  ; select tiles for sprites 20 - 23
  LDA #$92                 
  STA $0281                
  LDA #$94                 
  STA $0285                
  LDA #$93                 
  STA $0289                
  LDA #$AE                 
  STA $028D                
  RTS                      

	
move_heart_sprites:
;   move sprite of heartdown with the BG
  DEC $0280                
  LDA bg1_y                  
  CMP #$48                 
  BNE exit_move_sprites               
  LDA $1A                  
  LSR A                    
  BCC exit_move_sprites                
  LDA #$EF                 
  STA $0280                
  LDA #$39                 
  STA $0283                
  LDA #$80                 
  STA title_scroll_state  
  exit_move_sprites:              
  RTS                      


readtileset:
  	ldx TILESET_OFFSET
	
	setAXY16
	; First two bytes are where the tiles go in the background
	LDA background_tilesets, x
	STA TILE_START_LB

	inx
	inx
	; next two bytes are where the data for the group of tilesets is in memory
	; in the original NES game this starts at $a2e8
	; we've copied that data to tiles_to_background
	LDA background_tilesets, x
	; ADC #(background_tile_group_defintions - $A2E8)
	; CLC
	; ADC #$0f77
	STA TILE_TO_WRITE_LB

	inx
	inx
	LDA background_tilesets, x
	STA NUM_TILES_TO_WRITE
	setA8

  	rts

writetileset:
  ldx TILE_START_LB
  stx current_vram_addr
  stx VMADDL 
    
  LDY #$0000     
  STY tile_counter
  nexttile:            
	; get the attribute data here
	; attribute data depends on which 32x32 square the address is in
	; we actually only care about 1 bits for each quadrant
	; as we only have 2 bytes per tile, and 4 palettes.
	; addresses are always $2000 - $2800, since that's where we were
	; writing tiles.  $2000 - $23FF is the first page, 2400 - 27FF the 2nd
	
  	setAXY16
	LDA current_vram_addr

	CMP #$2400
	BPL calculate_attributes_from_address
	; this is just press start, attributes are always AA
	; and attribute data is always 0x0800
	LDA #$0800
	STA attribute_for_tile
	BRA write_tile_to_vram

	calculate_attributes_from_address:	
	; chop off unnecessary address part
	AND #$001F
	LSR A
	LSR A
	; A now has the column
	STA column_offset
	LDA current_vram_addr

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
	STA row_offset

	; load attribute data row * 8 + column
	ASL A
	ASL A
	ASL A
	ADC column_offset
	TAY
	LDA attribute_data, Y
	AND #$00FF
	STA attribute_for_tile

	; now figure out which half nibble we need
	; if vram add is odd we want right
	LDA current_vram_addr
	AND #$007F
	CMP #$0040
	BMI lrcheck
	LSR attribute_for_tile
	LSR attribute_for_tile
	LSR attribute_for_tile
	LSR attribute_for_tile

	lrcheck:
	LDA current_vram_addr
	AND #$0002
	
	BEQ done_picking_attributes
	LSR attribute_for_tile
	LSR attribute_for_tile

	done_picking_attributes:
	LDA attribute_for_tile	
	AND #$03
	ASL A
	ASL a
	
	STA attribute_for_tile	
	ASL A
	ASL A
	ASL A
	ASL A
	ASL A
	ASL A
	ASL A
	ASL A	
	STA attribute_for_tile

	write_tile_to_vram:
	LDY tile_counter
	LDA (TILE_TO_WRITE_LB),Y
	AND #$00FF
	ADC attribute_for_tile
        
	STA VMDATAL
	INY        	
	inc current_vram_addr      
	STY tile_counter
	CPY NUM_TILES_TO_WRITE
	BNE nexttile    

  setA8
  RTS                      

clearvm:
  	ldx #VRAM_BG1
  	stx VMADDL 
	
	lda #$12
	
	LDY #$0000
	clear_loop:
		sta VMDATAL
		stz VMDATAH
		iny
		CPY #(32*64)
		BNE clear_loop
	RTS


.include "palettes.asm"
; .include "charset.asm"
.include "tiles.asm"
.include "backgroundtilesets.asm"