POT_ROOM        = $20;
NOSE_ROOM       = $22;
TRAINING_ROOM   = $23;
UPGRADE_ROOM    = $24;
SHOP            = $25;
BLACK_MARKET    = $26;
SPA             = $27;

DOOR_DISTRIBUTION:
;w1 - 16 bytes
.byte POT_ROOM, POT_ROOM
.byte NOSE_ROOM, NOSE_ROOM, NOSE_ROOM, NOSE_ROOM
.byte TRAINING_ROOM, TRAINING_ROOM
.byte UPGRADE_ROOM, UPGRADE_ROOM, UPGRADE_ROOM
.byte SHOP, SHOP, SHOP, SHOP
.byte BLACK_MARKET

;w2 - 16 bytes
.byte POT_ROOM, POT_ROOM
.byte NOSE_ROOM, NOSE_ROOM, NOSE_ROOM
.byte TRAINING_ROOM, TRAINING_ROOM
.byte UPGRADE_ROOM, UPGRADE_ROOM
.byte SHOP, SHOP, SHOP
.byte BLACK_MARKET, BLACK_MARKET
.byte SPA, SPA

;w3 - 16 bytes
.byte NOSE_ROOM, NOSE_ROOM, NOSE_ROOM
.byte TRAINING_ROOM, TRAINING_ROOM, TRAINING_ROOM
.byte UPGRADE_ROOM, UPGRADE_ROOM
.byte SHOP, SHOP, SHOP
.byte BLACK_MARKET, BLACK_MARKET
.byte SPA, SPA, SPA