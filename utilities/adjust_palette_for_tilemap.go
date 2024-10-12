package main

import (
	"flag"
	"fmt"
	"io/ioutil"
	"os"
	"strings"
)

func main() {
	inputFile := flag.String("in", "1-1_shorter_map16.bin", "input file to adjust")
	flag.Parse()
	outputFilename := strings.Replace(*inputFile, ".bin", "_adj.bin", 1)

	println(fmt.Sprintf("outputing %s", outputFilename))
	outputFile, _ := os.Create(outputFilename)
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
