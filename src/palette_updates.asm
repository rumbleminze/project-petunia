
write_palette_data:
  PHX
  PHY
  PHA

  setAXY8
  LDA #$A0
  
  PHA
  PLB
  LDY #$00
  STZ CURR_PALETTE_ADDR
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
  BNE skip_writing_three_rows

  CLC
  LDA CURR_PALETTE_ADDR
  ADC #$10
  STA CGADD
  STA CURR_PALETTE_ADDR

skip_writing_three_rows:
  TYA
  AND #$0F
  CMP #$00
  BNE skip_writing_four_empties
  ; after 16 entries we write an empty set of palettes
  CLC
  LDA CURR_PALETTE_ADDR
  ADC #$40
  STA CGADD
  STA CURR_PALETTE_ADDR 

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
  
zero_all_palette:
  LDY #$00
  LDX #$02

  STZ CGADD

: STZ CGDATA
  DEY
  BNE :-
  DEX
  BNE :-

  RTL