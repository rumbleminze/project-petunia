package main

import (
	"flag"
	"io/ioutil"
	"os"
)

func main() {
	inputFile := flag.String("in", "1-1_shorter_map16.bin", "input file to adjust")
	outputFilename := flag.String("out", "1-1_shorter_map16_adjusted.bin", "output filename")
	flag.Parse()

	outputFile, _ := os.Create(*outputFilename)
	inputBytes, _ := ioutil.ReadFile(*inputFile)
	for i := 0; i < len(inputBytes); i += 1 {
		if i%2 == 1 {
			// add 4 to palette
			// palette is bytes xxxP PPxx
			inputBytes[i] += 0b00010000
		}
	}

	outputFile.Write(inputBytes)

}
