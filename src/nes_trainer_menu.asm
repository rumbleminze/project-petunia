new_menu_options:
.db $01 $20 $12 $E6 $A7
; ?, starting lb, #$20 / #$24 + for HB, length, characters
.db $04 $8C $01 $05 $28 $29 $16 $27 $29
.db $04 $CC $01 $08 $18 $24 $23 $29 $1E $23 $2A $1A
.db $04 $0C $02 $08 $1d $1a $16 $21 $29 $1d $12 $00
.db $04 $4C $02 $08 $28 $29 $27 $12 $12 $12 $12 $00
.db $04 $8C $02 $03 $01 $0F $01
.db $00 ; end


scores_for_health:
.db $00 $00 $00
.db $20 $4e $00
.db $50 $c3 $00
.db $A0 $86 $01
.db $40 $0D $03

menu_option_sprite_locations:
.db $60 $70 $80 $90 $A0

menu_option_sprite_locations_x:
.db $50 $50 $50 $50 $50

level_load_additions:
  ; original code
  LDA #$00
  STA $B2
  JSR $A1E7
  LDA $B2
  TAX

  PHA
  TYA
  PHA
  TXA
  PHA  
    ; max str
    ; LDA #$04
    ; STA $6021

    ; max hearts
    LDA #$E7
    STA $6019

    LDA #$03
    STA $601A
    
    ; score depends on health
    LDA $6026
    ASL a
    ADC $6026
    TAY
    LDX #$00
loop1:
    LDA scores_for_health, y
    STA $6013, X
    iny
    inx
    CPX #$03
    BNE loop1

    ; max health
    ; LDA #$04
    ; STA $6026

    ; hammers
    ; LDA #$20
    ; STA $601E

     ; feathers
    ; LDA #$20
    ; STA $601F

    ; wine
    ; LDA #$48
    ; STA $6020

    ; special weapons
    ; LDA #$02
    ; STA $600D
    ; STA $600E
    ; STA $600F

    ; LDA #$01
    ; STA $6010
    ; LDA #$02
    ; STA $6011
    ; LDA #$03
    ; STA $6012

nocheats: 
  PLA
  TAX
  PLA
  TAY
  PLA

  JMP $A113


level_select_values:
; world, level, display 1, display 2 
.db $02 $00 $01 $01
.db $02 $01 $01 $02
.db $02 $02 $01 $03
.db $03 $00 $01 $04
.db $04 $00 $02 $01
.db $04 $01 $02 $02
.db $04 $02 $02 $03
.db $05 $00 $02 $04
.db $06 $00 $03 $01
.db $06 $01 $03 $02
.db $06 $02 $03 $03
.db $07 $00 $03 $04 
.db $08 $00 $04 $01
.db $09 $00 $1a $19

next_level:
  INC $0809
  LDA $0809
  CMP #$0E
  BCC level_wrap
  LDA #$00
  STA $0809
level_wrap:
  ASL
  ASL

  TAY
  LDA level_select_values, y
  STA $6028
  
  INY
  LDA level_select_values, Y
  STA $6029
  
  INY
  LDA level_select_values, Y
  PHA

  INY
  LDA level_select_values, Y
  
  LDX #$22
  STX $2006
  LDY #$8E
  STY $2006
  STA $2007


 LDY #$8C
 STX $2006
 STY $2006
 PLA
 STA $2007
  JSR reset_scroll

  rts

prev_level:
  DEC $0809
  LDA $0809
  CMP #$FF
  BNE wrap_to_last_level
  LDA #$0D
  STA $0809
wrap_to_last_level:
  ASL
  ASL
  TAY
  LDA level_select_values, Y
  STA $6028
  
  INY
  LDA level_select_values, Y
  STA $6029
  
  INY
  LDA level_select_values, Y
  PHA

  INY
  LDA level_select_values, Y
  LDX #$22
  STX $2006
  LDY #$8E
  STY $2006
  STA $2007


 LDY #$8C
 STX $2006
 STY $2006
 PLA
 STA $2007
  JSR reset_scroll

  rts


title_screen_input:
  LDA $F6
  CMP #$01
  BNE check_left
  LDA $B2
  CMP #$02
  BEQ increment_health
  CMP #$03
  BEQ increment_str
  CMP #$04
  BNE check_start_select
  JMP next_level 

check_left:
  CMP #$02
  BNE check_start_select
  LDA $B2
  CMP #$02
  BEQ decrement_health
  CMP #$03
  BEQ decrement_str
  CMP #$04
  BNE check_start_select
  JMP prev_level

check_start_select:
  ASL  
  ASL
  ASL
  ; select has been pushed
  BCS jmp_to_select_pushed
  ASL
  ; start has been pushed
  BCS jmp_to_start_pushed
  RTS
  
jmp_to_select_pushed:
  JMP select_pushed
jmp_to_start_pushed:
  JMP start_pushed

reset_scroll:
  LDA #$00
  STA PpuScroll_2005
  STA PpuScroll_2005
  RTS

increment_health:
  INC $6026
  LDA $6026
  CMP #$04
  BCC not_full
  LDA #$04
  STA $6026
not_full:
  LDX #$26
  LDY #$13
  STX PpuAddr_2006
  STY PpuAddr_2006
  STA PpuData_2007
  JSR reset_scroll
  RTS

decrement_health:
  DEC $6026
  LDA $6026
  BPL not_zero
  LDA #$00
  STA $6026
not_zero:
  LDX #$26
  LDY #$13
  STX PpuAddr_2006
  STY PpuAddr_2006
  STA PpuData_2007  
  JSR reset_scroll
  RTS

increment_str:
  INC $6021
  LDA $6021
  CMP #$04
  BCC str_not_full
  LDA #$04
  STA $6021
str_not_full:
  LDX #$26
  LDY #$53
  STX PpuAddr_2006
  STY PpuAddr_2006
  STA PpuData_2007
  JSR reset_scroll
  RTS

decrement_str:
  DEC $6021
  LDA $6021
  BPL str_not_zero
  LDA #$00
  STA $6021
str_not_zero:
  LDX #$26
  LDY #$53
  STX PpuAddr_2006
  STY PpuAddr_2006
  STA PpuData_2007
  JSR reset_scroll
  RTS

start_pushed:
  LDA $B2
  CMP #$01
  BCC do_something_on_start
  rts
do_something_on_start:
  LDA #$00
  STA $B1
  RTS

select_pushed:
  LDX $B2
  CPX #$04
  BCC increment_choice
  LDX #$00
  BEQ choice_wrap_handled
increment_choice:
  INX
choice_wrap_handled:
  STX $B2
  LDA menu_option_sprite_locations,X
  STA $0230
  LDA menu_option_sprite_locations_x, X
  STA $0233
  RTS
