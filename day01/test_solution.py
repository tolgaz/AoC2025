#!/usr/bin/env python3
"""
Test cases for Day 1
"""
import pytest
from solution import parse_input, part1, part2, read_input


def test_example_part1():
    """Test part 1 with example input."""
    data = read_input('example.txt')
    parsed_data = parse_input(data)
    expected = 3
    assert part1(parsed_data) == expected


def test_example_part2():
    """Test part 2 with example input."""
    data = read_input('example.txt')
    parsed_data = parse_input(data)
    expected = 6
    assert part2(parsed_data) == expected


if __name__ == "__main__":
    pytest.main([__file__, "-v"])

