.p816
.smart

.include "macros.inc"
.include "registers.inc"
.include "header.asm"
.include "variables.asm"


.segment "BSS"
oam_lo_buffer: .res 512
oam_hi_buffer: .res 32
oamb_buffer_end:

.segment "CODE"

VRAM_CHARS = $0000
VRAM_BG_CHARS = $1000
VRAM_BG1   = $2000

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

	
	; Set Graphics Mode 0, 8x8 tiles, 4bpp
	lda #$01
	sta BGMODE

    ; Set BG1 and tile map and character data
	; lda #$20
	lda #$22
	sta BG1SC

	setAXY16
	lda #VRAM_CHARS
	sta BG12NBA
	setA8

	lda #$04
	sta SETINI
	
	jsr load_tilesets
	jsr clearvm
	
	STZ tileset_offset
	STZ tileset_offset + 1
	load_all_tilesets:		
		jsr readtileset
		jsr writetileset
		inc tileset_offset		
		inc tileset_offset		
		inc tileset_offset		
		inc tileset_offset		
		inc tileset_offset		
		inc tileset_offset
		lda tileset_offset
		CMP #(background_tilesets_end - background_tilesets)
		bne load_all_tilesets
	; Show BG1
	lda #%00000001
	sta TM

	lda #$0f
	sta INIDISP

	lda #%0000000
	sta OBSEL

	ldx #0
@zero_oam:
	stz oam_lo_buffer, x
	inx
	cpx #(oam_buffer_end - oam_lo_buffer)
	bne @zero_oam

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

load_tilesets:

		; Load character data into VRAM
	lda #$80
	sta VMAIN

	ldx #VRAM_CHARS
	stx VMADDL
	
	LDA #< sprite_tiles
	STA tileset_load_start
	CLC
	ADC #$08
	STA tileset_load_hb_start

	LDA #> sprite_tiles
	STA tileset_load_start + 1

	BCC :+
	INC A
:	STA tileset_load_hb_start + 1

	JSR load_tileset

	ldx #VRAM_BG_CHARS
	stx VMADDL

	LDA #<tiles
	STA tileset_load_start
	CLC
	ADC #$08
	STA tileset_load_hb_start

	LDA #>tiles
	STA tileset_load_start + 1
	BCC :+
	INC A
:	STA tileset_load_hb_start + 1

	JSR load_tileset
	RTS

load_tileset:
	ldy #$00
	@charset_loop:

		ldx #$00	

		@charset_row_loop:

			lda (tileset_load_start), y
			sta VMDATAL

			lda (tileset_load_hb_start),y
			sta VMDATAH

			inx
			iny

			cpx #08
			bne @charset_row_loop

		; NES tiles are 2bpp but we want to use 4bpp
		; the way they tiles are structures this means that 
		; for a row of 8 pixels, the first 16 bytes are the 2bpp data
		; and the next 16 bytes are just 0's (transparent)
		; we also take the oppurtunity to inc x by 8 here, to skip over the high
		; bits of the tiles we read
		ldx #$00
		@second_bit_plane_zeros:
			lda #$00
			sta VMDATAL
			sta VMDATAH
			inx
			iny
			cpx #08
			bne @second_bit_plane_zeros

		cpy #$1000
		bne @charset_loop
	
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
  	ldx tileset_offset
	
	setAXY16
	; First two bytes are where the tiles go in the background
	LDA background_tilesets, x
	STA tile_start_lb

	inx
	inx
	; next two bytes are where the data for the group of tilesets is in memory
	; in the original NES game this starts at $a2e8
	; we've copied that data to tiles_to_background
	LDA background_tilesets, x

	; ADC #(background_tile_group_defintions - $A2E8)
	; CLC
	; ADC #$0f77
	STA tile_to_write_lb

	inx
	inx
	LDA background_tilesets, x
	STA num_tiles_to_write
	setA8

  	rts

writetileset:
  ldx tile_start_lb

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
	LDA (tile_to_write_lb),Y
	AND #$00FF
	CLC
	ADC #$0100
	ADC attribute_for_tile
        
	STA VMDATAL
	INY        	
	inc current_vram_addr      
	STY tile_counter
	CPY num_tiles_to_write
	BNE nexttile    

  setA8
  RTS                      

clearvm:
  	ldx #VRAM_BG1
  	stx VMADDL 
	
	setAXY16
	lda #$0112
	
	LDY #$0000
	clear_loop:
		sta VMDATAL
		iny
		CPY #(32*64)
		BNE clear_loop
	RTS


.include "palettes.asm"
; .include "charset.asm"
.include "tiles.asm"
.include "backgroundtilesets.asm"
.include "sprite_tiles.asm"