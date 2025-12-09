# Day 2 - Advent of Code (Java)

## Quick Start

Since Maven is not installed, use these simple commands to compile and run:

### 1. Compile the code:
```bash
cd /Users/tolgazeybek/Documents/Code/AoC/day02
mkdir -p bin
javac -d bin src/main/java/aoc/Solution.java
```

### 2. Run with example input:
```bash
java -cp bin aoc.Solution example.txt
```

### 3. Run with actual input:
```bash
java -cp bin aoc.Solution input.txt
```

### 4. Or use the provided script:
```bash
./compile_and_run.sh
```

## Project Structure

```
day02/
├── src/
│   ├── main/java/aoc/
│   │   └── Solution.java      # Your solution code
│   └── test/java/aoc/
│       └── SolutionTest.java  # Unit tests
├── example.txt                # Example input
├── input.txt                  # Actual puzzle input
├── compile_and_run.sh         # Simple compile & run script
├── run.sh                     # Maven or javac fallback script
└── pom.xml                    # Maven config (if you install Maven later)
```

## Implementing Your Solution

1. Add your puzzle input to `input.txt` and example input to `example.txt`
2. Edit `src/main/java/aoc/Solution.java`:
   - Implement `solvePart1()` for Part 1
   - Implement `solvePart2()` for Part 2
3. Compile and run using the commands above

## Installing Maven (Optional)

If you want to use Maven for testing and dependency management:

```bash
# On macOS with Homebrew:
brew install maven

# Then you can use:
mvn clean compile
mvn exec:java
mvn test
```

## Tips

- The `readInput()` method reads the file and returns a List<String> of lines
- Start by implementing Part 1, test it with the example, then move to Part 2
- You can print debug output using `System.out.println()` or `System.err.println()`

