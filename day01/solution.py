#!/usr/bin/env python3
"""
Advent of Code 2025 - Day 1
"""
from pathlib import Path

def read_input(filename):
    """Read and parse the input file."""
    # Get the directory where this script is located
    script_dir = Path(__file__).parent
    filepath = script_dir / filename
    with open(filepath, 'r') as f:
        return f.read().strip()


def parse_input(data):
    """Parse the input data into a suitable format."""
    lines = data.split('\n')
    return lines

def part1(data):
    """Solve part 1 of the puzzle."""
    start_point = 50
    password = 0
    for rotation in data:
        direction = rotation[0]
        steps = int(rotation[1:])

        if direction == 'L':
            start_point -= steps
        elif direction == 'R':
            start_point += steps

        is_minus = start_point < 0
        start_point = abs(start_point)

        if start_point > 100:
            start_point = start_point % 100

        if is_minus:
            start_point = 100 - start_point

        if start_point == 0 or start_point == 100:
            password += 1
            start_point = 0

    return password

def part2(data):
    """Solve part 2 of the puzzle."""
    start_point = 50
    password = 0
    for rotation in data:
        direction = rotation[0]
        steps = int(rotation[1:])

        if direction == 'L':
            start_point -= steps
        elif direction == 'R':
            start_point += steps

        is_minus = start_point < 0
        start_point = abs(start_point)

        if start_point > 100:
            password += start_point // 100
            start_point = start_point % 100

        if is_minus:
            password += start_point // 100
            start_point = 100 - start_point

        if start_point == 0 or start_point == 100:
            password += 1
            start_point = 0

    return password

def part2_not_working(data):
    """Solve part 2 of the puzzle."""
    start_point = 50
    password = 0
    for rotation in data:
        direction = rotation[0]
        steps = int(rotation[1:])

        if direction == 'L':
            flipped = (100-start_point)%100
            password += (flipped+steps)//100
            start_point = (start_point-steps)%100
        elif direction == 'R':
            password += (start_point+steps)//100
            start_point = (start_point+steps)%100

    return password

def part2_new(data):
    """Solve part 2 of the puzzle."""
    start_point = 50
    password = 0
    for rotation in data:
        direction = rotation[0]
        steps = int(rotation[1:])

        for _ in range(steps):
            if direction == 'L':
                start_point -= 1
            elif direction == 'R':
                start_point += 1

            if start_point < 0:
                start_point = 99
            elif start_point > 99:
                start_point = 0

            if start_point == 0:
                password += 1

    return password

def main():
    # Read input
    data = read_input('input.txt')
    parsed_data = parse_input(data)

    # Solve part 1
    result1 = part1(parsed_data)
    print(f"Part 1: {result1}")

    # Solve part 2
    result2 = part2(parsed_data)
    print(f"Part 2: {result2}")


if __name__ == "__main__":
    main()

