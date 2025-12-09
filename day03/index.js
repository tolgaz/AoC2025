import { readFileSync } from "node:fs";
import { dirname, join } from "node:path";
import { fileURLToPath } from "node:url";

import { solvePart1, solvePart2 } from "./solution.js";

const __dirname = dirname(fileURLToPath(import.meta.url));

const inputPath = join(__dirname, "input.txt");
const input = readFileSync(inputPath, "utf-8");

console.log("Part 1:", solvePart1(input));
console.log("Part 2:", solvePart2(input));
