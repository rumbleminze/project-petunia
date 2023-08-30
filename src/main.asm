.p816
.smart

.include "macros.inc"
.include "registers.inc"
.include "header.asm"
.include "variables.asm"

.segment "NES_SPRITES"
nes_sprites_buffer: .res 256
nes_sprites_buffer_end:

.segment "BSS"
oam_lo_buffer: .res 512
oam_hi_buffer: .res 32
oam_buffer_end:

.segment "CODE"

VRAM_CHARS 		= $0000
VRAM_BG_CHARS 	= $1000
VRAM_BG1   		= $2000

start:
	.include "init.asm"
	
	; Set up the color palette
	stz CGADD
	LDX #$0000
	@fill_palette:
		:
			LDA palettes, x
			sta CGDATA
			inx
			CPX #(palettes_end - palettes)
			BNE :-

		CPX #$00FF
		BEQ :+
		@zero_rest:
			STZ CGDATA			
			STZ CGDATA
			inx
			inx
			CPX #$0200
		BNE @zero_rest
	:

	
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
	
	jsr clear_zero_page
	jsr load_tilesets
	jsr clearvm
	stz scroll_stop_flag
	inc scroll_stop_flag
	jsr clear_nes_sprite_ram

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
	lda #%00010001
	sta TM

	lda #$0f
	sta INIDISP

	lda #%0000000
	sta OBSEL

	ldx #0
@zero_oam:
	stz oam_lo_buffer, x
	lda #$f8
	sta oam_lo_buffer + 1, x
	stz oam_lo_buffer + 2, x
	stz oam_lo_buffer + 3, x
	inx
	inx
	inx
	inx
	cpx #(oam_hi_buffer - oam_lo_buffer)
	bne @zero_oam
	
	ldx #0
@zero_oam_hi:
	stz oam_hi_buffer, X
	inx
	cpx #(oam_buffer_end - oam_hi_buffer)
	bne @zero_oam_hi

	lda #%10000001
	sta NMITIMEN

mainloop:

	lda nmi_count
@nmi_check:
	wai
	cmp nmi_count
	beq @nmi_check
	php
	; jsr read_input
	; jsr count_frames
	; jsr scroll_bg1

	; jsr translate_nes_sprites_to_oam
	plp

	LDA joy1_buttons_mirror
	AND #$10
	beq mainloop
	jsr post_start

nmi:
	jsr dma_oam_table           
  	JSR handle_input  
	jsr title_screen_interrupt_handler	
	jsr initialize_heart_sprites
	bit RDNMI
	inc nmi_count
_rti:
	rti

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

; in the nes routine this only sets the v bit to F8
clear_nes_sprite_ram:
	setA8
	LDY #$0000

	@clear_sprite_memory:
	
	LDA #$F8
	STA $0200, Y

	LDA #$00
	STA $0201, Y
	STA $0202, Y
	STA $0203, Y

	INY
	INY
	INY
	INY
	CPY #$0100
	BNE @clear_sprite_memory
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

  ; #$21 is palatte and
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

translate_nes_sprites_to_oam:
	setA8
	LDY #$0000

sprite_loop:	
	; byte 1, Tile index
	LDA $201, Y
	STA oam_lo_buffer + 2, y
	beq empty_sprite

	; byte 0, Tile Y position
	LDA $200,Y
	STA oam_lo_buffer + 1, y

	; byte 3, Tile X Position
	LDA $203, Y
	STA oam_lo_buffer, y 

	; properties
	LDA $202, Y
	PHA
	AND #$03
	ASL A
	STA junk_byte
	PLA
	AND #$F0
	EOR #%00110000
	ORA junk_byte
	LDA #%00010010
	STA oam_lo_buffer + 3, y
	bra next_sprite

	empty_sprite:
	sta oam_lo_buffer, y
	lda #$f8 
	sta oam_lo_buffer + 1, y
	lda #$38
	sta oam_lo_buffer + 3, y

	next_sprite:
	INY
	INY
	INY
	INY
	CPY #$100
	BNE sprite_loop
	rts

dma_oam_table:
	lda #%00000000
	sta DMAP1
	lda #<OAMDATA
	sta BBAD1
	ldx #.loword(oam_lo_buffer)
	stx A1T1L
	lda #^oam_lo_buffer
	sta A1B1
	ldx #(oam_buffer_end - oam_lo_buffer)
	stx DAS1L
	lda #%00000010
	sta MDMAEN

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

clear_zero_page:
    setA8
	lda #$00
	ldy #$0000
:	sta $00, Y
	iny
	cpy #$0100
	bne :-

	rts

.include "palettes.asm"
; .include "charset.asm"
.include "tiles.asm"
.include "backgroundtilesets.asm"
.include "sprite_tiles.asm"
.include "input.asm"
.include "title_screen_post_start.asm"