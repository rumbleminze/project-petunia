set_palette_lookup:
  LDA PAL_OPTION
  BNE :+
    LDA #<palette_lookup
    STA PALETTE_LOOKUP_LOCATION
    LDA #>palette_lookup
    STA PALETTE_LOOKUP_LOCATION + 1
    rts
: 
    LDA #<alt_palette
    STA PALETTE_LOOKUP_LOCATION
    LDA #>alt_palette
    STA PALETTE_LOOKUP_LOCATION + 1
    rts

transfer_palette_data:
  LDY #$00

: STY CGADD
  LDA PALETTE_CACHE_BG + 0, Y
  STA CGDATA
  LDA PALETTE_CACHE_BG + 1, Y
  STA CGDATA
  LDA PALETTE_CACHE_BG + 2, Y
  STA CGDATA
  LDA PALETTE_CACHE_BG + 3, Y
  STA CGDATA
  LDA PALETTE_CACHE_BG + 4, Y
  STA CGDATA
  LDA PALETTE_CACHE_BG + 5, Y
  STA CGDATA
  LDA PALETTE_CACHE_BG + 6, Y
  STA CGDATA
  LDA PALETTE_CACHE_BG + 7, Y
  STA CGDATA
  TYA
  clc
  ADC #$10
  TAY
  CPY #$40
  BNE :-
  
  TYA
  ADC #$40
  TAX

  ; sprite palette entries
: TYA
  clc
  ADC #$40
  STA CGADD

  LDA PALETTE_CACHE_BG + 0, Y
  STA CGDATA
  LDA PALETTE_CACHE_BG + 1, Y
  STA CGDATA
  LDA PALETTE_CACHE_BG + 2, Y
  STA CGDATA
  LDA PALETTE_CACHE_BG + 3, Y
  STA CGDATA
  LDA PALETTE_CACHE_BG + 4, Y
  STA CGDATA
  LDA PALETTE_CACHE_BG + 5, Y
  STA CGDATA
  LDA PALETTE_CACHE_BG + 6, Y
  STA CGDATA
  LDA PALETTE_CACHE_BG + 7, Y
  STA CGDATA

  TYA
  ADC #$10
  TAY

  CPY #$80
  BNE :-

  rtl

write_palette_data:
  PHX
  PHY
  PHA

  setAXY8
  LDA #$A0
  
  PHA
  PLB
  jsr set_palette_lookup
  STZ CURR_PALETTE_ADDR
  STZ CGADD
  ; Kid Icarus stores the current palettes at 0x0390
  ; BG is 0390 - 039F
  ; Sprites are 03A0 - 03AF

  ; lookup our 2 byte color from palette_lookup, color * 2
  ; Our palettes are written by writing to CGDATA

  STZ PALETTE_COPY_IDX

  LDX #$00
palette_entry:

  LDY PALETTE_COPY_IDX
  LDA $0390, Y
  ASL A
  TAY

  LDA (PALETTE_LOOKUP_LOCATION), Y
  STA PALETTE_CACHE_BG, X
  INX
  INY
  
  LDA (PALETTE_LOOKUP_LOCATION), Y
  STA PALETTE_CACHE_BG, X
  INX
  INY
  
  ; every 4 we need to write a bunch of empty palette entries
  INC PALETTE_COPY_IDX
  LDA PALETTE_COPY_IDX
  AND #$03

  BNE skip_writing_three_rows

  CLC
  TXA
  ADC #$08
  TAX

skip_writing_three_rows:

  LDA PALETTE_COPY_IDX
  AND #$0F
  CMP #$00

  LDA PALETTE_COPY_IDX
  CMP #$20
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