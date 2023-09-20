.segment "ZEROPAGE"
nes_zp_00: .res 1
nes_zp_01: .res 1


bg1_x: .res 1
bg1_y: .res 1
bg1_y_hb: .res 1
current_vram_addr: .res 2
title_scroll_state: .res 1

frame_counter_lb: .res 1
frame_counter_hb: .res 1

in_nmi: .res 2
nmi_count: .res 2

column_offset: .res 2
row_offset: .res 2
attribute_for_tile: .res 2
tile_counter: .res 2

tile_start_lb: .res 1
tile_start_hb: .res 1
tile_to_write_lb: .res 1
tile_to_write_hb: .res 1	
num_tiles_to_write: .res 2
tileset_offset: .res 2	

tileset_load_start: .res 2
tileset_load_hb_start: .res 2
tileset_load_end: .res 2
scroll_stop_flag: .res 1
junk_byte: .res 2

joy1_buttons: .res 1
joy2_buttons: .res 1
joy1_buttons_mirror: .res 1
joy2_buttons_mirror: .res 1

some_copy_of_joy1: .res 4

nes_ef: .res 1
nes_f0: .res 1
nes_31f: .res 1
nes_1a: .res 1

.segment "SIXKREGION"
nes_6000_something: .res 256