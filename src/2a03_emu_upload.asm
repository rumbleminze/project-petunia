.segment "SOUND_EMU"
upload_sound_emulator_to_spc:
  REP #$18
  PHB
  LDA #$8C
  PHA
  PLB
  STZ $02
  LDX #$BBAA
: CPX $2140
  BNE :-
  LDY #$0000
  LDX #$8000
  STX $00
  LDX #$0200
  STX $2142
  LDA #$01
  STA $2141
  LDA #$CC
  STA $2140
: LDA $2140
  CMP #$CC
  BNE :-
: LDA $8000,Y
  STA $2141
  TYA
  STA $2140
: CMP $2140
  BNE :-
  INY
  CPY $00
  BNE :--
  INC $02
  LDA $02
  CMP #$02
  BEQ :+
  LDY #$0000
  LDX #$7DC0
  STX $00
  LDA #$8D
  PHA
  PLB
  BRA :--
: STZ $2141
  LDX #$0200
  STX $2142
  INY
  INY
  TYA
  STA $2140
  LDA #$01
  STA $0A18
  PLB
  STZ $00
  STZ $01
  STZ $02
  SEP #$30
  RTL

