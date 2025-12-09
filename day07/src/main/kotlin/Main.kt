import java.io.File
import kotlin.collections.withIndex

fun parseInput(input: String): List<MutableList<Char>> {
    return input.trim().lines().map { it.trim().toMutableList() }
}

fun solvePart1(input: String): Int {
    val lines = parseInput(input)
    val otherLines = lines.drop(1)
    val startPointX = lines.first().indexOf('S')
    var totalHit = 0
    otherLines.forEachIndexed { lineIndex, line ->
        var foundPipe = false
        line.forEachIndexed { charIndex, char ->
            if (char == '^') {
                foundPipe = true
                // Check if there is a  pipe above
                if (otherLines[lineIndex - 1][charIndex] == '|') {
                    totalHit += 1
                    line[charIndex - 1] = '|'
                    line[charIndex + 1] = '|'
                }
            } else if (char == '.' && lineIndex != 0) {
                // Check if ther is pipe over
                if (otherLines[lineIndex - 1][charIndex] == '|') {
                    line[charIndex] = '|'
                }
            }
        }
        if (!foundPipe) {
            if (lineIndex == 0) {
                // No pipes and first line below start, draw from start
                line[startPointX] = '|'
                return@forEachIndexed
            }

            // Find all pipes in the line above
            val lineAbove = otherLines[lineIndex - 1]
            val indexOfPipes = lineAbove.withIndex()
                .filter { it.value == '|' }
                .map { it.index }
                .toList()

            indexOfPipes.forEach { index -> line[index] = '|' }
        }
    }
    return totalHit
}


fun solvePart2(input: String): Long {
    val lines = parseInput(input)
    val col = lines.first().indexOf('S')
    val memoization = mutableMapOf<String, Long>()

    fun recursive(depth: Int, col: Int): Long {
        for (row in depth until lines.size) {
            val char = lines[row][col]
            if (char == '^') {
                var timelines = 0L
                if (memoization.containsKey("L-$row-$col")) {
                    timelines += memoization["L-$row-$col"]!!
                } else {
                    val retValue = recursive(row + 1, col - 1)
                    timelines += retValue;
                    memoization["L-$row-$col"] = retValue
                }

                if (memoization.containsKey("R-$row-$col")) {
                    timelines += memoization["R-$row-$col"]!!
                } else {
                    val retValue = recursive(row + 1, col + 1)
                    timelines += retValue;
                    memoization["R-$depth-$col"] = retValue
                }

                return timelines
            }
        }
        return 1L
    }

    return recursive(1, col)
}

fun main() {
    val input = File("input.txt").readText()
    println("Part 1: ${solvePart1(input)}")
    println("Part 2: ${solvePart2(input)}")
}
