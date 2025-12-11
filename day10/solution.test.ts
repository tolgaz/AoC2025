import { readInput, solvePart1, solvePart2 } from "./solution";

describe("Day 10", () => {
  const exampleInput = readInput("example.txt");

  test("Part 1 - Example", () => {
    const result = solvePart1(exampleInput);
    expect(result).toBe(7);
  });

  test.skip("Part 2 - Example", () => {
    const result = solvePart2(exampleInput);
    expect(result).toBe(0); // Update with expected value
  });
});
