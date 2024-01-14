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
  ; STA VOFS_HB

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
  ; STA VOFS_HB
  BRA :++     ; RTL
: LDA #$01
  STA HOFS_HB
  ; STA VOFS_HB
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

scroll_rollover:
  LDA #$EF  
  STA $FD
  LDA $5C
  ORA #$80
  STA $5C

  ; we have to update PPU_STORE here because we use it almost immediately
  ; in the hdma routine
  JSR flip_bg1_bit

  RTL

title_screen_rollover:
  LDA #$00
  STA $14
  STA $15
  LDA $1A
  EOR #$01
  STA $1A
  LDA #$00
  STA $FD
  JSR flip_bg1_bit
  
  RTL

flip_bg1_bit:
  LDA PPU_CONTROL_STATE
  AND #$02  
  CMP #$02
  BNE :+
  LDA PPU_CONTROL_STATE
  AND #$FD
  BRA :++
: LDA PPU_CONTROL_STATE
  ORA #$02

: STA PPU_CONTROL_STATE
  RTS
