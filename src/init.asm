; A very simple SNES init routine
; For serious use, you probably want to do more than this
; This is simple and understandable, though
; Will leave you in A8 XY16 mode

; equivilent to nes_c000
; Disable interrupts and enable native mode
sei
clc
xce
cld

setAXY16

; ZeroCPU registers NMITIMEN through MEMSEL
stz $4200
stz $4202
stz $4204
stz $4206
stz $4208
stz $420A
stz $420C

lda #$0080
sta INIDISP ; Turn off screen ("forced blank")

; Zero some registers used for rendering
stz OAMADDL
stz BGMODE
stz BG1SC
stz BG3SC
stz BG12NBA
stz VMADDL
stz W12SEL
stz WH0
stz WH2
stz WBGLOG
stz TM
stz TMW

; Disable color math / etc
ldx #$0030
stx CGWSEL
ldy #$00E0
sty COLDATA


; Zero window masks
stz WOBJSEL

setAXY8
; zero some of my variables
;   LDX #$FF                 
;   TXS                      
  LDA #$03                 
  STA $6FFA                
  LDA #$7F                 
  STA $6FFB                
  JSR nes_eb07          
  LDX #$00                 
: LDA $F081,X              
  STA $6000,X              
  INX                      
  BNE :-


LDA #$00                 
TAX                      
: STA $0100,X              
STA $0200,X              
; STA $0300,X              
; STA $0400,X              
; STA $0500,X              
; STA $0600,X              
; STA $0700,X              
INX                      
BNE :-     

setXY16


