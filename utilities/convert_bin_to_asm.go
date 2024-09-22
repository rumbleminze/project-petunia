package main

import (
	"flag"
	"fmt"
	"io/ioutil"
	"os"
)

func main() {
	inputFile := flag.String("in", "1-1_shorter_map16.bin", "input file to adjust")
	outputFilename := flag.String("out", "1-1_shorter_map16_adjusted.bin", "output filename")
	flag.Parse()
	println(fmt.Sprintf("outputing %s", *outputFilename))
	outputFile, _ := os.Create(*outputFilename)
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
