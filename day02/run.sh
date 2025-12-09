#!/bin/bash

# Quick Start Script for Day 2 AoC Solution
    cd ./day2

# Check if Maven is available
if command -v mvn &> /dev/null; then
    echo "Using Maven..."
    echo "Building the project..."
    mvn clean compile

    echo ""
    echo "Running with example input..."
    mvn exec:java -Dexec.args="example.txt"

  
else

  echo ""
    echo "Running with actual input..."
    mvn exec:java -Dexec.args="input.txt"

    echo ""
    echo "Running tests..."
    mvn test
    echo "Maven not found. Using javac and java directly..."

    # Create bin directory if it doesn't exist
    mkdir -p bin

    echo "Compiling..."
    javac -d bin src/main/java/aoc/*.java

    if [ $? -eq 0 ]; then
        echo ""
        echo "Running with example input..."
        java -cp bin aoc.Solution example.txt

        echo ""
        echo "Running with actual input..."
        java -cp bin aoc.Solution input.txt
    else
        echo "Compilation failed!"
        exit 1
    fi

    echo ""
    echo "Note: Tests require Maven or manual JUnit setup"
fi

