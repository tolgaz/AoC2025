#!/usr/bin/env ruby

load 'solution.rb'

def assert_equal(expected, actual, message = "")
  if expected == actual
    puts "✓ PASS: #{message}"
  else
    puts "✗ FAIL: #{message}"
  end
  puts "  Expected: #{expected}"
  puts "  Got: #{actual}"
end

# Test setup
if File.exist?('example.txt')
  example_input = File.readlines('example.txt').map(&:strip).reject(&:empty?)
  
  puts "Running tests..."
  puts ""
  
  result1 = solve_part1(example_input)
  assert_equal(13, result1, "Part 1")

  result2 = solve_part2(example_input)
  assert_equal(43, result2, "Part 2")
else
  puts "⚠ example.txt not found. Please add it to run tests."
end
