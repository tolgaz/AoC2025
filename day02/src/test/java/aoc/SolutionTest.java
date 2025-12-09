package aoc;

import java.io.IOException;
import java.util.List;

import static org.junit.jupiter.api.Assertions.assertEquals;
import org.junit.jupiter.api.Test;

public class SolutionTest {
    @Test
    public void testPart1Example() throws IOException {
        List<String> exampleInput = Solution.readInput("example.txt");

        long expected = 1227775554; // Update with expected result
        long actual = Solution.solvePart1(exampleInput);

        assertEquals(expected, actual, "Part 1 example should match");
    }

    @Test
    public void testPart2Example() throws IOException {

        List<String> exampleInput = Solution.readInput("example.txt");

        long expected = 4174379265L; // Update with expected result
        long actual = Solution.solvePart2(exampleInput);

        assertEquals(expected, actual, "Part 2 example should match");
    }
}
