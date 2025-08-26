SRC_DIR=src
OUT_DIR=out
OUTFILE=kid-icarusnes.sfc

$(TARGETS): | $(OUT_DIR)

default: $(OUT_DIR)/main.o
	ld65  -C $(SRC_DIR)/hirom.cfg -o $(OUT_DIR)/$(OUTFILE) $(OUT_DIR)/main.o

$(OUT_DIR)/main.o: $(SRC_DIR)/main.asm
	mkdir -p $(OUT_DIR)
	ca65 $(SRC_DIR)/main.asm -o $(OUT_DIR)/main.o
