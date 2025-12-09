package main

import (
	"fmt"
	"os"
	"strings"
)

func parseInput(input string) []string {
	return strings.Split(strings.TrimSpace(input), "\n")
}

func solvePart1(input string) int {
	lines := parseInput(input)
	// TODO: Implement part 1
	_ = lines
	return 0
}

func solvePart2(input string) int {
	lines := parseInput(input)
	// TODO: Implement part 2
	_ = lines
	return 0
}

func main() {
	input, err := os.ReadFile("input.txt")
	if err != nil {
		panic(err)
	}

	fmt.Printf("Part 1: %d\n", solvePart1(string(input)))
	fmt.Printf("Part 2: %d\n", solvePart2(string(input)))
}
