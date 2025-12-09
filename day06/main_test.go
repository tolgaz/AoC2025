package main

import (
	"os"
	"testing"
)

func TestPart1(t *testing.T) {
	input, err := os.ReadFile("example.txt")
	if err != nil {
		t.Fatal(err)
	}

	result := solvePart1(string(input))
	expected := 0 // TODO: Update with expected output

	if result != expected {
		t.Errorf("Part 1 = %d; want %d", result, expected)
	}
}

func TestPart2(t *testing.T) {
	input, err := os.ReadFile("example.txt")
	if err != nil {
		t.Fatal(err)
	}

	result := solvePart2(string(input))
	expected := 0 // TODO: Update with expected output

	if result != expected {
		t.Errorf("Part 2 = %d; want %d", result, expected)
	}
}
