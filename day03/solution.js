/**
 * Advent of Code - Day 3
 */

const parseInput = (input) => input.trim().split("\n");

const concatAndConvertToInt = (numberOne, numberTwo) =>
  parseInt(`${numberOne}${numberTwo}`, 10);

const loopBatteryBank = (line) => {
  let highestIndex = -1,
    highestValue = -1,
    largestJoltage = -1;
  const splitLine = line.split("");

  if (splitLine.length === 1) return parseInt(splitLine[0], 10);

  // First rotation
  splitLine.forEach((battery, i) => {
    // Last elem
    if (splitLine.length - 1 === i) return;
    const parsed = parseInt(battery, 10);
    if (parsed > highestValue) {
      highestIndex = i;
      highestValue = parsed;
      largestJoltage = parsed;
    }
  });
  const slicedLine = splitLine.slice(highestIndex + 1);
  highestIndex = -1;
  highestValue = -1;

  slicedLine.forEach((battery, i) => {
    const parsed = parseInt(battery, 10);
    if (parsed > highestValue) {
      highestIndex = i;
      highestValue = parsed;
    }
  });

  return concatAndConvertToInt(largestJoltage, highestValue);
};

export function solvePart1(input) {
  const lines = parseInput(input);
  return lines.reduce((acc, curr) => acc + loopBatteryBank(curr), 0);
}

const log = (array, batteriesLeft) => {
  console.log({
    array,
    length: array.length,
    lastIndexPossible: array.length - batteriesLeft,
    batteriesLeft,
  });
};

const recursivelyFindLargest = (array, batteriesLeft) => {
  //log(array, batteriesLeft);
  let highestIndex = -1;
  let highestValue = -1;
  for (
    let index = 0;
    index <= array.length - (batteriesLeft > 1 ? batteriesLeft : 0);
    index++
  ) {
    if (array[index] > highestValue) {
      highestIndex = index;
      highestValue = array[index];
    }
  }

  if (batteriesLeft === 1) {
    return highestValue;
  } else {
    return `${highestValue}${recursivelyFindLargest(
      array.slice(highestIndex + 1),
      batteriesLeft - 1
    )}`;
  }
};

export function solvePart2(input) {
  const lines = parseInput(input);
  const NUMBER_OF_BATTERIES = 12;
  const parsedLines = lines.map((str) => Array.from(str, Number));

  const temp = parsedLines.reduce(
    (acc, curr) =>
      acc + Number(recursivelyFindLargest(curr, NUMBER_OF_BATTERIES)),
    0
  );

  return temp;
}
