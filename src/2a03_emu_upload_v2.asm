.segment "SOUND_EMU"
upload_sound_emulator_to_spc:
  REP #$18
  PHB
  LDA #$8C
  PHA
  PLB
  STZ $02
  LDX #$BBAA
: CPX APUIO0
  BNE :-

  LDY #$0400
  STY APUIO2
  LDA #$01
  STA APUIO1
  LDA #$CC
  STA APUIO0

  LDX #$0000
: CMP $2140
  BNE :-
: LDA sound_emulator_first_2FBB,X
  STA $2141
  TXA
  STA $2140
  INX
: CMP $2140
  BNE :-
  CPX #$2FBB
  BCC :--

  JSR load_second_part

  LDY #$0400
  STY APUIO2
  STZ APUIO1
  TXA
  ADC #$02
  ORA #$01
  STA APUIO0

  ; LDX #$FFFF
  ; STX $11A6
  ; LDA #$7E
  ; STA $2C
  ; STA $2F
  ; STA $32
  ; LDX $1123
  ; BEQ $C155F7
  ; STX $2A
  ; LDX $1121
  ; BEQ $C155F7
  ; STX $2D
  ; LDX $1127
  ; BEQ $C155F7
  ; STX $30

  ; PHB
  ; PHK
  ; PLB
  ; LDY #$00C2
  ; LDA $5641,Y
  ; STA [$2A],Y
  ; STA [$2D],Y
  ; STA [$30],Y
  ; DEY
  ; BPL $C155E8
  ; PLB
  ; PLP


;   LDA #$00 ; - set to 00 to disable all sound
  LDA #$01 
  STA $0A18
  PLB
  STZ $00
  STZ $01
  STZ $02
  SEP #$30
  RTL

load_second_part:
 REP #$18
  LDA #$8D
  PHA
  PLB
  LDY #$BFFF
  STY APUIO2
  LDA #$01
  STA APUIO1
  TXA
  ADC #$02
  ORA #$01
  STA APUIO0
  LDX #$0000
: CMP APUIO0
  BNE :-
  ; LDA $C006AE ;???
  LDA #$00
  STA APUIO1
  TXA
  STA APUIO0
: CMP APUIO0
  BNE :-
: LDA sound_emulator_second_4000,X
  STA APUIO1
  TXA
  STA APUIO0
  INX
: CMP APUIO0
  BNE :-
  CPX #$4000
  BCC :--
  RTS
