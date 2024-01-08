package main

import (
	"flag"
	"fmt"
	"io/ioutil"
	"os"
)

// This utility will take an NES rom as input, and split it up into 4k banks
// It currently assumes a lot about the game, and is set up to parse the game
// Super Dodge Ball, a MMC1 game, where banks 8+ are CHR ROM banks and within those banks
// banks at memory 1A000 - 1FFFF are data and 8000 - 19FFF are tiles.  It will automatically
// convert the 2bpp tiles into 4bpp SNES format, but leave the data parts as is.
//
// For all banks it'll break up and label every 0x100 bytes, as well as setting a segment directive
//
// This script also assumes that the file will have a 16 byte header that we skip.
//
// It very naively will just print out the code as:
//
// .byte $HL, $HL, ......
//
// with 16 bytes per line
func main() {
	inputFile := flag.String("in", "Kid Icarus (UE) - ORIG DO NOT EDIT.nes", "input file to split out")

	inputBytes, _ := ioutil.ReadFile(*inputFile)
	var banks [][]byte
	var bankSize = 0x4000

	// remove the header
	headerLess := inputBytes[0x10:]

	for i := 0; i < len(headerLess); i += bankSize {
		end := i + bankSize

		if end > len(headerLess) {
			end = len(headerLess)
		}

		banks = append(banks, headerLess[i:end])
	}

	for i := 0; i < 8; i++ {
		var bankFile, _ = os.Create(fmt.Sprintf("bank%d.asm", i))
		defer bankFile.Close()

		bankFile.WriteString(fmt.Sprintf(".segment \"PRGA%d\"", i+1))
		bankFile.WriteString(fmt.Sprintf("; Bank %d\n", i))
		for byteIndex := 0; byteIndex < len(banks[i]); byteIndex++ {
			if byteIndex <= 0x1FFFF {
				if byteIndex%0x100 == 0 {
					bankFile.WriteString(fmt.Sprintf("\n\n; %04X - bank %d\n", byteIndex+0x8000, i))
				}
				if byteIndex%0x10 == 0 {
					bankFile.WriteString(".byte ")
				}

				bankFile.WriteString(fmt.Sprintf("$%02X", banks[i][byteIndex]))

				if byteIndex%0x10 == 0x0F {
					bankFile.WriteString("\n")
				} else {
					bankFile.WriteString(", ")
				}
			}
		}
	}

}
