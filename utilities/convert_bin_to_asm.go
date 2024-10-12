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
	outputFilename1 := strings.Replace(*inputFile, ".bin", ".asm", 1)
	outputFilename := strings.Replace(outputFilename1, ".mw3", "_palette.asm", 1)

	println(fmt.Sprintf("outputing %s", outputFilename))
	outputFile, _ := os.Create(outputFilename)
	inputBytes, _ := ioutil.ReadFile(*inputFile)
	defer outputFile.Close()
	for i := 0; i < len(inputBytes); i++ {
		if i%0x10 == 0 {
			outputFile.WriteString(".byte ")
		}
		outputFile.WriteString(fmt.Sprintf("$%02X", inputBytes[i]))
		if i%0x10 == 0x0F {
			outputFile.WriteString("\n")
		} else {
			outputFile.WriteString(", ")
		}
	}
}
