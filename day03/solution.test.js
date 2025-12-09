import { readFileSync } from "node:fs";
import { dirname, join } from "node:path";
import { fileURLToPath } from "node:url";

import { solvePart1, solvePart2 } from "./solution.js";

const __dirname = dirname(fileURLToPath(import.meta.url));

const exampleInput = readFileSync(join(__dirname, "example.txt"), "utf-8");

describe("Day 3", () => {
  describe("Part 1", () => {
    it("should solve the example", () => {
      const result = solvePart1(exampleInput);
      expect(result).toBe(357);
    });
  });

  describe("Part 2", () => {
    it("should solve the example", () => {
      const result = solvePart2(exampleInput);
      expect(result).toBe(3121910778619);
    });
  });
});
