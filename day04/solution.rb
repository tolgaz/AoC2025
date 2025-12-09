#!/usr/bin/env ruby

def read_input(filename)
  File.readlines(filename).map(&:strip).reject(&:empty?)
end

# Not used but initial way i initialized arrays
def init_array(lines) 
  full = []
  lines.each do |line|
    inner = []
    line.each do |char|
      inner.push(char)
    end
    full.push(inner)
  end
  return full
end

def solve_part1(lines)
  full = lines.map(&:chars)
  totalRes, = get_rolls_and_new_array(full)
  return totalRes
end

def get_rolls_and_new_array(full)
  totalRes = 0
  newFull = []
  full.each_with_index do |line, y|
    newLine = []
    line.each_with_index do |char, x|
      if char == '@'
        counter = 0
        (-1..1).each do |yx|
          (-1..1).each do |xx|
            if y+yx >= 0 && y+yx < full.size && x+xx >= 0 && x+xx < line.size
              if !(xx == 0 && yx == 0)
                if (full[y+yx][x+xx]) == '@'
                  counter+=1
                end
              end
            end
          end
        end
        if counter < 4
          totalRes += 1
          newLine.push(".")
        else 
          newLine.push("@")
        end
      else
        newLine.push(".")
      end
    end
    newFull.push(newLine)
  end

  return [totalRes, newFull]
end

# Old function, could just do full == newFull which does deep comparison LOL
def check_array_equal(full, newFull)
  full.each_with_index do |line, y|
    line.each_with_index do |char, x|
      if(full[y][x] != newFull[y][x])
        return false
      end
    end
  end
  return true
end

def solve_part2(lines)
  full = lines.map(&:chars)
  fullRes = 0

  loop do
    res, newFull = get_rolls_and_new_array(full)
    fullRes += res
    break if full == newFull
    full = newFull
  end

  return fullRes
end

# Main execution
if __FILE__ == $0
  begin
    lines = read_input("input.txt")
    
    # Part 1
    part1_result = solve_part1(lines)
    puts "Part 1: #{part1_result}"
    
    # Part 2
    part2_result = solve_part2(lines)
    puts "Part 2: #{part2_result}"
  rescue Errno::ENOENT
    puts "Error: File '#{filename}' not found!"
    exit 1
  end
end
