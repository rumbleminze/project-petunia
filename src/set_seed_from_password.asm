FIRST_PASSWORD_CHAR = $6031
K_CHAR  = $14
I_CHAR  = $12

maybe_seed_via_password:
  PHB
  LDA #$A8
  PHA
  PLB

  LDX #$23                 
  LDA #$00     
  
: STA $600D,X              
  DEX                      
  BPL :-
  LDX #$11                 
  LDA #$00 

: STA $6061,X              
  DEX                      
  BPL :-              

; skip this check if we are randomizing
LDA RANDOMIZE_ENABLED
BEQ bailToOriginal

LDA FIRST_PASSWORD_CHAR
CMP #K_CHAR
BNE bailToOriginal

LDA FIRST_PASSWORD_CHAR + 1
CMP #I_CHAR
BNE bailToOriginal

; seed setting
LDA FIRST_PASSWORD_CHAR + 2
AND #$0F
ASL A
ASL A
ASL A
ASL A
STA FIXED_SEED_LB

LDA FIRST_PASSWORD_CHAR + 3
AND #$0F
CLC
ADC FIXED_SEED_LB
STA FIXED_SEED_LB

LDA FIRST_PASSWORD_CHAR + 4
AND #$0F
ASL A
ASL A
ASL A
ASL A
STA FIXED_SEED_LB + 1

LDA FIRST_PASSWORD_CHAR + 5
AND #$0F
CLC
ADC FIXED_SEED_LB + 1
STA FIXED_SEED_LB + 1

; clear the stack
PLA
PLA
PLA
PLA
PLA
PLA
LDA #$A1
PHA
LDA #$04
PHA

LDA #$A2
PHA
PLB
PHA
LDA #$EE
PHA
LDA #$2A
PHA

LDA #$02
STA $A0
STA $6028
LDA #$FF
STA FIXED_SEED_LB - 1
LDA #$00
LDX #$00
RTL
bailToOriginal:
    PLB
    RTL