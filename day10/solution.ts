import * as fs from "node:fs";
import * as path from "node:path";

import { PowerSet } from "js-combinatorics";

type ConfigurationType = {
  indicatorLights: boolean[];
  buttons: number[][];
  joltages: number[];
};

export function readInput(filename: string): string[] {
  const filepath = path.join(__dirname, filename);
  return fs.readFileSync(filepath, "utf-8").trim().split("\n");
}

const parseInput = (lines: string[]): ConfigurationType[] =>
  lines.map((line) => {
    const splitted = line.split(" ");

    const indicatorLights = splitted[0]
      .replace(/[[\]]/g, "")
      .split("")
      .map((element) => element !== ".");

    const buttons = [];
    for (let i = 1; i < splitted.length - 1; i++) {
      buttons.push(splitted[i].replace(/[()]/g, "").split(",").map(Number));
    }

    const joltages = splitted[splitted.length - 1]
      .replace(/[{}]/g, "")
      .split(",")
      .map(Number);

    return { indicatorLights, buttons, joltages };
  });

const checkIfIndicatorLightsAreCorrectBuilder =
  (correct: boolean[]) => (toCheck: boolean[]) =>
    correct.every((_, i) => correct[i] === toCheck[i]);

export function solvePart1(lines: string[]): number {
  const configurations = parseInput(lines);
  let total = 0;

  configurations.forEach((config, i) => {
    console.log("Running for config:", i, ", of:", configurations.length);
    let lowest = Number.MAX_VALUE;
    const toCheck = Array(config.indicatorLights.length).fill(false);
    const checkIfIndicatorLightsAreCorrect =
      checkIfIndicatorLightsAreCorrectBuilder(config.indicatorLights);

    for (const subset of new PowerSet([...config.buttons.keys()])) {
      if (subset.length === 0 || subset.length >= lowest) continue;

      toCheck.fill(false);

      subset.forEach((buttonIndex) => {
        const buttons = config.buttons[buttonIndex];
        buttons.forEach((button) => {
          toCheck[button] = !toCheck[button];
        });
      });

      if (checkIfIndicatorLightsAreCorrect(toCheck)) {
        lowest = subset.length;
        if (lowest === 1) break;
      }
    }

    total += lowest;
  });

  return total;
}

export function solvePart2(_: string[]): number {
  // TODO: Implement part 2 solution
  return 0;
}

if (require.main === module) {
  main();
}

function main() {
  const lines = readInput("input.txt");
  console.log(`\nPart 1: ${solvePart1(lines)}`);
  console.log(`\nPart 2: ${solvePart2(lines)}`);
}
