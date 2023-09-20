; $1A
; $A0 - seems to determine if we've hit start
; $b2 - start vs. continue vs. whatever, essentially what state we're in
; $B6 - What bank we're in
; $BE ?
; $FD - bg_scroll_y / bg1_y
; $FE - bg1_y_hb
; $390 - $39f - palatte storage prior to copying
; a0ba

nes_98c6:
  ;LDA PpuStatus_2002       
  LDA $0100                
  ;STA PpuControl_2000  
nes_98cf:    
  RTS                      

nes_98d0:
; don's seem to go here
;   LDA $A0                  
;   CMP #$02                 
;   BCC nes_98cf                
;   LSR A                    
;   BCS $990B                
;   LSR A                    
;   BCC nes_98cf               
;   CMP #$02                 
;   BCS nes_98cf                
;   ASL A                    
;   TAX                      
;   LDA $9907,X              
;   STA $00                  
;   LDA $9908,X              
;   STA $01                  
;   LDA #$00                 
;   STA $02                  
;   LDA #$70                 
;   STA $03                  
;   LDX #$0F                 
;   LDY #$00    
;   nes_98f8:             
;   LDA ($00),Y              
;   STA ($02),Y              
;   INY                      
;   BNE nes_98f8           
;   INC $01                  
;   INC $03                  
;   DEX                      
;   BNE nes_98f8         
  RTS                      

nes_990b:
;nyi C904B0C00A

rts


nes_a003_something_with_music:
  JMP nes_a0fd            

nes_a000_data:
JMP nes_a05a ; 4C 5A A0
JMP nes_a554 ; 4C 54 A5
.byte $4c, $47, $AD ; JMP nes_ad47 ; 4C 47 AD
.byte $4C, $40, $DF ; JMP nes_df40 ; 4C 40 DF 
.byte $4c, $47, $AD ; 4C 47 AD 
.byte $4c, $47, $AD ; 4C 47 AD
.byte $4c, $47, $AD ; 4C 47 AD
.byte $4c, $47, $AD ; 4C 47 AD
.byte $4c, $47, $AD ; 4C 47 AD
.byte $4c, $47, $AD ; 4C 47 AD
.byte $4c, $47, $AD ; 4C 47 AD
.byte $4c, $47, $AD ; 4C 47 AD
.byte $4c, $47, $AD ; 4C 47 AD
.byte $4c, $47, $AD ; 4C 47 AD
.byte $4c, $47, $AD ; 4C 47 AD
.byte $4c, $47, $AD ; 4C 47 AD
.byte $4c, $47, $AD ; 4C 47 AD
.byte $4c, $47, $AD; 4C 47 AD
.byte $4c, $47, $AD ; 4C 47 AD
.byte $4c, $47, $AD ; 4C 47 AD
.byte $4c, $47, $AD; 4C 47 AD
.byte $4c, $47, $AD ; 4C 47 AD

; I doubt these are all real, just doing byte code for the rest.
.byte $67, $C5, $E7, $C5, $47, $AD, $47, $AD, $47, $AD, $47, $AD, $47, $AD, $47, $AD, $47, $AD, $47, $AD, $47, $AD, $47, $AD

nes_a05a:
  setAXY8
  LDX #$00     
  nes_a05c:            
  LDA $F081,X              
  STA $6000,X              
  INX                      
  BNE nes_a05c                
  JSR nes_a553 ;               
  JSR nes_eef0 ;                
  JSR nes_eb07 ;               
  LDA $A0                  
  CMP #$01                 
  BEQ post_start              
  LDA #$10                 
  STA $85                  
  JSR nes_eee5                
  LDA #$00                 
  STA $A0                  
  STA $18                  
  STA $0600                
  INC nes_1a                 
  JSR clear_nes_sprite_ram
  JSR nes_a236 
  LDA #$00                 
  JSR nes_a700                
  JSR nes_a71d                
  ;JSR nes_a5c4 ; $A5C4             
  nes_a097:   
  ; seems to loop until vblank
  ;LDA PpuStatus_2002       
  ;BPL nes_a097                
  JSR nes_eb2e           
  JSR write_palatte_data_to_vram
  JSR nes_ef01   
  main_busy_loop:
  nes_a0a5:             
  LDA nes_1a                
  ROR A                    
  BCC check_for_start      
;   LDA $038D                
;   BNE check_for_start      
;   LDA #$10                 
;   STA $0384                
check_for_start:         
  LDA $18                  
  AND #$10                 
  BEQ main_busy_loop 

nes_a0ba:
post_start:
    ; LDA #$01                 
    ; STA $0380                
    JSR nes_c856               
    JMP nes_a16a    

    LDA #$00                 
    STA $AD                  
    STA $AE                  
    JSR fill_nametable_with_12
    LDA #$20                 
    STA $85                  
    JSR nes_eee5               
    INC nes_1a                 
    JSR clear_nes_sprite_ram
    LDA #$01                 
    JSR nes_a700                
    JSR nes_a71d                
    JSR nes_a75b                
    LDA #$01                 
    STA $B1         
    nes_a0e9:         
    ;LDA PpuStatus_2002       
    ;BPL nes_a0e9               
    JSR nes_eb2e
    JSR write_palatte_data_to_vram
    JSR nes_ef01    
    nes_a0f7:           
    LDA $00                  
    LDA $B1                  
    BNE nes_a0f7            
    JSR nes_eef0                
    LDA $B2                  
    JSR nes_ee2b     




nes_a236:
  JSR fill_nametable_with_12
  ;LDA PpuStatus_2002       
  LDA #$23                 
;   STA PpuAddr_2006  
  STA VMADDH       
  LDA #$C0                 
;   STA PpuAddr_2006         
  STA VMADDL
  LDY #$3F                 
  LDA #$AA                 
;   STA PpuData_2007    
  nes_a24a:
  STA VMDATAL     
  DEY                      
  BPL nes_a24a                
  LDA #$00                 
  STA $46     
  nes_a254:             
  JSR nes_a263              
  JSR nes_c2b3 ; $C2B3                
  INC $46                  
  LDA $46                  
  CMP #$16                 
  BNE nes_a254               
  RTS                      
nes_a263:
  STA $00                  
  ASL A                    
  ASL A                    
  CLC                      
  ADC $00                  
  TAX                      
  LDY #$00    
  ; copies these 5 bytes specifically:
  ; E7 21 E8 A2 12
  nes_a26d:             
  LDA $A27A,X          ; ?????    
  STA $0041,Y          ; ?????   
  INX                      
  INY                      
  CPY #$05                 
  BNE nes_a26d                
  RTS                      

nes_a529:
;   LDA $0600                
;   BNE :+             
;   JMP write_palatte_data_to_vram
;   : TAY                      
;   LDX #$00                 
;   LDA PpuStatus_2002       
;   LDA $0602                
;   STA PpuAddr_2006         
;   LDA $0601                
;   STA PpuAddr_2006         
;   LDA $0603,X              
;   STA PpuData_2007         
;   INX                      
;   DEY                      
;   BNE $A543                
;   LDA #$00                 
;   STA $0600                
  RTS                      

nes_a554:
title_screen_interrupt_handler:
  PHP                      
  PHA                      
  TXA                      
  PHA                      
  TYA                      
  PHA                      
  ;LDA PpuStatus_2002       
  JSR nes_eb2e ;$EB2E                
  LDA $85                  
  CMP #$10                 
  BEQ nes_a577 ; $A577                
  CMP #$20                 
  BEQ nes_a589           
nes_a56a:  
  JSR count_frames         
  JSR nes_c856 ; $C856                
  PLA                      
  TAY                      
  PLA                      
  TAX                      
  PLA                      
  PLP                      
  RTS                      
nes_a577:
  JSR nes_a529                
  JSR nes_ebc9       
  JSR scroll_bg1_every_other_frame
  
  jsr initialize_heart_sprites
  JSR move_heart_sprites    
  JMP nes_a56a 
nes_a589:            
  LDA $18                  
  BEQ nes_a592               
;   LDA #$01                 
;   STA $0381  
nes_a592:              
  LDA $B1                  
  JSR nes_ee2b                

nes_a602:
move_heart_sprites:
;   move sprite of heartdown with the BG
  DEC $0280                
  LDA bg1_y                  
  CMP #$58                 
  BNE exit_move_sprites               
  LDA scroll_stop_flag                  
  LSR A                    
  BCC exit_move_sprites                
  LDA #$EF                 
  STA $0280                
  LDA #$39                 
  STA $0283                
  LDA #$80                 
  STA title_scroll_state  
  exit_move_sprites:              
  RTS         



nes_a0fd:
  JMP nes_a2cd     

nes_a109:
;   LDA #$00                 
;   STA $B2                  
;   JSR nes_a1e7               
;   LDA $B2                  
;   TAX                      
;   STA $AF                  
;   CLC                      
;   LDA #$05                 
;   ADC $A16E,X              
;   STA $08                  
;   LDA #$60                 
;   ADC #$00                 
;   STA $09                  
;   LDY #$07                 
; : LDA ($08),Y              
;   STA $0120,Y              
;   DEY                      
;   BPL :-               
;   CLC                      
;   LDA #$0D                 
;   ADC $A16E,X              
;   STA $08                  
;   LDA #$60                 
;   ADC #$00                 
;   STA $09                  
;   LDY #$1C                 
;   LDA ($08),Y              
;   STA $0130                
;   DEY                      
;   LDA ($08),Y              
;   STA $A0                  
;   DEY                      
;   LDA #$0F                 
;   STA $A6                  
;   STA $0171                
;   DEY                      
;   LDA ($08),Y              
;   STA $AA                  
;   STA $0170                
;   DEY                      
; : LDA ($08),Y              
;   STA $013E,Y              
;   STA $0157,Y              
;   DEY                      
;   BPL :-               
nes_a163:
    LDA #$00
    STA $38
    JMP nes_c06d
nes_a16a:
    INC $A0                  
    BNE nes_a163 
    ; not ran yet...            
    ; BRK                      
    ; RLA* $4E  
nes_a17a:               
    LDA #$03                 
    STA $B2                  
    LDA $B2                  
    SEC                      
    SBC #$03                 
    STA $6100                
    JSR nes_a826 ; $A826                
    LDA #$02                 
    STA $B1                  
    ;LDA PpuStatus_2002       
    ;BPL $A184                
    JSR write_palatte_data_to_vram
    JSR $EF01                
:   LDA $00                  
    LDA $B1                  
    BNE :-    
    JSR nes_eef0              
    JSR nes_abc6 ; $ABC6                
    BNE :+                
    JMP nes_a109 ; $A109     
:   JSR nes_ac4d ; $AC4D           

nes_a1e7:
  LDA #$00                 
  LDX $B2                  
  CLC                      
  ADC $A16E,X              
  TAX                      
  LDA $6028,X              
  CMP #$02                 
  BNE nes_a208              
  LDA $6029,X              
  BNE nes_a208               
  LDA #$00                 
  TAY                      
: STA $600D,X              
  INX                      
  INY                      
  CPY #$1A                 
  BNE :-
  nes_a208:
  RTS                      

nes_a209:
	
    
scroll_bg1_every_other_frame:
scroll_bg1:

;   ;Original code:
;	LDA frame_counter_lb                 
;   AND #$01                 
;   BEQ $A210                
;   RTS                               
;   LDA frame_counter_hb                  
;   BNE $A21A                
;   LDA frame_counter_lb                  
;   CMP #$80                 
;   BCC $A235                
;   INC $FD                  
;   JSR $A5CA                
;   LDA $FD                  
;   CMP #$F0                 
;   BNE $A235                
;   LDA #$00                 
;   STA frame_counter_lb                  
;   STA frame_counter_hb                 
;   LDA $1A                  
;   EOR #$01                 
;   STA $1A                  
;   LDA #$00                 
;   STA $FD                  
;   RTS                      

LDA frame_counter_lb
	AND #$01
	; only scroll every other frame
	BEQ :+
	rts
:	LDA frame_counter_hb
	BNE increment_vertical_scroll

	LDA frame_counter_lb

	CMP #$80
	BCC store_bg1_scroll

	increment_vertical_scroll:
	inc bg1_y
	bne :+
	; inc. the hb if we rolled
	inc bg1_y_hb
	:
	
	jsr move_heart_sprites
	; jsr move_heart_sprites

	LDA bg1_y
	CMP #$00
	BNE store_bg1_scroll

	LDA #$00
	STA frame_counter_lb
	STA frame_counter_hb

	LDA scroll_stop_flag
	EOR #$01

	STA scroll_stop_flag
	LDA #$00
	; STA bg1_y

	store_bg1_scroll:
	lda bg1_y
	sta BG1VOFS

	lda bg1_y_hb
	sta BG1VOFS
	
	rts

nes_a25f:
    LDA nes_ef               
    AND #$02                 
    STA nes_31f                
    LDA nes_f0                 
    AND #$02                 
    EOR nes_31f               
    CLC                      
    BEQ nes_a271             
    SEC    
    nes_a271:                  
    ROR nes_ef               
    ROR nes_f0                  
    RTS      

nes_a29d:
  INC $0302                
  JSR nes_a35a             
  STA $0303                
  RTS                      

nes_a2a7:
  LDA $0302                
  BEQ nes_a29d             
  LDA $0303                
  BEQ nes_a2c4              
  CMP #$12                 
  BEQ nes_a2cc               
  AND #$02                 
  BEQ nes_a2bd               
  LDA #$84                 
  BNE nes_a2bf  
  nes_a2bd:             
  LDA #$8B    
  nes_a2bf:             
  ;STA Sq0Sweep_4001        
  BNE nes_a2c9
  nes_a2c4:              
  LDY #$4A                 
  ;JSR $A276  
  nes_a2c9:              
  INC $0303       
  nes_a2cc:         
  RTS                      

nes_a2cd:
  LDA #$C0                 
  ;STA Ctrl2_FrameCtr_4017  
  JSR nes_a25f              
;   LDA $0380                
;   LSR A                    
;   BCS nes_a305               
  LDA $DF                  
  BNE nes_a2a7                
;   LDA #$00                 
;   STA $0302                
  JSR scroll_bg1              
;   JSR $A242                
;   JSR $A232                
;   JSR $ABE7    
nes_a2f0:
  LDA #$00                 
;   STA $0380                
;   STA $0381                
;   STA $0382                
;   STA $0383                
;   STA $0384                
;   STA $0385    
  RTS                      

nes_a305:
  JSR nes_a31d               
  BEQ nes_a2f0              
  LDA $032C                
  BEQ nes_a31d              
;   LDA $038D                
;   STA $034F                
  RTS                      
  
nes_a31d:
  JSR nes_a336                
  JSR nes_a35a               
  JSR nes_a327              
  RTS                      

nes_a327:
  LDA #$00                 
  STA $032D                
  STA $0302                
  STA $034F                
  STA $032C                
  RTS    

nes_a336:
  LDA #$00                 
  STA $034A                
  STA $034B                
  STA $034C                
  STA $034D                
  STA $0307                
;   STA $0388                
;   STA $0389                
;   STA $038A                
;   STA $038B                
;   STA $038C                
;   STA $038D                
  RTS                      

;looks like music stuff?
nes_a35a:
;   LDA #$10                 
;   STA Sq0Duty_4000         
;   STA Sq1Duty_4004         
;   STA NoiseVolume_400C     
;   LDA #$00                 
;   STA TrgLinear_4008       
;   STA DmcCounter_4011      
  RTS                      


nes_a553:
    RTS

nes_a700:
  ASL A                    
  ASL A                    
  ASL A                    
  ASL A                    
  CLC                      
  ADC #$2B                 
  STA $20                  
  LDA #$A7                 
  ADC #$00                 
  STA $21                  
  LDY #$00                 
  LDX #$10                 
: LDA ($20),Y              
  STA $0390,Y              
  INY                      
  DEX                      
  BNE :-
  RTS                      

nes_a71d:
; this almost seems like a bug, and should be Y not X?
  LDX #$00                 
: LDA $A74B,Y              
  STA $03A0,Y              
  INY                      
  CPY #$10                 
  BNE :-
  RTS                      

nes_a75b:
  JSR nes_a76b          
  JSR nes_a770            
  JSR nes_a77c              
  LDA #$04                 
  STA $B2                  
  JMP nes_a7ad              

nes_a76b:
  LDA #$00                 
  STA $B2                  
  RTS                      

nes_a770:
  LDA #$CB                 
  STA $08                  
  LDA #$A7                 
  STA $09                  
  JSR $E7CB                
  RTS                      

nes_a77c:
  JSR clear_nes_sprite_ram
  JMP nes_a782
; no idea why, but this jumps to the next instruction
nes_a782:               
  LDX #$00      
  nes_a784:           
  LDA $A790,X              
  STA $0230,X              
  INX                      
  CPX #$04                 
  BCC nes_a784           
  RTS      

nes_a7ad:
  LDX $B2                  
  CPX #$01                 
  BCC nes_a7b7               
  LDX #$00                 
  BEQ nes_a7b8    
  nes_a7b7:            
  INX      
  nes_a7b8:                
  STX $B2                  
  LDA $A7C7,X              
  STA $0230                
  LDA $A7C9,X              
  STA $0233                
  RTS                      

; gets called upon "continue"
nes_a826:
  JSR nes_a844
  JSR nes_a850              
  JSR nes_a860      
  LDA #$03                 
  STA $0701                
  LDA #$00                 
  STA $074E                
  LDX #$2F      
  nes_a83b:           
  LDA #$00                 
  STA $6031,X              
  DEX                      
  BPL nes_a83b           
  RTS                 

nes_a844:
  LDA #$00                 
  STA $0702                
  STA $0700                
  STA $0703                
  RTS                      

nes_a850:
  LDA #$AE                 
  STA $08                  
  LDA #$AA                 
  STA $09                  
  LDA #$20                 
  STA $00                  
  JSR nes_e7cb           
  RTS                      

nes_a860:
  JSR initialize_first_byte_of_0200_to_02FF
  JSR nes_a867            
  RTS                      

nes_a867:
  LDA $6100                
  BNE nes_a879            
  LDX #$00      
  nes_a86e:           
  LDA $AA79,X              
  STA $0234,X              
  INX                      
  CPX #$08                 
  BCC nes_a86e
  nes_a879:              
  RTS                      

password_check_maybe:
nes_abc6:
  ;JSR $ABD0                
  ;JSR $AC93                
  ;JSR $AC36                
  RTS                      

nes_ac4d:
  LDA #$28                 
  LDX #$12                 
  LDY #$00                 
  JSR fill_vram_and_attribute
  ;LDA PpuStatus_2002       
  LDA #$2A                 
;   STA PpuAddr_2006         
  STA VMADDH
  LDA #$08                 
;   STA PpuAddr_2006         
  STA VMADDL
  LDX #$00                 
: LDA $AC74,X              
;   STA PpuData_2007         
  STA VMDATAL
  INX                      
  CPX #$0F                 
  BCC :-                
  JSR nes_ebc9 ; $EBC9                
  RTS                      


nes_c06d:
  LDA #$00                 
  ;STA PpuControl_2000      
  ;STA PpuMask_2001         
  STA $0100                
  LDA $38                  
  BMI nes_c08d               
  AND #$0F                 
  BEQ nes_c083                
  JMP nes_c1d4
nes_c083:             
  LDA $A0                  
  JSR nes_c0c9               
nes_c08d:
  LDA #$A0                 
  JSR nes_c23d          
  LDA $A0                  
  CMP #$09                 
  BEQ nes_c096             
  JSR nes_c331  
nes_c096:              
  JSR nes_c24a                
  LDA #$00                 
  STA $38                  
  JMP $1F00  ; jump to a05a

;c0c9-c14f
nes_c0c9:
  setAXY8
  LDA #$00                 
  TAY                      
  STA $00                  
;   STA PpuAddr_2006         
;   STA PpuAddr_2006  
  STA VMADDL
  STA VMADDH       
  JSR nes_c17f
  LDA $A0                  
  BNE nes_c0e6 
  ; load tiles from $A000               
  LDA #$A0                 
  STA tileset_load_start + 1
  LDX #$20                 
  JSR nes_c170              
  BEQ nes_c120               
nes_c0e6: 
 lda #$0080
sta INIDISP ; Turn off screen ("forced blank")
  setXY16
  ldx #VRAM_BG_CHARS
  stx VMADDL

  ; disable interrupts
 stz NMITIMEN


  setAXY8
  ; load tiles from $8000 to BG Characters

  LDA #$C0                 
  STA tileset_load_start + 1            
  LDX #$0F                 
  JSR nes_c170         
  LDA $A0                  
  TAX                      
  LDA nes_c152_data,X              
  CMP #$80                 
  BEQ nes_c120
  game_start_maybe:
  AND #$BF                 
  STA $01                  
  LDA #$01                 
  JSR nes_c17f    
 
  JSR nes_c170
  LDA #$1C                 

  LDX #$04                 
  JSR nes_c170
  lda #%10000001
	sta NMITIMEN
  lda #$0f
	sta INIDISP  
nes_c120:  
; this builds up some code at 7F00 which is jumped to later
; 7f00 holds a jump table, mostly going to 
  LDA $A0                  
  ASL A                    
  TAY                      
  LDA nes_c15c_data,Y              
  STA $00                  
  LDA nes_c15c_data + 1,Y              
  STA $01                  
  LDY #$00                 
  LDA ($00),Y              
  STA $BE                  
  JSR nes_c17f
  INY                      
  LDA ($00),Y              
  PHA                      
  INY                      
  LDA ($00),Y              
  STA $01                  
  PLA                      
  STA $00                  
  LDY #$59   
: LDA ($00),Y              
  STA $7F00,Y              
  DEY                      
  BPL :-
  LDA #$10                 
  JMP nes_ca90       

; This data is referenced, usually indexed by $A0
nes_c152_data:
.byte $A0, $80, $C0

; this is a pointer to the data stored in c1a8, which seems to contain the location
; of the #$59 bytes to copy to $7F00 depending on what was in $A0
; this is possibly for levels/start menu
; these are definitely wrong as they point to NES addresses currently
nes_c15c_data:
.byte .lobyte(nes_c1a8_data)
.byte .hibyte(nes_c1a8_data)

.byte .lobyte(nes_c1a8_data+3)
.byte .hibyte(nes_c1a8_data+3)

.byte .lobyte(nes_c1a8_data+6)
.byte .hibyte(nes_c1a8_data+6)

.byte .lobyte(nes_c1a8_data+9)
.byte .hibyte(nes_c1a8_data+9)

.byte .lobyte(nes_c1a8_data+12)
.byte .hibyte(nes_c1a8_data+12)

.byte .lobyte(nes_c1a8_data+15)
.byte .hibyte(nes_c1a8_data+15) 

.byte .lobyte(nes_c1a8_data+18)
.byte .hibyte(nes_c1a8_data+18) 

.byte .lobyte(nes_c1a8_data+21)
.byte .hibyte(nes_c1a8_data+21) 

.byte .lobyte(nes_c1a8_data+24)
.byte .hibyte(nes_c1a8_data+24) 

.byte .lobyte(nes_c1a8_data+27)
.byte .hibyte(nes_c1a8_data+27)  

.byte .lobyte(nes_c1a8_data+30)
.byte .hibyte(nes_c1a8_data+30) 

; c1a8 data, seems maybe... some index then an address, usually on a bank barrier
; 01 00 A0 ; c1 a8
; 01 00 A0 ; c1 ab
; 02 00 80 ; c1 ae
; 05 00 80 ; c1 b1
; 02 A0 99 ; c1 b4
; 05 00 80 ; c1 b7
; 03 00 80 ; c1 ba
; 05 00 80 ; c1 bd
; 03 30 9C ; c1 c0
; 04 00 80 ; c1 c3

nes_c1a8_data:
.byte $01, .lobyte(nes_a000_data), .hibyte(nes_a000_data)
.byte $01, .lobyte(nes_a000_data), .hibyte(nes_a000_data)
.byte $02, $00, $80
.byte $05, $00, $80
.byte $02, $A0, $99
.byte $05, $00, $80
.byte $03, $00, $80
.byte $05, $00, $80
.byte $03, $30, $9C
.byte $04, $00, $80

copy_tile_data_banks:
copy_X_by_100_bytes_from_ptr_00_to_ppu:
nes_c170:
    stz tile_counter

    lda tileset_load_start + 1
    sta tileset_load_hb_start + 1

    lda tileset_load_start
    CLC
    ADC #$08
    STA tileset_load_hb_start

;   LDA ($00),Y              
;   STA PpuData_2007         
;   INC $00                  
;   BNE nes_c170              
;   INC $01                  
;   DEX                      
;   BNE nes_c170    
    @charset_row_loop:

    lda (tileset_load_start), y
    sta VMDATAL
    lda (tileset_load_hb_start),y
    sta VMDATAH

    inc tileset_load_start
    inc tileset_load_hb_start

    inc tile_counter
    lda tile_counter

    AND #$08

    beq @charset_row_loop
    ; NES tiles are 2bpp but we want to use 4bpp
    ; the way they tiles are structured this means that 
    ; for a row of 8 pixels, the first 16 bytes are the 2bpp data
    ; and the next 16 bytes are just 0's (transparent)
    stz tile_counter
    stz VMDATAL
    stz VMDATAH    
    stz VMDATAL
    stz VMDATAH    
    stz VMDATAL
    stz VMDATAH    
    stz VMDATAL
    stz VMDATAH  
    stz VMDATAL
    stz VMDATAH    
    stz VMDATAL
    stz VMDATAH    
    stz VMDATAL
    stz VMDATAH    
    stz VMDATAL
    stz VMDATAH
    lda tileset_load_start
    CLC
    ADC #$08
    sta tileset_load_start
    CLC
    ADC #$08
    STA tileset_load_hb_start
    
    ; keep going until we roll back to 0
    lda tileset_load_start
    bne copy_tile_data_banks

    inc tileset_load_start + 1
    inc tileset_load_hb_start + 1
    dex

    bne copy_tile_data_banks

    RTS                      

nes_c17f:
  PHA                      
  LDA $0100                
  AND #$7F                 
  ; STA PpuControl_2000      
  PLA                      
  STA $B6                  
  STA $FFFF                
  LSR A                    
  STA $FFFF                
  LSR A                    
  STA $FFFF                
  LSR A                    
  STA $FFFF                
  LSR A                    
  STA $FFFF                
  ;LDA PpuStatus_2002       
  LDA $0100                
  ;STA PpuControl_2000      
  RTS                      

nes_c1d4:
; nyi
    ; JSR nes_eef0                
    ; LDA #$10                 
    ; STA $0100                
    ; JSR $C26F                
    ; LDA $38                  
    ; JSR $C2A0                
    ; LDA $38                  
    ; CMP #$04                 
    ; BNE $C1EA                
    ; LDA PpuStatus_2002       
    ; BPL $C1EA                
    ; JSR write_palatte_data_to_vram
    ; JSR $EB2E                
    ; JSR $EF01                
    ; LDA $A3                  
    ; BNE $C1F8                
    ; LDA #$10                 
    ; STA $0100                
    ; STA PpuControl_2000      
    ; LDA #$03                 
    ; STA $6FFA                
    ; LDA #$7F                 
    ; STA $6FFB                
    ; JMP nes_c06d    
    rts         



nes_c23d:
  STA $F1                  
  LDX #$00                 
  TXA     
  nes_c242:                 
  STA $00,X                
  INX                      
  CPX $F1                  
  BCC nes_c242              
  RTS  

; store $45 bytes from ($43), 0 - ($43), Y to PPU ($41$42)
nes_c2b3:
  ;LDA PpuStatus_2002       
  LDA $42                  
;   STA PpuAddr_2006 
  STA VMADDL        
  LDA $41                  
;   STA PpuAddr_2006         
  STA VMADDH
  LDY #$00   
  nes_c2c2:              
  LDA ($43),Y              
;   STA PpuData_2007         
  STA VMDATAL
  INY                      
  CPY $45                  
  BNE nes_c2c2               
  RTS                    

nes_c24a:
  LDA #$10                 
  STA $0100                
  LDA #$1E                 
  STA $FF                  
  RTS                      


nes_c331:
  LDA #$01                 
;   STA $0380                
  JMP nes_c856               
  TXA                      
  PHA                      
  TYA                      
  PHA                      
  ; LDA PpuStatus_2002       
  ;JSR $EB2E                
  ;JSR write_palatte_data_to_vram
  ;JSR $C357                
  ;JSR handle_input         
 ; JSR count_frames         
 ; JSR $C856                
  PLA                      
  TAY                      
  PLA                      
  TAX                      
  RTS                      

nes_c856:
    LDA $B6                  
    PHA                      
    LDA #$04                 
    JSR nes_c17f                
    JSR nes_a003_something_with_music                
    PLA                      
    JSR nes_c17f              
    RTS                      

nes_ca90:
  PHA                      
  LDA $0100                
  AND #$7F                 
  ;STA PpuControl_2000      
  PLA                      
  STA $BC                  
  LDA $B6                  
  PHA                      
  LDA #$CA                 
  PHA                      
  LDA #$C6                 
  PHA                      
  LDA #$80                 
  STA $BD                  
  LDA #$06                 
  STA $B6                  
;   STA $FFFF                
;   LSR A                    
;   STA $FFFF                
;   LSR A                    
;   STA $FFFF                
;   LSR A                    
;   STA $FFFF                
;   LSR A                    
;   STA $FFFF                
  LDA #$6C                 
  STA $BB                  
  JMP $00BB ; we stored 6c 10 80 01 there, which is a JMP to ($8010), which is $98D0 in my one test
  PHA                      
  LDA $0100                
  AND #$7F                 
 ; STA PpuControl_2000      
  PLA                      
  STA $B8                  
  PLA                      
  STA $B6                  
  STA $FFFF                
  LSR A                    
  STA $FFFF                
  LSR A                    
  STA $FFFF                
  LSR A                    
  STA $FFFF                
  LSR A                    
  STA $FFFF                
  LDA $B8                  
  PHA                      
;  LDA PpuStatus_2002       
  LDA $0100                
;  STA PpuControl_2000      
  PLA                      
  RTS                      

initialize_first_byte_of_0200_to_02FF:
nes_e3f9:
  LDA #$F8                 
  LDX #$00                 
: STA $0200,X              
  INX                      
  INX                      
  INX                      
  INX                      
  BNE :-
  RTS                      


nes_e7cb:
  LDY #$00   
  nes_e7cd:              
  JSR $EA4B                
  BNE nes_e7e1                
;  LDA PpuStatus_2002       
  LDA $0100                
  AND #$FB                 
  STA $0100                
;  STA PpuControl_2000      
  RTS  
  nes_e7e1:                    
  BMI nes_e7cd           
  SEC                      
  SBC #$01                 
  ASL A                    
  TAX                      
  LDA $E7FB,X              
  STA $0A                  
  LDA $E7FC,X              
  STA $0B                  
  LDA #$E7                 
  PHA                      
  LDA #$CC                 
  PHA                      
  JMP ($000A) ; going to e81b?             

nes_e81b:
  JSR nes_ea4b                
  STA $00                  
;  LDX PpuStatus_2002       
;   STA PpuAddr_2006     
  STA VMADDH    
  LDA #$00                 
;   STA PpuAddr_2006         
  STA VMADDL
  JSR nes_ea4b                
  JSR nes_e83b             
  JSR nes_ea4b                
  TAX                      
  JSR nes_ea4b                
  JMP nes_e84b               
;--------sub start--------
nes_e83b:
  LDX #$00                 
  JSR nes_e861                
  JSR nes_e861               
  JSR nes_e861             
  LDX #$C0                 
  JMP nes_e861   

store_registers_load_ppu_from_x_ptr:
nes_e84b:            
  STX $0C                  
  STA $0D                  
  STY $01                  
  LDX #$40                 
  LDY #$00      
  nes_e855:          
  LDA ($0C),Y              
;   STA PpuData_2007   
  STA VMDATAL      
  INY                      
  DEX                      
  BNE nes_e855           
  LDY $01                  
  RTS                      

nes_e861:
  ;STA PpuData_2007 
  STA VMDATAL        
  DEX                      
  BNE nes_e861                
  RTS                      

nes_ea4b:
  LDA ($08),Y              
  PHP                      
  INY                      
  BNE nes_ea53                
  INC $09  
  nes_ea53:                
  PLP                      
  RTS                      

set_up_bank_switching:
nes_eb07:
  ; sets horizontal mirroring 
  ; and fix last bank at $C000 and switch 16 KB bank at $8000
  ; we don't need to do this, I think.
  ; LDA #$0F                 
  ; STA $9FFF                
  ; LSR A                    
  ; STA $9FFF                
  ; LSR A                    
  ; STA $9FFF                
  ; LSR A                    
  ; STA $9FFF                
  ; LSR A                    
  ; STA $9FFF                
  RTS                      

nes_eb2e:
  ; LDA #$00                 
  ; STA OamAddr_2003        
  ; write OAM data from 0200 to Sprite
  ; for us we just want to call 
  ; LDA #$02                 
  ; STA SpriteDma_4014       
  JSR translate_nes_sprites_to_oam
  RTS                      

fill_vram_and_attribute:
nes_eb76:
  STA $00                  
  STX $01                  
  STY $02                  
  ;LDA PpuStatus_2002       
  LDA $0100                
  AND #$FB                 
  ;STA PpuControl_2000      
  LDA $00                  
  ;STA PpuAddr_2006     
  STA VMADDL    
  LDY #$00                 
  ;STY PpuAddr_2006         
  STA VMADDH
  LDX #$04                 
  CMP #$20                 
  BCS nes_eb99              
  LDX $02      
  nes_eb99:            
  LDY #$00                 
  LDA $01    
  nes_eb9d:              
;   STA PpuData_2007   
  STA VMDATAL      
  DEY                      
  BNE nes_eb9d                
  DEX                      
  BNE nes_eb9d                
  LDY $02                  
  LDA $00                  
  CMP #$20                 
  BCC nes_ebc0              
  ADC #$02                 
;   STA PpuAddr_2006  
  STA VMADDL       
  LDA #$C0                 
;   STA PpuAddr_2006         
  STA VMADDH
  LDX #$40                
;   STY PpuData_2007       
  nes_ebba:   
  STY VMDATAL
  DEX                      
  BNE nes_ebba 
  nes_ebc0:              
  LDX $01                  
  LDA $0100                
;   STA PpuControl_2000      
  RTS                      

nes_ebc9:
  ;LDA PpuStatus_2002       
  LDA $FE                  
  ;STA PpuScroll_2005       
  STA BG1VOFS

  LDA bg1_y          
  ;STA PpuScroll_2005       
  STA BG1VOFS

  LDA $1B                  
  AND #$01                 
  STA $00                  
  LDA nes_1a               
  EOR #$FF                 
  AND #$01                 
  ASL A                    
  ORA $00                  
  STA $00                  
  LDA $0100                
  AND #$FC                 
  ORA $00                  
  ;STA PpuControl_2000      
  STA $0100                
  RTS                      

; A contains if we're on start (0x0 vs. continue (0x1)
; calculates where to jump based on Stack and A, then jumps there
nes_ee2b:
  ASL A                    
  TAY                      
  INY                      
  PLA                      
  STA $00                  
  PLA                      
  STA $01                  
  LDA ($00),Y              
  PHA                      
  INY                      
  LDA ($00),Y              
  STA $01                  
  PLA                      
  STA $00                  
  JMP ($0000)              

nes_ee42:
write_palatte_data_to_vram:
; this needs to be completely rewritten to actually write palettes
; maybe even convert from NES palattes to SNES
; 
  setXY16
  stz CGADD
	LDX #$0000
	@fill_palette:
		@palette_loop:
			LDA palettes, x
			sta CGDATA
			inx
			CPX #(palettes_end - palettes)
			BNE @palette_loop

		CPX #$0200
		BEQ fill_palette_done
		@zero_rest:
			STZ CGDATA			
			STZ CGDATA
			inx
			inx
			CPX #$0200
		BNE @zero_rest
  
  fill_palette_done:   
  setAXY8
  JMP nes_ebc9   

nes_ee6a:
handle_input:
read_input:
;   LDA Ctrl1_4016      
;   LDA JOY1L ; maybe should be JOY1H?     
;   AND #$04                 
;   STA $73                  
  JSR store_controller_to_zp

  LDA joy1_buttons_mirror                  
  STA some_copy_of_joy1                  
  STA some_copy_of_joy1 + 1   

  LDA joy1_buttons                 
  STA some_copy_of_joy1 + 2                  
  STA some_copy_of_joy1 + 3

  RTS                   

store_controller_to_zp:
    setAXY8
;   LDX #$01                 
;   STX JOYSER0           
;   DEX                      
;   STX JOYSER0          

  ;LDX #$08                

  LDA JOY1H           
  ;LSR A                    
  ;ROL joy1_buttons                  
  ;LSR A                    
  ;ROL nes_zp_00        
  STA joy1_buttons
  
  LDA JOY2H
  STA joy2_buttons
  ;LSR A                    
  ;ROL joy2_buttons                 
  ;LSR A                    
  ;ROL nes_zp_01      
STZ nes_zp_00
stz nes_zp_01
  ;DEX                      
  ;BNE :-

  LDA nes_zp_00                  
  ORA joy1_buttons                  
  STA joy1_buttons    

  LDA nes_zp_01                  
  ORA joy2_buttons                 
  STA joy2_buttons  

  LDX #$01      

: LDA joy1_buttons,X                
  TAY                      
  EOR joy1_buttons_mirror,X                
  AND joy1_buttons,X                
  STA joy1_buttons,X                
  STY joy1_buttons_mirror,X                
  DEX                      
  BPL :-

  setXY16
  RTS                    

nes_ee94:
count_frames:
	inc frame_counter_lb
	bne done_counting
	inc frame_counter_hb
	done_counting:
	rts

nes_eee5:            
  STZ bg1_y          
  STZ nes_1a                  
  STZ bg1_y_hb                  
  STZ $1B                  
  RTS                      


set_control_0100_value_bg_sprite_mask_to_00:
nes_eef0:
    LDA $0100                
    AND #$7F                 
    STA $0100                
    ;STA PpuControl_2000      
    LDA #$00                 
    ;STA PpuMask_2001         
    RTS                      
          


nes_ef01:
  LDA $0100                
  ORA #$80                 
  ;STA PpuControl_2000      
  STA $0100       

  LDA $FF ; FF is the value to set the mask to, generally 1E, which is sprites & bg in color
  ;STA PpuMask_2001         
  RTS                      

nes_ef73:
  LDA #$20                 
  BNE nes_ef7c               

fill_nametable_with_12:
nes_ef77:
  JSR nes_ef73               
  LDA #$28    
  nes_ef7c:             
  LDX #$12                 
  LDY #$00                 
  JMP fill_vram_and_attribute
