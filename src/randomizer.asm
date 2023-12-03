.segment "PRGA8"

; Rooms in Kid Icarus can be represented by two bytes
; 4 bits for each direction that you can come from
; 4 bits for each direction you can go to
; so a room is encoded as:
; (where U = UP, R = RIGHT, D = DOWN, L = LEFT)
;FROM U     R     D     L
;TO   LDRU  LDRU  LDRU  LDRU
;
; So a room encoded as:
; 0111 0110 0010 0011
;
; Would be a room where
; ;rom the top you can only go U, R, or D
; from R can only go R or D
; from D can only go R
; from L can go U or R
;
; and this room's potential exits would be listed as:
; 76 23
; 
; a fully open room, which all 4 directions are accessible from every other direction would be
; FF FF
; 
; we'll also encode the available exits for a room, we could
; probably deduce this but it's easier to just encode it
;
; we also save some room by encoding the room id and allowing us to skip encoding unused rooms
;
; rooms!
;FORTRESS_ROOMS_CONNECTIONS	equ	$BCF0
; FORTRESS_ROOMS_CONNECTIONS	= $F290
START_ROOM					= $33
DUNGEON_START				= $70AF
ENEMY_START					= $712F
FORTRESS_SIZE				= $20

; for music
FORT1_BOSS_IDX				= BOSS_MUSIC_ROOM
FORT2_BOSS_IDX				= BOSS_MUSIC_ROOM + 1
FORT3_BOSS_IDX				= BOSS_MUSIC_ROOM + 2

; varibale holders
ROOM_COUNT					= $0070
NEED_EXIT_NEXT				= $0071	; which direction we came from, this tells us
									; which set of bits to check for possible exits
ROOM_OFFSET					= $0072	; which room we're working with 0 - 63
NEED_EXIT					= $0073	; which exit will need to be available in a room
NEXT_ROOM_OFFSET			= $0074	; the next room we're going to
SYSTEM_SEED_LB				= $00EF
SYSTEM_SEED_RB				= $00F0
RNG_SEED 					= $0197
RNG_SEED_RB 				= $0198
PATH_COMPARISON				= $0075
ROOM_ID						= $0076
EXIT_PATH_BYTE				= $0077	; viable exits for the room we're in
NEXT_EXIT_PATH_BYTE			= $0078
DEADEND_DETECTOR			= $0079
PATH_START					= $6100
PATH_IDX					= $007A
VALID_EXITS					= $007B
ENEMY_TEMP_STORAGE			= $007C
ENEMY_PLACEMENT_IDX			= $007D
ROOM_PATH_START				= $6200
ROOM_PATH_IDX				= $007E
EXISTING_EXITS				= $007F

DUNGEON_SEED_LB			    = $011E
DUNGEON_SEED_RB			    = $011F

CURRENT_LEVEL_IDX			= $00A0
STORE_SEED_LB		        = $00B0

; these variables don't change per level
CURRENT_SCREEN		        = $04D1
CURRENT_LEVEL		        = $0130
CURRENT_WORLD		        = $00A0
LVL_ITEM_DATA		        = $FE00
LVL_START			        = $6200
LVL_DOORS			        = $6100
LVL_ITEM_COUNT		        = $6140
LVL_ITEMS			        = $6141
LVL_ENEMIES_T1		        = $6180
LVL_ENEMIES_T3		        = $61A0
LVL_ENEMIES_T4		        = $61C0	; this is positional infor for T3
LVL_PLATFORMS 		        = $6300
MAX_PLATFORM_SCRNS	        = $08
LVL_MAX_ITEMS		        = $05
FIRST_ROOM			        = $29
FIRST_EXIT_OPTION	        = $26
CURRENT_STR			        = $0152



; variables that are used while we generate the level
POTENTIAL				    = $00D0	; index of the next room we might use
CURRENT_SCREEN_ID		    = $00D1	; the index of the last screen we wrote
SCREEN_RULES_LOCATION	    = $00D2	; offset of the room connection rule byte we care about
SRL_WORK				    = $00D3	; temporary variable used to shift to get the right bit
ROOM_BIT				    = $00D4	; index of the bit we care about
SCREEN_RULE				    = $00D5
SCREEN_ADDR				    = $00D6
PREVIOUS_ROOM_IDX		    = $00D7
TEMP_JUNK				    = $00D8	; used withing some subroutines
DOOR_COUNT				    = $00D9	; how many doors we've placed
ROOM_RULES_ADDRESS_PTR	    = $00DA	; 2 bytes, word address of the rules we care about
										; needed because rooms take up more than 256 bytes
ROOM_LOCATION			    = $00DC	; location in a room that we're placing something (door or item)
DOOR_CHOSEN				    = $00DD	; which door (or item) we've chosen
DATA_OFFSET_CALC		    = $00DE	; used when calculating the data offset for a room index
LAST_DOOR_ROOM_IDX		    = $0086
PLATFORM_SCRNS_COUNT	    = $0087
PLATFORM_SCRNS_PTR		    = $0088	; 2 bytes, points to the next place to write platform

PLATFORM_BANK_COUNTS	    = $0098 ; 38, 39, 3A, and 3B hold counts for each platform bank
PLATFORM_BANK_IDX		    = $009C
PLATFORM_BANK_CURR_COUNT	= $009D
PLATFORM_BANK_OFFSET	    = $009E

PLATFORM_DATA_IDX		    = $008A
LAST_LEVEL_RANDOMIZED	    = $011D
FIXED_SEED_LB			    = $011E
FIXED_SEED_HB			    = $011F

LVL_1_1_SIZE 				=	$24
LVL_2_1_SIZE 				=	$36
LVL_3_1_SIZE 				=	$28

ENEMY_TABLE1_LB     		= $0
ENEMY_TABLE2_LB             = $20
ENEMY_TABLE3_LB             = $40

; original code that we swiped
dungeon_load_hijack:           
    ASL A                    
    TAX                      
    LDA $A7991C,X              
    STA $00                  
    LDA $A7991D,X              
    STA $01                  

    LDA #$00                 
    STA $02                  
    LDA #$70                 
    STA $03                  
    LDX #$0F                 
    LDY #$00      
loop:  
    LDA ($00),Y              
    STA ($02),Y              
    INY                      
    BNE loop                
    INC $01                  
    INC $03                  
    DEX                      
    BNE loop  
    ; RTL here to turn off dungeon randomization
    ; RTL

    LDA #$A8
    PHA
    PLB

    LDA FIXED_SEED_LB
    BEQ checkforExistingSeed
    STA RNG_SEED
    LDA FIXED_SEED_HB
    STA RNG_SEED_RB
    BRA zerodungeon

checkforExistingSeed:
	LDA STORE_SEED_LB
	BEQ newseed
	STA RNG_SEED
	LDA STORE_SEED_LB + 1
	STA RNG_SEED_RB
	JMP zerodungeon

newseed:
	; seed our rng
	LDA SYSTEM_SEED_LB
	STA STORE_SEED_LB
	STA RNG_SEED
	LDA SYSTEM_SEED_RB
	STA STORE_SEED_LB + 1
	STA RNG_SEED + 1

; zero out the dungeon we copied
zerodungeon:
    LDA #$00
    LDY #$BF
cleardungeon:
    STA DUNGEON_START, Y
    DEY
    BNE cleardungeon
    STA DUNGEON_START, Y	;do the last room
    STA PATH_IDX
    STA ROOM_PATH_IDX
    LDA #$FF
    STA DEADEND_DETECTOR

newdungeon:
    LDA CURRENT_LEVEL_IDX
    CMP #$03
    BNE checkForW2
    LDA #FORTRESS_SIZE
    BRA storeSize

checkForW2:
    CMP #$05
    BNE checkForW3
    LDA #FORTRESS_SIZE + 4
    JMP storeSize

checkForW3:
    LDA #FORTRESS_SIZE + 8

storeSize:
    STA ROOM_COUNT

setStartRoom:
    ; start room is 28th room, which is the 54th byte (0x36)
    LDY #$36
    STY ROOM_OFFSET

    ; room #01 is first room
    LDA #$01
    STA ROOM_ID

    LDA #$07
    STA EXIT_PATH_BYTE

storeroom:
	LDY ROOM_OFFSET
	LDA DUNGEON_START, Y	;if we already had a room then we skip counting it and just pick a new exit
	BNE room_exists

	LDA ROOM_ID
	STA DUNGEON_START, Y
	LDY ROOM_PATH_IDX
	STA ROOM_PATH_START, Y
	INC ROOM_PATH_IDX
	DEC ROOM_COUNT
	BNE newroom
	; room count has hit zero, time to place the boss, maybe
	; first we have some 1-off logic for world 2 fortress
	LDA CURRENT_LEVEL_IDX
	CMP #$05
	BEQ check_for_up_in_w2_boss
	BRL placeboss			;if we've placed the right number of moves, we jump to placing the boss

check_for_up_in_w2_boss:
	LDA NEED_EXIT
	CMP #$01
	BEQ keep_going_for_w2
	BRL placeboss

keep_going_for_w2:
	; keep adding rooms if we went up and tried to place the boss
	INC ROOM_COUNT
	BNE newroom

room_exists:
	; get the existing exits.  if we have other valid, non used exits we want to pick one of those
	STA ROOM_ID
	INY
	LDA DUNGEON_START, Y
	STA EXISTING_EXITS
	BRA deadend_detect

newroom:
	; main meet of the algorithm
	; we've got the room for this offset stored in ROOM_ID
	; and Y contains the memory offset (0-127, only the even numbers) to
	; store the room at
	LDA #$FF
	STA DEADEND_DETECTOR

deadend_detect:
    LDA DEADEND_DETECTOR
    BNE populatevalidpaths	;if DEADEND_DETECTOR gets to 0 give up and start over
    BRA zerodungeon	;start over with the next dungeon seed


populatevalidpaths:
    ; After storing the room, we pick a direction to go
    jsr getpathnibble
    STA VALID_EXITS
    ; subtract the existing exits
    LDA EXISTING_EXITS
    AND VALID_EXITS
    STA EXISTING_EXITS
    LDA VALID_EXITS
    SEC
    SBC EXISTING_EXITS

pickexit:
    ; pick an exit
    ; this will set:
    ; NEED_EXIT_NEXT to the door that needs to be open in the next room
    ; NEXT_ROOM_OFFSET with the memory offset of the next room
    ; NEED_EXIT with the exit that the current room needs to support
    DEC DEADEND_DETECTOR
    BNE rngdir	;if DEADEND_DETECTOR gets to 0 give up and start over
    BRL zerodungeon	;start over with the next dungeon seed

rngdir:
    jsr prng
    CLC
    AND #$03 				; trim to 0-3

up:
    CMP #$00				; go up
    BNE right
    LDA #$04
    STA NEED_EXIT_NEXT
    LDX #$01
    LDA ROOM_OFFSET
    SEC
    SBC #$10
    BMI pickexit			; OOB
    STA NEXT_ROOM_OFFSET
    BRA checkroom

right:
    CMP #$01				; go right
    BNE down
    LDA #$08
    STA NEED_EXIT_NEXT
    LDX #$02
    LDA ROOM_OFFSET			; check if we're all the way to the right, which would be 0x_E
    AND #$0E
    CMP #$0E
    BEQ pickexit			; TOO FAR! pick a new exit
    LDA ROOM_OFFSET
    CLC
    ADC #$02
    STA NEXT_ROOM_OFFSET
    BRA checkroom

down:
    CMP #$02				; go down
    BNE left
    LDA #$01
    STA NEED_EXIT_NEXT
    LDX #$04
    LDA ROOM_OFFSET
    CLC
    ADC #$10
    CMP #$80
    BPL pickexit			;OOB
    STA NEXT_ROOM_OFFSET
    BRA checkroom

left:
    LDA #$02
    STA NEED_EXIT_NEXT
    LDX #$08
    LDA ROOM_OFFSET		; check if we're on the left
    AND #$0F
    BNE notoob_left		; zero flag will be set if the accumulator got set to 0, which means we're at the left wall
    BRA pickexit
notoob_left:
    LDA ROOM_OFFSET		; reload room offset to move left
    SEC
    SBC #$02
    STA NEXT_ROOM_OFFSET

checkroom:
    ; check if we have open exits, and if we picked one
    STX NEED_EXIT
    LDY ROOM_OFFSET
    INY
    LDA DUNGEON_START, Y
    AND VALID_EXITS

    LDA VALID_EXITS
    AND NEED_EXIT
    BNE check_next_room
    BRA pickexit	; no good pick a new one
    ; check if there's a room that way already
check_next_room:
    LDY NEXT_ROOM_OFFSET
    LDA DUNGEON_START, Y
    BEQ storeexit			; no room skip this step

    ; if there is a room, check that it can have an exit that direction
    ; luckily the value of the room id is also the index, so we can 
    ; multiply it by 4, and add 2 to see if the exit is valid
    ASL A
    ASL A
    CLC
    ADC #$02
    TAY
    LDA FORTRESS_ROOMS_CONNECTIONS, Y
    AND NEED_EXIT_NEXT
    BNE storeexit
    BRL pickexit	;no good, pick a new exit.  there should _always_ be at least 1 we can do

; place the exit and move there 
storeexit:
    LDY ROOM_OFFSET		; prng clobbers y, we need to reset it
    INY					; dungeon memory is byte pairs of rooms then exits
    LDA NEED_EXIT
    ORA DUNGEON_START, Y; combine exits
    STA DUNGEON_START, Y; store exits
    LDY NEXT_ROOM_OFFSET
    INY
    LDA NEED_EXIT_NEXT
    ORA DUNGEON_START, Y
    STA DUNGEON_START, Y

    ; set up for the next iteration
    LDY PATH_IDX
    LDA NEED_EXIT
    STA PATH_START, Y
    INC PATH_IDX
    LDA NEXT_ROOM_OFFSET
    STA ROOM_OFFSET
    LDA NEXT_EXIT_PATH_BYTE
    STA EXIT_PATH_BYTE

pickroom:
    LDY NEXT_ROOM_OFFSET
    LDA DUNGEON_START, Y
    BNE got_a_room
    jsr prng
    AND #$3F
    CMP #$29	; we have 29 possible rooms 0-29, but 29 is the boss room
    BPL pickroom
    CMP #$0B
    BEQ pickroom
    STA ROOM_ID

    ; multiply by 4 since we have 4 bytes per room
    ASL A
    ASL A
    ; 2 more byte to get exits
    CLC
    ADC #$02
    TAY
    LDA FORTRESS_ROOMS_CONNECTIONS, Y
    AND NEED_EXIT_NEXT
    BEQ pickroom	; this room can't go that way, find a new one
got_a_room:
    BRL storeroom

placeboss:
    ; find room with a single entrance, preferably on the left side (0x08)
    ; 64 rooms
    LDA ROOM_OFFSET
    TAY
    LDA #$29
    LDX CURRENT_LEVEL_IDX
    CPX #$05 ; A0 == 05 means that we're in dungeon 2
    BNE writebossroom
    LDA #$0B

writebossroom:
    STA DUNGEON_START, Y
    INY
    LDA #$00
    STA DUNGEON_START, Y

    ; fix boss music
    DEY
    TYA
    LSR A

    CPX #$07
    BNE fortress2music
    STA FORT3_BOSS_IDX
    BRA donewithmusic

fortress2music:
    CPX #$05
    BNE fortress1music
    STA FORT2_BOSS_IDX
    BRA donewithmusic

fortress1music:
    STA FORT1_BOSS_IDX

donewithmusic:
    jsr populateenemies
    RTL

populateenemies:
	LDA #$40	;64 rooms
	STA ENEMY_PLACEMENT_IDX
	
	iterate_rooms:
	LDA ENEMY_PLACEMENT_IDX
	ASL A
	TAX
	LDA DUNGEON_START, X
	BEQ nextroom
	CMP #$01				; starting room, no enemies
	BEQ nextroom
	CMP #$15
	BEQ nextroom
	CMP #$16
	BEQ nextroom
	CMP #$28
	BEQ nextroom
	CMP #$07				; Spike room 07
	BNE spike09
	LDA #$51
	JMP storeenemy
	spike09:
	CMP #$08				; Spike room 08
	BNE spike13
	LDA #$31
	JMP storeenemy
	spike13:
	CMP #$13				; Spike room 13
	BNE spike1c
	LDA #$50
	JMP storeenemy
	spike1c:
	CMP #$1C				; Spike room 1C
	BNE spike20
	LDA #$53
	JMP storeenemy
	spike20:
	CMP #$20				; Spike room 20
	BNE bossroom
	LDA #$52
	JMP storeenemy
	bossroom:
	CMP #$29				; Boss Room
	BNE bossroom2
	LDA #$F0
	JMP storeenemy
	bossroom2:
	CMP #$0B
	BNE pickenemy
	LDA #$F0
	JMP storeenemy
	
	; pick a random enemy 1 in 8 chance of Eggplant
	pickenemy:
	JSR prng
	AND #$07
	BNE normalenemy
	eggplantwizard:
	LDA #$63
	JMP storeenemy
	
	normalenemy:
	JSR prng
	AND #$03				; random enemies are 0x1_, 0x2_, 0x3_, and 0x4_
	CLC
	ADC #$01
	ASL A
	ASL A
	ASL A
	ASL A
	; should now have 1-4 in the top nibble
	STA ENEMY_TEMP_STORAGE
	JSR prng
	AND #$03
	CLC
	ADC #$04
	ORA ENEMY_TEMP_STORAGE
	
	storeenemy:
	LDY ENEMY_PLACEMENT_IDX
	STA ENEMY_START, Y
	
	nextroom:
	DEC ENEMY_PLACEMENT_IDX
	BMI done
	JMP iterate_rooms
	
	done:
	RTS
	

; getpathnibble
; returns the nibble for relevante path for room in ROOM_ID
; assuming you are coming from NEED_EXIT_NEXT
getpathnibble:
	LDA ROOM_ID
	ASL A
	ASL A
	TAY
	LDA NEED_EXIT_NEXT
	
	from_up:
	CMP #$01
	BNE from_right
	LDA FORTRESS_ROOMS_CONNECTIONS, Y
	AND #$F0
	LSR A
	LSR A
	LSR A
	LSR A
	rts
	
	from_right:
	CMP #$02
	BNE from_down
	LDA FORTRESS_ROOMS_CONNECTIONS, Y
	AND #$0F
	rts
		
	from_down:	
	INY
	CMP #$04
	BNE from_left
	LDA FORTRESS_ROOMS_CONNECTIONS, Y
	AND #$F0
	LSR A
	LSR A
	LSR A
	LSR A
	rts
	
	from_left:
	LDA FORTRESS_ROOMS_CONNECTIONS, Y
	AND #$0F
	rts


FORTRESS_ROOMS_CONNECTIONS:
.byte $00, $00, $00, $00; room 00 - not a real room
.byte $77, $77, $07, $01; room 01 - 1111 1111 1111 1111
.byte $EE, $EE, $0F, $02; room 02 - 1110 1110 1110 1110
.byte $FF, $FF, $0F, $03; room 03 - 1111 1111 1111 1111

.byte $FF, $FF, $0F, $04; room 04 - 1111 1111 1111 1111
.byte $00, $00, $00, $05; room 05 - this is replaced, need to find the original
.byte $00, $00, $00, $06; room 06 - this is replaced, need to find the original
.byte $0E, $EE, $0E, $07; room 07 - 0000 1110 1110 1110

.byte $E6, $6E, $0F, $08; room 08 - 1110 0110 0110 1110
.byte $00, $00, $00, $09; room 09 - this is replaced, need to find the original
.byte $B2, $6B, $0F, $0A; room 0A - 1011 0010 0110 1011
.byte $80, $08, $09, $0B; room 0B - 1000 0000 0000 1100 (2-4 boss room)

.byte $FF, $FF, $0F, $0C; room 0C - 1111 1111 1111 1111
.byte $00, $00, $00, $0D; room 0D - this is replaced, need to find the original
.byte $33, $CC, $0F, $0E; room 0E - 0011 0011 1100 1100 (or 1111 1111 1100 1100 with wall clips)
.byte $FF, $FF, $0F, $0F; room 0F - 0111 0111 0111 0000

.byte $00, $00, $00, $10; room 10 - non-existant
.byte $00, $00, $00, $11; room 11 - this is replaced, need to find the original
.byte $AA, $0A, $0B, $12; room 12 - 1010 1010 0000 1010
.byte $EE, $EE, $0F, $13; room 13 - 1110 1110 1110 1110

.byte $BB, $0B, $0B, $14; room 14 - 1011 1011 0000 1011
.byte $EE, $EE, $0F, $15; room 15 - 1110 1110 1110 1110 (medic room)
.byte $EE, $EE, $0F, $16; room 16 - 1110 1110 1110 1110 (shop)
.byte $EE, $EE, $0F, $17; room 17 - 1110 1110 1110 1110 

.byte $EE, $EE, $0F, $18; room 18 - 1110 1110 1110 1110 
.byte $FF, $FF, $0F, $19; room 19 - 1111 1111 1111 1111
.byte $FF, $FF, $0F, $1A; room 1A - 1111 1111 1111 1111 (same as 19)
.byte $86, $48, $0F, $1B; room 1B - 1000 0110 0100 1000

.byte $50, $50, $05, $1C; room 1C - 0101 0000 0101 0000
.byte $00, $00, $00, $1D; room 1D - 0101 0000 0101 0000 (same as 1C)
.byte $FF, $F8, $0F, $1E; room 1E - 1111 1111 1111 1000
.byte $FF, $F8, $0F, $1F; room 1F - 1111 1111 1111 1000

.byte $FF, $FF, $0F, $20; room 20 - 1111 1111 1111 1111
.byte $77, $78, $0F, $21; room 21 - 0111 0111 0111 1000 (21 - 25 are all the same)
.byte $00, $00, $00, $22; room 22 - 0111 0111 0111 1000 (21 - 25 are all the same, I don't want to use this one)
.byte $00, $00, $00, $23; room 23 - 0111 0111 0111 1000 (21 - 25 are all the same, I don't want to use this one)

.byte $00, $00, $00, $24; room 24 - 0111 0111 0111 1000 (21 - 25 are all the same, I don't want to use this one)
.byte $00, $00, $00, $25; room 25 - 0111 0111 0111 1000 (21 - 25 are all the same, I don't want to use this one)
.byte $F6, $6F, $0F, $26; room 26 - 1111 0110 0110 1111
.byte $F6, $6F, $0F, $27; room 27 - 1111 0110 0110 1111 (same as 26)

.byte $AA, $0A, $0B, $28; room 28 - 1010 1010 0000 1010 (hot springs)
.byte $FF, $FF, $0F, $29; room 29 - 1111 1111 1111 1111 (1-4 and 3-4 boss room)

; prng
;
; Returns a random 8-bit number in A (0-255), clobbers Y (0).
;
; Requires a 2-byte value on the zero page called "seed".
; Initialize seed to any value except 0 before the first call to prng.
; (A seed value of 0 will cause prng to always return 0.)
;
; This is a 16-bit Galois linear feedback shift register with polynomial $0039.
; The sequence of numbers it generates will repeat after 65535 calls.
;
; Execution time is an average of 125 cycles (excluding jsr and rts)	
; Returns a random 8-bit number in A (0-255), clobbers Y (unknown).
prng:
	lda RNG_SEED+1
	tay ; store copy of high byte
	; compute seed+1 ($39>>1 = %11100)
	lsr ; shift to consume zeroes on left...
	lsr
	lsr
	sta RNG_SEED+1 ; now recreate the remaining bits in reverse order... %111
	lsr
	eor RNG_SEED+1
	lsr
	eor RNG_SEED+1
	eor RNG_SEED+0 ; recombine with original low byte
	sta RNG_SEED+1
	; compute seed+0 ($39 = %111001)
	tya ; original high byte
	sta RNG_SEED+0
	asl
	eor RNG_SEED+0
	asl
	eor RNG_SEED+0
	asl
	asl
	asl
	eor RNG_SEED+0
	sta RNG_SEED+0
	rts

; SCROLLING WORLD RANDOMIZATION START
scrolling_randomization:
    PHB
    LDA #$A8
    PHA
    PLB

	LDA CURRENT_SCREEN
	BNE loadNextScreen		;if we're not on the 0th screen, we've already generated it.
	JSR seedRNG	
	JSR generateLevel
	JSR generateEnemies
loadNextScreen:
	JSR writeRoomToLoadAddr	;writes the next room to the place that the game loads it
    PLB
    RTL

clearPlatformData:
	LDA #$FF
	LDY #$7F

	loopClear:
	STA LVL_PLATFORMS, Y
	DEY
	BPL loopClear

	RTS

writeRoomToLoadAddr:
	LDA CURRENT_SCREEN
	STA POTENTIAL
	ASL POTENTIAL
	LDY POTENTIAL
	LDA LVL_START, Y
	STA $49
	INY
	LDA LVL_START, Y
	STA $4A
	RTS					; we only re-generate on the first screen
	
seedRNG:
checkForNextLevelSeed:
	LDA FIXED_SEED_LB
	; if Fixed seed isn't set, then we randomize every time
	BEQ useSystemRNG

	LDA CURRENT_LEVEL
	CMP LAST_LEVEL_RANDOMIZED
	BEQ useFixedRng
	STA LAST_LEVEL_RANDOMIZED
	; new level, increment the seed number so 
	; levels don't repeat from the previous
	INC FIXED_SEED_LB
	BNE useFixedRng
	INC FIXED_SEED_LB
	INC FIXED_SEED_HB
	BNE useFixedRng
	INC FIXED_SEED_HB

useFixedRng:
	; first check for a set seed
	LDA FIXED_SEED_LB
	STA RNG_SEED	
	STA STORE_SEED_LB

	LDA FIXED_SEED_LB + 1
	STA RNG_SEED + 1	
	STA STORE_SEED_LB + 1
	RTS

useSystemRNG:
	LDA SYSTEM_SEED_LB
	BNE storerng_lb
	LDA #$BE
storerng_lb:
	STA STORE_SEED_LB
	STA RNG_SEED
	
	LDA SYSTEM_SEED_RB
	BNE storerng_rb
	LDA #$EF
storerng_rb:
	STA STORE_SEED_LB + 1
	STA RNG_SEED + 1	
	RTS

generateLevel:
	; reset our variables
	LDX #$63
	STX PLATFORM_SCRNS_PTR + 1
	LDX #$00
	STX PLATFORM_SCRNS_PTR	
	STX DOOR_COUNT
	STX LVL_ITEM_COUNT
	STX LAST_DOOR_ROOM_IDX
	STX PLATFORM_BANK_OFFSET
	STX PLATFORM_SCRNS_COUNT

	JSR clearPlatformData
	
	; write the first room
	LDA #FIRST_ROOM
	CLC
	ADC CURRENT_LEVEL
	STA POTENTIAL
	STA PREVIOUS_ROOM_IDX
	JSR storeRoom

	; add rooms until we've hit the size
	moreRooms:
		JSR pickNextRoom
		JSR checkRoom
	BEQ moreRooms			;try again, didn't work
	JSR storeRoom
	JSR placeDoor
	JSR addItem
	CPX LVL_GEN_PARAM_SIZE
	BNE moreRooms
	JSR writeExit
	BEQ generateLevel	;try again
	JSR writeDoorClosure
	RTS

; generateEnemies is done after the level is generated
; and generates the 4 enemy tables (2 of enemies, 2 of positions)
; it distributes the enemies against the values in the ENEMY_TABLE1 and ENEMY_TABLE2
; blocks, which are 16 bytes each creating a distribution of those enemy values
generateEnemies:
    LDA CURRENT_WORLD
    CMP #$02 ; world 1
    BNE :+
    LDA #.hibyte(ENEMY_TABLE)
    STA PARAM_ENEMY_TABLE1_HB
    LDA #.lobyte(ENEMY_TABLE)
    STA PARAM_ENEMY_TABLE1_LB
    BRA :+++

:   CMP #$04 ; world 2
    BNE :+
    LDA #.hibyte(ENEMY_TABLE_W2)
    STA PARAM_ENEMY_TABLE1_HB
    LDA #.lobyte(ENEMY_TABLE_W2)
    STA PARAM_ENEMY_TABLE1_LB
    BRA :++

:   CMP #$06 ; world 3
    BNE :+   ; I mean, this shouldn't happen, right?
    LDA #.hibyte(ENEMY_TABLE_W3)
    STA PARAM_ENEMY_TABLE1_HB
    LDA #.lobyte(ENEMY_TABLE_W3)
    STA PARAM_ENEMY_TABLE1_LB

:	LDA LVL_GEN_PARAM_SIZE
	LSR A
	TAX
	genEnemyLoop:
	; select T1 Enemy
	JSR prng
	AND #$0F
	TAY
	LDA (PARAM_ENEMY_TABLE1_LB), Y
	STA LVL_ENEMIES_T1, X
	STA LVL_ENEMIES_T1 - 1, X
	; select T2 Enemy, it's always 0x10 more than table 1
	JSR prng
	AND #$0F
	CLC
	ADC #$10
	TAY
	LDA (PARAM_ENEMY_TABLE1_LB), Y
	STA LVL_ENEMIES_T3, X
	STA LVL_ENEMIES_T3 - 1, X
	
	CMP #REAPER
	BNE zeroPosition
	
	addPosition:
	LDA #$38
	JMP writePosition

	zeroPosition:
	LDA #$00
	
	writePosition:
	STA LVL_ENEMIES_T4, X
	STA LVL_ENEMIES_T4 - 1, X

	nextEnemies:
	DEX
	DEX

	BPL genEnemyLoop
	RTS

; Pre-reqs:
;
;		POTENTIAL contains the index of the room to place a door
;		Y contains the memory offset (2 bytes per room)
;		LVL_START contains the starting address of the level data
;		Updates Y to point to the next place to write
placeDoor:
	
	; prevent doors on screen 2 for various reasons
	; it results in the level being regenerated when you exit the room
	CPX #$04
	BNE maybeDoor
	RTS
	
	maybeDoor:
	JSR prng
	AND #$03
	CMP #$01
	BEQ checkNumDoors
	RTS
	
	checkNumDoors:
	LDA DOOR_COUNT
	CMP #$06
	BMI pickDoorToPlace
	RTS
	
	pickDoorToPlace:
	JSR pickADoor
	STA DOOR_CHOSEN
	
	LDA POTENTIAL
	STA DATA_OFFSET_CALC
	JSR convertDataOffsetCalcToDataOffset
	ADC #$05
	TAY
	LDA (ROOM_RULES_ADDRESS_PTR), Y	
	BNE putADoorHere
	RTS
	
	putADoorHere:
	STA ROOM_LOCATION
	;door data is 4 bytes each, stage, screen, coords, room type
	LDA DOOR_COUNT
	ASL A
	ASL A
	TAY
	
	LDA CURRENT_LEVEL
	STA LVL_DOORS, Y
	
	TXA
	ROR A
	SEC
	SBC #$01
	STA LVL_DOORS+1, Y
	
	LDA ROOM_LOCATION
	STA LVL_DOORS+2, Y
	
	LDA DOOR_CHOSEN
	STA LVL_DOORS+3, Y
	
	INC DOOR_COUNT
	STX LAST_DOOR_ROOM_IDX

	RTS
	
; todo: this needs different logic per world
pickADoor:
	JSR prng
	AND #$0F

	LDY CURRENT_WORLD
	CPY #$02	
	BEQ loadDoorFromDistribution
	
	CLC
	ADC #$10
	CPY #$04	
	BEQ loadDoorFromDistribution
	
	CLC
	ADC #$10

	loadDoorFromDistribution:
	TAY
	LDA DOOR_DISTRIBUTION, Y
	STA TEMP_JUNK
	CMP #UPGRADE_ROOM
	BNE exitPickADoor

	; if we got an upgrade room, check that our str * 2 < world_value
	; get the max str for our world
	LDA CURRENT_WORLD
	CMP #$06
	BNE w2Max
	LDA #$04
	JMP compare_str

	w2Max:
	CMP #$04
	BNE w1Max
	LDA #$02
	JMP compare_str

	w1Max:
	LDA #$00

	; check against current str
	compare_str:
	CMP CURRENT_STR
	BPL exitPickADoor
	JMP pickADoor

	exitPickADoor:
	LDA TEMP_JUNK
	RTS

addItem:

	LDA LVL_ITEM_COUNT
	CMP #LVL_MAX_ITEMS
	BCC notatmaxitems
	RTS
	
	notatmaxitems:
	JSR prng
	AND #$07
	CMP #$01
	BEQ pickItem
	RTS
	
	pickItem:
	JSR prng
	AND #$01
	STA DOOR_CHOSEN	;yeah this is for doors, but we'll use it here
	
	LDA POTENTIAL
	SEC
	SBC #$01
	TAY
	LDA (PARAM_ITEM_LOCS_LB), Y
	STA ROOM_LOCATION
	
	LDA LVL_ITEM_COUNT
	ASL A
	ASL A
	TAY
	
	LDA CURRENT_LEVEL
	STA LVL_ITEMS, Y
	
	TXA
	ROR A
	SEC
	SBC #$01
	STA LVL_ITEMS+1, Y
	
	LDA ROOM_LOCATION
	STA LVL_ITEMS+2, Y
	
	LDA DOOR_CHOSEN
	STA LVL_ITEMS+3, Y
	
	INC LVL_ITEM_COUNT
	RTS

writeDoorClosure:
	LDA DOOR_COUNT
	ASL A
	ASL A
	TAY
	LDA #$FF
	STA LVL_DOORS, Y
	STA LVL_DOORS + 1, Y
	STA LVL_DOORS + 2, Y
	STA LVL_DOORS + 3, Y
	RTS

convertDataOffsetCalcToDataOffset:
	LDA PARAM_RULES_FP_LB
	STA ROOM_RULES_ADDRESS_PTR
	LDA PARAM_RULES_FP_HB
	STA ROOM_RULES_ADDRESS_PTR + 1
	LDA DATA_OFFSET_CALC
	SEC
	SBC #$01
	ASL A
	ASL A
	ASL A
	
	BCC exitConvert
	INC ROOM_RULES_ADDRESS_PTR + 1
	CLC
	
	exitConvert:
	; SRL_WORK now contains the index of the first byte of rules for our current room
	RTS

pickNextRoom:
	; pick a random new screen
	JSR prng
	AND #$3F
	CMP #$25	; valid rooms are 0 -> 36
	BPL pickNextRoom
	STA POTENTIAL
	INC POTENTIAL
	RTS

; checkRoom - compares rules of PREVIOUS_ROOM_IDX with POTENTIAL.  A > 0 means it works
checkRoom:

	; check if the room has platforms, if it does we might need to exit early
	JSR getPlatformDataForRoom
	CMP #$FF
	BEQ platformsWork

	LDA #MAX_PLATFORM_SCRNS
	CMP PLATFORM_SCRNS_COUNT
	BPL checkForPlatformDoor
	; not good, we have enough platforms
	LDA #$00
	RTS

checkForPlatformDoor:
	; we've got platforms, make sure the previous screen didn't have a door
	CPX LAST_DOOR_ROOM_IDX
	BNE platformsWork
	LDA #$00
	RTS

	platformsWork:
	LDA PREVIOUS_ROOM_IDX
	STA DATA_OFFSET_CALC
	JSR convertDataOffsetCalcToDataOffset
	
	; SRL_WORK now contains the index of the first byte of rules for our current room
	STA SRL_WORK
	
	; figure out which byte and bit of rules we want
	LDA POTENTIAL
	getroomrulebitindex:
		CMP #$08
		BPL moveToNextRuleBit
		JMP setindex
		moveToNextRuleBit:
		INC SRL_WORK
		SEC
		SBC #$08
		JMP getroomrulebitindex

	setindex:
		; now that we have the offset stored in SRL_WORK
		; get the right rule byte and store it
		STA ROOM_BIT 
		LDY SRL_WORK
		LDA (ROOM_RULES_ADDRESS_PTR), Y
		STA SCREEN_RULE

		LDA #$80
		
	bitcheck_loop:
		DEC ROOM_BIT
		BEQ compareroom 
		ROR A				; shift accumulator bit over
		BNE bitcheck_loop

	compareroom:

		AND SCREEN_RULE

	RTS

; writeExit - writes our exit room for the level
;	returns a 0 accumulator if the exit was bad and we need to restart
; 
writeExit:
	LDA #FIRST_EXIT_OPTION
	STA POTENTIAL
	JSR checkRoom
	BNE goodExit
	
	INC POTENTIAL
	JSR checkRoom
	BNE goodExit
	
	INC POTENTIAL
	JSR checkRoom
	BNE goodExit
	
	; last chance so if this isn't good remake the whole level
	RTS
	
	goodExit:
	JSR storeRoom
	; store FF FF in the last spot (fake room 0x26)
	LDA #$2C
	STA POTENTIAL
	JSR storeRoom
	RTS


; Pre-reqs:
;
;		POTENTIAL contains the index of the room to store (0 - 31)
;		Y contains the memory offset (2 bytes per room)
;		LVL_START contains the starting address of the level data
;		Updates Y to point to the next place to write
storeRoom:
	LDA POTENTIAL
	STA DATA_OFFSET_CALC
	STA PREVIOUS_ROOM_IDX
	JSR convertDataOffsetCalcToDataOffset
	getFirstRoomAddressByte:
	ADC #$06
	TAY
	LDA (ROOM_RULES_ADDRESS_PTR), Y
	STA LVL_START, X
	INX
	INY
	LDA (ROOM_RULES_ADDRESS_PTR), Y
	STA LVL_START, X
	INX
	
	; get platforms if they exist
	JSR getPlatformDataForRoom
	CMP #$FF
	BEQ exitStoreRoom	

	STA PLATFORM_DATA_IDX

	nextPlatform:
		LDY PLATFORM_BANK_OFFSET
		LDA CURRENT_LEVEL
		STA LVL_PLATFORMS, Y	
		INY

		TXA
		CLC
		LSR A
		SEC
		SBC #$01
		STA LVL_PLATFORMS, Y	
		INY

		PHY
		LDY PLATFORM_DATA_IDX
		LDA PLATFORM_DATA, Y
		PLY
		STA LVL_PLATFORMS, Y	
		INY

		LDA #$00
		STA LVL_PLATFORMS, Y
		INY

		; prep for the next bank by adding 0x20
		; wrapping back to 0x00 if we're over 0x60
		LDA PLATFORM_BANK_OFFSET
		CLC
		ADC #$20

		BVC nextPlatformBankAddress	; if overflow isn't clear, then go to 0x0[i+4]
		AND #$1F
		CLC
		ADC #$04

		nextPlatformBankAddress:
		STA PLATFORM_BANK_OFFSET
		INC PLATFORM_DATA_IDX
		LDY PLATFORM_DATA_IDX
		LDA PLATFORM_DATA, Y
		CMP #$00
		BEQ exitStoreRoom
		JMP nextPlatform
	
	exitStoreRoom:
		LDA POTENTIAL
		CMP #$00
		RTS

getPlatformDataForRoom:
	LDY #$00

	LDA PLATFORM_DATA, Y
	CMP CURRENT_WORLD
	BEQ checkPlatformRoom

	nextlineOfPlatformData:	
	TYA
	CLC
	ADC #$08
	TAY
	
	LDA PLATFORM_DATA, Y
	CMP #$FF
	BEQ platformDataReturn	; no more data, exit with FF in A

	CMP CURRENT_WORLD
	BNE nextlineOfPlatformData	; not current world

	checkPlatformRoom:
	LDA PLATFORM_DATA + 1, Y
	CMP POTENTIAL
	BNE nextlineOfPlatformData

	foundMatch:
	; found match!  the offset of actual platform locations is Y + 2
	INY
	INY
	TYA

	platformDataReturn:
	RTS



W4_SIZE            =     $1C

world_4_randomizer:
    PHB
    LDA #$A8
    PHA
    PLB

    LDA CURRENT_SCREEN
	CMP #$00
	BNE loadNextW4Screen		;if we're not on the 0th screen, we've already generated it.
	JSR useSystemRNG
	JSR generateW4
	JSR generateW4Enemies
loadNextW4Screen:
	JSR writeW4RoomToLoadAddr	;writes the next room to the place that the game loads it
    PLB
    RTL

writeW4RoomToLoadAddr:
	LDA CURRENT_SCREEN
	STA POTENTIAL
	ASL POTENTIAL
	LDY POTENTIAL
	LDA LVL_START, Y
	STA $49
	INY
	LDA LVL_START, Y
	RTS					; we only re-generate on the first screen


generateW4:

	LDX #$00
	; write the first room
    ; for W4 it's 00
	LDA #$00
	STA POTENTIAL
	JSR storeW4Room

	; add rooms until we've hit the size
	moreW4Rooms:
		JSR pickNextW4Room
	    JSR storeW4Room
	CPX #W4_SIZE
	BNE moreW4Rooms
	JSR writeW4Exit
    

	RTS

; generateEnemies is done after the level is generated
; and generates the 4 enemy tables (2 of enemies, 2 of positions)
; it distributes the enemies against the values in the ENEMY_TABLE1 and ENEMY_TABLE2
; blocks, which are 16 bytes each creating a distribution of those enemy values
generateW4Enemies:
	
	genW4EnemyLoop:
	; select T1 Enemy
	JSR prng
	AND #$0F
	TAY
	LDA W4_ENEMIES, Y
	STA LVL_ENEMIES_T1, X
	
	; select T2 Enemy, it's always Erinus.  we'll have one 50% of the time
	JSR prng
    AND #$01
    CMP #$00
    BEQ storeErinus
    LDA #ENEMY_ERINUS

    storeErinus:
	STA LVL_ENEMIES_T3, X
	
	DEX
	BPL genW4EnemyLoop
	RTS

pickNextW4Room:
	; pick a random new screen
	JSR prng
	AND #$07
	STA POTENTIAL
	RTS

; writeExit - writes our exit room for the level
;	returns a 0 accumulator if the exit was bad and we need to restart
; 
writeW4Exit:
	; store FF FF in the last spot (fake room index 8)
	LDA #$08
	STA POTENTIAL
	JSR storeW4Room

    LDA #$09
	STA POTENTIAL
	JSR storeW4Room
	RTS


; Pre-reqs:
;
;		POTENTIAL contains the index of the room to store (0 - 31)
;		Y contains the memory offset (2 bytes per room)
;		LVL_START contains the starting address of the level data
;		Updates Y to point to the next place to write
storeW4Room:
	LDA POTENTIAL
	ASL A	
	TAY
	LDA W4_SCREENS, Y
	STA LVL_START, X
    INX
	LDA W4_SCREENS + 1, Y
	STA LVL_START, X
	INX
	
	RTS   

.include "world1_screen_data.asm"
.include "world2_screen_data.asm"
.include "world3_screen_data.asm"
.include "world4_screen_data.asm"
.include "platform_data.asm"
.include "enemy_frequency_table.asm"
.include "door_distribution.asm"