; bank 0 - this houses our init routine and setup stuff
.segment "PRGA0"
init_routine:
  PHK 
  PLB 
  BRA initialize_registers

initialize_registers:
  setAXY16
  setA8

  LDA #$8F
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
  STA MEMSEL
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
  STZ NMITIMEN_STATE

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
  STZ EXTRA_VRAM_UPDATE

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

  JSR clearvm
  JSR zero_oam  
  JSR dma_oam_table
  JSL zero_all_palette

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
; Use #$04 to enable overscan if we can.
  LDA #$04
  LDA #$00
  STA SETINI


  lda #%0000000
  sta OBSEL

;   JSR zero_attribute_buffer

;   STZ ATTR_NES_HAS_VALUES
;   STZ ATTR_NES_VM_ADDR_HB
;   STZ ATTR_NES_VM_ADDR_LB
;   STZ ATTR_NES_VM_ATTR_START
;   STZ ATTRIBUTE_DMA
;   STZ COL_ATTR_HAS_VALUES
;   STZ COLUMN_1_DMA

  JSL upload_sound_emulator_to_spc
  JSL load_base_tiles
;   JSR do_intro
  JSR clearvm_to_12

  LDA #$A1
  PHA
  PLB 
  JML $A1C000


  snes_nmi:
    LDA RDNMI
    STZ REUSABLE_CALC_BYTE
    ; we only care about bits 10 (sprites and 08 bg)
    LDA PPU_MASK_STATE
    AND #$10
    BEQ :+
    STA REUSABLE_CALC_BYTE
    : LDA PPU_MASK_STATE
    AND #$08
    BEQ :+
    LDA #$01
    ORA REUSABLE_CALC_BYTE
    STA REUSABLE_CALC_BYTE
    : LDA REUSABLE_CALC_BYTE
    STA TM


  JSL setup_hdma    
  LDA #$7E
  STA A1B3
  LDA #$09
  STA A1T3H
  STZ A1T3L
  LDA #$0D
  STA BBAD3
  LDA #$03
  STA DMAP3

  LDA #%00001000
  STA HDMAEN

  JSR dma_oam_table
;   JSR disable_attribute_buffer_copy
;   JSR check_and_copy_attribute_buffer
;   JSR write_one_off_vrams
  RTL

clearvm:
  setAXY16
  ldx #$2000
  stx VMADDL 
	
	lda #$0000
	
	LDY #$0000
	clear_loop:
		sta VMDATAL
		iny
		CPY #(32*64)
		BNE clear_loop
  
  setAXY8
  RTS

clearvm_to_12:
  setAXY16
  ldx #$2000
  stx VMADDL 
	
	lda #$0012
	
	LDY #$0000
	:
		sta VMDATAL
		iny
		CPY #(32*64)
		BNE :-
  
  setAXY8
  RTS

  
  .include "intro_screen.asm"
  .include "palette_updates.asm"
  .include "palette_lookup.asm"
  .include "sprites.asm"
  .include "tiles.asm"
  .include "hardware-status-switches.asm"
  .include "scrolling.asm"




  .include "hdma_scroll_lookups.asm"